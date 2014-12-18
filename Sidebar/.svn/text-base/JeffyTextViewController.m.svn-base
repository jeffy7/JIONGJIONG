//
//  JeffyTextViewController.m
//  Program
//
//  Created by lanou on 13-12-2.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import "JeffyTextViewController.h"
#import "JeffyTextCell.h"
#import "JeffyHumorousColsction.h"
#import "Humorous.h"
#import "UMSocial.h"
#import "TopView.h"
#import "WebAddress.h"
#import "FootLoadView.h"
@interface JeffyTextViewController ()

@end

static int page = 1;
@implementation JeffyTextViewController


-(void)dealloc
{
    [_colection cancelResquest];
    [_scroll release];
    [_allHumorous release];
    [_topRefresh release];
    [_colection release];
    [_footLoad release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建下拉刷新栏
    if ([[UIScreen mainScreen] bounds].size.height == 480.0) {
        _topRefresh = [[topRefreshView alloc]initWithFrame:CGRectMake(0, -self.view.bounds.size.height/6.0-20, self.view.bounds.size.width, self.view.bounds.size.height/6.0)];
    }else{
        _topRefresh = [[topRefreshView alloc]initWithFrame:CGRectMake(0, -self.view.bounds.size.height/6.0, self.view.bounds.size.width, self.view.bounds.size.height/6.0)];
    }
    [self.tableView addSubview:_topRefresh];
    
    
    //创建下拉加载栏
    _footLoad = [[FootLoadView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 30)];
    _footLoad.hidden = YES;
    [self.view addSubview:_footLoad];
    
    
    // Custom initialization
    self.allHumorous = [NSMutableArray array];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.395 green:0.846 blue:0.128 alpha:0.500];
    }else
    {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.395 green:0.846 blue:0.128 alpha:0.770];
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"more_three_line"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(backSiderbarPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];

    
    self.navigationItem.title = @"囧文囧话";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:
                                   [UIImage imageNamed:@"main_background.png"]]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"night_channel_undo_bar.jpg"] forBarMetrics:UIBarMetricsDefault];
    
   
    [self dragRefresh];
    
}

#pragma mark -------------
#pragma mark  实现数据回传的代理方法
- (void)requestDataSuccessful:(JeffyHumorousColsction *)humConnection
{
    //humConnection.receiveData  即为接收的收据  进行解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:humConnection.receiveData options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dic objectForKey:@"items"];
    
    //找到三十条  便利   取出其笑话   创建类
    for (NSDictionary *dic in array) {
        Humorous *humor = [[Humorous alloc] init];
        humor.humorous = [dic objectForKey:@"content"];
        
        if (![[dic objectForKey:@"user"]  respondsToSelector:@selector(objectForKey:)]) {
            humor.usreName = @"囧囧游客";
        }else{
            humor.usreName = [[dic objectForKey:@"user"] objectForKey:@"login"];
        }
    
        NSString *str = [dic objectForKey:@"image"];
        //过滤掉有图片的
        if (![str respondsToSelector:@selector(length)]) {
            [self.allHumorous addObject:humor];
        }
        [humor release];

    }

    [UIView animateWithDuration:1 animations:^{
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            
            self.tableView.contentInset = UIEdgeInsetsMake(44, 0, _footLoad.bounds.size.height+30, 0);
            _footLoad.hidden = YES;
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0,_footLoad.bounds.size.height , 0);
            _footLoad.hidden = YES;
        }
        
    }completion:^(BOOL finished) {
        self.topRefresh.topfresh2.hidden = YES;
        [self.topRefresh.topfresh stopAnimating];
    }];

    _fresh = NO;
    [self.tableView reloadData];
}

- (void)didShareButtonWith:(UIButton *)sender showTextLabel:(NSString *)text showImage:(UIImage *)image
{
    [UMSocialSnsService presentSnsIconSheetView:self.view.window.rootViewController
                                         appKey:@"5299908256240b573b0996dd"
                                      shareText:[text stringByAppendingString:@"----来自囧囧"]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,nil]
                                       delegate:nil];
}
#pragma mark -----------------------------
#pragma mark 检测下拉状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //开始刷新
    if (self.tableView.contentOffset.y <= -_topRefresh.bounds.size.height) {
        //下拉刷新
        [self dragRefresh];
    }
 
}
#pragma mark 检测下拉状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    //self.tableView.contentOffset.y   就是屏幕顶点离scrollview可见的距离
    if (self.tableView.contentOffset.y > self.tableView.contentSize.height - self.view.bounds.size.height && !_fresh ) {
        _footLoad.hidden = NO;
        _fresh = YES;

        [self performSelector:@selector(dragLoad) withObject:nil afterDelay:1];

    }
    _footLoad.center = CGPointMake(_footLoad.center.x, scrollView.contentSize.height+_footLoad.bounds.size.height/2);

}
#pragma mark 下拉刷新
- (void)dragRefresh
{
    [_colection cancelResquest];
    self.colection = [[JeffyHumorousColsction alloc] init];
    [_colection release];
    _colection.delegate = self;
    _fresh = YES;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.tableView.contentInset = UIEdgeInsetsMake(_topRefresh.bounds.size.height+44, 0, _footLoad.bounds.size.height, 0);
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(_topRefresh.bounds.size.height, 0, _footLoad.bounds.size.height, 0);
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentOffset = CGPointMake(0, -_topRefresh.bounds.size.height+44);
    }];
    //下拉刷新
    self.topRefresh.topfresh2.hidden = NO;
    [self.topRefresh.topfresh startAnimating];
    [self performSelector:@selector(requestAgain) withObject:nil afterDelay:1];
}
- (void)requestAgain
{

    [self.allHumorous removeAllObjects];
    [self.colection dataGetWithUrl:jeffyAddress(page)];
}


#pragma mark 上拉加载
- (void)dragLoad
{
    _fresh = YES;

    //开辟空间  停留
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, _footLoad.bounds.size.height+30, 0);
    
    //回去与不回去的区别
//    [UIView animateWithDuration:1 animations:^{
//        self.tableView.contentOffset = CGPointMake(0, self.tableView.contentSize.height -
//                                                   self.view.bounds.size.height+30);
//    }];
    [_colection dataGetWithUrl:jeffyAddress(page+1)];
    page++;

    
    
}

- (void)backSiderbarPage{
    
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
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Humorous *hum = [self.allHumorous objectAtIndex:indexPath.row];
    if (hum.humImage == nil) {
        return [JeffyTextCell calcultorHeightwith:hum.humorous] + 60;
    }else {
        return [JeffyTextCell calcultorHeightwith:hum.humorous] + 160;

    }


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allHumorous.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    JeffyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[JeffyTextCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //防止下拉刷新的时候数据没有回来,故意往上刷 ,导致cell没有值,形成越界,
    if (self.allHumorous.count > indexPath.row) {
        Humorous *hum = [self.allHumorous objectAtIndex:indexPath.row];
        cell.showView.image = [UIImage imageNamed:@"icon_my_enable.png"];
        cell.userNameLabel.text = hum.usreName;
        cell.showTextLabel.text = hum.humorous;
        cell.showView.image = [UIImage imageNamed:@"120"];
        cell.showTextLabel.numberOfLines = 0;
        [cell.showTextLabel sizeToFit];
        cell.delagate = self;
        cell.backgroundColor = [UIColor clearColor];
        //由于重用会造成改变   所以每次需要改回来
        //强制装换回来
        CGRect temp = cell.showTextLabel.frame;
        temp.size.width = 300.0;
        cell.showTextLabel.frame = temp;
        
        //修改后面显示图片的frem  让其影藏
        cell.picImage.frame = CGRectMake(cell.picImage.frame.origin.x, 60+cell.showTextLabel.frame.size.height, 100, 100);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当点击主界面的时候，侧边栏消失
    if (self.scroll.contentOffset.x < self.slidebarWidth) {
        [UIView animateWithDuration:0.35 animations:^{
            self.scroll.contentOffset = CGPointMake(self.slidebarWidth, 0);
        }];
        return;
    }

}
- (void)didReceiveMemoryWarning
{
    

    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.tableView window]) {
        self.footLoad = nil;
        self.topRefresh = nil;
        self.allHumorous = nil;
        self.tableView = nil;
    }
    // Dispose of any resources that can be recreated.
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
