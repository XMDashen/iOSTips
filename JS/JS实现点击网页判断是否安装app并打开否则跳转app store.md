JS实现点击网页判断是否安装app并打开否则跳转app store

核心
```
<!-- a标签的链接，设置为对应的下载链接；点击打开的动作，在click事件中注册 --> 
<a href="https://itunes.apple.com/cn/app/id477927812" id="openApp">贴吧客户端</a> 
<script type="text/javascript"> 
document.getElementById('openApp').onclick = function(e){ 
// 通过iframe的方式试图打开APP，如果能正常打开，会直接切换到APP，并自动阻止a标签的默认行为 
// 否则打开a标签的href链接 
var ifr = document.createElement('iframe'); 
ifr.src = 'com.baidu.tieba://'; 
ifr.style.display = 'none'; 
document.body.appendChild(ifr); 
window.setTimeout(function(){ 
document.body.removeChild(ifr); 
},3000) 
}; 
</script>
```

```
if(navigator.userAgent.match(/android/i)) {
// 通过iframe的方式试图打开APP，如果能正常打开，会直接切换到APP，并自动阻止a标签的默认行为
// 否则打开a标签的href链接
var isInstalled;
//下面是安卓端APP接口调用的地址，自己根据情况去修改
var ifrSrc = 'cartooncomicsshowtwo://platformapi/startApp? type=0&id=${com.id}&phone_num=${com.phone_num}';
var ifr = document.createElement('iframe');
ifr.src = ifrSrc;
ifr.style.display = 'none';
ifr.onload = function() {
// alert('Is installed.');
isInstalled = true;
alert(isInstalled);
document.getElementById('openApp0').click();};
ifr.onerror = function() {
// alert('May be not installed.');
isInstalled = false;
alert(isInstalled);
}
document.body.appendChild(ifr);
setTimeout(function() {
document.body.removeChild(ifr);
},1000);
}
//ios判断
if(navigator.userAgent.match(/(iPhone|iPod|iPad);?/i))
if(navigator.userAgent.match(/(iPhone|iPod|iPad);?/i)) {
//Animation://com.yz.animation
var isInstalled;
//var gz = '{"comName":"${com.short_name}","comID":"${com.id}","comPhoneNum":"${com.phone_num}","type":"0"}';
//var jsongz =JSON.parse(gz);
//下面是IOS调用的地址，自己根据情况去修改
var ifrSrc = 'Animation://?comName=${com.short_name}&comID=${com.id}&comPhoneNum=${com.phone_num}&type=0';var ifr = document.createElement('iframe');
ifr.src = ifrSrc;
ifr.style.display = 'none';
ifr.onload = function() {
// alert('Is installed.');
isInstalled = true;
alert(isInstalled);
document.getElementById('openApp1').click();};
ifr.onerror = function() {
// alert('May be not installed.');
isInstalled = false;
alert(isInstalled);
}
document.body.appendChild(ifr);
setTimeout(function() {
document.body.removeChild(ifr);
},1000);
}
}
```

测试可用
```
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<script type="text/javascript">
		</script>
		<title></title>
	</head>
	<body>
		<button id="openUrl" width="200" height="200">OpenUrl</button>
			<script type="text/javascript">
				
				var appSource="dongdongOpenUrl://";
//				var appSource="QQ41E4789A://";
//				var appSource="http://www.jianshu.com";
				document.getElementById("openUrl").onclick=function(e) {
					//alert("click");
					var ifr=document.createElement("iframe");
					ifr.src=appSource
					
					ifr.style.display="none";
					ifr.onload=function() {
						//alert("跳转到app");
						window.location.href=appSource;
						return;
					}
					
					ifr.onerror=function () {
						//alert("未安装app");
					}
					document.body.appendChild(ifr);
					setTimeout(function() {
						document.body.removeChild(ifr);
						window.location.href="https://itunes.apple.com/us/app/%E6%87%82%E6%87%82%E5%A9%9A%E7%A4%BC-%E6%96%B9%E6%A1%88%E4%B8%AD%E5%BF%83%E7%AD%B9%E5%A9%9A%E5%B9%B3%E5%8F%B0/id1211982236?mt=8";
						
					},4000);
				}
					
				
			</script>
	</body>
</html>
```
