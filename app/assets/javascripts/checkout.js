$(document).ready(function(){
  $('#use_billing_address').click(function() {
    $('.shipping_order_form').prop('hidden',$(this).is(':checked'));
  });
});
