/**
 * for order manage
 */
// Add Record
function addRecord() {
    // get values
    var user = $("#userId").val();
    var receiver = $("#receiver").val();
    var address = $("#address").val();
    var phone = $("#phone").val();
    var date = $("#date").val();
    var price = $("#totalPrice").val();

    // Add record
    
    jQuery.ajax({
		url : 'order!add',
		processData : true,
		dataType : "text",
		data : {
			userId: user,
	        realPrice: price,
	        date:date,
	        receiver: receiver,
	        address: address,
	        phone: phone
		},
		complete : function(data) {
			$("#add_new_record_modal").modal("hide");
 
			// clear fields from the popup
	        $("#userId").val("");
	        $("#receiver").val("");
	        $("#address").val("");
	        $("#phone").val("");
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

function addItem() {
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

function UpdateOrderDetails() {
    // get values
	var user = $("#update_userId").val();
	var receiver = $("#update_receiver").val();
    var address = $("#update_address").val();
    var phone = $("#update_phone").val();
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
			userId: user,
			receiver: receiver,
	        address: address,
	        phone: phone,
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

function GetOrderItemDetails(oid,bid){
	jQuery.ajax({
    	url : 'orderItem!details',
		processData : true,
		dataType : "json",
		data :{
			orderId:oid,
			bookId:bid
		},
		success: function(result) {
			result = JSON.parse(result);
			$("#update_order_id").val(result.orderId);
		    $("#update_book_id").val(result.bookId);
		    $("#update_number").val(result.num);
		    $("#update_price").val(result.realPrice);

			$("#update_order_item_modal").modal("show");
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

function ShowItems(id){
	jQuery.ajax({
    	url : 'orderItem!showItems',
		processData : true,
		dataType : "json",
		data :{
			id:id
		},
		success: function(result) {
			result = JSON.parse(result);
			tbody = "";
			$.each(result, function (n, value) {
				var book = value.book;
				var trs = "<tr>";
				trs += "<td>" + book.id + "</td>";
	            trs += "<td>" + book.name + "</td>";
	            trs += "<td>" + value.num + "</td>";
	            trs += "<td>" + value.realPrice + "</td>";
	            trs += "<td>" + "<button class='btn btn-warning edit' type='button'"
	            	+ "onclick='GetOrderItemDetails(" + value.orderId + "," + value.bookId + ")'"
	            	+ ">Update</button>" + "</td>";
	            trs += "<td>" + "<button class='btn btn-danger' type='button' "
	            	+ "onclick='DeleteOrderItem(" + value.orderId + "," + value.bookId + ")'"
	            	+ ">Delete</button>" + "</td>";
	            trs += "</tr>";
	            tbody += trs;
	        });
			$("#order_item_body").html(tbody);
			
			
			$("#hidden_order_id").val(id);
			$("#order_item_modal").modal("show");
		}
    });
}

$(function(){
	$(".edit").click(function(e) {
		alert("edit");
		var dataset = e.currentTarget.dataset;
		// Add User ID to the hidden field for furture usage
		$("#hidden_order_id").val(dataset.id);
    
		$("#update_receiverId").val(dataset.user);
		$("#update_receiver").val(dataset.receiver);
	    $("#update_address").val(dataset.address);
	    $("#update_phone").val(dataset.phone);
		$("#update_totalPrice").val(dataset.price);
		$("#update_date").val(dataset.date);

		$("#update_order_modal").modal("show");
	});
	$("#add_new_record").click(function(e){
		$("#add_new_record_modal").modal("show");
	});
	$("#add_item").click(function(e){
		$("#order_id").val($("#hidden_order_id").val());
		$("#add_new_item_modal").modal("show");
	});
});