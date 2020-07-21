<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>getFeed</title>

<!-- JQuery -->
	
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
	
		<!-- JQuery -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

	
<style>
	
	body {
	
	}
	
	#outline {
	
		width: 1300px;
		margin: 0 auto;
	
	}
	
	#main { 
		
		width: 960px;
		margin: 0 auto;
		
	}
	
	img #image {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	  border: 1px solid rgb(0, 0, 0);
	}
	
	}
	#writerInfo {

    display: table-cell;
    vertical-align: middle;

	
	}
	#writerName {
	
	padding-top: 5px;
	font-size: 18px;
	color: #000000;
		
	}
	#scrolltop {
	  position: fixed;
	  left: 85%;
	  bottom: 50px;
	}
	#profile {
	 display: inline-block;	
	 margin-top: 10px;
	}
	.fa-heart {
	
	color: red;
	
	}
	
	.fa-exclamation-triangle {
	
	color: red;
	
	}
	#feedbottom {
	
	border: 1px solid #B8B8B8;
	padding: 10px 5px 10px 8px;
	
	}



</style>


<script type="text/javascript">

$(function(){
	
	$("#writerInfo").on("click", function (){
		self.location="../myfeed/getMyFeed/${feed.writer.userCode}";
		
	});
	
	//scrollTop 부드럽게 이동하는 부분
	$( window ).scroll( function() {
		if ( $( this ).scrollTop() > 200 ) {
			$( '.top' ).fadeIn();
		} else {
			$( '.top' ).fadeOut();
		}
	} );
	//스크롤탑 애니메이션
	$( '.top' ).click( function() {
		$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
		return false;
	} );
	
	//follow 구현
	$("#follow").on("click", function(){
		var fm = $("#follow").text();
		//self.location="../팔로우 add 팔로우";
		if(fm == "Follow"){
			
		$("#follow").text("following").attr("class", "btn btn-default btn-rounded");
		
		} else {
		
			//alert("Do you really want to unfollow?");
			$("#follow").text("Follow").attr("class", "btn btn-outline-default btn-rounded");
			
		}
	});
	
	//댓글 구현
	$("button:contains('등록')").on("click", function(){
	
		alert("등록되었습니다.");
		
	});
	
	$("i:contains('신고')").on("hover", function(){
		
		$('[data-toggle="tooltip"]').tooltip();
		
	});
	
	$("i:contains('신고')").on("click", function(){
		
		alert("addReport임돠");
		
	});
	
	//좋아요 연결
	$("body").on("dblclick", function(){
		var likeClass = $("#like").attr("class");
		console.log(likeClass);
		if(likeClass =='far fa-heart'){
			
		$("#like").attr("class", "fas fa-heart");
		//addLike 추가
		}else{
			
		$("#like").attr("class", "far fa-heart");
		//deleteLike 추가
		}

	});
	
	$("#like").on("click", function(){
		
		var likeClass = $("#like").attr("class");
		console.log(likeClass);
		if(likeClass =='far fa-heart'){
			
		$("#like").attr("class", "fas fa-heart");
		//addLike 추가
		
		}else{
			
		$("#like").attr("class", "far fa-heart");
		//deleteLike 추가
		}
		
	});
	

	
})


</script>


</head>
<body>


<!--Navbar-->
<nav class="navbar navbar-light purple lighten-4 mb-4">

  <!-- Navbar brand -->
  <a class="navbar-brand" href="#">Navbar</a>

  <!-- Collapse button -->

</nav>
<!--/.Navbar-->

	
	<div id="outline">

	<div id="main">
	
	<br/>
	<br/>
	
	
	<div class="container">
	<div class="row">
	<div class="col-10">
	<h2> <strong> ${feed.feedTitle} </strong></h2>
	<br>
	<!-- Medium input -->
	<h5> ${feed.feedExplanation}</h5>
	</div>
	
	<div class="col-2">
	<br>
		<div align="right">
		<i id="like" class="far fa-heart" style="font-size: 25px"></i>
		</div>
		<br>
		<div align="right">
		<i class="far fa-eye" style="font-size: 25px">                         ${feed.feedViewCount}</i>
		</div>
		
	</div>
	</div>
	</div>
	
	<hr/>
	<c:forEach var="images" items="${feed.images}">
		<c:set var="i" value="0"/>
		<c:set var="i" value="${i+1 }"/>
		<c:if test="${images.isThumbnail == '0'}">
			<div id="image">
			<img src="../images/uploadFiles/${images.imageFile}" style="width:960px" />
			</div>
		</c:if>
	</c:forEach>

	<hr/>
	
	<div class="container">
	 <div class="row">
		 <div class="col-8">
		 <span id="profile">
		<img src="../images/others/default-profile-picture1.jpg" class="rounded-circle" width="35px"> &nbsp; <a id="writerName" href="../myfeed/getMyFeedList/${feed.writer.userCode}">${feed.writer.userName}</a>
		 </span>
		 </div>
	    <div class="col-4">
	    	<span class="badge badge-pill green"><i class="fas fa-dollar-sign"></i></span>

	    	<button type="button" id="follow" class="btn btn-outline-default btn-rounded" >Follow</button>
	    </div>
	  </div>
</div>
	<hr/>
	<br/>
	
	<div class="container">
	 <div class="row">
		<div class="col-8">
		<div class="container">
		<div class="row">
		<div class="col-8">
		<form id="myform">
			<div class="md-form" style="width:100%;">
			  <textarea id="textarea-char-counter" class="form-control md-textarea" length="500" rows="2"></textarea>
			  <label for="textarea-char-counter">Type your Comment</label>
			</div>
		</form>
		</div>
		<div class="col-4">
		<br>
		<button type="button" class="btn btn-indigo">등록</button>
		</div>
		</div>
		</div>
		<div id="feedbottom">
		<c:choose>
		
		<c:when test="${!empty feed.comments }">
			<c:forEach var="comments" items="${feed.comments}">
			<c:set var="i" value="0"/>
			<c:set var="i" value="${i+1 }"/>
			<img src="../images/others/default-profile-picture1.jpg" class="rounded-circle" width="15px"><a href="/마이피드/${comments.user.userCode}">${ comments.user.userName}</a>
			comment ${comments.commentText }
			</c:forEach>
		</c:when>
		<c:when test="${empty feed.comments}">
			<br>
			<br>
			<h6 align="center"> Please leave your comments! </h6>
			<br>
			<br>
		</c:when>
		
		</c:choose>
		</div>
		
		</div>
		
		<div class="col-4" id="feedInfo">
		<div id="feedbottom">
			<h6>사용장비</h6>
			<c:if test="${!empty feed.feedUseGears }">
			
			${feed.feedUseGears}
			
			</c:if>
			<c:if test="${empty feed.feedUseGears }">
				<p align="center" style="font-size: 13px; font-style:italic;">사용 장비가 없습니다.</p>
			</c:if>
		</div>
		<br>
		<div id="feedbottom">
			<h6>색 상</h6>
			<c:forEach var="images" items="${feed.images}" begin="0" end="0">
			<c:if test="${!empty image.color }">
			<c:if test="${images.isThumbnail == '1' }">
			
			<c:forEach var="color" items="${images.color}">
			<c:if test="${!empty color }">
				R: ${color.red}  G: ${color.green } B: ${color.blue}
			</c:if>

			</c:forEach>
			</c:if>
			</c:if>
			<c:if test="${empty color }">
				<p align="center" style="font-size: 13px; font-style:italic;">No colors</p>
			</c:if>
			</c:forEach>
		</div>
		<br>
		<div id="feedbottom">	
			<h6>협업자</h6>
			
			<c:if test="${!empty feed.coworkers }">
			
			<c:forEach var="coworkers" items="${feed.coworkers}">
				<c:set var="i" value="0"/>
				<c:set var="i" value="${i+1 }"/>
				<a href="/myfeed/${coworkers.user.userCode}">${coworkers.user.userName}</a>
			</c:forEach>
			</c:if>
			<c:if test="${empty feed.coworkers }">
				<p align="center" style="font-size: 13px; font-style:italic;">협업자가 없습니다.</p>
			</c:if>

		</div>
		<br>
		<div id="feedbottom">	
			<h6>태그</h6>
		
			<c:if test="${empty keyword }">
				
					<p align="center" style="font-size: 13px; font-style:italic;">태그가 없습니다..</p>
			
			</c:if>	

			
		</div>	
			<div align="right">
			<a href="#" data-toggle="tooltip" title="여기를 눌러 신고하세요"><i class="fas fa-exclamation-triangle">신고</i></a>
			</div>
		</div>
			
	</div>
	</div>
	
	
	</div>
	
	</div>

</body>
</html>