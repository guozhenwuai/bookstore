/**
 * for book manage
 */
// Add Record
function addRecord() {
    // get values
    var bookname = $("#bookname").val();
    var category = $("#category").val();
    var author = $("#author").val();
    var price = $("#price").val();

    // Add record
    
    $.ajaxFileUpload({
		url : 'book!add',
		fileElementId : 'cover',
		dataType : "text",
		data : {
			name: bookname,
	        category: category,
	        author: author,
	        realPrice: price
		},
		complete : function(data) {
			$("#add_new_record_modal").modal("hide");
 
			// clear fields from the popup
	        $("#bookname").val("");
	        $("#category").val("");
	        $("#author").val("");
	        $("#price").val("");
	        
	        location.reload();
		}
	});
}

function ClearInputFile(f){
    f.value = ''; //for IE11, latest Chrome/Firefox/Opera...  
}

function DeleteBook(id) {
    var conf = confirm("Are you sure, do you really want to delete Book?");
    if (conf == true) {
    	jQuery.ajax({
        	url : 'book!delete',
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

function showCover(id){
	$("#cover_img").attr('src',"getCover?id="+id);
	$("#cover_modal").modal("show");
}

function UpdateBookDetails() {
    // get values
    var bookname = $("#update_bookname").val();
    var category = $("#update_category").val();
    var author = $("#update_author").val();
    var price = $("#update_price").val();

    // get hidden field value
    var id = $("#hidden_book_id").val();

    // Update the details by requesting to the server using ajax
    $.ajaxFileUpload({
		url : 'book!update',
		fileElementId : 'update_cover',
		dataType : "text",
		data : {
			id:id,
			name: bookname,
	        category: category,
	        author: author,
	        realPrice: price
		},
		complete : function(data) {
			// hide modal popup
            $("#update_book_modal").modal("hide");
            // reload Users by using readRecords();
            location.reload();
		}
	});
}

$(function(){
	$(".edit").click(function(e) {
		
		var dataset = e.currentTarget.dataset;
		// Add User ID to the hidden field for furture usage
		$("#hidden_book_id").val(dataset.id);
		//$("#hidden_cover_src").val(dataset.cover);
    
		$("#update_bookname").val(dataset.name);
		$("#update_author").val(dataset.author);
		$("#update_category").val(dataset.category);
		$("#update_price").val(dataset.price);
		
		ClearInputFile(document.getElementById('update_cover'));

		$("#update_book_modal").modal("show");
	});
	$("#add_new_record").click(function(e){
		ClearInputFile(document.getElementById('cover'));
		$("#add_new_record_modal").modal("show");
	});
});