
Heading () {
  # Print the text with a green color
  echo -e "\e[32m $* \e[0m"
}

STAT(){
  if [ $1 -eq 0 ]; then
    echo "success" >&2
  else
    echo "failed" >&2
    exit 1  # Exit the script with an error code
  fi
}
