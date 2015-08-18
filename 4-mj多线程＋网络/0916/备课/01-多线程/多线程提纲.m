一、进程和线程

二、线程的基本概念

三、多线程在iOS开发中的应用
1> 耗时操作在主线程（PPT）
2> 演示耗时操作卡住主线程的示例
* 说明监听按钮的方法是在主线程
* 点击按钮后开始执行耗时操作
* 执行耗时操作过程中，点击segmentControl，滚动textView
3> 耗时操作在子线程（PPT）

四、多线程的实现方案
1> 多种方案对比
2> 简单演示pthread，解决刚才阻塞UI的问题

五、NSThread
1> 利用NSThread解决阻塞UI的问题
2> 演示mainThread、currentThread方法、name属性、threadPriority优先级属性
3> 创建3条线程同时执行，看打印结果
4> 其他创建线程的方式
5> 线程的状态
* 出生 -> 运行 -> 睡眠 -> 死亡
* 演示exit、sleep方法
6> 线程的资源抢夺
7> 线程通信

六、GCD
1> 基本概念
2> 同步、异步、队列
3> 线程间通信
4> 常用函数
* once
* after
* group

七、单例模式
http://www.cnblogs.com/supercheng/archive/2012/11/26/singlemodal.html

八、NSOperation、NSOperationQueue
1> NSInvocationOperation
2> NSBlockOperation
3> NSOperationQueue
4> 自定义NSOperation