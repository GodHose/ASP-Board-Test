<%@ codepage="65001" language="VBScript" %>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<meta name="Generator" content="EditPlus®">
	<title>Home page</title>
</head>
<body>
<%
Dim id, pw
id = Request.form("id")
pw = Request.form("pw")
%>
<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->
<%
'SELECT *
'FROM tbl_login
'WHERE id = #{id}
'	AND pw = #{pw}
strSql = "SELECT * FROM tbl_login WHERE id = '" & id & "' AND pw = '" & pw & "'"
rs.Open strSql, dbCon

nickname = Empty

Do Until rs.eof
	nickname = rs("name")
	rs.movenext
loop

dbCon.close()
set dbCon = Nothing


If Not IsEmpty(nickname) Then
	Session("login")=id
	Session("nickname")=nickname
	Response.write("<script>alert('로그인에 성공했습니다.')</script>")
Else 
	Response.write("<script>alert('로그인에 실패했습니다.')</script>")
End If

Response.write("<script>window.location.href='./'</script>")
%>

<!-- include DB Disconnector -->
<!-- #include virtual="/common/dbDiscon.asp" -->

</body>
</html>
