

function decrementQuantity(price) {
    var input_count = document.getElementById("quantity_input");

    if (input_count.value > 1){
        input_count.value--;
        priceCalculator(price,input_count.value);
    }
}

function incrementQuantity(price){

    var input_count= document.getElementById("quantity_input");
    input_count.value++;

    priceCalculator(price,input_count.value);

}


function priceCalculator(price,input){
    var price_of_element = document.getElementById("price");
    var currency_unit = price_of_element.textContent.substring(0, 1);
    price_of_element.textContent = currency_unit + (price * input).toFixed(2);

}
