/**
 * 
 */

function placeOrder(id){
	var receiver = $("#receiver").val();
    var address = $("#address").val();
    var phone = $("#phone").val();
    var map = $("#hidden_map").val();
    location.href="placeOrder?userId="+id
    	+"&receiver="+receiver
    	+"&address="+address
    	+"&phone="+phone
    	+"&map="+map;
}