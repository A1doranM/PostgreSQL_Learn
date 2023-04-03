-- JSON in PostgreSQL

-- Getting info from JSON

-- 1. Get json length

jsonb_array_length

-- 2. List all keys within JSON row

json_object_keys

-- 3. If we want to see key/value style

SELECT
    j.key,
    j.value
FROM table_name, jsonb_each(table_name) j;

-- 4. Turning JSON object to table format

jsonb_to_record

SELECT
    j.*
FROM table_name, jsonb_to_record(table_name) j (
    director_id ING,
    first_name VARCHAR(255)
    ....
    other table_structure
);

-- 5. Existence operator "?" returns nothing or data.

SELECT
    *
FROM directors_docs
WHERE body->'first_name' ? 'John';

--- INDEXING ON JSONB

-- For indexing JSON we should use GIN (Generalized Inverted Index)
-- The core capability of GIN Index is to speed up FULL TEXT SEARCH
-- When performing searching based on specific Keys or elements in a TEXT or a document, GIN Index
-- is the way to go.
-- It sores "Key" (or an element or a value) and the "position list" pairs. The position
-- list is the rowID of the key. This means, if the "Key" occurs at multiple places in the
-- document, GIN Index stores the Key only once along with its position of occurrences which
-- not only keeps the GIN Index compact in size and also helps speed-up the searches in a great way.
-- The default GIN operator class for jsonb supports queries with the key-exists operators
-- ?, ?| and ?&, the containment operator @>, and the jsonpath match operators @? and @@.

-- Disadvantages
-- Size of the GIN Index can be very big based in the data size and complexity.

-- Lets try it

CREATE INDEX idx_gin_contacts_docs_body ON table_name USING GIN(field_name);

-- Another way to create Index

-- The technical difference between a jsonb_ops and a jsonb_path_ops GIN index is
-- that the former creates independent index items for each key and value in the
-- data, while the latter creates index items only for each value in the data.
-- Basically, each jsonb_path_ops index item is a hash of the value and the key(s)
-- leading to it; for example to index {"foo": {"bar": "baz"}}, a single index
-- item would be created incorporating all three of foo, bar, and baz into the
-- hash value. Thus a containment query looking for this structure would result
-- in an extremely specific index search; but there is no way at all to find out
-- whether foo appears as a key. On the other hand, a jsonb_ops index would create
-- three index items representing foo, bar, and baz separately; then to do the
-- containment query, it would look for rows containing all three of these items.
-- While GIN indexes can perform such an AND search fairly efficiently, it will
-- still be less specific and slower than the equivalent jsonb_path_ops search,
-- especially if there are a very large number of rows containing any single one
-- of the three index items.

-- A disadvantage of the jsonb_path_ops approach is that it produces no index
-- entries for JSON structures not containing any values, such as {"a": {}}.
-- If a search for documents containing such a structure is requested, it will
-- require a full-index scan, which is quite slow. jsonb_path_ops is therefore
-- ill-suited for applications that often perform such searches.

CREATE INDEX idx_gin_contacts_docs_body_2 ON table_name USING GIN(field_name jsonb_path_ops);
