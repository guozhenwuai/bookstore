/**
 * for cart item manage
 */
// Add Record
function addRecord() {
    // get values
	var user_id = $("#user_id").val();
    var book_id = $("#book_id").val();
    var num = $("#number").val();

    // Add record
    jQuery.ajax({
		url : 'cartItem!add',
		processData : true,
		dataType : "text",
		data : {
			userId: user_id,
	        bookId: book_id,
	        num: num
		},
		complete : function(data) {
			$("#add_new_record_modal").modal("hide");
 
			// clear fields from the popup
			$("#user_id").val("");
	        $("#book_id").val("");
	        $("#number").val("");
	        
	        location.reload();
		}
	});
}

function DeleteCartItem(uid,bid) {
    var conf = confirm("Are you sure, do you really want to delete CartItem?");
    if (conf == true) {
    	jQuery.ajax({
        	url : 'cartItem!delete',
    		processData : true,
    		dataType : "text",
    		data :{
    			userId:uid,
    			bookId:bid
    		},
    		complete: function(data) {
    			location.reload();
    		}
        });
    }
}

function UpdateCartItemDetails() {
    // get values
	var user_id = $("#update_user_id").val();
    var book_id = $("#update_book_id").val();
    var num = $("#update_number").val();

    // Update the details by requesting to the server using ajax
    jQuery.ajax({
		url : 'cartItem!update',
		processData : true,
		dataType : "text",
		data : {
			userId: user_id,
	        bookId: book_id,
	        num: num
		},
		complete : function(data) {
			// hide modal popup
            $("#update_cart_item_modal").modal("hide");
            // reload Users by using readRecords();
            location.reload();
		}
	});
}

$(function(){
	$(".edit").click(function(e) {
		
		var dataset = e.currentTarget.dataset;
		// Add User ID to the hidden field for furture usage
    
		$("#update_user_id").val(dataset.uid);
	    $("#update_book_id").val(dataset.bid);
	    $("#update_number").val(dataset.num);
	    
		$("#update_cart_item_modal").modal("show");
	});
	$("#add_new_record").click(function(e){
		$("#add_new_record_modal").modal("show");
	});
});