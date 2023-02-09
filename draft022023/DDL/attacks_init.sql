DROP TABLE IF EXISTS spells;
DROP TABLE IF EXISTS statuses;
DROP TABLE IF EXISTS move_effect;
DROP TABLE IF EXISTS skill_members;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS skillsets;

CREATE TABLE statuses(
	id INTEGER PRIMARY KEY,
	name TEXT NOT NULL,
	related_stat_id INTEGER,
	reduction_factor FLOAT,
	FOREIGN KEY (related_stat_id) REFERENCES stat_types(id)
);

CREATE TABLE move_effect(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL, 
    related_stat INTEGER,
	related_status INTEGER,
    factor FLOAT, 
    FOREIGN KEY (related_stat) REFERENCES stat_types(id),
	FOREIGN KEY (related_status) REFERENCES statuses(id)
);


CREATE TABLE effect_link(
    id INTEGER PRIMARY KEY,
    exp_count INTEGER NOT NULL,
    prev_effect INTEGER,
    next_effect INTEGER, 
    FOREIGN KEY (prev_effect) REFERENCES move_effect(id),
    FOREIGN KEY (next_effect) REFERENCES move_effect(id)
);



CREATE TABLE spells(
    id INTEGER PRIMARY KEY,
    type_id INTEGER NOT NULL,
	effect_id INTEGER,
    name TEXT NOT NULL, 
    power INTEGER NOT NULL,
    cost INTEGER NOT NULL,
    acc_multiplier FLOAT NOT NULL,
    is_physical BOOLEAN NOT NULL,
    FOREIGN KEY (type_id) REFERENCES monster_types(id),
	FOREIGN KEY (effect_id) REFERENCES move_effect(id)
);


CREATE TABLE spell_link(
    id INTEGER PRIMARY KEY,
    req_points INTEGER,
    prev_spell INTEGER,
    next_spell INTEGER, 
    FOREIGN KEY (prev_spell) REFERENCES spells(id),
    FOREIGN KEY (next_spell) REFERENCES spells(id)
);



CREATE TABLE skills(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
	members_id INTEGER NOT NULL,
	FOREIGN KEY (members_id) REFERENCES skill_members
);

CREATE TABLE skill_members(
    id INTEGER PRIMARY KEY,
    list_head INTEGER NOT NULL,
    FOREIGN KEY (list_head) REFERENCES spell_link(id)
);

CREATE TABLE skillsets(
    id INTEGER PRIMARY KEY,
    skill_1 INTEGER NOT NULL,
    skill_2 INTEGER,
    skill_3 INTEGER,
    FOREIGN KEY (skill_1) REFERENCES skills(id),
    FOREIGN KEY (skill_2) REFERENCES skills(id),
    FOREIGN KEY (skill_3) REFERENCES skills(id)
);