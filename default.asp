<%@ codepage="65001" language="VBScript" %>
<!DOCTYPE html>
<head>
	<title>ASP 게시판 구축 테스트</title>
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
page = request.querystring("page")
If page <= 0 Or IsEmpty(page) Then
	page = 1
End If
page = Cint(page)
pageSize = request.querystring("pageSize")
If pageSize <= 0 Or IsEmpty(pagesize) Then
	pageSize = 15
End If
pageSize = Cint(pageSize)

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

<!-- include DB Connector -->
<!-- #include virtual="./common/dbCon.asp" -->

<!-- 회원가입 Modal -->
<div class="modal fade" id="accountModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원가입</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form action="./account.asp" method="post">
			<input type="text" class="form-control" name="id" placeholder="아이디" required /><br/>
			<input type="password" class="form-control" name="pw" placeholder="패스워드" required /><br/>
			<input type="text" class="form-control" name="nickname" placeholder="로그인" required /><br/>
			<input type="submit" class="form-control" value="회원가입" />
		</form>
      </div>

    </div>
  </div>
</div>

<!-- Container (About Section) -->
<div id="about" class="container-fluid">
	<div class="row">
		<div class="col-sm-12">
			<div class="col-sm-9">
				<h2>게시판</h2><br>
			</div>
			<div class="col-sm-3 text-center" style="border:1px solid black; padding:10px;">
				<%
				If IsEmpty(Session("login")) Then
				%>
				<form action="./login.asp" method="post">
					<input type="text" class="form-control" name="id" placeholder="아이디" /><br/>
					<input type="password" class="form-control" name="pw" placeholder="패스워드" /><br/>
					<input type="submit" class="form-control btn-primary" value="로그인" /><br/>
					<a href="#" data-toggle="modal" data-target="#accountModal">아직도 회원이 아니신가요?</a>
				</form>
				<%
				Else
				%>
				<input type="text" class="form-control" value="환영합니다" readonly /><br/>
				<input type="text" class="form-control" value='<%= Session("nickname") %> 님' readonly /><br/>
				<form action="./logout.asp" method="post">
					<input type="submit" class="form-control btn-default" value="로그아웃" />
				</form>
				<%
				End If
				%>
			</div>

			<div class="col-sm-12 text-right" style="margin-top:10px;">
				<div class="form-group">
					<select class="form-inline" id="view_content_count">
						<%
						Dim optclass(4)
						For i=1 To 4
							optclass(i)=""
						Next

						If pageSize = 15 Then
							optclass(1)="selected"
						ElseIf pageSize = 20 Then
							optclass(2)="selected"
						ElseIf pageSize = 30 Then
							optclass(3)="selected"
						ElseIf pageSize = 50 Then
							optclass(4)="selected"
						End If
						%>
						<option <%=optclass(1)%>>15개씩 보기</option>
						<option <%=optclass(2)%>>20개씩 보기</option>
						<option <%=optclass(3)%>>30개씩 보기</option>
						<option <%=optclass(4)%>>50개씩 보기</option>
						
					</select>
				</div>
			</div>
		
			<table class="table table-hover">
				<colgroup>
					<col width="5%">
					<col width="30%">
					<col width="10%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회 수</th>
					</tr>
				</thead>
				<tbody>
					<%
					'SELECT bno,
					'	title,
					'	writer,
					'	regdate,
					'	viewcnt,
					'FROM tbl_board,
					'ORDER BY bno DESC
					strSql = "SELECT TOP " & pageSize & " bno, title, writer, regdate, viewcnt FROM tbl_board WHERE bno NOT IN (SELECT TOP " & (page-1)*pageSize & " bno FROM tbl_board ORDER BY bno DESC) ORDER BY bno DESC"
					rs.Open strSql, dbCon
					
					Dim rs_bno, rs_title, rs_writer, rs_regdate, rs_viewcnt

					Do Until rs.eof
						rs_bno = rs("bno")
						rs_title = rs("title")
						rs_writer = rs("writer")
						rs_regdate = rs("regdate")
						rs_viewcnt = rs("viewcnt")

						Response.Write ("<tr id='" & rs_bno & "'>")
						Response.Write ("	<td>" & rs_bno & "</td>")
						Response.Write ("	<td>" & rs_title & "</td>")
						Response.Write ("	<td>" & rs_writer & "</td>")
						Response.Write ("	<td>" & rs_regdate & "</td>")
						Response.Write ("	<td>" & rs_viewcnt & "</td>")
						Response.Write ("</tr>")
						
						rs.movenext
					Loop
					rs.close
					%>
				</tbody>
			</table>

			<div class="col-sm-1 text-left">
				<div class="btn-group">
					<button class="btn btn-primary btn-write">쓰기</button>
				</div>
			</div>

			<div class="col-sm-10 text-center">
				<ul class="pagination">
					<%
					Dim prev_disabled, prev_href
					Dim next_disabled, next_href

					prev_disabled=""
					prev_href=""
					next_disabled=""
					next_href=""

					'이전 버튼
					If page = 1 Then
					prev_disabled="disabled"
					Else
					prev_href="./?page=" & (page-1) & "&pageSize=" & pageSize
					End If
					Response.Write("<li class='page-item " & prev_disabled & "'><a class='page-link' href='" & prev_href & "'>이전</a></li>")

					strSql = "SELECT COUNT(bno) FROM tbl_board"
					rs.Open strSql, dbCon
					countStr = rs.GetString()
					count = Cint(countStr)
					rs.close

					'페이징 리스트
					Dim i, cnt
					cnt=0
					i=(((page-1)\10)*10)+1

					Dim listactive
					Do While (cnt < 10) And (i * pageSize < count + pageSize)

						listactive=""
						If i = page Then
							listactive="active"
						End If
						Response.Write("<li class='page-item " & listactive & "'><a class='page-link' href='./?page=" & i & "&pageSize=" & pageSize & "'>" & i & "</a></li>")

						i = i + 1
						cnt = cnt + 1
					Loop

					'다음 버튼
					max_page = 1
					Do While max_page * pageSize < count + pageSize
						max_page = max_page + 1
					Loop
					max_page = max_page - 1

					If page = max_page Then
					next_disabled="disabled"
					Else
					next_href="./?page=" & (page+1) & "&pageSize=" & pageSize
					End If
					Response.Write("<li class='page-item " & next_disabled & "'><a class='page-link' href='" & next_href & "'>다음</a></li>")
					%>
									
				</ul>
			</div>

		</div>
	</div>
</div>

<!-- include DB Disconnector -->
<!-- #include virtual="./common/dbDiscon.asp" -->

<!-- Footer -->
<footer class="container-fluid text-center bg-grey">
	<a href="#myPage" title="To Top">
		<span class="glyphicon glyphicon-chevron-up"></span>
	</a>
	<p>Board Test Made By Eduwill Project Internship</p>
</footer>

<script>

$(document).ready(function(){
	// 읽기
	$("tr").click(function(){
		if(this.id > 0){
			window.location.href="./read.asp?bno="+this.id;
		}
	});
	// 쓰기
	$(".btn-write").click(function(){
		window.location.href="./write_form.asp";
	});
	// 
	$("#view_content_count").change(function(){
		var count = $(this).val().substring(0, 2) * 1;
		window.location.href="?page=<%=page%>&pageSize="+count;
	});
});
	var result = "${msg}";

	if (result == "success") {
		alert("처리가 완료되었습니다.");
	}
</script>

</body>
</html>