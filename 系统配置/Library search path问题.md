##Library search path问题

library search paths 路径带有空格，导致拆分成2个路径查询，出现ld: warning: directory not found for option错误

解决方法：将路径加上""双引号即可

![Snip20160813_3.png](./pic/Snip20160813_3.png)

![Snip20160813_4.png](./pic/Snip20160813_4.png)
