<%
Dim dbCon , dbIP, dbId, dbPasswd, strSql

dbIP = "localhost"
dbId = "sa"
dbPasswd = "ghtp8787@"
dbName = "testdb"

set dbCon = Server.CreateObject("ADOdb.Connection")
dbCon.Open "Provider=SQLOLEDB;Data Source=" & dbIP & ";Initial Catalog=" & dbName  & ";user ID=" & dbId & ";password=" & dbPasswd & ";"

Set rs = Server.CreateObject("ADODB.Recordset")
Set rs.ActiveConnection = dbCon
%>