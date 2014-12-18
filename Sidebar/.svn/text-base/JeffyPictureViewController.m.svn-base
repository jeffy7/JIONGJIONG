//
//  JeffyPictureViewController.m
//  JIONGJIONG
//
//  Created by lanou on 13-12-4.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "JeffyPictureViewController.h"
#import "JeffyTextCell.h"
#import "PictureAndText.h"
#import "UMSocial.h"
#import "Collection.h"
#import "UIImageView+ImageWithUrl.h"
#import "WebAddress.h"
#import "GDataXMLNode.h"
@interface JeffyPictureViewController ()

@end
static int page = 1;
@implementation JeffyPictureViewController
-(void)dealloc
{
    [_scroll release];
    [_allPictureTextArray release];
    [_topRefresh release];
    [_footLoad release];
    
    [_colection cancelResquest];
    [_colection release];

    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allPictureTextArray = [NSMutableArray array];
    
    
    //创建下拉刷新栏
    if([[UIScreen mainScreen] bounds].size.height == 480.0) {
        _topRefresh = [[topRefreshView alloc]initWithFrame:CGRectMake(0, -self.view.bounds.size.height/6.0-20, self.view.bounds.size.width, self.view.bounds.size.height/6.0)];
    }else{
        _topRefresh = [[topRefreshView alloc]initWithFrame:CGRectMake(0, -self.view.bounds.size.height/6.0, self.view.bounds.size.width, self.view.bounds.size.height/6.0)];
    }
    [self.tableView addSubview:_topRefresh];
    
    //创建下拉加载栏
    _footLoad = [[FootLoadView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 30)];
    _footLoad.hidden = YES;
    [self.view addSubview:_footLoad];
    
    
    
    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.000 green:0.753 blue:0.082 alpha:0.500];
    }else
    {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.753 blue:0.082  alpha:0.770];
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"more_three_line"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(backSiderbarPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    self.navigationItem.title = @"图文并茂";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:
                                   [UIImage imageNamed:@"main_background.png"]]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"night_channel_undo_bar.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    
      [self dragRefresh];
    
}

- (void)requestDataSuccessful:(JeffyHumorousColsction *)humConnection
{
    GDataXMLDocument *document = [[[GDataXMLDocument alloc] initWithData:humConnection.receiveData options:0 error:nil] autorelease];
    
    GDataXMLElement *root = [document rootElement];
    
    //找根节点
    NSArray *jokes = [root nodesForXPath:@"//joke" error:nil];
    
    
        for (GDataXMLElement *joke in jokes) {
            
            NSArray *names = [joke elementsForName:@"name"];
            GDataXMLElement *name = [names objectAtIndex:0];
            NSString *nameValue = [name stringValue];
            
            
            NSArray *texts = [joke elementsForName:@"text"];
            GDataXMLElement *text = [texts objectAtIndex:0];
            NSString *textValue = [text stringValue];
            
            
            NSArray *imgurls = [joke elementsForName:@"imgurl"];
            GDataXMLElement *imgurl = [imgurls objectAtIndex:0];
            NSString *imgurlValue = [imgurl stringValue];
            
            
            PictureAndText *pic = [[PictureAndText alloc] init];
            pic.picUrl = imgurlValue;
            pic.title = textValue;
            pic.userName = nameValue;
            
            
            [self.allPictureTextArray addObject:pic];
            [pic release];

            
        }

    
    //动画效果回车
    [UIView animateWithDuration:1 animations:^{
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            self.tableView.contentInset = UIEdgeInsetsMake(44, 0, _footLoad.bounds.size.height+30, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }completion:^(BOOL finished) {
        self.topRefresh.topfresh2.hidden = YES;
        [self.topRefresh.topfresh stopAnimating];
    }];
    
    
    [self.tableView reloadData];
    _fresh = NO;
    _footLoad.hidden = YES;
    //上拉效果小时
    
    
}
- (void)backSiderbarPage
{
    
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
#pragma mark -----------------------------
#pragma mark 第三方分享
- (void)didShareButtonWith:(UIButton *)sender showTextLabel:(NSString *)text showImage:(UIImage *)image
{
    [UMSocialSnsService presentSnsIconSheetView:self.view.window.rootViewController
                                         appKey:@"5299908256240b573b0996dd"
                                      shareText:[text stringByAppendingString:@"----来自囧囧"]
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,nil]
                                       delegate:nil];
    
}
#pragma mark -----------------------------
#pragma mark 下拉刷新
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
        [self performSelector:@selector(dragLoad) withObject:nil afterDelay:0.5];
        
    }
    _footLoad.center = CGPointMake(_footLoad.center.x, scrollView.contentSize.height+_footLoad.bounds.size.height/2);
    
}
- (void)dragRefresh
{
    [_colection cancelResquest];
    self.colection = [[JeffyHumorousColsction alloc] init];
    [_colection release];
    _colection.delegate = self;
    _fresh = YES;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.tableView.contentInset = UIEdgeInsetsMake(_topRefresh.bounds.size.height+44, 0, _footLoad.bounds.size.height+30, 0);
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(_topRefresh.bounds.size.height, 0, 0, 0);
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentOffset = CGPointMake(0, -_topRefresh.bounds.size.height);
    }];
    //下拉刷新
    self.topRefresh.topfresh2.hidden = NO;
    [self.topRefresh.topfresh startAnimating];
    [self performSelector:@selector(requestAgain) withObject:nil afterDelay:1];
}
- (void)requestAgain
{
    //显示时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    [self.allPictureTextArray removeAllObjects];
    [_colection dataGetWithUrl:PictureAndTextWeb(dateString,page)];
    [formatter release];

  
}
#pragma mark -----------------------------
#pragma mark 上拉加载
- (void)dragLoad
{
    _fresh = YES;
    
    //开辟空间  停留
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, _footLoad.bounds.size.height+30, 0);
    //显示时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    [_colection dataGetWithUrl:PictureAndTextWeb(dateString,page+1)];
    page++;
    [formatter release];

    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.allPictureTextArray.count;
    ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureAndText *picTex = [self.allPictureTextArray objectAtIndex:indexPath.row];

    return [JeffyTextCell calcultorHeightwith:picTex.title] + 170;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    JeffyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[JeffyTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.allPictureTextArray.count > indexPath.row) {

    PictureAndText *picWithText = [self.allPictureTextArray objectAtIndex:indexPath.row];
    cell.userNameLabel.text = picWithText.userName;
    cell.showView.image = [UIImage imageNamed:@"120"];
    cell.showTextLabel.text = picWithText.title;
    cell.showTextLabel.numberOfLines = 0;
    [cell.showTextLabel sizeToFit];
    cell.delagate = self;
    cell.backgroundColor = [UIColor clearColor];
    //由于重用会造成改变   所以每次需要改回来
    //强制装换回来
    CGRect temp = cell.showTextLabel.frame;
    temp.size.width = 300.0;
    cell.showTextLabel.frame = temp;

    //修改后面显示图片的frem  让其显示
    cell.picImage.frame = CGRectMake(cell.picImage.frame.origin.x, 60+cell.showTextLabel.frame.size.height, 100, 100);
    
    [cell.picImage loadImageWithUrlSting:picWithText.picUrl];
    // Configure the cell...
    }
    return cell;
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
        self.allPictureTextArray = nil;
        self.topRefresh = nil;
        self.footLoad = nil;
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
