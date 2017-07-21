/**
 * for user manage
 */
// Add Record
function addRecord() {
	// get values
    var user_id = $("#user_id").val();
    var name = $("#name").val();
    var province = $("#province").val();
    var city = $("#city").val();
    var street = $("#street").val();
    var building = $("#building").val();
    var phone_num = $("#phone_num").val();
    var is_default = $("input[name='is_default']:checked").val();

    // Add record
    
    jQuery.ajax({
		url : 'receiver!add',
		processData : true,
		dataType : "text",
		data : {
			userId: user_id,
	        name: name,
	        province: province,
	        city: city,
	        street: street,
	        definitAddr: building,
	        phoneNum: phone_num,
	        isDefault: is_default
		},
		complete : function(data) {
			$("#add_new_record_modal").modal("hide");
 
			// clear fields from the popup
			$("#user_id").val("");
	        $("#name").val("");
	        $("#province").val("");
	        $("#city").val("");
	        $("#street").val("");
	        $("#building").val("");
	        $("#phone_num").val("");
	        $("input[name='is_default']").get(1).click();
	        
	        location.reload();
		}
	});
}

function DeleteReceiver(id) {
    var conf = confirm("Are you sure, do you really want to delete Receiver?");
    if (conf == true) {
    	jQuery.ajax({
        	url : 'receiver!delete',
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

function UpdateReceiverDetails() {
    // get values
	var user_id = $("#update_user_id").val();
    var name = $("#update_name").val();
    var province = $("#update_province").val();
    var city = $("#update_city").val();
    var street = $("#update_street").val();
    var building = $("#update_building").val();
    var phone_num = $("#update_phone_num").val();
    var is_default = $("input[name='update_is_default']:checked").val();

    // get hidden field value
    var id = $("#hidden_receiver_id").val();

    // Update the details by requesting to the server using ajax
    jQuery.ajax({
		url : 'receiver!update',
		processData : true,
		dataType : "text",
		data : {
			id:id,
			userId: user_id,
	        name: name,
	        province: province,
	        city: city,
	        street: street,
	        definitAddr: building,
	        phoneNum: phone_num,
	        isDefault: is_default
		},
		complete : function(data) {
			// hide modal popup
            $("#update_receiver_modal").modal("hide");
            // reload Receivers by using readRecords();
            location.reload();
		}
	});
}

$(function(){
	$(".edit").click(function(e) {
		
		var dataset = e.currentTarget.dataset;
		// Add Receiver ID to the hidden field for furture usage
		$("#hidden_receiver_id").val(dataset.id);
		$("#update_name").val(dataset.name);
	    $("#update_province").val(dataset.province);
	    $("#update_city").val(dataset.city);
	    $("#update_street").val(dataset.street);
	    $("#update_building").val(dataset.building);
	    $("#update_phone_num").val(dataset.phone);
        var index = dataset.isDefault;
        if(index==1){
        	index=0;
        }
        else{
        	index=1;
        }
        $("input[name='update_is_default']").get(index).click();

		$("#update_receiver_modal").modal("show");
	});
	$("#add_new_record").click(function(e){
		$("#add_new_record_modal").modal("show");
	});
});