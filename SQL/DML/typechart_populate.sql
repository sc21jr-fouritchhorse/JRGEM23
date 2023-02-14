INSERT INTO type_matchups(effect_name)
VALUES ('HEALS'),
('IMMUNE'),
('WEAK'),
('NORMAL'),
('STRONG');

INSERT INTO monster_types(type_name)
VALUES ('FLAME'),
('WATER'),
('PLANT'),
('ICE'),
('EARTH'),
('WIND'),
('BOLT'),
('SPIRIT'),
('HERO'),
('HOLY'),
('DEMON'),
('BEAST'),
('UNDEAD'),
('DRAGON'),
('NATURE'),
('INDUST');

INSERT INTO type_interactions(effect_1, effect_2, multiplier)
SELECT e1.id, e2.id,
    CASE e2.effect_name
        WHEN 'HEALS'  THEN (-2.0)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN ( 1.0)
        WHEN 'NORMAL' THEN ( 2.0)
        WHEN 'STRONG' THEN ( 4.0)
    END
FROM type_matchups e1
JOIN 
    type_matchups e2 
    ON e1.effect_name = 'STRONG';


INSERT INTO type_interactions(effect_1, effect_2, multiplier)
SELECT 
    e1.id, e2.id,
    CASE e2.effect_name
        WHEN 'HEALS'  THEN (-0.25)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN ( 0.0)
        WHEN 'NORMAL' THEN ( 0.0)
        WHEN 'STRONG' THEN ( 0.5)
    END
FROM type_matchups e1
JOIN type_matchups e2 ON e1.efffect_name = 'IMMUNE';


INSERT INTO type_interactions(effect_1, effect_2, multiplier)
SELECT e1.id, e2.id,
    CASE e2.effect_name
        WHEN 'HEALS'  THEN (-1.5)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN ( 0.25)
        WHEN 'NORMAL' THEN ( 0.5)
        WHEN 'STRONG' THEN ( 1.0)
    END
FROM type_matchups e1
JOIN type_matchups e2 ON e1.effect_name = 'WEAK';


INSERT INTO type_interactions(effect_1, effect_2, multiplier)
SELECT e1.id, e2.id,
    CASE e2.effect_name
        WHEN 'HEALS'  THEN ( 2.0)
        WHEN 'IMMUNE' THEN ( 0.0)
        WHEN 'WEAK'   THEN (-0.5)
        WHEN 'NORMAL' THEN (-1.0)
        WHEN 'STRONG' THEN (-2.0)
    END
FROM type_matchups e1
JOIN type_matchups e2 ON e1.effect_name = 'HEALS';



INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'FLAME';

INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'WATER';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'PLANT';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'ICE';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'EARTH';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'WIND';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'BOLT';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'SPIRIT';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'HERO';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'HOLY';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'DEMON';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'BEAST';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'UNDEAD';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'DRAGON';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'NATURE';


INSERT INTO type_effectiveness(def_type, atk_type, effect)
SELECT td.id, ta.id,
    CASE ta.type_name
        WHEN 'FLAME'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'WATER'  THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'PLANT'  THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'ICE'    THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'EARTH'  THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'WIND'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'BOLT'   THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'SPIRIT' THEN (SELECT id FROM type_matchups WHERE type_name = 'IMMUNE')
        WHEN 'HERO'   THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'HOLY'   THEN (SELECT id FROM type_matchups WHERE type_name = 'STRONG')
        WHEN 'DEMON'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'BEAST'  THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'UNDEAD' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
        WHEN 'DRAGON' THEN (SELECT id FROM type_matchups WHERE type_name = 'NORMAL')
        WHEN 'NATURE' THEN (SELECT id FROM type_matchups WHERE type_name = 'WEAK')
        WHEN 'INDUST' THEN (SELECT id FROM type_matchups WHERE type_name = 'HEALS')
    END
FROM monster_types ta
JOIN monster_types td ON td.type_name = 'INDUSTRIAL';
