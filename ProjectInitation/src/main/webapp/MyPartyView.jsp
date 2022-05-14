<%@page import="xe.smhrd.model.InviteVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>초대장 만들기</title>
    <link rel="stylesheet" type="text/css" href="assets/css/MypartyView.css">
    <style type="text/css">
        table, th, td{
            border: 1px solid black;
        }
    </style>
</head>
<body>
<%
	InviteVO myvo = (InviteVO) session.getAttribute("myvo");
	List<InviteVO> myitemlist = (List<InviteVO>) session.getAttribute("myitemlist");
%>
<form id="frm" action="MyCommitService?v_id=<%=myvo.getV_id()%>&action=commit" method="post">
<div class="wrap">
	<h1><%=myvo.getV_name() %></h1><br>
	<%=myvo.getV_cont() %><br><br>
	<table border-collapse:collapse; width="1200px">
		<tr height="20px" id="head">
            <th id="th1">대표이미지</th>
            <th id="th2">사용할 아이템 목록</th>
            <th id="th3">추천수</th>
            <th id="th4">최종 선택</th>
        </tr>
 
		<tr align="center">
			<!-- 대표 이미지 가져오기 -->
			<td id="images" rowspan="<%=myitemlist.size() + 1%>">
				<img src="img/<%=myvo.getP_img() %>" alt="<%=myvo.getP_name()%>" width="500" height="500">
			</td>
		</tr>
			<!-- 반복문을 통해 전체 항목과 조회수, 체크박스 가져오기 -->
			<%for(InviteVO ivo : myitemlist){ %>
				<tr align="center">
            		<td><%=ivo.getI_name() %></td>
            		<td><%=ivo.getSel_g() %></td>
            		<td id="choice" align="center">
            			<input type="checkbox" name="seli_id" value="<%=ivo.getI_id()%>">
            		</td>
		        </tr>
			<%	}%>
		<!-- 			</tr>
				</tr>
		</tr> -->
		    
		<tr height="40px">
        	<td id="date"align="center">
                개최일자 :  <%=myvo.getV_date()%>
            </td>
            <td id="spot" align="center">
                장소 : <%=myvo.getV_adr()%>
            </td>

            <td id="linklink" align="center">
                <a href="#pop_win1" class="btn_open"><button>① 투표 보내기</button></a>
            </td>
            <td id="button" align="center">
                <a href="#pop_win2" class="btn_open"><button>③ 초대장 보내기</button></a>
                <a href="#" onclick="chk_form()" ><button>② 초대장 등록하기</button></a>

            </td>
        </tr>
	</table>
</div>
</form>
			
<a href="#pop_win3" class="btn_open" style="display: none;" >팝업창 열기</a><br>

<!-- 기본 url 따오는 창 (안보임) -->
<input type="text" id = "ShareUrl" style="display: none;">  
  <!-- 팝업창 -->
	<div id="pop_win1" class="pop_wrap" style="display: none;">
		<div class="pop_inner">
			<p class="dsc">초대장을 복사해주세요</p>
			<input type="text" id = "ShareUrl1" style="width:400px"><br>
			<button OnClick="javascript:CopyUrlToClipboard1()" class="btn_close">URL 복사</button>
		</div>
	</div>


	<div id="pop_win2" class="pop_wrap" style="display: none;">
		<div class="pop_inner">
			<p class="dsc">초대장을 복사해주세요</p>
			<input type="text"  id = "ShareUrl2"  style="width:400px"><br>
			<button OnClick="javascript:CopyUrlToClipboard2()" class="btn_close">URL 복사</button>
		</div>
	</div>
	
	<div id="pop_win3" class="pop_wrap" style="display: none;">
		<div class="pop_inner">
			<p class="resultdsc">정상적으로 등록되었습니다</p>
			<!-- 
			<p class="dsc">초대장을 복사해주세요</p>
			<input type="text"  id = "ShareUrl3"  style="width:400px"><br>
			<button OnClick="javascript:CopyUrlToClipboard3()" class="btn_close">URL 복사</button>
			 -->
			<button class="btn_close">창닫기</button>
		</div>
	</div>
	<!-- 팝업창 끝 -->  

  	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
	
	var target = document.querySelectorAll('.btn_open');
	var btnPopClose = document.querySelectorAll('.pop_wrap .btn_close');
	var targetID;
	
	var obShareUrl = document.getElementById("ShareUrl");	
	var obShareUrl1 = document.getElementById("ShareUrl1");
	var obShareUrl2 = document.getElementById("ShareUrl2");

	
	obShareUrl.value = window.document.location.host	//현재 주소 추출
	// 최종목적지 설정
	obShareUrl1.value = obShareUrl.value+"/ProjectInitation/MyVoteService?v_id=<%=myvo.getV_id()%>";
	obShareUrl2.value = obShareUrl.value+"/ProjectInitation/MyResultService?v_id=<%=myvo.getV_id()%>";

	
	$('#ShareUrl').val(obShareUrl.value);
	$('#ShareUrl1').val(obShareUrl1.value);
	$('#ShareUrl2').val(obShareUrl2.value);
	

	
	function CopyUrlToClipboard1(){	
		obShareUrl1.select();  // 해당 값이 선택되도록 select() 합니다
		document.execCommand("copy"); // 클립보드에 복사합니다.
		obShareUrl1.blur(); // 선택된 것을 다시 선택안된것으로 바꿈니다.
		alert("URL이 클립보드에 복사되었습니다"); 
	}
	function CopyUrlToClipboard2(){	
		obShareUrl2.select();
		document.execCommand("copy");
		obShareUrl2.blur();
		alert("URL이 클립보드에 복사되었습니다"); 
	}
/* 	
 	var obShareUrl3 = document.getElementById("ShareUrl3"); 
 	obShareUrl3.value = obShareUrl2.value 
 	$('#ShareUrl3').val(obShareUrl3.value); 
 	function CopyUrlToClipboard3(){	
		obShareUrl3.select();
		document.execCommand("copy");
		obShareUrl3.blur();
		alert("URL이 클립보드에 복사되었습니다"); 
	} 
	 */
	function chk_form() {
		document.getElementById('frm').submit();
	}
	
	var popup = new Boolean(false);
	if(<%=session.getAttribute("popup")%>!=null){
		popup = new Boolean(<%=session.getAttribute("popup")%>);
	}

	if(popup==Boolean(true)){
		console.log("팝업확인")
		document.querySelector("#pop_win3").style.display = 'block';
		popup = new Boolean(false);
		<%request.getSession().setAttribute("popup", false);%>
	}

 	// 팝업 열기
	for (var i = 0; i < target.length; i++) {
		target[i].addEventListener('click', function() {
			targetID = this.getAttribute('href');
			document.querySelector(targetID).style.display = 'block';
		});
	}
 	
	// 팝업 닫기
	for (var j = 0; j < target.length; j++) {
		btnPopClose[j].addEventListener('click', function() {
			this.parentNode.parentNode.style.display = 'none';
		});
	}
	

  </script>

</body>
</html>