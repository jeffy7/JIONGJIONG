//
//  OriginalCommunityViewController.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-5.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "OriginalCommunityViewController.h"
#import "DZjOriginalCell.h"
#import "KeyBoard.h"
#import "ShareMood.h"
#import "UploadViewController.h"
#import "landingViewController.h"
#import "UserInfo.h"
#import "UIImageView+ImageWithUrl.h"
#import "topRefreshView.h"
#import "WebAddress.h"
#import "FootLoadView.h"
@interface OriginalCommunityViewController ()
{
    float hight;
    BOOL refreshflag;
    BOOL myflag;
    NSMutableArray *allText;
    UIAlertView *alert;
    UIButton *button;
}
@end


static inline NSString * documentPath ()
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collect"];
    return document;
}

@implementation OriginalCommunityViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"myKeboard" object:nil];

    [alert release];
    [_topRefresh release];
    [_footLoad release];
    _upload.target = nil;
    _upload.rightIterm = nil;
    [_upload release];
    [_allShareMood release];
    [_allTextArray release];
    [_allVideoArray release];
    [_allcommentArray release];
    [_array release];
    
    [_colesion cancelResquest];
    [_allData cancelResquest];
    [_textData cancelResquest];
    [_colesion release];
    [_allData release];
    [_textData release];
    
    [_scroll release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //用户信息变更消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myKeboard) name:@"myKeboard" object:nil];
       

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor whiteColor];
    _currentLoad = 1;
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
        self.freshHeight = 0;
    }else
    {
        self.freshHeight = 44;
    }
    hight = 0;
    if ([UIScreen mainScreen].bounds.size.height<568) {
        hight = -12;
    }
    self.array = [NSMutableArray array];
    self.allShareMood = [NSMutableArray array];
    self.allTextArray = [NSMutableArray array];
    self.allVideoArray = [NSMutableArray array];
    self.allcommentArray = [NSMutableArray array];

    //创建下拉刷新栏
    _topRefresh = [[topRefreshView alloc]initWithFrame:CGRectMake(0,-self.tableView.bounds.size.height/6+hight, self.view.bounds.size.width,self.tableView.bounds.size.height/6)];
    [self.tableView addSubview:_topRefresh];
    //创建下拉加载栏
    _footLoad = [[FootLoadView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 30)];
    _footLoad.hidden = YES;
    [self.tableView addSubview:_footLoad];
    //提示栏
    alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您还未登陆,是否登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.navigationItem.title = @"原创社区";
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.317 green:0.578 blue:1.000 alpha:0.500];
    }else
    {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.317 green:0.578 blue:1.000 alpha:1];
    }
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"more_three_line"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(backSiderbarPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"shar_line"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:self action:@selector(origalAlert:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.bounds = CGRectMake(0, 0, 44, 44);
    button.tag = 10;
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.showsTouchWhenHighlighted = YES;
    [button setImage:[UIImage imageNamed:@"recommend_login_icon"] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(origalAlert:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar2 = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.tag = 20;
    self.navigationItem.rightBarButtonItems = @[rightBar2,rightBar];
    [rightBar2 release];
    [rightBar release];
    
    
    _upload = [[UploadViewController alloc]init];
    _upload.target = self;
    _upload.rightIterm = rightBar;
    _upload.action = @selector(dragRefresh);
    [self dragRefresh];
    
}

#pragma mark 登录检测
- (void)origalAlert:(UIBarButtonItem  *)senter
{
    UserInfo *user = [UserInfo userShare];
    if (user.userName.length<6&&user.passWord.length<6) {
        alert.tag = senter.tag;
        [alert show];
        return;
    }
    
    if (senter.tag == 10) {
        [self myKeboard];
    }else
    {
        senter.enabled = NO;
       [self mycontent];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        landingViewController *landing = [[landingViewController alloc]init];
        if (alertView.tag == 10) {
            landing.keyBoard = YES;
        }
        #pragma mark 登陆视图
        [self.navigationController pushViewController:landing animated:YES];
        [landing release];
    }
}


- (void)mycontent{
    
    refreshflag = YES;
    myflag = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(_freshHeight+_topRefresh.bounds.size.height-hight, 0, _footLoad.bounds.size.height+20, 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.contentOffset = CGPointMake(0, -(_freshHeight+_topRefresh.bounds.size.height));
    }];
    self.topRefresh.topfresh2.hidden = NO;
    [self.topRefresh.topfresh startAnimating];
    [_array removeAllObjects];
    [_allShareMood removeAllObjects];
    [_allTextArray removeAllObjects];
    [_allVideoArray removeAllObjects];
    [_allcommentArray removeAllObjects];
    UserInfo *user = [UserInfo userShare];
    NSString *urlString = [NSString stringWithFormat:@"http://124.205.147.26/student/class_11/team_three/resource/AllPHP/hlSelectUserShareFromName.php?userName=\'%@\'",user.userName];
    [self.allData dataGetWithUrl:urlString];
}

- (void)myKeboard
{
    
    
    [self.navigationController.view addSubview:_upload.view];
    [_upload commentsStartAnimation];
}

#pragma mark 下拉刷新
- (void)dragRefresh
{   refreshflag = YES;
    myflag = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(_freshHeight+_topRefresh.bounds.size.height-hight, 0, _footLoad.bounds.size.height+20, 0);
    //下拉刷新
    self.topRefresh.topfresh2.hidden = NO;
    [self.topRefresh.topfresh startAnimating];
    //网络类
    [_allData cancelResquest];
    [_textData cancelResquest];
    [_colesion cancelResquest];
    self.allData = [[JeffyHumorousColsction alloc] init];
    [_allData release];
    self.allData.delegate = self;
    
    self.textData = [[JeffyHumorousColsction alloc] init];
     [_textData release];
    self.textData.delegate = self;
    self.colesion = [[JeffyHumorousColsction alloc] init];
     [_colesion release];

    [_array removeAllObjects];
    [_allShareMood removeAllObjects];
    [_allTextArray removeAllObjects];
    [_allVideoArray removeAllObjects];
    [_allcommentArray removeAllObjects];
    Original(1);
    [self.allData dataGetWithUrl:urlString];
}


#pragma mark 上拉加载
- (void)dragLoad
{   refreshflag = YES;
    _currentLoad++;
    Original(_currentLoad);
    [self.allData dataGetWithUrl:urlString];
}


#pragma mark -------------
#pragma mark  实现数据回传的代理方法
- (void)requestDataSuccessful:(JeffyHumorousColsction *)humConnection
{
    static int textindex = 0;
    static int jsonArrayCount = 0;
    if (humConnection == self.allData) {
        NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:humConnection.receiveData options:NSJSONReadingMutableContainers error:nil];
        if (jsonArray.count<1) {
            //缩回下拉效果
            [UIView animateWithDuration:1 animations:^{
                self.tableView.contentInset = UIEdgeInsetsMake(_freshHeight, 0, _footLoad.bounds.size.height+20, 0);
                _footLoad.hidden = YES;
            }completion:^(BOOL finished) {
                self.topRefresh.topfresh2.hidden = YES;
                [self.topRefresh.topfresh stopAnimating];
            }];
            refreshflag = NO;
            return;
        }
        textindex = 0;
        jsonArrayCount = jsonArray.count;
      [jsonArray addObjectsFromArray:self.array];
        self.array = jsonArray;
        
        NSMutableArray *allMood = [NSMutableArray array];
        NSMutableArray *allArray = [NSMutableArray array];
            for (NSDictionary *dic in _array) {
                if ([_array indexOfObject:dic] >= jsonArrayCount) {
                    break;
                }
            ShareMood *share = [[ShareMood alloc] init];
            [share setValuesForKeysWithDictionary:dic];
                [allMood addObject:share];
                [allArray addObject:share.comment];
                [share release];
        }
        [allMood addObjectsFromArray:self.allShareMood];
        [allArray addObjectsFromArray:self.allcommentArray];
        self.allShareMood = allMood;
        self.allcommentArray = allArray;
        ShareMood *share;
        allText = [[NSMutableArray alloc]init];
        for (; textindex< jsonArrayCount; textindex++) {
            share = self.allShareMood[textindex];
            if (share.contentURL.length) {
                break;
            }else{
                //网址为空
                NSString *str = @"";
                [allText addObject:str];
            }
        }
        
        if (textindex < jsonArrayCount) {
            [self.textData dataGetWithUrl:share.contentURL];
        }
}
    

    
    
    if (humConnection == self.textData) {
        
        NSString *str = [[NSString alloc] initWithData:humConnection.receiveData encoding:NSUTF8StringEncoding];
        
        [allText addObject:str];
        [str release];
        textindex++;
        if (textindex < jsonArrayCount) {
            ShareMood *share;
            for (; textindex<jsonArrayCount; textindex++) {
                share = self.allShareMood[textindex];
                
                if (share.contentURL.length) {
                    break;
                }else{
                    //网址为空
                    NSString *str = @"";
                    [allText addObject:str];
                }
            }
            
            if (textindex < jsonArrayCount) {
                [self.textData dataGetWithUrl:share.contentURL];
            }
        }
    }

    if (allText.count == jsonArrayCount) {
        [allText addObjectsFromArray:self.allTextArray];
        self.allTextArray = allText;
        [allText release];
        [self.tableView reloadData];
        //缩回下拉效果
        _footLoad.hidden = YES;
        [UIView animateWithDuration:1 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(_freshHeight, 0, _footLoad.bounds.size.height+20, 0);
        }completion:^(BOOL finished) {
            self.topRefresh.topfresh2.hidden = YES;
            [self.topRefresh.topfresh stopAnimating];
        }];
        //收回上拉加载
        textindex = 0;
        refreshflag = NO;
        button.enabled = YES;
       
}
    
    
}

#pragma mark 左导航键
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.view window]) {
    self.view = nil;
    self.colesion = nil;
    self.allData = nil;
    self.textData = nil;
    self.array = nil;
    self.allShareMood = nil;
    self.allTextArray = nil;
    self.allVideoArray = nil;
    self.allcommentArray = nil;
    self.topRefresh = nil;
    self.footLoad = nil;
    self.upload = nil;
    [alert release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZjOriginalCell *cell = [[[DZjOriginalCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"]autorelease];
    BOOL imageExit = NO;
     NSIndexPath *DZJindexPath = [NSIndexPath indexPathForRow:self.allShareMood.count-1-indexPath.row inSection:indexPath.section];
    ShareMood *share = self.allShareMood[DZJindexPath.row];
    if (share.pictureURL&&share.pictureURL.length>0) {
        imageExit = YES;
    }
    
    float height =[cell returnHightForCell:self.allTextArray[DZJindexPath.row] cellImage:imageExit comments:self.allcommentArray[DZJindexPath.row]];
    return height;
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_allTextArray.count==_allShareMood.count&&_allShareMood.count) {
        return _allTextArray.count;
    }
    return 0;
}
#pragma mark -------
#pragma mark  执行代理方法 更新数据库的评论
- (void)updataCommentWith:(int)index
{
    NSString *url = @"http://msg.lanou3g.com/student/class_11/team_three/resource/AllPHP/JJUpdataComment.php";
    ShareMood *share = [self.allShareMood objectAtIndex:index];
    int userID = share.userID;
    NSString *comment = self.allcommentArray[index];
    
    NSString *bodyStr = [NSString stringWithFormat:@"comment=%@&userID=%d",comment,userID];
    NSData *data = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [_colesion dataPOSTWithUrl:url body:data];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DZjOriginalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[DZjOriginalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag = (int)self.tableView;
        cell.delegete = self;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.dataArray = self.allcommentArray;
    NSIndexPath *DZJindexPath = [NSIndexPath indexPathForRow:self.allShareMood.count-1-indexPath.row inSection:indexPath.section];
    cell.indexPath = DZJindexPath;
    //用户心情的赋值
    ShareMood *mood = nil;
    if (DZJindexPath.row < self.allShareMood.count) {
        mood = [self.allShareMood objectAtIndex:DZJindexPath.row];
        cell.usernameLabel.text = mood.userName;
        cell.publishTime.text = mood.publishedTime;
        if (mood.pictureURL.length>0&&mood.pictureURL) {
            [cell.publishImageView loadImageWithUrlSting:mood.pictureURL];
        }
        if (mood.userImageURL.length > 0) {
            [cell.userImageView loadImageWithUrlSting:mood.userImageURL];
        }else
        {
            cell.userImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
        }
        cell.viedoUrlSting = mood.videoURL;
    }
    if (DZJindexPath.row < _allTextArray.count) {
        cell.text.text = self.allTextArray[DZJindexPath.row];
    }
    if (DZJindexPath.row < _allcommentArray.count) {
        cell.comments.text = self.allcommentArray[DZJindexPath.row];
    }
    [cell refreshposition:(mood.pictureURL.length>0&&mood.pictureURL)];
    
    return cell;
}



#pragma mark 检测下拉状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y <= -(_freshHeight+_topRefresh.bounds.size.height)) {
        //下拉刷新
        _currentLoad = 1;
        [self dragRefresh];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //如果看到底端则加载
    if (scrollView.contentOffset.y >scrollView.contentSize.height-self.view.bounds.size.height&&!refreshflag&&_allTextArray.count&&!myflag) {
        _footLoad.hidden = NO;
        refreshflag = YES;
        [self dragLoad];
    }
    _footLoad.center = CGPointMake(_footLoad.center.x, scrollView.contentSize.height+_footLoad.bounds.size.height/2+5);
    
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
