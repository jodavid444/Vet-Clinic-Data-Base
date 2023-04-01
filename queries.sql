/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth  FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- 1st transaction
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*2nd transaction */

BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL OR species = '';

SELECT * from animals;
COMMIT;

/*3rd transaction */

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * from animals;

/*4th transaction */

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT first_delete;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO first_delete;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

/* Aggregate Functions */
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts)
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg),MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- Multiple tables querys

SELECT owner_id, full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME"
   FROM animals
   INNER JOIN owners
   ON  animals.owner_id = owners.id
   WHERE owners.full_name = 'Melody Pond';

    SELECT species.name AS "Animal Species", animals.name AS "ANIMALS NAME"
    FROM animals
    JOIN species
    ON animals.species_id = species.id
    WHERE species.id = 1;

SELECT  full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME"
   FROM owners
   LEFT JOIN  animals
   ON  owners.id =  animals.owner_id ;

SELECT species.name AS "SPECIES NAME",  COUNT(animals.name) AS "SPECIES COUNT" 
    FROM species
    JOIN animals
    on species.id = animals.species_id 
    GROUP By species.name;
 
SELECT full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME",species.name AS "Animal Species"
   FROM animals
   INNER JOIN owners ON  animals.owner_id = owners.id
   INNER JOIN species ON  animals.species_id = species.id
   WHERE owners.id = 2 and species.name = 'Digimon'; 

 SELECT full_name AS "OWNER NAME" , animals.name AS "ANIMALS NAME",species.name AS "Animal Species"
   FROM animals
   INNER JOIN owners ON  animals.owner_id = owners.id
   INNER JOIN species ON  animals.species_id = species.id
   WHERE owners.id = 5 and animals.escape_attempts = 0; 

   SELECT full_name AS "OWNER NAME",  COUNT(animals.name) AS "ANIMAL COUNT" 
    FROM owners
    JOIN animals
    on owners.id = animals.owner_id 
    GROUP By full_name
    ORDER BY COUNT(animals.name) DESC LIMIT 1;

 --  querys for many-to-many

   SELECT animals.id, animals.name AS Last_Seen, visit_date
   FROM animals JOIN visits 
   ON animals.id = visits.animal_id
   WHERE vets_id = (SELECT id from vets WHERE name = 'William Tatcher')
   ORDER BY visit_date DESC LIMIT 1;

    SELECT vets.name AS "VET NAME" , COUNT(animals.name) AS "animals count"
    from animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON visits.vets_id = vets.id
    WHERE vets_id = (SELECT id from vets WHERE name = 'Stephanie Mendez')
    GROUP BY vets.name;
       