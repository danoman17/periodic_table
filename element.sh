#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# validate the input
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
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
  [[ $1 =~ ^[A-Z][a-z]?$ ]]
}

handle_name() {
  [[ $1 =~ ^[A-Za-z]*$ ]]
}

# number search
search_number() {
  
  ELEMENT_SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")"
  
  if [[ -z $ELEMENT_SYMBOL ]]
  then
    echo "I could not find that element in the database."
  else
    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")"

    ELEMENT_TYPE_NAME="$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $1")" 

    ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")"

    MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")"
    BOLING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")"

    echo "The element with atomic number $1 is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE_NAME, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOLING_POINT celsius."

  fi 
  
}

# symbol search
search_symbol() {

  ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")"

  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else

    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")"

    ELEMENT_TYPE_NAME="$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")" 

    ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"
    BOLING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"
  
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($1). It's a $ELEMENT_TYPE_NAME, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOLING_POINT celsius."

  fi  
}

# name search
search_name() {

  ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")"

  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")"

    ELEMENT_TYPE_NAME="$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")" 

    ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"
    BOLING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"
  
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($1). It's a $ELEMENT_TYPE_NAME, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOLING_POINT celsius."
  fi
 
  
}



# Determine the type of the input and call the function
if is_number "$input"; then
  search_number $input
elif is_symbol "$input"; then
  search_symbol $input
elif handle_name "$input"; then
  search_name $input
fi
