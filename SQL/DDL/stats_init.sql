--EXECUTION PRIORITY 2;
DROP TABLE IF EXISTS stats;
DROP TABLE IF EXISTS stat_instances;
DROP TABLE IF EXISTS stat_collections;
DROP INDEX IF EXISTS stat_count;


CREATE TABLE stats (
    id INTEGER PRIMARY KEY,
    stat_name TEXT NOT NULL,
    name_short TEXT NOT NULL
);

CREATE TABLE stat_collections(
    id INTEGER PRIMARY KEY,
    owner_id INTEGER NOT NULL,
    atk_instance INTEGER NOT NULL,
    def_instance INTEGER NOT NULL,
    spd_instance INTEGER NOT NULL,
    crg_instance INTEGER NOT NULL,
    wsd_instance INTEGER NOT NULL,
    FOREIGN KEY (atk_instance) REFERENCES stat_instances(id),
    FOREIGN KEY (def_instance) REFERENCES stat_instances(id),
    FOREIGN KEY (spd_instance) REFERENCES stat_instances(id),
    FOREIGN KEY (crg_instance) REFERENCES stat_instances(id),
    FOREIGN KEY (wsd_instance) REFERENCES stat_instances(id)
);

CREATE TABLE stat_instances(
    id INTEGER PRIMARY KEY,
    stat_value INTEGER NOT NULL,
    stat_type INTEGER NOT NULL,
    set_code INTEGER NOT NULL,
    FOREIGN KEY (stat_type) REFERENCES stats(id)
);
