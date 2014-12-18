//
//  DZJSetViewController.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-15.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "DZJSetViewController.h"
#import "UserInfo.h"
#import "WebAddress.h"
@interface DZJSetViewController ()

@end


@implementation DZJSetViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_imageItems release];
    [_itermArray  release];
    [_sheetViewDelete release];
    [_sheetViewResigh release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.000 green:0.378 blue:0.337 alpha:0.500];
    }else
    {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.378 blue:0.337    alpha:0.770];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"more_three_line"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    self.imageItems = [self hlImageItems];
    
    self.itermArray = @[@"夜间模式",@"清除缓存",@"退出当前账号"];
    _sheetViewResigh = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出当前账号" otherButtonTitles:nil, nil];
    _sheetViewDelete = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除数据缓存" otherButtonTitles:nil, nil];
}

- (NSArray *)hlImageItems
{
    UIImage *image1 = [UIImage imageNamed:@"moon"];
    UIImage *image2 = [UIImage imageNamed:@"trash"];
    return @[image1, image2];
}

-(void)back
{
#pragma mark 左导航键
    if (_scroll.contentOffset.x) {
            [UIView animateWithDuration:0.35 animations:^{
                _scroll.contentOffset = CGPointMake(0, _scroll.contentOffset.y);
            } completion:^(BOOL finished) {
                
            }];
            
        }else
        {
            [UIView animateWithDuration:0.35 animations:^{
                _scroll.contentOffset = CGPointMake(self.slidebarWidth, _scroll.contentOffset.y);
            } completion:^(BOOL finished) {
                
            }];
            
        }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.backgroundColor = [UIColor clearColor];
    }
      if (indexPath.section == 0) {
          UISwitch *cellSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width/3, cell.bounds.size.height)];
          [cellSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventTouchUpInside];
          cell.accessoryView = cellSwitch;
         [cellSwitch setOn:[@"ON" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"daySwitch"]]];
          [cellSwitch release];
          cell.backgroundColor = [UIColor colorWithWhite:0.706 alpha:0.720];
          cell.textLabel.backgroundColor = [UIColor clearColor];
          cell.imageView.image = [_imageItems objectAtIndex:0];
    }
    if (indexPath.section == 1) {
         cell.backgroundColor = [UIColor colorWithWhite:0.706 alpha:0.720];
       cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.imageView.image = [_imageItems objectAtIndex:1];
    }
    
    if (indexPath.section == 2) {

        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.830];
    }
    
    cell.textLabel.text = self.itermArray[indexPath.section];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
             [_sheetViewDelete showInView:self.view.window];
            break;
        case 2:
            [_sheetViewResigh showInView:self.view.window];
            break;
        default:
            break;
    }
    //当点击主界面的时候，侧边栏消失
    if (self.scroll.contentOffset.x < self.slidebarWidth) {
        [UIView animateWithDuration:0.35 animations:^{
            self.scroll.contentOffset = CGPointMake(self.slidebarWidth, 0);
        }];
        return;
    }
}
- (void)switchChange:(UISwitch*)cellswitch
{
    NSString *str;
    if (cellswitch.isOn) {
        str = @"ON";
    }else
    {
        str = @"OFF";
    }
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"daySwitch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeDayAndNight" object:nil userInfo:nil];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (!buttonIndex) {
        if (actionSheet==_sheetViewResigh) {
            [self resignCurrentAccount];
        }else
        {
            [self deleteCache];
        } 
    }
}

- (void)deleteCache
{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:Cachespath(@"DZJPhotoes/") error:nil];
    
}
- (void)resignCurrentAccount
{
    UserInfo *user = [UserInfo userShare];
    user.userName = nil;
    user.passWord = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userPassWord"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserInfo" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}

@end
