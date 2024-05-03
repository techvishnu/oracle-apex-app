DECLARE
  l_university_name      VARCHAR2(200);
  l_university_location  VARCHAR2(200);
  l_university_state     VARCHAR2(100);
  l_university_website   VARCHAR2(200);
  l_cursor               SYS_REFCURSOR;
  l_counter              NUMBER := 0;

  TYPE university_record IS RECORD (
    name        VARCHAR2(200),
    location    VARCHAR2(200),
    state       VARCHAR2(100),
    website     VARCHAR2(200)
  );

  TYPE university_table IS TABLE OF university_record;
  l_university_table university_table;

BEGIN
  -- Open a cursor to fetch Indian university data
  OPEN l_cursor FOR
    SELECT university_name, university_location, university_state, university_website
    FROM indian_universities;

  -- Fetch university data into a collection
  LOOP
    FETCH l_cursor
      INTO l_university_name, l_university_location, l_university_state, l_university_website;
    EXIT WHEN l_cursor%NOTFOUND;
    l_counter := l_counter + 1;
    l_university_table(l_counter) := university_record(
      l_university_name,
      l_university_location,
      l_university_state,
      l_university_website
    );
  END LOOP;

  CLOSE l_cursor;

  -- Process the university data collection
  FOR i IN 1 .. l_university_table.COUNT LOOP
    -- Perform any desired operations with the university data
    DBMS_OUTPUT.PUT_LINE(
      'University Name: '   || l_university_table(i).name   || ' | ' ||
      'Location: '          || l_university_table(i).location || ' | ' ||
      'State: '             || l_university_table(i).state  || ' | ' ||
      'Website: '           || l_university_table(i).website
    );
  END LOOP;
END;
/
