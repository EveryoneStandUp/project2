function handleListUpButtonClick() {
	// 아이디 얻는 코드 
	const boardId = $(this).attr("data-board-id");
	const boardNickName = $(this).attr("data-board-userId");
	let today = new Date();
	console.log(boardId);
	console.log(today);
	console.log(boardNickName);


	$.ajax("/running/getRunningDetail?boardId=" + boardId, {
		success: function(data) {
			let latNum = `${data.board.lat}`;
			let lngNum = `${data.board.lng}`;
			let people = `${data.board.people}`;
			let currentNum = `${data.board.currentNum}`;
			let nickName = `${data.myNickName.nickName}`;
			let time = `${data.board.time}`
			let compareTime = new Date(time);

			console.log(nickName)



			$(".chatRoomModalBody").remove();
			$("#chatRoomModalBefore").after('<div class="modal-body chatRoomModalBody">' + data.board.writer + 'Chat Room with &nbsp; 을 생성하시겠습니까?</div>');

			$("#resMate").empty();

			$("#resMate").append(`
			<div>

        <div class="mb-3">
          <label for="" class="form-label">게시물</label>
          <br />
          <h2><span>${data.board.title}</span></h2>
        </div>
        <div class="mb-3">
          <label for="" class="form-label">작성자</label>
          <br />
          <span>${data.board.writer}</span>
		  <button style="display: none;"type="hidden" class="createChatRoomCheckBtn" data-bs-toggle="modal" data-bs-target="#createChatRoom">${data.board.writer}</button>
        </div>
        <div class="mb-3">
          <label for="" class="form-label">모임 시간</label>
          <br />
          <span>${data.board.time}</span>
        </div>
        <div id="map" class="map-container mb-2" ></div>
        
        <div>
			<label for="" class="form-label">참여자</label>
									
      `);

			let memberIds = [];
			let waitingMemberIds = [];
			let isMine = false;
			let isWaitingMember = false;
			let isRejectMember = false;

			// 대기자 인지
			for (let i = 0; i < data.waitingMembers.length; i++) {
				if (nickName === data.waitingMembers[i].memberId) {
					isWaitingMember = true;
				}
			}

			// 거절된 사람인지
			for (let i = 0; i < data.rejectMembers.length; i++) {
				if (nickName === data.rejectMembers[i].memberId) {
					isRejectMember = true;
				}
			}

			// 신청 수락된 사람인지
			for (let i = 0; i < data.members.length; i++) {
				if (boardNickName === data.members[i].memberId) {
					continue;
				}

				let memberId = data.members[i].memberId;
				memberIds.push(memberId); // 배열에 memberId 추가		

				if (nickName === data.members[i].memberId) {
					isMine = true;
				}

				$("#resMate").append(`
				<span type="text" class="form-control">${memberId}</span>
				 <div style="height: 10px;"></div>
				`);
			}

			console.log("*** " + isMine)

			$("#resMate").append(`</div>`)


			// 필요한 경우에 각각의 memberId 값을 가져올 수 있음
			console.log(memberIds[0]); // 첫 번째 memberId 값
			console.log(memberIds[1]); // 두 번째 memberId 값

			if (today < compareTime) {
				if (!isRejectMember) {
					if (isWaitingMember) {
						$("#resMate").append(`</div>
					
<div class="mb-2" style="display: flex; justify-content: space-between; width: 100%;">
  <button class="btn btn-warning" data-board-id="${data.board.id}" data-board-userId="${data.board.writer}" style="flex-grow: 1;">신청대기중👼👼👼</button>
    <div style="width: 10px;"></div>
    
  <button class="joinPartyBtn btn btn-danger" data-board-id="${data.board.id}" data-board-userId="${data.board.writer}" style="flex-grow: 1;">취소하기🙋‍♂️🙋‍♀️🙋‍♂️🙋‍♀</button>
</div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button class="btn btn-success" type="button" onclick="location.href='/running/id/${data.board.id}' ">상세보기</button></div>			
			 <div style="width: 10px;"></div>
			<div style="display: flex;">
			<div class = "mt-2">모집인원 : ${data.board.people} / 현재인원 : ${data.board.currentNum - 1 < 0 ? 0 : data.board.currentNum - 1}</div>  
      <button class="chatRoomCheckBtn btn btn-light" type="button" style="margin-left: auto;">${data.board.writer}님과의 채팅방 만들기</button></div>
			`);
					} else if (people > currentNum && isMine) {
						$("#resMate").append(`</div>
						<div class="mb-2" style="display: grid; grid-template-columns: 1fr;">
			<button  class = "joinPartyBtn btn btn-danger" data-board-id = "${data.board.id}" data-board-userId = "${data.board.writer}">취소하기🙋‍♂️🙋‍♀️🙋‍♂️🙋‍♀</button></div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button class="btn btn-success" type="button" onclick="location.href='/running/id/${data.board.id}' ">상세보기</button></div>			
			 <div style="width: 10px;"></div>
			<div style="display: flex;">
			<div class = "mt-2">모집인원 : ${data.board.people}  / 현재인원 : ${data.board.currentNum - 1 < 0 ? 0 : data.board.currentNum - 1}</div> 
      <button class="chatRoomCheckBtn btn btn-light" type="button" style="margin-left: auto;">${data.board.writer}님과의 채팅방 만들기</button></div>
			`);
					} else if (people > currentNum && !isMine) {
						$("#resMate").append(`</div>
						
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button  class = "joinPartyBtn btn btn-primary" data-board-id = "${data.board.id}" data-board-userId = "${data.board.writer}">참여하기🙋‍♂️🙋‍♀️🙋‍♂️🙋‍♀</button></div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button class="btn btn-success" type="button" onclick="location.href='/running/id/${data.board.id}' ">상세보기</button></div>			
			 <div style="width: 10px;"></div>
			<div style="display: flex;">
			<div class = "mt-2">모집인원 : ${data.board.people} / 현재인원 : ${data.board.currentNum - 1 < 0 ? 0 : data.board.currentNum - 1}</div> 
			<button class="chatRoomCheckBtn btn btn-light" type="button" style="margin-left: auto;">${data.board.writer}님과의 채팅방 만들기</button></div>
			`);
					} else if (people <= currentNum && !isMine) {
						$("#resMate").append(`
				</div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button   data-board-id = "${data.board.id}" data-board-userId = "${data.board.writer}">마감되었습니다.</button></div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button class="btn btn-success" type="button" onclick="location.href='/running/id/${data.board.id}' ">상세보기</button></div>			
			 <div style="width: 10px;"></div>
			<div style="display: flex;">
			<div class = "mt-2">모집인원 : ${data.board.people} / 현재인원 : ${data.board.currentNum - 1 < 0 ? 0 : data.board.currentNum - 1}</div>  
			<button class="chatRoomCheckBtn btn btn-light" type="button" style="margin-left: auto;">${data.board.writer}님과의 채팅방 만들기</button></div>
			`);

					} else {
						$("#resMate").append(`</div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button  class = "joinPartyBtn btn btn-danger" data-board-id = "${data.board.id}" data-board-userId = "${data.board.writer}">취소하기🙋‍♂️🙋‍♀️🙋‍♂️🙋‍♀</button><div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button class="btn btn-success" type="button" onclick="location.href='/running/id/${data.board.id}' ">상세보기</button></div>
			 <div style="width: 10px;"></div>
			<div style="display: flex;">
			<div class = "mt-2">모집인원 : ${data.board.people} / 현재인원 : ${data.board.currentNum - 1 < 0 ? 0 : data.board.currentNum - 1}</div> 
			<button class="chatRoomCheckBtn btn btn-light" type="button" style="margin-left: auto;">${data.board.writer}님과의 채팅방 만들기</button></div>
			`);

					}
				} else {
					$("#resMate").append(`</div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button  class = "btn btn-danger" data-board-id = "${data.board.id}" data-board-userId = "${data.board.writer}">거절된 러닝</button></div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button class="btn btn-success" type="button" onclick="location.href='/running/id/${data.board.id}' ">상세보기</button></div>		
			 <div style="width: 10px;"></div>
			<div style="display: flex;">
			<div class = "mt-2">모집인원 : ${data.board.people} / 현재인원 : ${data.board.currentNum - 1 < 0 ? 0 : data.board.currentNum - 1}</div>  
			<button class="chatRoomCheckBtn btn btn-light" type="button" style="margin-left: auto;">${data.board.writer}님과의 채팅방 만들기</button></div>
			`);
				}
			} else {
				$("#resMate").append(`</div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button  class = "btn btn-danger" data-board-id = "${data.board.id}" data-board-userId = "${data.board.writer}">종료된 러닝</button></div>
			<div class="mb-2" style="display: grid; grid-template-columns: 1fr;"><button class="btn btn-success" type="button" onclick="location.href='/running/id/${data.board.id}' ">상세보기</button></div>			
			 <div style="width: 10px;"></div>
			<div style="display: flex;">
			<div class = "mt-2">모집인원 : ${data.board.people} / 현재인원 : ${data.board.currentNum - 1 < 0 ? 0 : data.board.currentNum - 1}</div> 
			<button class="chatRoomCheckBtn btn btn-light" type="button" style="margin-left: auto;">${data.board.writer}님과의 채팅방 만들기</button></div>
			`);
			}

			$(".chatRoomCheckBtn").click(function() {
				const yourNickNameLong = $(this).text();
				const yourNickName = yourNickNameLong.substring(0, yourNickNameLong.indexOf("님과의"));
				console.log(yourNickName);
				$.ajax("/chat/roomCheck?yourNickName=" + yourNickName, {
					success: function(data) {
						console.log(data.check);
						if (data.check) {
							document.addEventListener('keyup', keyupHandler);
							$(".btn-close").click();
							$("#chatListContainer").remove("");
							$("#chatContainer").remove("");
							$("#chatButton").hide();
							$("#chatList").hide();
							$("#chatBox").show();
							$(".chatNameTag").remove();
							$("#dChat").show();
							$("#dGroupChat").hide();
							$("#chatMemberListBtn").hide();
							$(`#returnBtn`).after(`
								<span style="white-space: nowrap; position: absolute; left: 50%; transform: translateX(-50%);" class="chatNameTag">${yourNickName}님과의 채팅방</span>
							`);
							$.ajax("/chat/roomOpen", {
								data: { yourNickName: yourNickName },
								contentType: "application/json",
								success: function(response) {
									var chatList = response.chatList;
									var myId = response.myId;
									lastChatRoomId = response.chatRoomId;
									$("#chatBox").append(`
			                			<div id="chatContainer"></div> 
			            			`)
									if (chatList.length > 12) {
										$("#chatBox").css("width", "357px");
										$(".input-group").css("width", "357px");
										$("#chatSearchBox").css("width", "303px");
										$("#chatSearch").css("width", "232px");
									} else {
										$("#chatBox").css("width", "340px");
										$(".input-group").css("width", "340px");
										$("#chatSearchBox").css("width", "320px");
										$("#chatSearch").css("width", "249px");
									}
									for (const chat of chatList) {
										if (chat.senderId === myId) {
											if (chat.fileName !== null) {
												$("#chatContainer").append(`
						                	        <div class="d-flex justify-content-end" style="padding-right: 10px;" id="${chat.id}">
						            	                <div style="font-size: 12px; margin-top: auto; margin-right: 2px;">${chat.time}</div>
						          						<div>
															<img class="img-fluid img-thumbnail" src="${chat.imgUrl}" height="200" width="200" />
														</div>
						    	                    </div>
							                    `)
											} else {
												$("#chatContainer").append(`
						                	        <div class="d-flex justify-content-end" style="padding-right: 10px;" id="${chat.id}">
						            	                <div style="font-size: 12px; margin-top: auto; margin-right: 2px;">${chat.time}</div>
						        	                    <div style=" padding: 5px; background-color: #f0f0f0; border-radius: 15px; margin-bottom: 5px; word-break: break-all; max-width: 200px;">${chat.message}</div> 
						    	                    </div>
							                    `)
											}
										} else {
											if (chat.fileName !== null) {
												$("#chatContainer").append(`
							                        <div class="d-flex justify-content-start" style="padding-left: 10px;" id="${chat.id}">
						          						<div>
															<img class="img-fluid img-thumbnail" src="${chat.imgUrl}" height="200" width="200" />
														</div>
							                            <div style="font-size: 12px; margin-top: auto; margin-left: 2px;">${chat.time}</div>
							                        </div>
							                    `)
											} else {
												$("#chatContainer").append(`
							                        <div class="d-flex justify-content-start" style="padding-left: 10px;" id="${chat.id}">
							                            <div style=" padding: 5px; background-color: #f0f0f0; border-radius: 15px; margin-bottom: 5px; word-break: break-all; max-width: 200px;">${chat.message}</div>
							                            <div style="font-size: 12px; margin-top: auto; margin-left: 2px;">${chat.time}</div>
							                        </div>
							                    `)
											}
										}
									}
									scrollToBottom();
									lastChatId = chatList[chatList.length - 1].id;
									repeat = setInterval(function() {
										currentChatId(lastChatId, lastChatRoomId, $("#chatContainer"));
									}, 500);

								}
							})
						} else {
							$(".createChatRoomCheckBtn").trigger("click");
						}
					}
				})
			})


			//*********** 지도 관련 ***************/
			$('#confirmModal').on('shown.bs.modal', function() {
				var mapContainer = document.getElementById('map');
				var mapOption = {
					center: new kakao.maps.LatLng(latNum, lngNum),
					level: 1
				};

				var map = new kakao.maps.Map(mapContainer, mapOption);

				function resizeMap() {
					var mapContainer = document.getElementById('map');
					mapContainer.style.width = '470px';
					mapContainer.style.height = '500px';
				}

				resizeMap();
				map.relayout();

				var markerPosition = new kakao.maps.LatLng(latNum, lngNum);
				var marker = new kakao.maps.Marker({
					position: markerPosition
				});
				marker.setMap(map);
			});

			$('#confirmModal').modal('show');
		}
	});
}



$(".listUpButton").click(handleListUpButtonClick);


$(document).on('click', '.joinPartyBtn', function() {

	const boardId = $(this).attr("data-board-id");
	const userId = $(this).attr("data-board-userId");

	console.log("&&" + boardId)
	console.log("!!" + userId)

	const data = { boardId, userId };
	console.log(data)

	$.ajax("/running/joinParty", {
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(data),

		success: function(data) {
			if (data.join) {
				alert("신청되었습니다.");
				location.href = "/running/id/" + boardId;
			} else {
				alert("취소되었습니다.");
				location.reload();
			}

		},
		error: function(jqXHR) {
			alert("신청 실패");
		}


	});
});



