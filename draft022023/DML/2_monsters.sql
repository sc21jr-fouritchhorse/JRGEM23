/*TODO: Insert the folllowing

Rat
    BEAST type
(Evolves into \/)
Were-rat
    BEAST type
(or)
Cybrat
    BEAST/INDUST type
(Evolves into \/)
Verminator
    BEAST/INDUST type

(Synth 4 rats)
Rat-King
    BEAST/UNDEAD type

Pidgeon
    BEAST/WIND type
(Evolves into \/)
Doh-doh
    BEAST/NATURE type
(Evolves into \/)
Mountain-devil
    NATURE/WIND type

Cigarette
    FLAME type
(Evolves into \/)
Pack-O'-Cigarettes
    FLAME type
(Evolves into \/)
Nichomet
    FLAME/DEMON type

Uprooted-weed
    PLANT type
(Evolves into \/)
Boisterous-weed
    PLANT/BEAST type
(Evolves into \/)
Dande-lion
    PLANT/BEAST type

Cracked-bottle
    WATER type
(Evolves into \/)
Spillage
    WATER/SPIRIT type
(Evolves into \/)
Mr-Bubbly
    WATER/SPIRIT type

Electric sheep
    ELEC/BEAST
(synth w/ the child of 2 electric sheep \/)
Three electric sheep stuck together
    ELEC/BEAST

*/



INSERT INTO species(name)
VALUES('Rat');

INSERT INTO species(name)
VALUES('Cigarette');

INSERT INTO species(name)
VALUES('Pidgeon');

INSERT INTO species(name)
VALUES('Broken bottle');

INSERT INTO species(name)
VALUES('Uprooted weed');

--Insert statistics data
INSERT INTO statistics(holder_id_fk, stat_type, val)
SELECT m.id, s.id,
CASE s.long_name
WHEN 'ATTACK' THEN 15
WHEN 'DEFENSE' THEN 11
WHEN 'SPEED' THEN 22
WHEN 'COURAGE' THEN 11
WHEN 'WISDOM' THEN 8
WHEN 'HP' THEN 20
WHEN 'MP' THEN 18
END
FROM stat_types s
JOIN species m ON m.name = 'Rat';

INSERT INTO statistics(holder_id_fk, stat_type, val)
SELECT m.id, s.id,
CASE s.long_name
WHEN 'ATTACK' THEN 15
WHEN 'DEFENSE' THEN 5
WHEN 'SPEED' THEN 10
WHEN 'COURAGE' THEN 25
WHEN 'WISDOM' THEN 10
WHEN 'HP' THEN 30
WHEN 'MP' THEN 34
END
FROM stat_types s
JOIN species m ON m.name = 'Cigarette';

INSERT INTO statistics(holder_id_fk, stat_type, val)
SELECT m.id, s.id,
CASE s.long_name
WHEN 'ATTACK' THEN 11
WHEN 'DEFENSE' THEN 12
WHEN 'SPEED' THEN 12
WHEN 'COURAGE' THEN 13
WHEN 'WISDOM' THEN 11
WHEN 'HP' THEN 23
WHEN 'MP' THEN 24
END
FROM stat_types s
JOIN species m ON m.name = 'Pidgeon';

INSERT INTO statistics(holder_id_fk, stat_type, val)
SELECT m.id, s.id,
CASE s.long_name
WHEN 'ATTACK' THEN 15
WHEN 'DEFENSE' THEN 10
WHEN 'SPEED' THEN 9
WHEN 'COURAGE' THEN 13
WHEN 'WISDOM' THEN 8
WHEN 'HP' THEN 17
WHEN 'MP' THEN 20
END
FROM stat_types s
JOIN species m ON m.name = 'Broken bottle';

INSERT INTO statistics(holder_id_fk, stat_type, val)
SELECT m.id, s.id,
CASE s.long_name
WHEN 'ATTACK' THEN 12
WHEN 'DEFENSE' THEN 16
WHEN 'SPEED' THEN 15
WHEN 'COURAGE' THEN 25
WHEN 'WISDOM' THEN 14
WHEN 'HP' THEN 35
WHEN 'MP' THEN 30
END
FROM stat_types s
JOIN species m ON m.name = 'Uprooted weed';