# Periodic Table Information Lookup

This project demonstrates a bash script that retrieves information about elements from the periodic table using a PostgreSQL database.

## Project Overview

The bash script accepts an atomic number, symbol, or name of an element as input and outputs detailed information about the element by querying the PostgreSQL database.

## Database Setup

1. Create and populate the PostgreSQL database using the provided dump file. Run the following commands:

    ```sh
    psql -U postgres -f periodic_table.sql
    ```

2. The database `periodic_table` will be created with the following tables:
   - `elements`: Contains atomic number, symbol, and name of elements.
   - `properties`: Contains atomic number, atomic mass, melting point, boiling point, and type ID.
   - `types`: Contains type ID and type (e.g., metal, nonmetal, metalloid).

3. In the element.sh script change the following line to your postgres user :
    ```sh
    PSQL="psql --username=<username> --dbname=periodic_table -t --no-align -c"
    ```
    


## Bash Script

The bash script `lookup_element.sh` retrieves and displays information about elements from the database. It accepts an atomic number, symbol, or name as input and outputs the element's details.

### Usage

```sh
./lookup_element.sh <element>
```

- `<element>`: Can be the atomic number (e.g., `1`), the symbol (e.g., `H`), or the name (e.g., `Hydrogen`) of the element.

### Example

```sh
./lookup_element.sh 1
```

Output:

```
The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
```
## Conclusion

This project demonstrates the ability to design, implement, and manage a complex relational database in PostgreSQL. It showcases data modeling skills, knowledge of SQL, and understanding of database constraints and normalization.

Feel free to explore the database and modify it as needed for your purposes.