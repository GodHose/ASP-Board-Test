<%@ codepage="65001" language="VBScript" %>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<meta name="Generator" content="EditPlus®">
	<title>Home page</title>
</head>
<body>
<%
Dim id, pw, nickname

id = Request.form("id")
pw = Request.form("pw")
nickname = Request.form("nickname")
%>

<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->

<%
'SELECT *
'FROM tbl_login
'WHERE id = #{id}
strSql = "SELECT * FROM tbl_login WHERE id = '" & id & "'"
rs.Open strSql, dbCon

If Not (rs.eof) Then
    Response.write("<script>alert('중복되는 아이디가 존재합니다.')</script>")
Else      
    rs.close
    strSql = "INSERT INTO tbl_login(id, pw, name) VALUES ('" & id & "', '" & pw & "', '" & nickname & "')"
    rs.Open strSql, dbCon

    Response.write("<script>alert('회원가입에 성공했습니다.')</script>")  
End If
%>

<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->

<%
Response.write("<script>window.location.href='./'</script>")
%>
</body>
</html>