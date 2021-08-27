I was working on some feature and wrangling my brain on how to test the
code since it depended on some complicated modules. And then it hit me,
I could just mock the function out and it'd have some expected return.
This might seem obvious in hindsight, but this was really amazing when I
got to learn this. I'll go through things to mock here and add in
references to where I got things.


Plan:
- Basic python mocking with an example
- Difference between mock.path and mock.path.object?
- mocking functions
- Using side_effects and return in mocks.
- How to mock context managers, mock.patch.object and why?
- Parametrizing tests?
- How do you assert exceptions e.g. pytest.raises?
- How to usue temporary directories e.g. tmpdir?
- what does this do? mocker.patch("builtins.open", mocker.mock_open(), create=True)
- mocking date times and their disadvantages
  dealing with datetime and freezeguns dependency.
- mocking function call on an object e.g. postgresql cursor


dangerous mocking scenarios e.g. mocking python libraries, etc.

Mocking function and context manager:
`
Mocking function call on an object:
mock_sth = mocker.Mock(fetchall = lambda : return thing )

Mocking psql db_conn and cursor:

mock_db_conn = mocker.MagicMock()
mock_cursor = mocker.Mock(fetchall=lambda: [(x,) for x in range(10)])
mock_db_conn.cursor = lambda: mock_cursor
mock_context = mocker.Mock()
mock_context.enter = lambda: mock_db_conn
mock_context.exit = lambda: None
mocker.patch('psql_dbconn').return_value.enteer.return_value = mock_db_conn
