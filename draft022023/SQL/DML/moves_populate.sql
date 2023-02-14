INSERT INTO statuses(name, short_name, min_turns, max_turns, affected_stat, factor_percent)
VALUES ('POISON', 'PSN', 3, 10, (SELECT id FROM stats WHERE name_short = 'DEF'), 75),
       ('BAD POISON', 'XL_PSN', 2, 8, (SELECT id FROM stats WHERE name_short = 'DEF'), 50),
       ('SLEEP', 'SLP', 2, 7, 0, 0),
       ('PARALYSIS', 'PRLS', 5, 10, (SELECT id FROM stats WHERE name_short = 'SPD'), 25),
       ('CONFUSED', 'CNFS', 2, 7, (SELECT id FROM stats WHERE name_short = 'ATK'), 150),
       ('LOVESTRUCK', 'LV', 5, 15, (SELECT id FROM stats WHERE name_short = 'WSD'), 50),
       ('PANIC', 'PNC', 5, 15, (SELECT id FROM stats WHERE name_short = 'CRG'), 50),
       ('BURN', 'BRN', 5, 10, (SELECT id FROM stats WHERE name_short = 'ATK'), 50);

INSERT INTO move_effects(name, related_stat, related_status, factor_percent, linked_effect)
VALUES ('BURN_EFFECT', NULL, (SELECT id FROM statuses WHERE name = 'BURN'), 0, NULL),
       --note to self, create check in the application that links to the power of the calling move
       ('DRAIN_EFFECT', (SELECT id FROM stats WHERE name_short = 'HP'), NULL, 50, NULL),
       ('DEF_DROP', (SELECT id FROM stats WHERE name_short = 'DEF'), NULL, 75, NULL),
       ('CRG+DEF_DROP', (SELECT id FROM stats WHERE name_short = 'CRG'), NULL, 75,
        (SELECT id FROM move_effects WHERE name = 'DEF_DROP'));

INSERT INTO move_categories(name)
VALUES('ATK/DEF'),
      ('CRG/WSD'),
      ('EFFECT'),
      ('DEF/ATK');

INSERT INTO moves(name, type, move_category, power, cost, hit_percent, effect_percent, effect)
VALUES('Blister', (SELECT id FROM monster_types WHERE name = 'FLAME'),
       (SELECT id FROM move_categories WHERE name = 'CRG/WSD'), 10, 0, 100, 25,
       (SELECT id FROM move_effects WHERE name = 'BURN_EFFECT')),
      ('Scream', (SELECT id FROM monster_types WHERE name = 'BEAST'),
       (SELECT id FROM move_categories WHERE name = 'EFFECT'), 0, 5, 0, 65,
       (SELECT id FROM move_effects WHERE name = 'CRG+DEF_DROP')),
      ('Claw',  (SELECT id FROM monster_types WHERE name = 'BEAST'),
       (SELECT id FROM move_categories WHERE name = 'ATK/DEF'), 12, 0,
       100, 0, NULL);

