##iOS网络协议
两台计算机之间进行通讯所共同遵守的规则，就是网络协议

不同的协议代表着不同的资源查找方式、传输方式

###TCP/IP协议（是个协议族，包含了各个层次的众多协议）
四个层次：==应用层、传输层==、互联网络层、网络接口层

传输层协议：TCP、UDP协议
TCP需要接收方反馈(需要建立连接，三次握手，四次挥手)，UDP不需要(UDP为无连接协议)
TCP传输比UDP更可靠，但是效率不如UDP高

应用层协议：HTTP

socket：套接字编程,对tcp/ip协议的封装，是一个接口

###HTTP协议
URL统一资源定位符

HTTP：优点
程序规模小，通信速度快
可以传输任意类型的数据
非持续连接，服务器对客户端做出相应后马上断开连接

在HTTP/1.1协议中，定义了8种发送http请求的方法
GET、POST、OPTIONS、HEAD、PUT、DELETE、TRACE、CONNECT、PATCH

最常用的是GET和POST（实际上GET和POST都能办到增删改查）


###GET&POST
GET
在请求URL后面以?的形式跟上发给服务器的参数，多个参数之间用&隔开，比如http://ww.test.com/login?username=123&pwd=234&type=JSON

POST
发给服务器的参数全部放在请求体中
理论上POST传递的数据量没有限制

###GET和POST的选择

（1）如果要传递大量数据，比如文件上传，只能用POST请求

（2）GET的安全性比POST要差些，如果包含机密\敏感信息，建议用POST

（3）如果仅仅是索取数据（数据查询），建议使用GET

（4）如果是增加、修改、删除数据，建议使用POST


请求头、请求行、请求体、


###在iOS中，常见的发送HTTP请求（GET和POST）的解决方案有

（1）苹果原生（自带）

NSURLConnection：用法简单，最古老最经典最直接的一种方案

NSURLSession：iOS 7新出的技术，功能比NSURLConnection更加强大

CFNetwork：NSURL*的底层，纯C语言

（2）第三方框架

     ASIHttpRequest：外号“HTTP终结者”，功能极其强大，可惜早已停止更新

     AFNetworking：简单易用，提供了基本够用的常用功能

AFN基于NSURL，ASI基于CFHTTP，ASI的性能更好一些。


###常见相应状态码
200 OK 请求成功
400 Bad Request 请求语法错误，无法解析
404 Not Found 无法找到资源
500 Internal Server Error 服务器内部错误
