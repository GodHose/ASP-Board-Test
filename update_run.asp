<%@ codepage="65001" language="VBScript" %>
<meta charset="utf-8">
<%
bno = Request.form("bno")
title = Request.form("title")
content = Request.form("content")
%>
<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->
<%
'UPDATE tbl_board
'SET title = #{title}
'	, content = #{content}
'WHERE bno = #{bno}
strSql = "UPDATE tbl_board SET title = '" & title & "', content = '" & content & "' WHERE bno = '" & bno & "'"
rs.Open strSql, dbCon

Response.write("<script>alert('성공적으로 글을 수정했습니다')</script>")
Response.write("<script>window.location.href='./'</script>")
%>

<!-- include DB Disconnector -->
<!-- #include virtual="/common/dbDiscon.asp" -->