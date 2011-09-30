var AUDIENCE = ( function(context) {
	
	// Register User As Audience In Room
	var joinRoom = function () {
		var url = context.getVar('joinRoomUrl');
		var requestData = {
			'room_name' : context.getVar('roomName')
		};
		
		$.getJSON(url, requestData, function(responseData) {
			console.log("Joined Game: " + JSON.stringify(responseData));
			outputToConsole(responseData);
		});
	};
	
	// Make Poll Choices Clickable
	var attachPollChoiceTriggers = function () {
		var roomName = context.getVar('roomName');
		var choiceElements = context.getElement('pollChoices');
		var url = context.getVar('submitMoodUrl');
		
		$.each( choiceElements, function (index, choiceElement) {
			var choice = $(choiceElement).data('choice');
			var requestData = {
				'room_name' : roomName,
				'answer' : choice
			};
			
			$(choiceElement).click( function() {
				console.log("Submit Mood: " + choice);
				$.getJSON(url, requestData, function (responseData) {
					console.log("Received Choice: " + JSON.stringify(responseData));
					outputToConsole(responseData);
				});	
			});			
		});
	};
	
	// Debug Output To Console
	var outputToConsole = function (jsonData) {
		var console = CONTEXT.getElement('console');
		$(console).append("<li>" + JSON.stringify(jsonData) + "</li>");	
	};
	
	// Join Room Immediately and Subscribe To Channel. Register Elements To Actions.
	var initOnPageReady = function () {
		joinRoom();
		attachPollChoiceTriggers();	
	};
	
	// ///////////////////////////
	// Expose These As Public
	// ///////////////////////////
	
	var my = {};
	my.initOnPageReady = initOnPageReady;
	
	return my;
	
} (CONTEXT) );