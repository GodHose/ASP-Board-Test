<%@ codepage="65001" language="VBScript" %>
<!DOCTYPE html>
<head>
  <title>ASP 게시판 구축 실습</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="./css/style.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

<%
Dim bno
bno = Request.QueryString("bno")

%>
<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->
<%
'UPDATE tbl_board
'SET viewcnt = viewcnt + 1
'WHERE bno = #{bno}
strSql = "UPDATE tbl_board SET viewcnt = viewcnt + 1 WHERE bno = '" & bno & "'"
rs.Open strSql, dbCon

'SELECT *
'FROM tbl_board
'WHERE bno = #{bno}
strSql = "SELECT * FROM tbl_board WHERE bno = '" & bno & "'"
rs.Open strSql, dbCon
Do Until rs.eof
	title = rs("title")
	writer = rs("writer")
	regdate = rs("regdate")
	viewcnt = rs("viewcnt")
	content = rs("content")
	rs.movenext
loop
%>

<!-- Header -->
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="/">Board Test</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#about">Board</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Container (About Section) -->
<div id="about" class="container-fluid">
	<div class="row">
		<div class="col-sm-12">
			<h2><%= bno%>번 게시글</h2><br>
			<div class="form-group">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="title" name="title" value="<%= title%>" readonly />
			</div>
			<div class="form-group">
				<label for="writer">작성자:</label>
				<input type="text" class="form-control" id="writer" name="writer" value="<%= writer%>" readonly />
			</div>
			<div class="form-group">
				<label for="content">내용:</label>
				<textarea class="form-control" rows="5" id="content" name="content" readonly><%= content%></textarea>
			</div>
			<div class="btn-group">
				<button class="btn btn-secondary btn-list">목록</button>
				<%If (StrComp(Session("login"), writer, 1)) = 0 Then%>
				<button class="btn btn-default btn-update">수정</button>
				<button class="btn btn-danger btn-remove">삭제</button>
				<%End If%>
			</div>
		</div>
	</div>
</div>

<!-- Footer -->
<footer class="container-fluid text-center bg-grey">
	<a href="#myPage" title="To Top">
		<span class="glyphicon glyphicon-chevron-up"></span>
	</a>
	<p>Board Test Made By Eduwill ICT Internship</p>
</footer>

<script>
$(document).ready(function(){
	//목록
	$(".btn-list").click(function(){
		window.location.href="./";
	});
	//수정
	$(".btn-update").click(function(){
		window.location.href="./update_form.asp?bno=" + <%= bno %>
	});
	//삭제
	$(".btn-remove").click(function(){
		if(confirm("글을 삭제하시겠습니까?\n\n삭제된 글은 복구할 수 없습니다")){
			window.location.href="./delete_run.asp?bno=" + <%= bno %>;
		}		
	});
});
</script>

<!-- include DB Disconnector -->
<!-- #include virtual="/common/dbDiscon.asp" -->

</body>
</html>