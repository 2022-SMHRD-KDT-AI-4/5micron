<%@page import="xe.smhrd.model.InviteVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	InviteVO myvo = (InviteVO) session.getAttribute("myvo");
	List<InviteVO> myitemlist = (List<InviteVO>) session.getAttribute("myitemlist");
	%>
<div>
	<h1><%=myvo.getV_name() %></h1><br>
	<%=myvo.getV_cont() %><br><br>
	<table border="1">
	<tr>
	<td>
	대표이미지
	</td>
	<td>
	파티에 사용될 아이템
	</td>
	</tr>
	<tr>
	<td>
	<img src="img/<%=myvo.getP_img() %>" style="max-width: 700px;">
	</td>
	<td>
		<%for(InviteVO ivo : myitemlist){
			%>
			<li><%=ivo.getI_name() %></li><br>
			<%	}%>
	</td>
	</tr>
	</table>
	
</div>
개최일시 : <%=myvo.getV_date()%><br>
개최지 : <%=myvo.getV_adr() %><br>
</body>
</html>