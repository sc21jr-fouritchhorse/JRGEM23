DROP TABLE IF EXISTS base_stats;
DROP TABLE IF EXISTS type_combos;
DROP TABLE IF EXISTS species;


CREATE table species(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL);

/*TODO: change this to accomadate for genetics/exp when those are implemented*/
CREATE TABLE base_stats(
    id INTEGER PRIMARY KEY,
    atk INTEGER NOT NULL,
    def INTEGER NOT NULL,
    crg INTEGER NOT NULL,
    wsd INTEGER NOT NULL,
    spd INTEGER NOT NULL,
    hp INTEGER NOT NULL,
    mp INTEGER NOT NULL,
    m_id INTEGER NOT NULL,
    FOREIGN KEY (m_id) REFERENCES species(id)
);

CREATE table type_combos(
    id INTEGER PRIMARY KEY,
    m_id INTEGER NOT NULL,
    t1_id INTEGER NOT NULL,
    t2_id INTEGER,
    FOREIGN KEY (m_id) REFERENCES species(id),
    FOREIGN KEY (t1_id) REFERENCES monster_types(id),
    FOREIGN KEY (t2_id) REFERENCES monster_types(id)
);
