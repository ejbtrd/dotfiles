#!/bin/bash
# dotfiles manager

files=("sway/config" "waybar/config" "waybar/style.css")

for f in "${files[@]}"
do
   echo "Updating $f"
   cp ~/.config/$f $f

   git add "$f"
done

git commit -m "dotfiles: Automated sync"
git push
