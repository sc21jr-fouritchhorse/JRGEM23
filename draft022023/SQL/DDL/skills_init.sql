DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS skill_member;

CREATE TABLE skills (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    descrip TEXT
);

CREATE TABLE skill_member (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    descrip TEXT,
    point_cost INTEGER NOT NULL,
    move INTEGER NOT NULL,
    parent_skill INTEGER NOT NULL,
    next INTEGER,
    FOREIGN KEY (move) REFERENCES moves(id),
    FOREIGN KEY (parent_skill) REFERENCES skills(id),
    FOREIGN KEY (next) REFERENCES skill_member(id)
);