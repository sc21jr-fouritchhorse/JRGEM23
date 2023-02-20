--EXECUTION PRIORITY 4;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS skill_member;

CREATE TABLE skills (
    id INTEGER PRIMARY KEY,
    skill_name TEXT NOT NULL,
    descrip TEXT
);

CREATE TABLE skill_member (
    id INTEGER PRIMARY KEY,
    required_exp INTEGER NOT NULL,
    move_id INTEGER NOT NULL,
    parent_skill INTEGER NOT NULL,
    next_member INTEGER,
    FOREIGN KEY (move_id) REFERENCES moves(id),
    FOREIGN KEY (parent_skill) REFERENCES skills(id),
    FOREIGN KEY (next_member) REFERENCES skill_member(id)
);
