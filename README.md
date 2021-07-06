# HYFCornerRadius
针对View分别裁剪不同值的圆角，简单易用

## 使用方法
1. 把本仓库的两个类文件引入项目
2. 在需要设置不同圆角的地方引入`#import "UIView+HYDiffRadius.h"` 
3. 使用示例：
```
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    mainView.backgroundColor = [UIColor greenColor];
    mainView.topleftValue = 20;
    mainView.toprightValue = 10;
    mainView.bottomleftValue = 5;
    mainView.bottomrightValue = 30;
    [mainView drawMyRect];
    [self.view addSubview:mainView];
```
ps:整体思路参照[这里](https://github.com/MrGCY/AnyCornerRadius),主要做了一些优化，原文直接在View上进行设置，所有想使用的View都要继承特定view,个人觉得使用不太方便，所以创建了一个分类，通过runtime添加了分类属性，再进行裁剪

## TODO
本demo没有对border进行处理，我们的项目中没有用到这里就不再赘述了，需要的同学可以参照该demo进行自定义，原理差不多
