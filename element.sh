#!/bin/bash

PSQL="psql --username=<username> --dbname=periodic_table -t --no-align -c"

# validate the input
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

# assign to input variable 
input=$1

# Function to check if input is a number
is_number() {
  [[ $1 =~ ^[0-9]+$ ]]
}

# Function to check if input is a element symbol
is_symbol() {
  [[ $1 =~ ^[A-Z][a-z]?$ ]]
}

# Fcuntion to check if input is a name of an element
handle_name() {
  [[ $1 =~ ^[A-Za-z]+$ ]]
}

# number search
search_number() {
  
  ELEMENT_SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")"
  
  # validate the element is on the DB
  if [[ -z $ELEMENT_SYMBOL ]]
  then
    echo "I could not find that element in the database."
  else
    # we get the information of the element
    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")"

    ELEMENT_TYPE_NAME="$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $1")" 

    ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")"

    MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")"

    BOLING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")"

    # display the element information
    echo "The element with atomic number $1 is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE_NAME, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOLING_POINT celsius."

  fi 
  
}

# symbol search
search_symbol() {

  ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")"

  # validate the element is on the DB
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else

    # we get the information of the element
    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")"

    ELEMENT_TYPE_NAME="$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")" 

    ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    BOLING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    # display the element information
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($1). It's a $ELEMENT_TYPE_NAME, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOLING_POINT celsius."

  fi  
}

# name search
search_name() {

  ATOMIC_NUMBER="$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")"

  # validate the element is on the DB
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else

    # we get the information of the element
    ELEMENT_NAME="$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")"

    ELEMENT_SYMBOL="$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")"

    ELEMENT_TYPE_NAME="$($PSQL "SELECT types.type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")" 

    ATOMIC_MASS="$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    MELTING_POINT="$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    BOLING_POINT="$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")"

    # display the element information
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE_NAME, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOLING_POINT celsius."
  fi
 
  
}

# Determine the type of the input and redirect it to its function
if is_number "$input"; then
  search_number $input
elif is_symbol "$input"; then
  search_symbol $input
elif handle_name "$input"; then
  search_name $input
fi
