#!/bin/bash

MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi
echo "$MY_PATH"

soundsDir="$MY_PATH/../sounds/"
voice="Emily"

generate='say -v "$voice" "$soundFile". Can you spell "$soundFile?" -o "$MY_PATH/../sounds/$soundFile.aiff"'
encode='ffmpeg -v 0 -y -i "$MY_PATH/../sounds/$soundFile".aiff "$MY_PATH/../sounds/$soundFile".wav '

list=()

while IFS=$(echo -en '\n\b') read -r word || [[ -n "$word" ]]; do
        echo $word
        list+=($word)
done < "$1"

declare -p list
for soundFile in "${list[@]}"; do
    eval $generate
    eval $encode
done

eval "rm -rf $MY_PATH/../sounds/*.aiff"
