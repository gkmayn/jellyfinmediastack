#!/bin/bash

# Define the directory names in variables
dir1="jellyfin-config"
dir2="sonarr-config"
dir3="radarr-config"
dir4="qbittorrent-config"
dir5="downloadclient-downloads"
dir6="prowlarr-config"
dir7="requestrr-config"
dir8="movies"
dir9="tvseries"

# Create the directories using mkdir
mkdir -p "$dir1" "$dir2" "$dir3" "$dir4" "$dir5" "$dir6" "$dir7" "$dir8" "$dir9"

# Print the paths of the created directories
echo "Path of $dir1: $(realpath "$dir1")"
echo "Path of $dir2: $(realpath "$dir2")"
echo "Path of $dir3: $(realpath "$dir3")"
echo "Path of $dir4: $(realpath "$dir4")"
echo "Path of $dir5: $(realpath "$dir5")"
echo "Path of $dir6: $(realpath "$dir6")"
echo "Path of $dir7: $(realpath "$dir7")"
echo "Path of $dir8: $(realpath "$dir8")"
echo "Path of $dir9: $(realpath "$dir9")"
