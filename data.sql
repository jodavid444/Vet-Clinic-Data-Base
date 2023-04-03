/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Agumon', '2020-02-03', 0, 'true', 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Gabumon', '2018-11-15', 2, 'true', 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu', '2021-01-07', 1, 'false', 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon', '2017-05-12', 5, 'true', 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Charmander', '2020-02-08', 0, 'false', -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES ('Plantmon', '2021-11-15', 2, 'true', -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
   VALUES ('Squirtle', '1993-04-02', 3, 'false', -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Angemon', '2005-06-12', 1, 'true', -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Boarmon', '2005-06-07', 7, 'true', 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Blossom', '1998-10-13', 3, 'true', 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Ditto', '2022-05-14', 4, 'true', 22);

-- Multiple tables
INSERT INTO owners (full_name, age) 
VALUES ('Sam Smith',34 ),
       ('Jennifer Orwel',19 ),
       ('Bob',45 ),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

INSERT INTO species (name) 
VALUES ('Pokemon'),
       ('Digimon'); 

UPDATE animals
    SET species_id = (SELECT id from species WHERE name = 'Digimon')
    WHERE name like '%mon'; 

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Pokemon')
WHERE name not LIKE '%mon';  

UPDATE animals
set owner_id = 1 
WHERE name = 'Agumon';

UPDATE animals
set owner_id = 2 
WHERE name = 'Gabumon' or name = 'Pikachu';

UPDATE animals
set owner_id = 3 
WHERE name = 'Devimon' or name = 'Plantmon';

UPDATE animals
set owner_id = 4
WHERE name = 'Charmander' or name = 'Squirtle' or name = 'Blossom';

UPDATE animals
set owner_id = 5
WHERE name = 'Angemon' or name = 'Boarmon';

UPDATE owners
SET full_name = 'Jennifer Orwell'
WHERE id = 2;

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
       ('Maisy Smith', 26, '2019-01-17'),
       ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harkness', 38, '2008-08-08');

INSERT INTO specializations (species_id, vets_id, )
    VALUES ((SELECT id from species WHERE name = 'Pokemon'), (SELECT id from vets WHERE name = 'William Tatcher')),       
          ((SELECT id from species WHERE name = 'Digimon'), (SELECT id from vets WHERE name = 'Stephanie Mendez')),
           ((SELECT id from species WHERE name = 'Pokemon'), (SELECT id from vets WHERE name = 'Stephanie Mendez')),
           ((SELECT id from species WHERE name = 'Digimon'), (SELECT id from vets WHERE name = 'Jack Harkness'));

INSERT INTO visits (animal_id, vets_id, visit_date)
    VALUES  ((SELECT id FROM animals WHERE name = 'Agumon'),(SELECT id from vets WHERE name = 'William Tatcher'), '2020-05-24'),
            ((SELECT id FROM animals WHERE name = 'Agumon'),(SELECT id from vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
            ((SELECT id FROM animals WHERE name = 'Gabumon'),(SELECT id from vets WHERE name = 'Jack Harkness'), '2021-02-02'),
            ((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2020-01-05'),
            ((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2020-03-08'),
            ((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2020-05-14'),
            ((SELECT id FROM animals WHERE name = 'Devimon'),(SELECT id from vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
            ((SELECT id FROM animals WHERE name = 'Charmander'),(SELECT id from vets WHERE name = 'Jack Harkness'), '2021-02-24'),
            ((SELECT id FROM animals WHERE name = 'Plantmon'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2019-12-21'),
            ((SELECT id FROM animals WHERE name = 'Plantmon'),(SELECT id from vets WHERE name = 'William Tatcher'), '2020-08-10'),
            ((SELECT id FROM animals WHERE name = 'Plantmon'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2021-04-07'),
            ((SELECT id FROM animals WHERE name = 'Squirtle'),(SELECT id from vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
            ((SELECT id FROM animals WHERE name = 'Angemon'),(SELECT id from vets WHERE name = 'Jack Harkness'), '2020-10-03'),
            ((SELECT id FROM animals WHERE name = 'Angemon'),(SELECT id from vets WHERE name = 'Jack Harkness'), '2020-11-04'),
            ((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2019-01-24'),
            ((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2019-05-15'),
            ((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2020-02-27'),
            ((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id from vets WHERE name = 'Maisy Smith'), '2020-08-03'),
            ((SELECT id FROM animals WHERE name = 'Blossom'),(SELECT id from vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
            ((SELECT id FROM animals WHERE name = 'Blossom'),(SELECT id from vets WHERE name = 'William Tatcher'), '2021-01-11');
            
-- performance audit

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
SELECT * FROM (SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') 
visit_timestamp;

insert into owners (full_name, email)
 select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';       