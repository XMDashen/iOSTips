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