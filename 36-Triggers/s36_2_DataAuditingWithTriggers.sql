-- Data auditing with triggers
-- #################################

-- Example. We have 'players' table and we want to log all data when the name of a player
-- changed or updated.

-- Players table

CREATE TABLE players (
   player_id SERIAL PRIMARY KEY,
   name VARCHAR(100)
);

-- Player audit table to store all changes

CREATE TABLE players_audits (
    player_audit_id SERIAL PRIMARY KEY,
    player_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    edit_date TIMESTAMP NOT NULL
);

-- Trigger

CREATE OR REPLACE FUNCTION fn_players_name_changes_log()
    RETURNS Trigger
    LANGUAGE PLPGSQL
    AS
&&
BEGIN

    -- COMPARE THE new value with old
    -- NEW, OLD

    -- if new name not equals to old name
    if NEW.name <> OLD.name THEN
        INSERT INTO players_audits
        (
            player_id,
            name,
            edit_date
        )
        VALUES
        (
            OLD.player_id,
            OLD.name,
            NOW()
        );
    END IF;

    RETURN NEW;

END;
&&
