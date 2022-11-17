#!/bin/bash
# dotfiles manager

files=(
    ".config/sway/config"
    ".config/sway/sway-prop"
    ".config/waybar/config"
    ".config/waybar/style.css"
    ".config/waybar/mediaplayer.py"
    ".config/alacritty/alacritty.yml"
    ".gitconfig"
    ".config/backgrounds/wallpaper.png"
    ".config/mako/config"
)

function usage() {
    echo "Usage: $0 [-d] [-u]"
    exit 0
}

function deploy() {
    printf "WARNING: This will overwrite your local files! Continue? "
    read confirmation
    case "$confirmation" in
        Y|y) switch;;
        N|n) exit;;
    esac

    # select yn in "Yes" "No"; do
    #     case $yn in
    #         Yes ) echo "yes"; break;;
    #         No ) echo "no"; break;;
    #     esac
    # done

    printf "\n"

    for f in "${files[@]}"
    do
        echo "Deploying $f"

        # Create directory, if it doesn't exist
        FILE_DIR="$HOME/$(sed 's|\(.*\)/.*|\1|' <<< $f)"
        [ -d "$FILE_DIR" ] || mkdir -p "$FILE_DIR" &> /dev/null

        cp $f ~/$f
    done

    echo "Restarting sway..."
    sway reload > /dev/null
}

function update() {
    for f in "${files[@]}"
    do
        echo "Updating $f"
        cp ~/$f $f
        git add "$f"
    done

    git commit -m "dotfiles: Automated sync :robot:"
    git push
}

while getopts ":du" o; do
    case "${o}" in
        d) deploy;;
        u) update;;
        *) usage;;
    esac
done
shift $((OPTIND-1))
