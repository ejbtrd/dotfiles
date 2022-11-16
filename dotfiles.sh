#!/bin/bash
# dotfiles manager

files=("sway/config" "sway/sway-prop" "waybar/config" "waybar/style.css" "waybar/mediaplayer.py" "alacritty/alacritty.yml")

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
        cp $f ~/.config/$f
        sleep 0.25
    done
elif [ "$1" == "update" ]; then
    for f in "${files[@]}"
    do
        echo "Updating $f"
        cp ~/.config/$f $f
    done
elif [ "$1" == "push" ]; then
    for f in "${files[@]}"
    do
        echo "Adding $f"
        git add "$f"
    done

    git commit -m "dotfiles: Automated sync"
    git push
else
    echo "Please specify action: deploy, update, push"
fi
