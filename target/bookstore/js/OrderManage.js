/**
 * for order manage
 */
// Add Record
function addRecord() {
    // get values
    var receiver = $("#receiverId").val();
    var date = $("#date").val();
    var price = $("#totalPrice").val();

    // Add record
    
    jQuery.ajax({
		url : 'order!add',
		processData : true,
		dataType : "text",
		data : {
			userId: receiver,
	        realPrice: price,
	        date:date
		},
		complete : function(data) {
			$("#add_new_record_modal").modal("hide");
 
			// clear fields from the popup
	        $("#receiverId").val("");
	        $("#date").val("");
	        $("#totalPrice").val("");
	        
	        location.reload();
		}
	});
}

function DeleteOrder(id) {
    var conf = confirm("Are you sure, do you really want to delete Order?");
    if (conf == true) {
    	jQuery.ajax({
        	url : 'order!delete',
    		processData : true,
    		dataType : "text",
    		data :{
    			id:id
    		},
    		complete: function(data) {
    			location.reload();
    		}
        });
    }
}

function UpdateOrderDetails() {
    // get values
	var receiver = $("#update_receiverId").val();
    var date = $("#update_date").val();
    var price = $("#update_totalPrice").val();

    // get hidden field value
    var id = $("#hidden_order_id").val();

    // Update the details by requesting to the server using ajax
    jQuery.ajax({
		url : 'order!update',
		processData : true,
		dataType : "text",
		data : {
			id:id,
			userId: receiver,
	        realPrice: price,
	        date:date
		},
		complete : function(data) {
			// hide modal popup
            $("#update_order_modal").modal("hide");
            // reload Users by using readRecords();
            location.reload();
		}
	});
}

$(function(){
	$(".edit").click(function(e) {
		
		var dataset = e.currentTarget.dataset;
		// Add User ID to the hidden field for furture usage
		$("#hidden_order_id").val(dataset.id);
    
		$("#update_receiverId").val(dataset.receiver);
		$("#update_totalPrice").val(dataset.price);
		$("#update_date").val(dataset.date);

		$("#update_order_modal").modal("show");
	});
	$("#add_new_record").click(function(e){
		$("#add_new_record_modal").modal("show");
	});
});