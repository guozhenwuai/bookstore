/**
 * 
 */

function updateAvatar(id){
	$.ajaxFileUpload({
		url : 'updateAvatar',
		fileElementId : 'avatar',
		dataType : "text",
		data : {
			id:id
		},
		complete : function(data) {
	        location.reload();
		}
	});
}

function saveProfile(id){
	var email = $("#email").val();
    var receiver = $("#receiver").val();
    var address = $("#address").val();
    var phone = $("#phone").val();
    jQuery.ajax({
		url : 'userProfile!save',
		processData : true,
		dataType : "text",
		data : {
			id: id,
	        email: email,
	        receiver: receiver,
	        address: address,
	        phone: phone
		},
		complete : function(data){}
    });
}

function orderHistory(id){
	location.href="orderHistory?id="+id;
}

function resetPassword(id){
	var password = $("#old_password").val();
    var newpwd = $("#new_password").val();
    jQuery.ajax({
		url : 'userProfile!resetPassword',
		type: "post",
		dataType : "json",
		data :{
			id: id,
			password: password,
			newpwd: newpwd
		},
		success: function(result){
			if(result=="false"){
				alert("please input old password correctly!");
			}
			else{
				alert("successfully reset password!");
				$("#password_modal").hide();
			}
		}
	});
}