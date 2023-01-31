DROP TABLE IF EXISTS spells;
DROP TABLE IF EXISTS skill_members;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS skillsets;

CREATE TABLE spells(
    id INTEGER PRIMARY KEY,
    type_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    power INTEGER NOT NULL,
    cost INTEGER NOT NULL,
    acc_multiplier FLOAT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES monster_types(id)
);

CREATE TABLE skills(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE skill_members(
    spell_id INTEGER NOT NULL,
    skill_id INTEGER NOT NULL,
    PRIMARY KEY (spell_id, skill_id),
    FOREIGN KEY (spell_id) REFERENCES spells(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id)
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