<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>VIG</title>

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
	
		<!-- JQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	<script src="//127.0.0.1:3000/socket.io/socket.io.js"></script>
	
	<style type="text/css">
	 body {
	 
	 	margin-top: 70px;
	 
	 }
	 .user_list {
	 
	 	border-right: 1px solid black;
	 	min-height: 500px;
	 	
	 
	 }
	 #profileImage{
	 
	 width: 30px;
	 border-radius: 15px;
	 margin-left: 8px;
	 
	 }
	 .chat-body {
	 
	  width: 700x;
	  height: 450px;
	  border: 1px solid gray;
	  overflow:auto; 
	  margin-bottom: 10px;
	  
	 
	 }
	 
	 .selectChat {
	 
	 margin: 3px auto;
	 
	 }
	 
	
	
	</style>
	
	<script type="text/javascript">
	
	var socket;
	
	$(function(){	
		
		//첫 로딩시에는 chat영역 안보임
		$("#chatPlace").attr("style", "visibility:hidden");
				
				socket = io.connect('http://127.0.0.1:3000');
				var username = $("input[name='userCode']").val();
				var selectUser = $("input[name='selectUser']").val();
				var roomId;
				var data;
				var diplayValue;
				
				//socket으로 서버에 username = socketId로 전달할 수 있도록 함
				socket.emit('setSocketId', username);
				
				
				socket.on('connect', function(username){
					
					while(username == ''){
						username = alert("로그인 해주세요");
						hitory.go(-1);
						return false;
					}
					$('input[name=username]').val(username);
	
				});
				
				socket.on('send message', function(data){
					data = JSON.stringify(data);
					data = JSON.parse(data);
					 if(data.sender == username){
							
							displayValue ="<div class='media' style='text-align:right'><div class='media-right'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"+
							"</div><div class='media-body'>" + data.contents + "<span class='msg-body'>("+data.createdAt+")</span></div></div>";
							
							console.log(displayValue);
							
								
								
							} else {
								
							displayValue ="<div class='media' style='text-align:left'><div class='media-left'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"
								+ data.sender + "</span></div><div class='media-body'><span class='msg-body'>" + data.contents + "</span>("+data.createdAt+")</div></div>";
								
							console.log(displayValue);
							
							}
					 $('.chat-body').append(displayValue);
					 
				});

				socket.on('remove', function(username){
					$('#user_list p#'+username).remove();
				});
				
				//page로딩시 ajax로 userlist를 가져온다.
				$.ajax({
					
					url: 'http://127.0.0.1:3000/chat/getChatList/'+username,
					method: 'get',
					dataType: 'json',
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success: function(JSONData, status) {
						
						var data = JSON.stringify(JSONData);
						data = JSON.parse(data);
						console.log("JsonData"+data);
						console.log("json크기"+data.length);
						for(var i = 0; i < data.length; i++){
							var userCode = data[i].userCodes[1];
							roomId = data[i]._id;
							console.log(userCode);
							console.log(username);
							console.log(roomId);
							if(i==0){
								$('input[name="roomId"]').val(roomId);
							}
							if(username != userCode){
								
							var user = '<div class="chatUser" onClick="getChat(\''+data[i]._id+','+userCode+'\')">'+
											"<img id='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
											"<p style='display: inline-block; margin: 3px auto;'>"+userCode+"</p></div>"
							} else if(username == userCode) {
								
								userCode = data[i].userCodes[0];
								var user = '<div class="chatUser" onClick="getChat(\''+data[i]._id+','+userCode+'\')">'+
								"<img id='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
								"<p style='display: inline-block; margin: 3px auto;'>"+userCode+"</p></div>"
								
							}
							$(".user_list").append(user);
						}
							
						
					}
					});
				

					
				
				//유저 선택하고, 메세지 보내기를 누르면  join
				$("#sendMessages").on("click", function(){
					
					selectUser = $("#userselect").val();
					socket.emit('createChat', username, selectUser);
					
					
				});
				
				
				

				$('#submit_btn').on("click",function(e){
					
				
					roomId = $('input[name="roomId"]').val();
					var message = $('#message_input').val();
					console.log(message);
					var attached = $('#attached_input').val();
					selectUser = $("input[name='selectUser']").val();
					console.log("메세지를 보낼 유저"+selectUser);
					if(message != ''){
						socket.emit('send message', message, selectUser);
						$('#message_input').val('');
					} else if (attached != '') {
						$("#status").empty().text("File is uploading...");
					    $(this).ajaxSubmit({
					        error: function(xhr) {
							    status('Error: ' + xhr.status);
					        },
					        success: function(response) {
							    $("#status").empty().text(response);
					        }
					    });
						$('#attached_input').val('');
						chatScrollfix();
					}
					return false;
					
				});
				


				
			});
	
	
	function chatScrollfix(){
		
		//scroll가장 하단으로 자동 고정
		$(".chat-body").scrollTop($(".chat-body").height()+500); 
		
		
	}
	
	function getChat(data){
		
		var list = data.split(",");
		username = $("input[name='userCode']").val();
		$('input[name="selectUser"]').val(list[1]);
		console.log($('input[name="selectUser"]').val());
		
		var select = $("#selectChat").text();
		//선택한 유저가 이미 선택되었는지 확인,
		if(select == list[1]){
			
			return false;
			
		}
		
		$.ajax({
			url: 'http://127.0.01:3000/chat/getChat/'+list[0],
			method: 'get',
			dataType: 'json',
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success: function(JSONData, status) {
				
				data = JSON.stringify(JSONData);
				data = JSON.parse(data);
				
				console.log(data);
				var inputSelect = document.getElementsByName("selectUser");
				var user = '<div class="selectChat" style="vertical-align: middle">'+
				"<img id='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
				"<p id='selectChat' style='display: inline-block; margin: 3px auto;'>"+list[1]+"</p></div><hr>"
				
				 for(var i = 0; i<data.length; i++){
					 
					 
					 if(data[i].sender == username){
							
							displayValue ="<div class='media' style='text-align:right'><div class='media-right'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"+
							"</div><div class='media-body'>" + data[i].contents + "<span class='msg-body'>("+data[i].createdAt+")</span></div></div>";
							
							console.log(displayValue);
							$('.chat-body').append(displayValue);
								
								
							} else {
								
							displayValue ="<div class='media' style='text-align:left'><div class='media-left'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"
								+ data[i].sender + "</span></div><div class='media-body'><span class='msg-body'>" + data[i].contents + "</span>("+data[i].createdAt+")</div></div>";
								
								$('.chat-body').append(displayValue);
								
							}

					
					
					
				}
				$("#chatPlace").attr("style", "visibility:visible");
				chatScrollfix();
				roomId=data[1].roomId;
				$("#selectUser").append(user);
				//$("#selectUser").append(user);
				//$("input[name='selectUser']").val(list[1]);
				
				
		//	}
			
			
			}
		});
		
		
		
	};
	
	
	
	</script>
	
	
</head>
<body>
	
	
	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	<div class="container">
	<div class="row">
	<h1 style="text-align:left">Message</h1>
	</div>
	<hr><br>
		<div class="row">
			<div class="col-3">
				<input type="text" id="userselect">
				<button class=" -roundedbtn btn-floating btn-indigo btn-sm" id="sendMessages"><i class="fas fa-envelope"></i></button>
				<div class="user_list">

				</div>
			
			</div>
			<div class="col-9" id="chatPlace">
				
				
				<div id="selectUser" ></div>
				
				<div  class="chat-body">
			
				
				</div>

			
				
				<form id="chat_form" method="post" enctype="multipart/form-data">
					<div class="row">
						<div class="col-9">
							<input type="hidden" name="roomId">
							<input type="hidden" name="selectUser">
							<input type="hidden" name="userCode" value="${user.userCode }">
							<input style="width:600px; vertical-align: middle" type="text" id="message_input" class="form-control" placeholder="메세지를 입력해주세요">
						</div>
						<div class="col-3">
							<button style="display: inline-block;" type="button" id="submit_btn" class="btn btn-outline-default waves-effect">전송</button>
						</div>
						
					</div>
				</form>
		
			</div>
		</div>
	</div>






</body>
</html>