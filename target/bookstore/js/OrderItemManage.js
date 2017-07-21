/**
 * for order item manage
 */
// Add Record
function addRecord() {
    // get values
	var order_id = $("#order_id").val();
    var book_id = $("#book_id").val();
    var num = $("#number").val();
    var price = $("#price").val();

    // Add record
    jQuery.ajax({
		url : 'orderItem!add',
		processData : true,
		dataType : "text",
		data : {
			orderId: order_id,
	        bookId: book_id,
	        num: num,
	        realPrice: price
		},
		complete : function(data) {
			$("#add_new_record_modal").modal("hide");
 
			// clear fields from the popup
			$("#order_id").val("");
	        $("#book_id").val("");
	        $("#number").val("");
	        $("#price").val("");
	        
	        location.reload();
		}
	});
}

function DeleteOrderItem(oid,bid) {
    var conf = confirm("Are you sure, do you really want to delete OrderItem?");
    if (conf == true) {
    	jQuery.ajax({
        	url : 'orderItem!delete',
    		processData : true,
    		dataType : "text",
    		data :{
    			orderId:oid,
    			bookId:bid
    		},
    		complete: function(data) {
    			location.reload();
    		}
        });
    }
}

function UpdateOrderItemDetails() {
    // get values
	var order_id = $("#update_order_id").val();
    var book_id = $("#update_book_id").val();
    var num = $("#update_number").val();
    var price = $("#update_price").val();

    // Update the details by requesting to the server using ajax
    jQuery.ajax({
		url : 'orderItem!update',
		processData : true,
		dataType : "text",
		data : {
			orderId: order_id,
	        bookId: book_id,
	        num: num,
	        realPrice: price
		},
		complete : function(data) {
			// hide modal popup
            $("#update_order_item_modal").modal("hide");
            // reload Users by using readRecords();
            location.reload();
		}
	});
}

$(function(){
	$(".edit").click(function(e) {
		
		var dataset = e.currentTarget.dataset;
		// Add User ID to the hidden field for furture usage
    
		$("#update_order_id").val(dataset.oid);
	    $("#update_book_id").val(dataset.bid);
	    $("#update_number").val(dataset.num);
	    $("#update_price").val(dataset.price);

		$("#update_order_item_modal").modal("show");
	});
	$("#add_new_record").click(function(e){
		$("#add_new_record_modal").modal("show");
	});
});