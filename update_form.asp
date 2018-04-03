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

<%If IsEmpty(Session("login")) Then%>
<script>
alert("로그인 후에 이용하실 수 있습니다");
window.location.href="./";
</script>
<%End If%>

<%
Dim bno
bno = Request.QueryString("bno")
%>
<!-- include DB Connector -->
<!-- #include virtual="/common/dbCon.asp" -->
<%
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
			<h2>게시글 쓰기</h2><br>
			<div class="form-group">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="title" name="title" value="<%= title%>" />
			</div>
			<div class="form-group">
				<label for="writer">작성자:</label>
				<input type="text" class="form-control" id="writer" name="writer" value="<%= writer%>" readonly />
			</div>
			<div class="form-group">
				<label for="content">내용:</label>
				<textarea class="form-control" rows="5" id="content" name="content"><%= content%></textarea>
			</div>
			<div class="btn-group">
				<button class="btn btn-secondary btn-list">목록</button>
				<button class="btn btn-primary btn-update">수정</button>
			</div>
		</div>
	</div>
</div>

<form action="./update_run.asp" method="post" name="frm">
	<input type="hidden" name="bno" value="<%= bno%>" />
	<input type="hidden" name="title" />
	<input type="hidden" name="content" />
</form>

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
		if(confirm("글 목록으로 돌아가시겠습니까?\n\n작성 내용은 모두 사라집니다")){
			window.location.href="./";
		}	
	});
	//쓰기
	$(".btn-update").click(function(){
		if(confirm("글을 수정하시겠습니까?")){
			document.frm.title.value=$("#title").val();
			document.frm.content.value=$("#content").val();
			document.frm.submit();
		}		
	});
});
</script>

<!-- include DB Disconnector -->
<!-- #include virtual="/common/dbDiscon.asp" -->

</body>
</html>