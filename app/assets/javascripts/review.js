$(document).ready(function(){
  $('[id^="rating_id_"]').click(function(){
    var rating = $(this).data("value")
    $('#reviewRatingValue').val(rating);
    for (var i = 1; i <= 5; i++) {
        $("#rating_id_" + i).addClass("rate-empty");
    }
    for (var i = 1; i <=rating; i++) {
        $("#rating_id_" + i).removeClass("rate-empty");
        $("#rating_id_" + i).addClass("rate-star");
    }
  });
});
