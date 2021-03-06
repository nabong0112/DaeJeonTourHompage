<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 작성하기</title>
<link type="text/css" rel="stylesheet" href="/css/egovframework/mainStyle.css">
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/css/egovframework/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
<!-- header ------------------------------------------ -->
	<%@ include file="include/fixingheader.jsp"%>
	<!-- //header -->
	<!-- nav --------------------------------------------- -->
	<%@ include file="include/fixingNav.jsp" %>
	<!-- //nav -->
	<section id="section">
		<div class="container">
		<div>
		<c:choose>
			<c:when test="${check eq 'write'}">
			<b class="alignleft" style="color: #0aa9de; font-size: 30px;">
			글 작성하기</b>
			</c:when>
			<c:otherwise>
			<b class="alignleft" style="color: #0aa9de; font-size: 30px;">
			글 수정하기</b>
			</c:otherwise>
		</c:choose>
		<b class="aligncenter"style="color: #0aa9de; font-size: 30px;">&nbsp;</b>
			<b class="alignright" style="color: #0aa9de;font-size: 30px;">&nbsp;</b><br><br><br>
		</div>
			<form id ="form" method="post" action="writeCheck.do" enctype="multipart/form-data">
					<table class="type2" align="center">
						<thead>
							<tr>
								<th><b>게시판</b></th>
								<td><select name="boardValue" style="height: 23px;">
									<option value="1">공지사항</option>
									<option value="2">질문게시판</option>
									<option value="3">자유게시판</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><b>제목</b></th>
								<td>
								<c:choose>
									<c:when test="${check eq 'write'}">
										<input type="text" size="30px" name="boardTitle" placeholder="제목을 입력하세요">
									</c:when>
									<c:otherwise>
										<input type="text" size="30px" name="boardTitle" value="${list.boardTitle}">
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
							<tr>
								<th><b>작성자</b></th>
								<td><input type="hidden" name="boardUser" value="${sessionScope.userId}">
									${sessionScope.userId}</td>
							</tr>
							<tr>
								<th><b>내용</b></th>
								<td>
								<c:choose>
									<c:when test="${check eq 'write'}">
										<textarea name="boardText" id="boardText"
										style="resize: none; width: auto;"></textarea>
									</c:when>
									<c:otherwise>
										<textarea name="boardText" id="boardText"
										style="resize: none; width: auto;">${list.boardText}</textarea>
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
							<tr>
								<th><b>파일첨부</b></th>
								<th><input type="file" name="file"></th>
							</tr>
						</thead>
						<tbody>
						<tr>
						<td colspan="2" align="center">
						<c:choose>
							<c:when test="${check eq 'write'}">
							<input type="hidden" name="check" value="${check}">
								<input type="button" class="dropbtn" id="write" value="등록하기">
							</c:when>
							<c:otherwise>
							<input type="hidden" name="boardNo" value="${list.boardNo}">
							<input type="hidden" name="check" value="${check}">
								<input type="button" class="dropbtn" id="update" value="수정하기">
							</c:otherwise>
						</c:choose>
						<input type="button" class="dropbtn" name="back" value="돌아가기" onclick="javascript:Back();"></td>
						</tbody>
						<tr>
					</table>
				</form>
				</div>
		</section>
<script type="text/javascript">
function Back() { //돌아가기 버튼
	var bool = confirm('돌아가시겠습니까? 지금까지 작성한 글은 저장되지 않습니다!');
	if (bool == true) {
		history.back();
	} else {
		return false;
	}
}

$(function(){//에디터를 사용하기위한 함수
    //전역변수
    var obj = [];              
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "boardText",
        sSkinURI: "/css/egovframework/editor/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부
            bUseModeChanger : true,
        }
    });
    //추가 버튼
    $("#write").click(function(){
            	try{
            		obj.getById["boardText"].exec("UPDATE_CONTENTS_FIELD", []);
                 	$('#form').submit();
                 	alert("등록 되었습니다!");
            	}catch(exception){
            		alert("데이터 등록을 실패하였습니다.");
                	 return false;
            	}

    });
  	//수정 버튼
    $("#update").click(function(){
            	try{
            		obj.getById["boardText"].exec("UPDATE_CONTENTS_FIELD", []);
                 	$('#form').submit();
                 	alert("수정 되었습니다!");
            	}catch(exception){
            		alert("데이터 등록을 실패하였습니다.");
                	 return false;
            	}
    });
});
</script>
</body>
</html>