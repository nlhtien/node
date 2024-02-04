#!/bin/bash

chat_api_url="http://localhost:3000/send-message"

while true; do
  read -p "Enter your message (type 'exit' to stop): " message

  if [ "$message" == "exit" ]; then
    break
  fi

  if [ "$message" == "send-image" ]; then
    read -p "Enter the path to your image file: " image_path

    # Check if the image file exists
    if [ ! -f "$image_path" ]; then
      echo "File not found: $image_path"
      continue
    fi

    # Use curl to send the image and message
    timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
    response=$(curl -X POST -H "Content-Type: application/json" --data "{\"message\": \"send-image\", \"timestamp\": \"$timestamp\"}" --data-binary "@$image_path" $chat_api_url)
    echo "Response: $response"
  else
    timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
    response=$(curl -X POST -H "Content-Type: application/json" --data "{\"message\": \"$message\", \"timestamp\": \"$timestamp\"}" $chat_api_url)
    echo "Response: $response"
  fi

  if [ "$message" == "terminate-server" ]; then
    echo "Terminating script..."
    exit 0
  fi
done

