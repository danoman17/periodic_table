#!/bin/bash

#PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# TODO: validate the input

if [[ -z $1 ]]
then
  echo "Usage: $0 <atomic_number> | <symbol> | <name>"
  exit 1
fi

input=$1

echo "The input is: $input"

# TODO: validate the type if the input <atomic_number> <element_symbol> <element_name>

