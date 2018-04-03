<!--METADATA TYPE= "typelib"  NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\System\ado\msado15.dll"  -->
<%@ codepage="65001" language="VBScript" %>
<meta charset="utf-8">
<%
title = Request.form("title")
writer = Request.form("writer")
content = Request.form("content")
%>

<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->

<%
'INSERT INTO tbl_board(
'	title,
'	writer,
'	regdate,
'	content)
'VALUES(
'	#{title},
'	#{writer},
'	getdate(),
'	#{content}
')

strSql = "INSERT INTO tbl_board(title, wrtier, regdate, content) VALUES (?, ?, getdate(), ?)"
Set objCom = Server.CreateObject("ADODB.Command")
with objCom
    .ActiveConnection = dbCon
    .CommandText = strSql
    .Prepared = True
    .Parameters.Append .CreateParameter("@title", adVarChar, adParamInput, 255, title)
    .Parameters.Append .CreateParameter("@writer", adVarChar, adParamInput, 255, writer)
    .Parameters.Append .CreateParameter("@content", adVarChar, adParamInput, 255, content)
    .Execute
End With

'strSql = "INSERT INTO tbl_board(title, writer, regdate, content) VALUES ('" & title & "', '" & writer & "', getdate(), '" & content & "')"
'rs.Open strSql, dbCon
'dbCon.execute(strSql)
%>

<!-- include DB Disconnector -->
<!-- #include virtual="/common/dbDiscon.asp" -->

<%
Response.write("<script>alert('성공적으로 글을 게시했습니다')</script>")
Response.write("<script>window.location.href='./'</script>")
%>