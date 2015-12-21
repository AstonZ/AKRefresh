# AKRefresh 自定义动画的下拉刷新组件

| 一千个应用有一千种下拉刷新


#### 支持高度自定义动画的下拉刷新，理论上支持所有你想要的动画效果
#### 支持用户使劲儿下拉的时候，刷新组件之上的扩展View，也是高度自定义

用法:
- 1. 新建一个UIView子类，遵循<AKRefreshAnimateHeaderViewProtocol>,
- 2. 实现StartAnimation，StopAnimation两个方法
- 3. 一句话调用，详情见Demo


初次提交，本Demo没有增加很多特效动画，后期会自行补充
欢迎Clone，增加你想要的交互效果吧！



 效果如下: 
 
  ![image](https://github.com/AstonZ/AKRefresh/blob/master/Resources/AKRefreshDemo.gif)
  
  
  TOTO: 
  1. 目前版本需要在Scroll所在的Controller dealloc的时候 取消监听，还没找到解决办法
  2. 协议里面有一个alloc方法，是因为不写这个编译不能通过，求大神指教如何传入Class参数的时候指定为UIView的子类呢？
  
  MIT
