-- Find all animals whose name ends in "mon"
SELECT * from animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals
WHERE neutered = TRUE AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals
WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals
WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Set species and Rollback;
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;

-- Update species based on name and empty species
Begin;
UPDATE animals SET species='digimon' where name like '%mon';
UPDATE animals SET species='pokemon' where species='';
COMMIT;
SELECT * FROM animals;

-- Delete all records and Rollback
Begin;
DELETE FROM animals;
SELECT * FROM animals;
Rollback;
SELECT * FROM animals;

-- Delete and Rollback with savepoints
BEGIN;
DELETE FROM animals WHERE date_of_birth>'2022-01-01';
SAVEPOINT first_savepoint;
UPDATE animals set weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO SAVEPOINT first_savepoint;

-- Update on weight conditions
SELECT * FROM animals;
UPDATE animals set weight_kg=weight_kg*-1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Counting and calculations based on data
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;
SELECT AVG(weight_kg) FROM animals;
SELECT CASE WHEN (COUNT(CASE WHEN neutered THEN 1 END)) > COUNT(CASE WHEN not neutered THEN 1 END) THEN 'NEUTERED' ELSE 'NOT NEUTERED' END FROM animals;
SELECT species, MIN(weight_kg) as "Minimum Weight", MAX(weight_kg) as "Maximum Weight" FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) as "AVERAGE ESCAPE ATTEMPTS" from animals WHERE date_of_birth BETWEEN '1990-01-01' and '2000-01-01' GROUP BY species;


-- List all animals that belong to Melody Pond

SELECT
	a.name
    FROM animals a
    INNER JOIN owners o ON a.owner_id = o.id
    WHERE o.full_name = 'Melody Pond';

--  List of all animals that are pokemon

SELECT
	a.name
    FROM animals a
    INNER JOIN species s ON a.species_id = s.id
    WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT 
	o.full_name, STRING_AGG (a.name, ', ') as animals
    FROM owners o
    LEFT JOIN animals a ON o.id = a.owner_id
    GROUP BY o.full_name;    

-- How many animals are there per species?

SELECT
	s.name, COUNT(a.name) AS count_species
    FROM animals a
    JOIN species s ON a.species_id = s.id
    GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT
	a.name
    FROM animals a
    LEFT JOIN species s ON a.species_id = s.id
    LEFT JOIN owners o ON a.owner_id = o.id
    WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT
	a.name
    FROM animals a
    LEFT JOIN owners o ON a.owner_id = o.id
    WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?

SELECT
	o.full_name, COUNT(a.*) AS quantity
    FROM animals a
    LEFT JOIN owners o ON a.owner_id = o.id
    GROUP BY o.full_name
    ORDER BY quantity DESC
    LIMIT 1;

-- Day-4 Work
-- 1-Who was the last animal seen by William Tatcher?
SELECT
	a.name, v.visit
    FROM visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN vets e ON v.vet_id = e.id
    WHERE e.name = 'William Tatcher'
    ORDER BY v.visit DESC
    LIMIT 1;

-- 2-How many different animals did Stephanie Mendez see?
SELECT
	COUNT(DISTINCT(v.*)) AS quantity
    FROM visits v
    JOIN vets e ON v.vet_id = e.id
    WHERE e.name = 'Stephanie Mendez';

-- 3-List all vets and their specialties, including vets with no specialties.
SELECT
	v.name AS vet, STRING_AGG(s.name, ', ') as specializations
    FROM vets v
    LEFT JOIN specializations z ON v.id = z.vet_id
    LEFT JOIN species s ON z.specie_id = s.id
    GROUP BY v.name;

-- 4-List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
	a.name, v.visit
    FROM visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN vets e ON v.vet_id = e.id
    WHERE e.name = 'Stephanie Mendez' AND v.visit BETWEEN '2020-04-01' AND '2020-08-30'
    ORDER BY v.visit DESC;

-- 5-What animal has the most visits to vets?
SELECT
	a.name, COUNT(v.*) AS visits
    FROM visits v
    JOIN animals a ON v.animal_id = a.id
    GROUP BY a.name
    ORDER BY visits DESC
    LIMIT 1;

-- 6-Who was Maisy Smith's first visit?
SELECT
	a.name
    FROM visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN vets e ON v.vet_id = e.id
    WHERE e.name = 'Maisy Smith'
    ORDER BY v.visit ASC
    LIMIT 1;

-- 7-Details for most recent visit: animal information, vet information, and date of visit.
SELECT
	a.name AS animal, 
    s.name AS specie, 
    e.name AS veterinary, 
    e.age, 
    e.date_of_graduation, 
    v.visit AS date
    FROM visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN species s ON a.species_id = s.id
    JOIN vets e ON v.vet_id = e.id
    ORDER BY v.visit DESC
    LIMIT 1;

-- 8-How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS Qty
    FROM visits 
    INNER JOIN animals ON visits.animal_id = animals.id 
    INNER JOIN vets ON visits.vet_id = vets.id
    WHERE animals.species_id NOT IN (
        SELECT specie_id FROM specializations 
        WHERE vet_id = vets.id
    );

-- 9-What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
    s.name AS specie
    FROM visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN species s ON a.species_id = s.id
    JOIN vets e ON v.vet_id = e.id
    WHERE e.name = 'Maisy Smith'
    GROUP BY s.name
    ORDER BY COUNT(v.*) DESC
    LIMIT 1;