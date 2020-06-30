$(document).ready(function(){
  $('#use_billing_address').click(function() {
    $('.shipping_order_form').prop('hidden',$(this).is(':checked'));  });

  if (window.location.pathname == '/checkout/address') {
    $('.shipping_order_form').prop('hidden',$('#use_billing_address').is(':checked'));
  }
});
