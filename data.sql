INSERT INTO animals (name,  date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
	
  ('Agumon', '2020-02-03', 0, TRUE, 10.23),
	('Gabumon', '2018-11-15', 2, TRUE, 8),
	('Pikachu', '2021-01-07', 1, FALSE, 15.4 ),
	('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals (name,  date_of_birth, weight_kg, neutered, escape_attempts)
VALUES

	('Charmander', '2020-02-08', -11, FALSE, 0),
	('Plantmon', '2021-11-15', -5.7, TRUE, 2),
	('Squirtle', '1993-06-02', -12.13, FALSE, 3),
	('Angemon', '2005-06-12', -45, TRUE, 1),
	('Boarmon', '2005-06-07', 20.4, TRUE, 7),
	('Blossom', '1998-10-13', 17, TRUE, 3),
	('Ditto', '2022-05-14', 22, TRUE, 4);


-- Insert Owners into the Owners table - line by line

INSERT INTO owners (
    full_name, age
) VALUES (
    'Sam Smith', 34
);

INSERT INTO owners (
    full_name, age
) VALUES (
    'Jennifer Orwell', 19
);

INSERT INTO owners (
    full_name, age
) VALUES (
    'Bob', 45
);

INSERT INTO owners (
    full_name, age
) VALUES (
    'Melody Pond', 77
);

INSERT INTO owners (
    full_name, age
) VALUES (
    'Dean Winchester', 14
);

INSERT INTO owners (
    full_name, age
) VALUES (
    'Jodie Whittaker', 38
);

-- Insert species into species table

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Update species id into animals table

UPDATE animals
	SET species_id=(SELECT id from species WHERE name = 'Digimon')
	WHERE name LIKE '%mon';

UPDATE animals
	SET species_id=(SELECT id from species WHERE name = 'Pokemon')
	WHERE name NOT LIKE '%mon'; 

-- Update Owners id into animals table

UPDATE animals
	SET owner_id=1
	WHERE name = 'Agumon';

UPDATE animals
	SET owner_id=2
	WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
	SET owner_id=3
	WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
	SET owner_id=4
	WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
	SET owner_id=5
	WHERE name IN ('Angemon', 'Boarmon');

-- Insert Vets into Vets table

INSERT INTO vets (
    name, age, date_of_graduation
) VALUES (
    'William Tatcher', 45, '2000-04-23'
);

INSERT INTO vets (
    name, age, date_of_graduation
) VALUES (
    'Maisy Smith', 26, '2019-01-17'
);

INSERT INTO vets (
    name, age, date_of_graduation
) VALUES (
    'Stephanie Mendez', 64, '1981-05-04'
);

INSERT INTO vets (
    name, age, date_of_graduation
) VALUES (
    'Jack Harkness', 38, '2008-06-08'
);

-- Insert specializations into specializations table

INSERT INTO specializations (
    vet_id, specie_id
) SELECT v.id, s.id
    FROM species s
    INNER JOIN vets v ON v.name = 'William Tatcher' AND s.name = 'Pokemon';

INSERT INTO specializations (
    vet_id, specie_id
) SELECT v.id, s.id
    FROM species s
    INNER JOIN vets v ON v.name = 'Stephanie Mendez' AND s.name IN ('Digimon', 'Pokemon');

INSERT INTO specializations (
    vet_id, specie_id
) SELECT v.id, s.id
    FROM species s
    INNER JOIN vets v ON v.name = 'Jack Harkness' AND s.name = 'Digimon';

	-- Insert visits into visits table

	INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-05-24'
    FROM animals a
    INNER JOIN vets v ON v.name = 'William Tatcher' AND a.name = 'Agumon';

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-07-22'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Stephanie Mendez' AND a.name = 'Agumon';    

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2021-02-02'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Jack Harkness' AND a.name = 'Gabumon';    
   
INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-01-05'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Pikachu';   

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-03-08'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Pikachu'; 

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-05-14'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Pikachu'; 

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2021-05-04'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Stephanie Mendez' AND a.name = 'Devimon'; 

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2021-02-24'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Jack Harkness' AND a.name = 'Charmander';  

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2019-12-21'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Plantmon'; 

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-08-10'
    FROM animals a
    INNER JOIN vets v ON v.name = 'William Tatcher' AND a.name = 'Plantmon';

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2021-04-07'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Plantmon';    

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2019-09-29'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Stephanie Mendez' AND a.name = 'Squirtle'; 

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-10-03'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Jack Harkness' AND a.name = 'Angemon';      

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-11-04'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Jack Harkness' AND a.name = 'Angemon'; 

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2019-01-24'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Boarmon';

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2019-05-15'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Boarmon';  

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-02-27'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Boarmon';        

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-08-03'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Maisy Smith' AND a.name = 'Boarmon';

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2020-05-24'
    FROM animals a
    INNER JOIN vets v ON v.name = 'Stephanie Mendez' AND a.name = 'Blossom'; 

INSERT INTO visits (
    animal_id, vet_id, date_of_visit
) SELECT a.id, v.id, '2021-01-11'
    FROM animals a
    INNER JOIN vets v ON v.name = 'William Tatcher' AND a.name = 'Blossom';

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';