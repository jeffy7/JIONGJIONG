//
//  MainViewController.h
//  Sidebar
//
//  Created by dongzhejia on 13-11-29.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<QuartzCore/QuartzCore.h>

@class TopView;
@class BottomView;
@class TopViewDelegateController;
@class BottomViewDelegateController;
@class MyImageScrollView;
@interface SidebarViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,retain) UIScrollView * BottomScroll;//底层滚动窗口
@property(nonatomic,retain) UIView *dayAndNightView;
@property(nonatomic,retain) TopView *topView;//主窗口
@property(nonatomic,retain) BottomView *bottom;//边栏
//主界面导航
@property(nonatomic,retain) UINavigationController *topNavition;
//两个视窗的代理控制器
@property(nonatomic,retain) TopViewDelegateController *topDelegate;
//侧边栏导航
@property(nonatomic,retain) UINavigationController *bottomNavition;
@property(nonatomic,retain)  BottomViewDelegateController *bottomDelegate;
@property(nonatomic,assign) float slidebarWidth;
@end
