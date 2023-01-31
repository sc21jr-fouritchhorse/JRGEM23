DROP TABLE IF EXISTS type_matchups;
DROP TABLE IF EXISTS monster_types;
DROP TABLE IF EXISTS type_interactions;
DROP TABLE IF EXISTS type_effectiveness;
DROP VIEW IF EXISTS typechart_as_strings;

CREATE TABLE type_matchups (
    id    INTEGER PRIMARY KEY,
    name  TEXT NOT NULL
);

CREATE TABLE monster_types(
    id    INTEGER PRIMARY KEY,
    name  TEXT NOT NULL
);

INSERT INTO type_matchups(name) VALUES ("HEALS");
INSERT INTO type_matchups(name) VALUES ("IMMUNE");
INSERT INTO type_matchups(name) VALUES ("WEAK");
INSERT INTO type_matchups(name) VALUES ("NORMAL");
INSERT INTO type_matchups(name) VALUES ("STRONG");



INSERT INTO monster_types(name) VALUES ("FLAME");
INSERT INTO monster_types(name) VALUES ("WATER");
INSERT INTO monster_types(name) VALUES ("PLANT");
INSERT INTO monster_types(name) VALUES ("ICE");
INSERT INTO monster_types(name) VALUES ("EARTH");
INSERT INTO monster_types(name) VALUES ("WIND");
INSERT INTO monster_types(name) VALUES ("BOLT");
INSERT INTO monster_types(name) VALUES ("SPIRIT");
INSERT INTO monster_types(name) VALUES ("HERO");
INSERT INTO monster_types(name) VALUES ("HOLY");
INSERT INTO monster_types(name) VALUES ("DEMON");
INSERT INTO monster_types(name) VALUES ("BEAST");
INSERT INTO monster_types(name) VALUES ("UNDEAD");
INSERT INTO monster_types(name) VALUES ("DRAGON");
INSERT INTO monster_types(name) VALUES ("NATURE");
INSERT INTO monster_types(name) VALUES ("INDUST");


/*For now, this modifies the strength of the attack itself rather
than (directly) calcing how much is taken from health*/

CREATE TABLE type_interactions(
    id    INTEGER PRIMARY KEY,
    effect_1 INTEGER NOT NULL,
    effect_2 INTEGER NOT NULL,
    result FLOAT,
    FOREIGN KEY (effect_1) REFERENCES type_matchups(id),
    FOREIGN KEY (effect_2) REFERENCES type_matchups(id)
);


INSERT INTO type_interactions(effect_1, effect_2, result)
SELECT e1.id, e2.id,
    CASE e2.name
        WHEN 'HEALS'  THEN (-2.0)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN ( 1.0)
        WHEN 'NORMAL' THEN ( 2.0)
        WHEN 'STRONG' THEN ( 4.0)
    END
FROM type_matchups e1
JOIN type_matchups e2 ON e1.name = 'STRONG';


INSERT INTO type_interactions(effect_1, effect_2, result)
SELECT e1.id, e2.id,
    CASE e2.name
        WHEN 'HEALS'  THEN (-0.25)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN ( 0.0)
        WHEN 'NORMAL' THEN ( 0.0)
        WHEN 'STRONG' THEN ( 0.5)
    END
FROM type_matchups e1
JOIN type_matchups e2 ON e1.name = 'IMMUNE';


INSERT INTO type_interactions(effect_1, effect_2, result)
SELECT e1.id, e2.id,
    CASE e2.name
        WHEN 'HEALS'  THEN (-1.5)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN ( 0.25)
        WHEN 'NORMAL' THEN ( 0.5)
        WHEN 'STRONG' THEN ( 1.0)
    END
FROM type_matchups e1
JOIN type_matchups e2 ON e1.name = 'WEAK';


INSERT INTO type_interactions(effect_1, effect_2, result)
SELECT e1.id, e2.id,
    CASE e2.name
        WHEN 'HEALS'  THEN ( 2.0)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN (-0.5)
        WHEN 'NORMAL' THEN (-1.0)
        WHEN 'STRONG' THEN (-2.0)
    END
FROM type_matchups e1
JOIN type_matchups e2 ON e1.name = 'HEALS';



CREATE TABLE  type_effectiveness(
    id      INTEGER PRIMARY KEY,
    atk_type  INTEGER NOT NULL,
    def_type INTEGER NOT NULL,
    effect  INTEGER NOT NULL,
    FOREIGN KEY (atk_type) REFERENCES monster_types(id),
    FOREIGN KEY (def_type) REFERENCES monster_types(id),
    FOREIGN KEY (effect) REFERENCES type_matchups(id)
);


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'FLAME';

INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'WATER';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'PLANT';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'ICE';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'EARTH';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'WIND';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'BOLT';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'SPIRIT';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'HERO';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'HOLY';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'DEMON';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'BEAST';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'UNDEAD';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'DRAGON';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'NATURE';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE name = 'IMMUNE')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE name = 'HEALS')
    END
FROM monster_types ta
JOIN monster_types td ON td.name = 'INDUSTRIAL';

CREATE VIEW typechart_as_strings AS
    SELECT
           x.id,
           t_1.name AS attacking_type,
           t_2.name AS defending_type,
           e.name   AS damage_effect
        FROM type_effectiveness x
        JOIN monster_types t_1
            ON t_1.id = x.atk_type
        JOIN monster_types t_2
            ON t_2.id = x.def_type
        JOIN type_matchups e
            ON e.id = x.effect
        ORDER BY t_2.id;