/**
 * for cart manage
 */
// Add Record
function addRecord() {
    // get values
    var user_id = $("#user_id").val();
    var book_id = $("#book_id").val();
    var num = $("#num").val();

    // Add record
    $.post("addCart", {
        user_id: user_id,
        book_id: book_id,
        num: num
    }, function (data, status) {
        // close the popup
        $("#add_new_record_modal").modal("hide");

        // read records again
        readRecords();

        // clear fields from the popup
        $("#user_id").val("");
        $("#book_id").val("");
        $("#num").val("");
    });
}

//READ records
function readRecords() {
    $.post("listCart", {}, function (data, status) {
        $(".records_content").html(data);
    });
}


function DeleteCart(user_id,book_id) {
    var conf = confirm("Are you sure, do you really want to delete Cart?");
    if (conf == true) {
        $.post("deleteCart", {
        	user_id: user_id,
            book_id: book_id
            },
            function (data, status) {
            	// reload Carts by using readRecords();
            	readRecords();
            }
        );
    }
}

function GetCartDetails(user_id,book_id) {
    // Add Cart ID to the hidden field for furture usage
	
	$("#update_user_id").val(user_id);
    $("#update_book_id").val(book_id);
    $.post("getCartDetails", {
            user_id: user_id,
            book_id: book_id
        },
        function (data, status) {
            // PARSE json data
            var cart = JSON.parse(data);
            // Assing existing values to the modal popup fields
            $("#update_num").val(cart.num);
        }
    );
    
    // Open modal popup
    $("#update_cart_modal").modal("show");
}

function UpdateCartDetails() {
    // get values
    var user_id = $("#update_user_id").val();
    var book_id = $("#update_book_id").val();
    var num = $("#update_num").val();

    // get hidden field value

    // Update the details by requesting to the server using ajax
    $.post("updateCartDetails", {
            user_id: user_id,
            book_id: book_id,
            num: num
        },
        function (data, status) {
            // hide modal popup
            $("#update_cart_modal").modal("hide");
            // reload Carts by using readRecords();
            readRecords();
        }
    );
}

$(document).ready(function () {
    // READ recods on page load
    readRecords(); // calling function
});