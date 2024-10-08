CREATE TABLE demons (
    demon_id              RAW(16) DEFAULT sys_guid() PRIMARY KEY,
    demon                 VARCHAR2(1000) NOT NULL,
    CONSTRAINT unique_demon UNIQUE ( demon ),

    -- Additional columns for note and dates
    note                    VARCHAR2(4000),  -- General-purpose note field
    date_created            TIMESTAMP(9) WITH TIME ZONE DEFAULT systimestamp(9) NOT NULL,
    date_updated            TIMESTAMP(9) WITH TIME ZONE,
        date_created_or_updated TIMESTAMP(9) WITH TIME ZONE GENERATED ALWAYS AS ( coalesce(date_updated, date_created) ) VIRTUAL
);

CREATE OR REPLACE TRIGGER trigger_set_date_updated_demon BEFORE
    UPDATE ON demons
    FOR EACH ROW
BEGIN
    :new.date_updated := systimestamp;
END;
/