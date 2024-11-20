#!/bin/bash

# Check if an output path is provided
if [ -z "$1" ]; then
  echo "Error: No output path provided."
  exit 1
fi

output_path="$1"

# Ensure the directory for the output path exists
output_dir=$(dirname "$output_path")
if [ ! -d "$output_dir" ]; then
  echo "Output directory does not exist. Creating: $output_dir"
  mkdir -p "$output_dir"
fi

# Run the camera capture command
echo "Capturing image to: $output_path"
rpicam-still --output "$output_path"

# Check if the command succeeded
if [ $? -eq 0 ]; then
  echo "Image captured successfully: $output_path"
  exit 0
else
  echo "Failed to capture image."
  exit 1
fi
