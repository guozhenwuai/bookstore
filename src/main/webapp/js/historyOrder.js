
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

function ShowItems(id){
	jQuery.ajax({
    	url : 'itemDetails',
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
				trs += "<td>" 
					+ "<img src='getCover?id="+value.bookId+"' "
					+ "onerror='this.src=\"img/default.jpg\"' "
					+ " style='width:50px'/>" + "</td>";
	            trs += "<td>" + book.name + "</td>";
	            trs += "<td>" + value.num + "</td>";
	            trs += "<td>" + value.realPrice + "</td>";
	            trs += "</tr>";
	            tbody += trs;
	        });
			$("#order_item_body").html(tbody);
			
			
			$("#hidden_order_id").val(id);
			$("#order_item_modal").modal("show");
		}
    });
}