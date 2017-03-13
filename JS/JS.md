导入jquery库

<head>
<script src="jquery.js"></script>
</head>

<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js">
</script>
</head>

<head>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js">
</script>
</head>

基础语法是：$(selector).action()
美元符号定义 jQuery
选择符（selector）“查询”和“查找” HTML 元素
jQuery 的 action() 执行对元素的操作

jQuery 元素选择器
jQuery 使用 CSS 选择器来选取 HTML 元素。
$("p") 选取 <p> 元素。
$("p.intro") 选取所有 class="intro" 的 <p> 元素。
$("p#demo") 选取所有 id="demo" 的 <p> 元素

jQuery 属性选择器
jQuery 使用 XPath 表达式来选择带有给定属性的元素。
$("[href]") 选取所有带有 href 属性的元素。
$("[href='#']") 选取所有带有 href 值等于 "#" 的元素。
$("[href!='#']") 选取所有带有 href 值不等于 "#" 的元素。
$("[href$='.jpg']") 选取所有 href 值以 ".jpg" 结尾的元素

网络请求

XHR创建请求对象
variable=new XMLHttpRequest();

请求
xmlhttp.open("POST/GET","http://...",true);
xmlhttp.send();

响应
xmlhttp.responseText
responseText	获得字符串形式的响应数据。
responseXML		获得 XML 形式的响应数据。


响应状态--onreadystatechange
onreadystatechange	存储函数（或函数名），每当 readyState 属性改变时，就会调用该函数。
readyState	存有 XMLHttpRequest 的状态。从 0 到 4 发生变化。
0: 请求未初始化
1: 服务器连接已建立
2: 请求已接收
3: 请求处理中
4: 请求已完成，且响应已就绪
status	
200: "OK"
404: 未找到页面

xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
    }
  }
  
  
  FormData对象
  var form = new FormData();
form.append("username", "uijcde3d");
form.append("engname", "inwedf2d");

processData: false,  // 设置jQuery不去处理发送的数据
contentType: false   // 设置jQuery不去设置Content-Type请求头

Access-Control-Allow-Origin 跨域访问
JSONP只支持GET

