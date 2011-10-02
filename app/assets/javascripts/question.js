$(function () {
  if ($('#question_list li').length > 0) {
    setTimeout(updateQuestions, 10000);
  };
});

function updateQuestions() {
  var room_id = $('#room').attr('data-id')
  var after = $('.question:first').attr('data-time');
  var page = $('#questions').attr('data-page');
  if (!page) {
    $.getScript('/questions/newly_created.js?room_id=' + room_id + "&after=" + after + "&page=" + page);
  };
  setTimeout(updateQuestions, 10000);
}