$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $("#question_up").on("submit", voteQuestion);
  $("#question_down").on("submit", voteQuestion);
  $("#answer_up").on("submit", voteAnswer);
  $("#answer_down").on("submit", voteAnswer);
  //$("#comment_up").on("submit", voteComment);
  //$("#comment_down").on("submit", voteComment);

  function voteQuestion(event) {
    event.preventDefault()
    var $voteButton = $(event.target);
    var url = $voteButton.attr("action");
    var method = $voteButton.attr("method");
    var data = $voteButton.serialize();

    $.ajax({
      url: url,
      method: method,
      data: data,
    })
      .done( function(reputation) {
        $("#questionReputation").text(reputation.value);
      });
  };

  function voteAnswer(event) {
    event.preventDefault()
    var $voteButton = $(event.target);
    var url = $voteButton.attr("action");
    var method = $voteButton.attr("method");
    var data = $voteButton.serialize();
    console.log(event.target);
    console.log(url)
    console.log(method)
    console.log(data)

    $.ajax({
      url: url,
      method: method,
      data: data
    })
      .done( function(reputation) {
        $("#answerReputation").text(reputation.value);
      });
  };

  // function voteComment(event) {
  // };


  $(".posterbox").on("click", function(event) {
    alert("hitting the paragraph");
    event.preventDefault();


  });

});
