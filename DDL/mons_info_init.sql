DROP TABLE IF EXISTS base_stats;
DROP TABLE IF EXISTS type_combos;
DROP TABLE IF EXISTS species;


CREATE table species(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL);

CREATE TABLE statistic(
	id INTEGER PRIMARY KEY,
	/*This references either the species (if a base stat) or the instance of the monster(if statxp or genetics)*/
	holder_id_fk INTEGER NOT NULL,
	name TEXT NOT NULL,
	value INTEGER NOT NULL
);
	
CREATE TABLE base_stats(
    id INTEGER PRIMARY KEY,
    m_id INTEGER NOT NULL,
    atk INTEGER NOT NULL,
    def INTEGER NOT NULL,
    crg INTEGER NOT NULL,
    wsd INTEGER NOT NULL,
    spd INTEGER NOT NULL,
    hp INTEGER NOT NULL,
    mp INTEGER NOT NULL,
    FOREIGN KEY (m_id) REFERENCES species(id),
	FOREIGN KEY (atk) REFERENCES statistic(id),
	FOREIGN KEY (def) REFERENCES statistic(id),
	FOREIGN KEY (spd) REFERENCES statistic(id),
	FOREIGN KEY (crg) REFERENCES statistic(id),
	FOREIGN KEY (wsd) REFERENCES statistic(id),
	FOREIGN KEY (hp) REFERENCES statistic(id),
	FOREIGN KEY (mp) REFERENCES statistic(id)
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
