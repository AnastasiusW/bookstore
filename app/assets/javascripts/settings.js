$(document).ready(function(){
  $('#agree_checkbox').click(function() {
    var current_checkbox = document.getElementById("agree_checkbox").checked;
    var current_destroy = document.getElementById("destroy_button");
    if (current_checkbox) {
        current_destroy.removeAttribute("disabled");
    }
    else {
        current_destroy.setAttribute("disabled", "true");
    }
  });
});
