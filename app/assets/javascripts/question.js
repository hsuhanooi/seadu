$(function () {
  if ($('#question_list li').length > 0) {
    setTimeout(updateQuestions, 5000);
  };
});

function updateQuestions() {
  var room_id = $('#room').attr('data-id')
  var page = $('#questions').attr('data-page');
  var sorting = $('#questions').attr('data-sort');
  if (!page) {
    $.getScript('/questions/' + sorting + '.js?room_id=' + room_id + "&page=" + page);
  };
  setTimeout(updateQuestions, 5000);
}