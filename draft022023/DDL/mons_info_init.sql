DROP TABLE IF EXISTS base_stats;
DROP TABLE IF EXISTS type_combos;
DROP TABLE IF EXISTS species;


CREATE table species(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL);

CREATE TABLE stat_types(
    id INTEGER PRIMARY KEY,
	long_name TEXT NOT NULL,
	short_name TEXT NOT NULL
);


CREATE TABLE statistics(
	id INTEGER PRIMARY KEY,
	/*This references either the species (if a base stat) 
    or the instance of the monster(if statxp or genetics)*/
	holder_id_fk INTEGER NOT NULL,
	val INTEGER NOT NULL,
	stat_type INTEGER NOT NULL,
	FOREIGN KEY (stat_type) REFERENCES stat_types(id)
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
