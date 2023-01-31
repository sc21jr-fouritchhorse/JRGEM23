DROP TABLE IF EXISTS stats;
DROP TABLE IF EXISTS type_combos;
DROP TABLE IF EXISTS species;


CREATE TABLE stats(
    id INTEGER PRIMARY KEY,
    atk INTEGER NOT NULL,
    def INTEGER NOT NULL,
    crg INTEGER NOT NULL,
    wsd INTEGER NOT NULL,
    spd INTEGER NOT NULL,
    hp INTEGER NOT NULL,
    mp INTEGER NOT NULL,
    acc INTEGER NOT NULL
);

CREATE table type_combos(
    id INTEGER PRIMARY KEY,
    t1_id INTEGER NOT NULL,
    t2_id INTEGER,
    FOREIGN KEY (t1_id) REFERENCES monster_types(id),
    FOREIGN KEY (t2_id) REFERENCES monster_types(id)
);

CREATE table species(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    type_id INTEGER NOT NULL,
    base_stats_id INTEGER NOT NULL,
    base_skills_id INTEGER NOT NULL,
    FOREIGN KEY (type_id) REFERENCES type_combos(id),
    FOREIGN KEY (base_stats_id)  REFERENCES stats(id),
    FOREIGN KEY (base_skills_id) REFERENCES skills(id)
);