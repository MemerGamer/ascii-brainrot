#!/bin/bash

# Define the video titles and their corresponding YouTube URLs
declare -A videos=(
  ["Subway Surfer"]="https://www.youtube.com/watch?v=i0M4ARe9v0Y"
  ["Cat"]="https://www.youtube.com/watch?v=J---aiyznGQ"
  ["Fish"]="https://www.youtube.com/watch?v=poa_QBvtIBA"
)

# Initialize options
audio="--no-audio"
loop="--loop"

# Function to display the menu
show_menu() {
  while true; do
    clear
    echo "===== ascii-brainrot ====="
    echo "1) Subway Surfer"
    echo "2) Cat"
    echo "3) Fish"
    echo "4) Toggle Audio (Currently: $(get_toggle_state "$audio" "Audio"))"
    echo "5) Toggle Loop (Currently: $(get_toggle_state "$loop" "Loop"))"
    echo "6) Exit"
    echo "========================="
    read -p "Choose an option (1-6): " choice

    case $choice in
    1 | 2 | 3)
      # Map the choice to the video title
      case $choice in
      1) title="Subway Surfer" ;;
      2) title="Cat" ;;
      3) title="Fish" ;;
      esac
      play_video "$title"
      ;;
    4)
      if [[ $audio == "--no-audio" ]]; then
        audio=""
      else
        audio="--no-audio"
      fi
      echo "Audio toggled to: $(get_toggle_state "$audio" "Audio")"
      sleep 1
      ;;
    5)
      if [[ $loop == "--loop" ]]; then
        loop=""
      else
        loop="--loop"
      fi
      echo "Loop toggled to: $(get_toggle_state "$loop" "Loop")"
      sleep 1
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid option. Please choose a number between 1 and 6."
      sleep 1
      ;;
    esac
  done
}

# Function to get a human-readable toggle state
get_toggle_state() {
  local flag=$1
  local option=$2
  if [[ -z $flag ]]; then
    echo "Enabled"
  else
    echo "Disabled"
  fi
}

# Function to play the selected video
play_video() {
  local title=$1
  local url=${videos[$title]}
  echo "Playing: $title..."
  mpv --quiet $audio $loop -vo=tct "$url"
  read -p "Press Enter to return to the menu..."
}

# Check if mpv is installed
if ! command -v mpv &>/dev/null; then
  echo "mpv is not installed. Please install it to run this script."
  exit 1
fi

# Start the menu
show_menu
