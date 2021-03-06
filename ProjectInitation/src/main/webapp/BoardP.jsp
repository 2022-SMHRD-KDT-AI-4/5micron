<%@page import="xe.smhrd.model.MemberVO"%>
<%@page import="xe.smhrd.model.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="xe.smhrd.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Come On Yo</title>
    <link rel="stylesheet" type="text/css" href="assets/css/BoardP.css?ver=3">
    <link rel="stylesheet" type="text/css" href="assets/css/sideheart.css">
    <link rel="stylesheet" type="text/css" href="assets/css/input.css">
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/icon.png" />
    <style type="text/css">
        @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
        html,body{width: 100%;height: 100%}
        body,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,
        input,textarea,button,select{margin: 0;padding: 0}
        body,input,textarea,select,button,table{font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;font-size: 12px;}
        img,fieldset{border: 0;}
        ul,ol{list-style: none;}
        em,address{font-style: normal;}
        a{text-decoration: none;}
        a:hover,a:active,a:focus{text-decoration: underline;}        
    </style>
    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
	<script src="assets/base.js"></script>
</head>

<body id="board">
<%
	MemberVO mvo = (MemberVO) session.getAttribute("vo");
%>
	<nav class="privacy">
	<%if (mvo == null) {%>
		<div class="icons">
			<!-- <a class="login-icon" href="Login.jsp">login</a>
			<a class="join-icon" href="Join.jsp">join</a> -->
	 		<a class="login-icon" href="javascript:login();">login</a>
			<a class="join-icon" href="Join.jsp?uri=BoardP">join</a>
		</div>
	<%} else {%>
		<div class="icons">
			<a class="logout-icon" href="LogoutService">logout</a>
		</div>
	<%}%>
	</nav>
	
<%MemberVO vo = (MemberVO) session.getAttribute("vo");%>
<div class="board_header">
	<a href="Main.jsp"><img src="assets/images/logoda.png" alt=""></a>
</div>

	
	
    <div class="wrap">
        <h1 id="headname"></h1>
        <div class="fixed_img_col">
            <ul id="listset">
            </ul>
        </div>
    </div>
    
<%List<BoardVO> cartList = (List<BoardVO>) session.getAttribute("cartList");%>
<!-- ????????? ?????? -->
<button class="cartopen" style="position: fixed; right:22px; top: 13px; margin: 0; padding: 0;  display: block;">
    <img src="img/bono.png" width="40px" height="40px" alt="????????????">
</button>
    
    <div class="outer-div" style="margin-right: -40%;">	
		<div class="title">
        <h3>??? ??????</h3>
        <button class="cartclose" style="position: absolute; right:2px;top: 4px; margin: 0; padding: 0; ">
        	<img src="img/bono.png"  width="40px" height="40px" alt="????????????">
        </button>
        </div>
		
        
        <div class="inner-div">
            <table border="0">
            <tbody id="cart">
            </tbody>
            </table>
        </div>
        <div class="button">
            <div>
                <input type="button" onclick="cartclear();" value="?????????">
                <input type="button" id="toInvite" onclick = "location.href = 'Invitepage.jsp'" value="????????????">
            </div>
            </div>
            <div class="bg_img"></div>	
    </div>
    <!-- ????????? ?????? ??? -->
    
    <!-- ?????? ?????? ?????? -->
	<button class="top">
			<img src="assets/images/conged.png" alt="top button">
	</button>
    
    <!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	let pv_pt_id = getParameterByName("pt_id");

	let p_id = [];
	let p_name = [];
	let p_img = [];
	<% if (cartList != null) {
		for (BoardVO cvo : cartList) {	%>
		p_id.push('<%=cvo.getP_id()%>');
		p_name.push('<%=cvo.getP_name()%>');
		p_img.push('<%=cvo.getP_img()%>');
		<% } }%>
		
		
	$(document).ready(function() {
		console.log("??????");
		boardload(pv_pt_id);
		makecartlist(); 
	})
	
	
	/* ????????? ?????? ?????? */
	
	function boardload(pv_pt_id, pv_num){
		$.ajax({
			url : 'ListService',
			type : 'post',
			dataType : "json",
			data : {
				"pt_id" : pv_pt_id,
			},
			 success : function(board){
	               console.log("????????????(????????????)");
 	               makeheadname(board);
	               makeboard(board);
	               console.log(board[0].pt_name);
	            },
	            error : function(){ alert('error!'); }
	         });
	}
	
	function makeheadname(board){
 		console.log("?????? ?????? ??????");
 		$('#headname').html('');
 		h1 = board[0].pt_name+` ??? ?????? ??????`;
 		$('#headname').append(h1);
 	}
	
	
	function makeboard(board){
 		console.log("?????? ?????? ??????");
 		$('#listset').html('');
 		for(let i = 1; i<board.length; i++){
 		tr = `
  			<li>
    		<a href="BoardView.jsp?pt_id=`+board[i].pt_id+`&num=`+board[i].num+`">
        		<span class="thumb">
            		<div class="img"><img class="cover" src="img/`+board[i].p_img+`" alt="`+board[i].p_name+`"/></div>
            		<em style="font-size: 45px;">???????????? ????????? ??????</em>
        		</span>
        		<strong>`+board[i].p_name+`</strong>
    		</a>
		</li> 
			`;
 		$('#listset').append(tr);
 		}
 	}
	
	/* ????????? ?????? ?????? ??? */
	
	/* ?????? ?????? ?????? */

	function cartclear(){
		$.ajax({
			url : 'CartClearService',
			type : 'post',
			success : function(res){
				console.log("????????????");	
				clearcartlist();				
				makecartlist();
				},
	            error : function(){ alert('error!'); }
		});
	}
	
	function setcartlist(res){
	console.log("????????? ??????");
	for (var i = 0; i < res.length; i++){
		p_id.push(res[i].p_id);
		p_name.push(res[i].p_name);
		p_img.push(res[i].p_img);
 	  }
	}
	
	function clearcartlist(){
		console.log("????????? ????????? ?????? ??????");
		p_id = [];
		p_name = [];
		p_img = [];
		$('#cart').html('');	//????????? ????????????
	}
	
	function makecartlist(){	
		console.log("????????? ?????? ??????");	
		for (var i = 0; i < p_id.length; i++){
 			console.log("??????????????? : "+p_id[i],p_name[i],p_img[i]);
			 tr = `
                <tr>
				 	<td width="250px"><center>
						<img src="img/`+p_img[i]+`" width="250px">
					</center></td>
				</tr>
				<tr>
					<td><center>
							`+p_name[i]+`
					</center></td>
                 </tr>
              `;
			 $('#cart').append(tr);
		}
	}
	
	/* ?????? ?????? ?????? ??? */
	
	/* ?????? ?????? ?????? ?????? */
 	 
  	$('.cartopen').click(function(){
 		$(this).fadeOut();
 		$('.outer-div').animate({
 			marginRight:0
 		},1000);
 	});
 	
 	$('.cartclose').click(function(){
 		$('.cartopen').fadeIn();
 		$('.outer-div').animate({
 			marginRight:'-40%'
 		},1000);
 	});
 	
 	/* ?????? ?????? ?????? ?????? ??? */
 	
	if(<%=session.getAttribute("vo")==null%>){
 		$('#toInvite').attr("disabled", true);
 	}else{
 		$('#toInvite').attr("disabled", false);
 	}
 	
	
	
	/* ???????????? ?????? ?????? */
	
	function getParameterByName(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        result = regex.exec(location.search);
	    return result === null ? "" : decodeURIComponent(result[1].replace(/\+/g, " "));
	}
	
	/* ????????? ?????? */
	function login(){
		var URL = window.location.href;
		URL = URL.replace("http://" + window.location.host + "/ProjectInitation/", "");
		location.href = "Login.jsp?url=" + URL;
	}
	</script>
</body>
</html>