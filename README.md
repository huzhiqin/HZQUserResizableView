# HZQUserResizableView - 高仿猿题库做题界面


` *有劳大家的小手抖一抖，给颗小星星★★～！谢谢！^ —— ^`

` *封装好的ResizableView,绿色、安全！(以后有机会把富文本功能加上)谢谢大家的支持和反馈，如有任何问题请留言。`

` *QQ:276635035`


# 本DEMO截图

![](https://github.com/huzhiqin/HZQUserResizableView/blob/master/HZQUserResizableView/HZQUserResizableView/ImageCache/screenshot.gif)

# 猿题库截图

![](https://github.com/huzhiqin/HZQUserResizableView/blob/master/HZQUserResizableView/HZQUserResizableView/ImageCache/screenshot2.gif)

使用方法：
```oc 
/**
 *  创建ResizableView
 */
    // 1.初始化UserResizableView
    CGRect gripFrame = CGRectMake(0, ScreenHeight/2, ScreenWidth, ScreenHeight/2);

    HZQUserResizableView *userResizableView = [[HZQUserResizableView alloc] initWithFrame:gripFrame];

    userResizableView.delegate = self;

    /** 距离顶部的间距 */

    userResizableView.topDistance = 150.0f;

    /** 距离底部的间距 */

    userResizableView.bottomDistance = 60.0f;

    // 2.底层容器contentView（能够被拖拽）

    UIView *contentView = [[UIView alloc] initWithFrame:gripFrame];

    [contentView setBackgroundColor:[UIColor clearColor]];

    userResizableView.contentView = contentView;

    [self.view addSubview:userResizableView];

```
