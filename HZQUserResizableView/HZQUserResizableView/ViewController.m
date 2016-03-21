//
//  ViewController.m
//  HZQUserResizableView
//
//  Created by 1 on 16/3/21.
//  Copyright © 2016年 HZQ. All rights reserved.
//

#import "ViewController.h"
#import "HZQUserResizableView.h"
#import "UIColor+HexString.h"

#define BackgroundColor [UIColor colorwithHexString:@"f7f7f7"]

@interface ViewController () <HZQUserResizableViewDelegate> {
    UIScrollView *_topScrollView;
    UILabel *_label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = BackgroundColor;
    
    [self setupTopView];
    [self setupResizableView];
}

/**
 *  创建顶部一个滑动scrollView
 */
- (void)setupTopView {
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/2 + 20)];
    _topScrollView.autoresizesSubviews = YES;
    [self.view addSubview:_topScrollView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _label.text = @"    ①自那以后，我亲眼看见一个州接一个州地消灭了它们所有的狼。我看见过许多刚刚失去了狼的山的样子，看见南面的山坡由于新出现的弯弯曲曲的鹿径而变得皱皱巴巴。我看见所有可吃的灌木和树苗都被吃掉，先是衰弱不振，然后死去。这样一座山看起来就好像什么人给了上帝一把大剪刀，叫他成天只修剪树干，不做其他事情。结果，那原来渴望着食物的鹿群的饿殍，和死去的艾蒿丛一起变成了白色，或者就在高于鹿头的部分还留有叶子的刺柏下腐烂掉。——这些鹿是因其数目太多而死去的。\n    ②我现在想，正像当初鹿群在对狼的极度恐惧中生活着那样，那一座山将要在对它的鹿的极度恐惧中生活。而且，大概就比较充分的理由来说，当一只被狼拖去的公鹿在两年或三年就可得到补替时，一片被太多的鹿拖疲惫了的草原，可能在几十年里都得不到复原。\n    ③牛群也是如此，清除了其牧场上的狼的牧牛人并未意识到，他取代了狼用以调整牛群数目以适应其牧场的工作。他不知道像山那样来思考。正因为如此，我们才有了尘暴，河水把未来冲刷到大海去。\n    ④我们大家都在为安全、繁荣、舒适、长寿和平静而奋斗着。鹿用轻快的四肢奋斗着，牧牛人用套圈和毒药奋斗着，政治家用笔，而我们大家则用机器、选票和美金。所有这一切带来的都是同一种东西：我们这一时代的和平。用这一点去衡量成就，全部是很好的，而且大概也是客观的思考所不可缺少的，不过，太多的安全似乎产生了____的危险。这个世界的启示在荒野。——这也是狼的嗥叫中____的内涵，它已被群山所理解，却还极少为人类所____。（节选自《像山那样思考》）";
    _label.numberOfLines = 0;
    _label.backgroundColor = BackgroundColor;
    [_topScrollView addSubview:_label];
    
    CGSize maxSize = CGSizeMake(ScreenWidth, MAXFLOAT);
    CGFloat textHeight = [_label.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    NSLog(@"textHeight: %f", textHeight);
    _topScrollView.contentSize = CGSizeMake(0, textHeight + 40);

}

/**
 *  集成可调整的ResizableView
 */
- (void)setupResizableView {
    // 1.初始化UserResizableView
    CGRect gripFrame = CGRectMake(0, ScreenHeight/2, ScreenWidth, ScreenHeight/2);
    HZQUserResizableView *userResizableView = [[HZQUserResizableView alloc] initWithFrame:gripFrame];
    userResizableView.delegate = self;
    /** 距离顶部的间距 */
    userResizableView.topDistance = 150.0f;
    /** 距离底部的间距 */
    CGSize maxSize = CGSizeMake(ScreenWidth, MAXFLOAT);
    CGFloat textHeight = [_label.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    userResizableView.bottomDistance = ScreenHeight - textHeight > 0 ? 50.0f : 50.0f + ScreenHeight - textHeight;
    
    // 2.文字dragBtn（最底层，只是用来显示文字而已）
    UIButton *dragBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 24)];
    [dragBtn setImage:[UIImage imageNamed:@"dragBtn"] forState:0];
    [userResizableView addSubview:dragBtn];
    
    // 3.底层容器contentView（能够被拖拽）
    UIView *contentView = [[UIView alloc] initWithFrame:gripFrame];
    [contentView setBackgroundColor:[UIColor clearColor]];
    userResizableView.contentView = contentView;
    
    // 4.滑动ScrollView和3个内容View(内容可替换成tableView等等)
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight/2 - 20)];
    scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor blackColor];
    // 内容根据容器View自适应
    scrollView.autoresizesSubviews = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:scrollView];
    
    // 4.1创建几个可滑动的内容
    for (int i = 0; i < 3; i++) {
        // 4.1.1View
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(scrollView.frame), 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
        // 内容根据容器scrollView自适应
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        view.backgroundColor = [UIColor colorwithHexString:@"f7f5f5"];

        // 4.1.2文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        [label setText:[NSString stringWithFormat:@"这是第%d题", i + 1]];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;

        [scrollView addSubview:view];
        [view addSubview:label];

    }
    
    [self.view addSubview:userResizableView];
}

/** 开始拖动的时候响应的代理方法 */
- (void)userResizableViewDidBeginEditing:(HZQUserResizableView *)userResizableView {
    NSLog(@"容器目前的高度: %f", CGRectGetHeight(userResizableView.frame));
    
    CGRect scrollFrame = _topScrollView.frame;
    scrollFrame.size.height = ScreenHeight - CGRectGetHeight(userResizableView.frame) + 20;
    _topScrollView.frame = scrollFrame;

}

/** 结束拖动的时候响应的代理方法 */
- (void)userResizableViewDidEndEditing:(HZQUserResizableView *)userResizableView {
    NSLog(@"容器拖动之后的高度: %f", CGRectGetHeight(userResizableView.frame));
}

@end
