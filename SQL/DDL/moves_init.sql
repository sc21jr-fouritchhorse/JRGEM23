DROP TABLE IF EXISTS moves;
DROP TABLE IF EXISTS statuses;
DROP TABLE IF EXISTS move_effects;
DROP TABLE IF EXISTS move_categories;

CREATE TABLE statuses
(
    id             INTEGER PRIMARY KEY,
    status_name    TEXT    NOT NULL,
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
    effect_name    TEXT NOT NULL,
    related_stat   INTEGER,
    related_status INTEGER,
    factor_percent INTEGER NOT NULL,
    linked_effect  INTEGER,
    FOREIGN KEY (related_stat) REFERENCES stats (id),
    FOREIGN KEY (related_status) REFERENCES statuses(id),
    FOREIGN KEY (linked_effect) REFERENCES move_effects (id)
);

CREATE TABLE move_categories
(
    id INTEGER PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE moves
(
    id             INTEGER PRIMARY KEY,
    move_name           TEXT    NOT NULL,
    descrip        TEXT,
    power          INTEGER NOT NULL,
    cost           INTEGER NOT NULL,
    hit_percent    INTEGER NOT NULL,
    effect_percent INTEGER NOT NULL,
    move_category  INTEGER NOT NULL,
    type           INTEGER NOT NULL,
    effect         INTEGER,
    FOREIGN KEY (type) REFERENCES monster_types (id),
    FOREIGN KEY (effect) REFERENCES move_effects (id),
    FOREIGN KEY (move_category) REFERENCES move_categories(id)
);