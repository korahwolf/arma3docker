#!/bin/bash
set -e

INSTALL_DIR="/home/steam/files"
CONFIG_DIR="/home/steam/config"
STEAMCMD="/home/steam/steamcmd/steamcmd.sh"

needs_rename_fix=0

chown -R 1000:1000 /home/steam


# download server and workshop mods

args=(
    +force_install_dir "$INSTALL_DIR"
    +login "$STEAM_USER" "$STEAM_PASS"
    +app_update 233780
)

while read -r id; do
    [ -z "$id" ] && continue
    [[ $STEAM_USER == "anonymous" ]] && continue
    if [ ! -e "$INSTALL_DIR/steamapps/workshop/content/107410/$id/" ]; then
        args+=(+workshop_download_item 107410 "$id" validate)
        needs_rename_fix=1
    fi
done < "$CONFIG_DIR/workshop_ids.txt"

args+=(+quit)

gosu steam "$STEAMCMD" "${args[@]}"


# add a symlink for all the mod files

shopt -s nullglob

for dir in "$INSTALL_DIR/steamapps/workshop/content/107410/"*/; do
    mod_id=$(basename "$dir")

    # delete mods that are not in the mod list anymore
    if ! grep -Fxq "$mod_id" "$CONFIG_DIR/workshop_ids.txt"; then
        rm -rfv "$INSTALL_DIR/@$mod_id" "$dir"
        continue
    fi

    gosu steam ln -sfvn "$dir" "$INSTALL_DIR/@$mod_id"
done


# rename all mod files to lowercase

if [ "$needs_rename_fix" -eq 1 ]; then
    for mod in "$INSTALL_DIR"/@*/; do
        # rename directories to lowercase (deepest first)
        find "$mod" -depth -type d | while read -r dir; do
            new=$(echo "$dir" | tr '[:upper:]' '[:lower:]')
            [ "$dir" = "$new" ] || mv "$dir" "$new"
        done

        # rename files to lowercase
        find "$mod" -type f | while read -r file; do
            new=$(echo "$file" | tr '[:upper:]' '[:lower:]')
            [ "$file" = "$new" ] || mv "$file" "$new"
        done
    done
fi


# start server (final process)

cd "$INSTALL_DIR"

mods=$(find . -maxdepth 1 -type l -name '@*' -printf '%f;' | sed 's/;$//')
exec gosu steam ./arma3server_x64 -config=$CONFIG_DIR/server.cfg -mod="$mods"
