function regist () {
	
var form = new FormData();
form.append("username", "lol643");
form.append("engname", "dfisecsce2");
form.append("password", "a123211");
form.append("confirm_password", "a123211");
form.append("rank_level", "5D");
form.append("avatar", "Mouse");
form.append("name", "wssxx");
form.append("sex", "1");
form.append("birthdayYear", "1957");
form.append("birthdayMonth", "1");
form.append("birthdayDay", "1");
form.append("idcard", "510107199112120101");
form.append("mobile", "");
form.append("email", "3358846010@qq.com");
form.append("back_act", "");
form.append("act", "act_register");
form.append("is_email", "1");

var settings = {
  "async": true,
  "crossDomain": true,
  "url": "https://shop.eweiqi.com/user.php?act=validate_email",
  "method": "POST",
  "headers": {
    "cache-control": "no-cache",
    "postman-token": "3b006a1f-0879-572f-a361-290337bb6c53"
  },
  "processData": false,
  "contentType": false,
  "mimeType": "multipart/form-data",
  "data": form
}

$.ajax(settings).done(function (response) {
  alert(response)
});

}