--EXECUTION PRIORITY 1;
DROP TABLE IF EXISTS type_matchups;
DROP TABLE IF EXISTS monster_types;
DROP TABLE IF EXISTS type_interactions;
DROP TABLE IF EXISTS type_effectiveness;

CREATE TABLE type_matchups (
    id INTEGER PRIMARY KEY,
    effect_name TEXT NOT NULL
);

CREATE TABLE monster_types(
    id INTEGER PRIMARY KEY,
    type_name TEXT NOT NULL
);

/*For now, this modifies the strength of the attack itself rather
than (directly) calcing how much is taken from health*/
CREATE TABLE type_interactions(
    id INTEGER PRIMARY KEY,
    effect_1 INTEGER NOT NULL,
    effect_2 INTEGER NOT NULL,
    multiplier FLOAT,
    FOREIGN KEY (effect_1) REFERENCES type_matchups(id),
    FOREIGN KEY (effect_2) REFERENCES type_matchups(id)
);


CREATE TABLE type_effectiveness(
    id INTEGER PRIMARY KEY,
    atk_type INTEGER NOT NULL,
    def_type INTEGER NOT NULL,
    effect INTEGER NOT NULL,
    FOREIGN KEY (atk_type) REFERENCES monster_types(id),
    FOREIGN KEY (def_type) REFERENCES monster_types(id),
    FOREIGN KEY (effect) REFERENCES type_matchups(id)
);
