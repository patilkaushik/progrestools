/* ----------------------------------------
Dump schema of all connected DBs
---------------------------------------- */

DEFINE VARIABLE i AS INTEGER NO-UNDO.
DEFINE VARIABLE j AS CHARACTER NO-UNDO.

do i = 1 to NUM-DBS:
CREATE ALIAS DICTDB FOR DATABASE value(ldbname(i)).
j = '/backup/Q1396445/dump/schema/' + SUBSTRING( string(pdbname(i)+ ".df"),16).
RUN prodict/dump_df.p( "ALL", j,"").
end.
