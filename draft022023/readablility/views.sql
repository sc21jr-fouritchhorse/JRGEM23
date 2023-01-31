
DROP VIEW IF EXISTS typechart_as_strings;
DROP VIEW IF EXISTS monsters_as_strings_with_stats;

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

CREATE VIEW monsters_as_strings_with_stats AS
    SELECT
        x.name, mt_1.name, mt_2.name,
        bs.hp, bs.mp, bs.atk, bs.def, bs.spd, bs.crg, bs.wsd
    FROM species x
    JOIN type_combos tc ON x.id = tc.m_id
        JOIN monster_types mt_1 ON tc.t1_id = mt_1.id
            JOIN monster_types mt_2 ON tc.t2_id = mt_2.id
    JOIN base_stats bs ON x.id = bs.m_id
    ORDER BY x.id DESC;