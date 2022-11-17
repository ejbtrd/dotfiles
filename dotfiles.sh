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

if [ "$1" == "deploy" ]; then
    echo "WARNING: This will overwrite your local files!"

    for i in {5..1}; do
        printf "\033[0K\rProceeding in $i..."
        sleep 1
    done

    printf "\n"

    for f in "${files[@]}"
    do
        echo "Deploying $f"
        cp $f ~/$f
        sleep 0.25
    done
elif [ "$1" == "update" ]; then
    for f in "${files[@]}"
    do
        echo "Updating $f"
        cp ~/$f $f
        git add "$f"
    done

    git commit -m "dotfiles: Automated sync :robot:"
    git push
else
    echo "Please specify action: deploy, update"
fi
