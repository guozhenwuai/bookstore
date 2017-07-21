/**
 * 
 */
$(function(){
	jQuery.validator.addMethod("UsernameExistence",function(value,element,param){
		var re;
		$.post("usernameExistence", {
	        username: value
	    },function (data, status) {
	        // PARSE json data
	        var result = JSON.parse(data);
	        if(result.success){
	        	re = true;
	        }
	        else{
	        	re = false;
	        }
	    });
		return re;
	},"Username already exists");
});
