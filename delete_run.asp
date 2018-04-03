<%@ codepage="65001" language="VBScript" %>
<meta charset="utf-8">

<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->

<%
bno = Request.querystring("bno")

'DELETE FROM tbl_board
'WHERE bno = #{bno}
strSql = "DELETE FROM tbl_board WHERE bno = '" & bno & "'"
rs.Open strSql, dbCon
%>

<!-- include DB Disconnector -->
<!-- #include virtual="/common/dbDiscon.asp" -->

<%
Response.write("<script>alert('성공적으로 글을 삭제했습니다')</script>")
Response.write("<script>window.location.href='./'</script>")
%>