#!/bin/bash

#PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# validate the input
if [[ -z $1 ]]
then
  echo "Usage: $0 <atomic_number> | <symbol> | <name>"
  exit 1
fi

# assign the input 
input=$1

# Function to check if input is a number
is_number() {
  [[ $1 =~ ^[0-9]+$ ]]
}

# Function to check if input is a single character (element symbol)
is_symbol() {
  [[ $1 =~ ^[A-Za-z]$ ]]
}

handle_name() {
  [[ $1 =~ ^[A-Z][a-z]*$ ]]
}

# Determine the type of the input and call the function
if is_number "$input"; then
  echo "$input is a number"
elif is_symbol "$input"; then
  echo "$input is symbol"
elif handle_name "$input"; then
  echo "$input is an element name"
fi
