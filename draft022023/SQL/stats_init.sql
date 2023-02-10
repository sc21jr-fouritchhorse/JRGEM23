DROP TABLE IF EXISTS stats;
DROP TABLE IF EXISTS stat_instances;
DROP TABLE IF EXISTS stat_collections;
DROP INDEX IF EXISTS stat_count;


CREATE TABLE stats (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    name_short TEXT NOT NULL
);

CREATE TABLE stat_collections(
    id INTEGER PRIMARY KEY,
    owner_id INTEGER NOT NULL
);

CREATE TABLE stat_instances(
    id INTEGER PRIMARY KEY,
    value INTEGER NOT NULL,
    stat_type INTEGER NOT NULL,
    set_code INTEGER NOT NULL,
    FOREIGN KEY (stat_type) REFERENCES stats(id),
    FOREIGN KEY (set_code) REFERENCES stat_collections(id)
);

CREATE UNIQUE INDEX stat_count ON stat_instances(set_code, stat_type);

CREATE TRIGGER stat_count_check
BEFORE INSERT ON stat_instances
BEGIN
  SELECT CASE
    WHEN (SELECT COUNT(*) FROM stat_instances WHERE set_code = NEW.set_code AND stat_type = NEW.stat_type) > 5 THEN
      RAISE(ABORT, 'Too many instances of stat type in set code')
    END;
END;