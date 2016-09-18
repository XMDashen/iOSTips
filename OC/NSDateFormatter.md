##NSDateFormatter

//获取到date时间
NSDate *date=datePicker.date;
    
//初始化时间格式
NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
  
//设置时间格式(中间间隔符号可任意给)
dateFormatter.dateFormat=@"yyyy-MM-dd";
dateFormatter.dateFormat=@"hh:mm";

yyyy:年
MM:月
dd:日
hh:时(12小时制)
HH:时(24小时制)
mm:分
ss:秒

//将时间NSDate以formatter的样式转化为字符串
NSString *dateString=[dateFormatter stringFromDate:date];

//将formatter样式的时间字符串转化为时间NSDate
NSDate *date=[dateFormatter dateFromString:dateString];