/**
 * for user manage
 */
// Add Record
function addRecord() {
    // get values
    var username = $("#username").val();
    var password = $("#password").val();
    var email = $("#email").val();
    var receiver = $("#receiver").val();
    var address = $("#address").val();
    var phone = $("#phone").val();
    var isAdmin = $("input[name='isAdmin']:checked").val();

    // Add record
    
    jQuery.ajax({
		url : 'user!add',
		processData : true,
		dataType : "text",
		data : {
			username: username,
	        password: password,
	        email: email,
	        isAdmin: isAdmin,
	        receiver: receiver,
	        address: address,
	        phone: phone
		},
		complete : function(data) {
			$("#add_new_record_modal").modal("hide");
 
			// clear fields from the popup
	        $("#username").val("");
	        $("#password").val("");
	        $("#email").val("");
	        $("#receiver").val("");
	        $("#address").val("");
	        $("#phone").val("");
	        $("input[name='isAdmin']").get(1).click();
	        
	        location.reload();
		}
	});
}

function DeleteUser(id) {
    var conf = confirm("Are you sure, do you really want to delete User?");
    if (conf == true) {
    	jQuery.ajax({
        	url : 'user!delete',
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

function UpdateUserDetails() {
    // get values
    var username = $("#update_username").val();
    var password = $("#update_password").val();
    var email = $("#update_email").val();
    var receiver = $("#update_receiver").val();
    var address = $("#update_address").val();
    var phone = $("#update_phone").val();
    var isAdmin = $("input[name='update_isAdmin']:checked").val();

    // get hidden field value
    var id = $("#hidden_user_id").val();

    // Update the details by requesting to the server using ajax
    jQuery.ajax({
		url : 'user!update',
		processData : true,
		dataType : "text",
		data : {
			id:id,
			username: username,
	        password: password,
	        email: email,
	        isAdmin: isAdmin,
	        receiver: receiver,
	        address: address,
	        phone: phone
		},
		complete : function(data) {
			// hide modal popup
            $("#update_user_modal").modal("hide");
            // reload Users by using readRecords();
            location.reload();
		}
	});
}

$(function(){
	$(".edit").click(function(e) {
		
		var dataset = e.currentTarget.dataset;
		// Add User ID to the hidden field for furture usage
		$("#hidden_user_id").val(dataset.id);
		
		$("#update_username").val(dataset.username);
        $("#update_password").val(dataset.password);
        $("#update_email").val(dataset.email);
        $("#update_receiver").val(dataset.receiver);
        $("#update_address").val(dataset.address);
        $("#update_phone").val(dataset.phone);
        var index = dataset.isAdmin;
        if(index==1){
        	index=0;
        }
        else{
        	index=1;
        }
        $("input[name='update_isAdmin']").get(index).click();

		$("#update_user_modal").modal("show");
	});
	$("#add_new_record").click(function(e){
		$("#add_new_record_modal").modal("show");
	});
});