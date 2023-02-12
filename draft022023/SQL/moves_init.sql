DROP TABLE IF EXISTS moves;
DROP TABLE IF EXISTS statuses;
DROP TABLE IF EXISTS move_effects;

CREATE TABLE statuses
(
    id             INTEGER PRIMARY KEY,
    name           TEXT    NOT NULL,
    short_name     TEXT    NOT NULL,
    min_turns      INTEGER NOT NULL,
    max_turns      INTEGER NOT NULL,
    affected_stat  INTEGER,
    factor_percent INTEGER,
    FOREIGN KEY (affected_stat) REFERENCES stats (id)
);

CREATE TABLE move_effects
(
    id             INTEGER PRIMARY KEY,
    related_stat   INTEGER NOT NULL,
    factor_percent INTEGER NOT NULL,
    linked_effect  INTEGER,
    FOREIGN KEY (related_stat) REFERENCES stats (id),
    FOREIGN KEY (linked_effect) REFERENCES move_effects (id)
);

CREATE TABLE moves
(
    id             INTEGER PRIMARY KEY,
    name           TEXT    NOT NULL,
    descrip        TEXT,
    power          INTEGER NOT NULL,
    cost           INTEGER NOT NULL,
    hit_percent    INTEGER NOT NULL,
    effect_percent INTEGER,
    move_category  INTEGER NOT NULL,
    type           INTEGER NOT NULL,
    effect         INTEGER,
    status         INTEGER,
    FOREIGN KEY (type) REFERENCES monster_types (id),
    FOREIGN KEY (effect) REFERENCES move_effects (id),
    FOREIGN KEY (status) REFERENCES statuses (id),
    CHECK ( move_category >= 1 AND move_category <= 3 )
);