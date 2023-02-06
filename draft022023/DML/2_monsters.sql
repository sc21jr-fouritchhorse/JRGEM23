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
INSERT INTO base_stats(m_id, atk, def, spd, crg, wsd, hp, mp)
    VALUES((SELECT id FROM species  WHERE name = 'Rat'),
                  15, 11, 22, 11, 8, 20, 18);
INSERT INTO type_combos(m_id, t1_id, t2_id)
    VALUES ((SELECT id FROM species WHERE name = 'Rat'),
            (SELECT id FROM monster_types t WHERE name = 'BEAST'),
            (SELECT id FROM monster_types t WHERE name = 'BEAST'));


INSERT INTO species(name)
    VALUES('Cigarette');
INSERT INTO base_stats(m_id, atk, def, spd, crg, wsd, hp, mp)
    VALUES ((SELECT  id FROM species  WHERE name = 'Cigarette'),
             15, 5, 10, 25, 10, 30, 34);
INSERT INTO type_combos(m_id, t1_id, t2_id)
    VALUES ((SELECT id FROM species WHERE name = 'Cigarette'),
           (SELECT id FROM monster_types WHERE name = 'FLAME'),
           (SELECT id FROM monster_types WHERE name = 'FLAME'));


INSERT INTO species(name)
    VALUES('Pidgeon');
INSERT INTO base_stats(m_id, atk, def, spd, crg, wsd, hp, mp)
    VALUES ((SELECT id FROM species WHERE name = 'Pidgeon'),
             11, 12, 12, 13, 11, 23, 24);
INSERT INTO type_combos(m_id, t1_id, t2_id)
    VALUES ((SELECT id FROM species WHERE name = 'Pidgeon'),
            (SELECT id FROM monster_types WHERE name = 'BEAST'),
            (SELECT id FROM monster_types WHERE name = 'WIND'));


INSERT INTO species(name)
    VALUES('Broken bottle');
INSERT INTO base_stats(m_id, atk, def, spd, crg, wsd, hp, mp)
    VALUES((SELECT id FROM species WHERE name = 'Broken bottle'),
            15, 10, 9, 13, 8, 17, 20);
INSERT INTO type_combos(m_id, t1_id, t2_id)
    VALUES((SELECT id FROM species WHERE name = 'Broken bottle'),
           (SELECT id FROM monster_types WHERE name = 'WATER'),
           (SELECT id FROM monster_types WHERE name = 'WATER'));


INSERT INTO species(name)
    VALUES('Uprooted weed');
INSERT INTO base_stats(m_id, atk, def, spd, crg, wsd, hp, mp)
    VALUES((SELECT id FROM species WHERE name = 'Uprooted weed'),
            12, 16, 15, 25, 14, 35, 30);
INSERT INTO type_combos(m_id, t1_id, t2_id)
    VALUES((SELECT id FROM species WHERE name = 'Uprooted weed'),
           (SELECT id FROM monster_types WHERE name = 'PLANT'),
           (SELECT id FROM monster_types WHERE name = 'PLANT'))