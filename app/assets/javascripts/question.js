$(function () {
  if ($('#question_list li').length > 0) {
    setTimeout(updateQuestions, 5000);
  };
});

function updateQuestions() {
  var room_id = $('#room').attr('data-id');
  var page = $('#questions').attr('data-page');
  var sorting = $('#questions').attr('data-sort');
  var teacher = $('#teachers_view').length > 0;
  if (!page) {
    $.getScript('/questions/' + sorting + '.js?room_id=' + room_id + "&page=" + page + "&teacher=" + teacher);
  };
  setTimeout(updateQuestions, 5000);
}