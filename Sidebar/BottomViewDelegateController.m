//
//  BottomViewDelegateController.m
//  Sidebar
//
//  Created by dongzhejia on 13-11-29.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//
#import "TopView.h"
#import "BottomView.h"
#import "BottomViewDelegateController.h"
#import "JeffyTextViewController.h"
#import "JeffyCollectionViewController.h"
#import "JeffyPictureViewController.h"
#import "OriginalCommunityViewController.h"
#import "DZJSetViewController.h"
#import "landingViewController.h"
#import "TopViewDelegateController.h"
@interface BottomViewDelegateController ()

@end



@implementation BottomViewDelegateController

- (void)dealloc
{
    [_iterms release];
    [_scroll release];
    [_setMenuNavigation release];
    [_picNavition release];
    [_wordNavition release];
    [_originalNavigation release];
    [_collectNavigation release];
    [_topView release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.iterms = @[@"今日囧闻",@"图文并茂",@"囧文囧话",@"原创社区",@"我的收藏",@"设置"];
        BottomView *bottomView = [[BottomView alloc]initWithFrame:_topView.bounds style:UITableViewStylePlain];
        self.view = bottomView;
        [bottomView release];
        bottomView.delegate = self;
        bottomView.dataSource = self;
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"] autorelease];
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
//        imageView.image = [UIImage imageNamed:@"settingcell_bg_bottom@2x"];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        cell.selectedBackgroundView = imageView;
//        [imageView release];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"video_line"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"sidebar_nav_photo"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"sidebar_nav_news"];
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"sidebar_nav_focus"];
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"star_line"];
            break;
        case 5:
            cell.imageView.image = [UIImage imageNamed:@"config_line"];
            break;
            
        default:
            break;
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.text = self.iterms[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UIScreen mainScreen].bounds.size.height <500) {
        return 50;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      switch (indexPath.row) {
        case 0:{
            [self backToMainView:tableView];
            break;
        }
        case 1:{
            //显示图文并茂
            [self pushTextAndPicturePage:tableView];
            
            break;
        }
        case 2:{
            
            [self pushXiaohuaPage:tableView];
            break;
        }
        case 3:{
            
            [self OriginalCommunity:tableView];
            break;
        }
        case 4:{
            
            [self pushCollectionPage:tableView];
            break;
        }
              
          case 5:{
              
              [self pushSetPage:tableView];
              break;
          }

            
        default:
            break;
    }
    CATransition *transitionSecond = [CATransition animation];
    transitionSecond.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transitionSecond.type = @"rippleEffect";
    transitionSecond.duration = 2;
    transitionSecond.startProgress = 0.4;
    [[tableView cellForRowAtIndexPath:indexPath].layer addAnimation:transitionSecond forKey:@"animation2"];
}

#pragma mark 推出设置界面
- (void)pushSetPage:(UITableView *)tableView
{
    UIView *oldView = self.changeNavition.view;
    if (!_setMenuNavigation) {
        DZJSetViewController *setController = [[DZJSetViewController alloc]initWithStyle:UITableViewStyleGrouped];
        setController.scroll = self.scroll;
        setController.slidebarWidth = _slidebarWidth;
        _setMenuNavigation = [[UINavigationController alloc] initWithRootViewController:setController];
        [setController release];
    }
    self.changeNavition = _setMenuNavigation;
    self.changeNavition.view.frame = self.topView.bounds;
    
    [UITableView animateWithDuration:0.5 animations:^{
        self.scroll.contentOffset = CGPointMake(tableView.bounds.size.width, self.scroll.contentOffset.y);
        
    } completion:^(BOOL finished) {
         if (self.changeNavition.view != oldView) {
        [self.topView addSubview:self.changeNavition.view];
        [oldView removeFromSuperview];
         }
    }];

}

#pragma mark 返回主界面
- (void)backToMainView:(UITableView *)tableView
{
    [self.changeNavition.view removeFromSuperview];
    self.changeNavition = nil;
    [UITableView animateWithDuration:0.5 animations:^{
           self.scroll.contentOffset = CGPointMake(tableView.bounds.size.width, self.scroll.contentOffset.y);
           } completion:^(BOOL finished) {
    }];

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BottomView *bottom = (BottomView *)self.view;
    if (bottom.contentOffset.y<-44) {
        bottom.userImageView.transform = CGAffineTransformMakeScale(1 - bottom.contentOffset.y*0.002, 1 - bottom.contentOffset.y*0.002);
        bottom.tableHeaderView.transform = CGAffineTransformMakeScale(1 - bottom.contentOffset.y*0.002, 1 - bottom.contentOffset.y*0.002);
    }

}

#pragma mark 原创社区
-(void) OriginalCommunity:(UITableView *)tableView
{
    UIView *oldView = self.changeNavition.view;
    if (!_originalNavigation) {
        OriginalCommunityViewController *originalController = [[OriginalCommunityViewController alloc]initWithStyle:UITableViewStylePlain];
        originalController.scroll = self.scroll;
        originalController.slidebarWidth = _slidebarWidth;
        _originalNavigation = [[UINavigationController alloc] initWithRootViewController:originalController];
        [originalController release];
    }
    self.changeNavition = _originalNavigation;
    self.changeNavition.view.frame = self.topView.bounds;
    
    [UITableView animateWithDuration:0.5 animations:^{
        self.scroll.contentOffset = CGPointMake(tableView.bounds.size.width, self.scroll.contentOffset.y);
        
    } completion:^(BOOL finished) {
         if (self.changeNavition.view != oldView) {
        [self.topView addSubview:self.changeNavition.view];
        [oldView removeFromSuperview];
         }
    }];
}


#pragma mark 图文并茂
- (void)pushTextAndPicturePage:(UITableView *)tableView
{
    
    
    UIView *oldView = self.changeNavition.view;
    if (!_picNavition) {
        JeffyPictureViewController *pictureVC = [[JeffyPictureViewController alloc] init];
        pictureVC.scroll = self.scroll;
        pictureVC.slidebarWidth = _slidebarWidth;
       _picNavition = [[UINavigationController alloc] initWithRootViewController:pictureVC];
        [pictureVC release];
    }
    self.changeNavition = _picNavition;
    self.changeNavition.view.frame = self.topView.bounds;
    
    [UITableView animateWithDuration:0.5 animations:^{
        self.scroll.contentOffset = CGPointMake(tableView.bounds.size.width, self.scroll.contentOffset.y);
        
    } completion:^(BOOL finished) {
         if (self.changeNavition.view != oldView) {
        [self.topView addSubview:self.changeNavition.view];
        [oldView removeFromSuperview];
         }
    }];
}



#pragma mark 收藏
- (void)pushCollectionPage:(UITableView *)tableView
{
    UIView *oldView = self.changeNavition.view;

        JeffyCollectionViewController *collectVC = [[JeffyCollectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
        collectVC.scroll = self.scroll;
        collectVC.slidebarWidth = _slidebarWidth;
        self.collectNavigation = [[UINavigationController alloc] initWithRootViewController:collectVC];
        [_collectNavigation release];
        [collectVC release];
    
    self.changeNavition = _collectNavigation;
    self.changeNavition.view.frame = self.topView.bounds;
    [UITableView animateWithDuration:0.5 animations:^{
        self.scroll.contentOffset = CGPointMake(tableView.bounds.size.width, self.scroll.contentOffset.y);
    } completion:^(BOOL finished) {
        [self.topView addSubview:self.changeNavition.view];
        [oldView removeFromSuperview];
    }];
    
}

- (void)pushXiaohuaPage:(UITableView *)tableView{
    
    UIView *oldView = self.changeNavition.view;
    if (!_wordNavition) {
        JeffyTextViewController *textVC = [[JeffyTextViewController alloc] init];
        textVC.scroll = self.scroll;
        textVC.slidebarWidth = _slidebarWidth;

        _wordNavition = [[UINavigationController alloc] initWithRootViewController:textVC];
        [textVC release];
    }
    self.changeNavition = _wordNavition;
    self.changeNavition.view.frame = self.topView.bounds;

    [UITableView animateWithDuration:0.5 animations:^{
        self.scroll.contentOffset = CGPointMake(tableView.bounds.size.width, self.scroll.contentOffset.y);
    } completion:^(BOOL finished) {
        if (self.changeNavition.view != oldView) {
            [self.topView addSubview:self.changeNavition.view];
            [oldView removeFromSuperview];
        }
    }];
   
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.view window]) {
        self.view = nil;
        self.iterms = nil;
        self.scroll = nil;
        self.topView = nil;
    }

}

@end
