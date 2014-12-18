//
//  JeffyCollectionViewController.m
//  JIONGJIONG
//
//  Created by lanou on 13-12-4.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "JeffyCollectionViewController.h"
#import "CollectionCell.h"
#import "Collection.h"

@interface JeffyCollectionViewController ()

@end

@implementation JeffyCollectionViewController
static inline NSString * cachePath ()
{
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collect"];
    return cache;
}
-(void)dealloc
{
    [_allCollectionHum release];
    [_scroll release];
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
- (void)unarchiver
{
    //放归档
    NSMutableData *data = [NSData dataWithContentsOfFile:cachePath()];
    NSKeyedUnarchiver *unarchiver = [[[NSKeyedUnarchiver alloc] initForReadingWithData:data] autorelease];
    self.allCollectionHum = [unarchiver decodeObjectForKey:@"coll"];
    [unarchiver finishDecoding];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.798 green:0.405 blue:0.693 alpha:0.500];
    }else
    {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.798 green:0.405 blue:0.693     alpha:0.770];
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"more_three_line"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(backSiderbarPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];

    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:
                                   [UIImage imageNamed:@"main_background.png"]]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"night_channel_undo_bar.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    self.allCollectionHum = [NSMutableArray array];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:cachePath()]) {
        [self unarchiver];
    }
    if (self.allCollectionHum.count == 0) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 50)];
        label.text = @"还没有收藏哦亲,记的长按收藏哦!";
        label.textAlignment = NSTextAlignmentCenter;
        [self.tableView addSubview:label];
        [label release];
    }

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.tableView window]) {
        self.allCollectionHum = nil;
        self.tableView = nil;
    }
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.allCollectionHum.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Collection *coll = [self.allCollectionHum objectAtIndex:indexPath.row];
    if (!coll.collectImage) {
        return [CollectionCell calcultorHeightwith:coll.collectHum]+60;
        
    }else{
        return [CollectionCell calcultorHeightwith:coll.collectHum]+160;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[CollectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    Collection *collect = [self.allCollectionHum objectAtIndex:indexPath.row];
    
    cell.collectView.image = collect.collectImage;
    cell.userNameLabel.text = collect.userName;
    cell.showView.image = collect.userImage;
    
    cell.vedioURL = collect.vedioURL;
    cell.collectLabel.text = collect.collectHum;
    cell.collectLabel.numberOfLines = 0;
    [cell.collectLabel sizeToFit];
    cell.backgroundColor = [UIColor clearColor];

    //由于重用会造成改变   所以每次需要改回来
    //强制装换回来
    CGRect temp = cell.collectLabel.frame;
    temp.size.width = 300.0;
    cell.collectLabel.frame = temp;
    
    cell.collectView.frame = CGRectMake(cell.collectView.frame.origin.x, 60+cell.collectLabel.frame.size.height, 100, 100);
 
    return cell;
}
#pragma mark-------关于编辑的几个代理方法

//1
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}
//2
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//3类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//4开始编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除数据源
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        
        [_allCollectionHum removeObjectAtIndex :indexPath.row];
        NSArray *deleArray = [NSArray arrayWithObjects:indexPath, nil];
        [self.tableView deleteRowsAtIndexPaths:deleArray withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        //删除完成后归档
        [self archiver];
        if (self.allCollectionHum.count == 0) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 50)];
            label.text = @"还没有收藏哦亲,记的长按收藏哦!";
            label.textAlignment = NSTextAlignmentCenter;
            [self.tableView addSubview:label];
            [label release];
        }
        
    }
}
- (void)archiver
{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[[NSKeyedArchiver alloc] initForWritingWithMutableData:data] autorelease];
    [archiver encodeObject:self.allCollectionHum forKey:@"coll"];
    [archiver finishEncoding];
    [fileManger createFileAtPath:cachePath() contents:data attributes:nil];
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
