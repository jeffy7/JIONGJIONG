//
//  landingViewController.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-9.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "landingViewController.h"

@interface landingViewController ()

@end

@implementation landingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_landView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"night_user_header_defaultbg.jpg"]]];
//	self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.993 blue:0.987 alpha:1.000];
    self.navigationItem.title = @"欢迎登陆";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationController.navigationItem.rightBarButtonItem = buttonItem;
    [buttonItem release];
    _landView = [[landingView alloc]initWithFrame:self.view.bounds];
    _landView.keyBoard = _keyBoard;
    _landView.dismiss = _dismiss;
    self.landView.presentVC = self;
    if (_dismiss) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
        swipe.direction = UISwipeGestureRecognizerDirectionDown;
        [_landView addGestureRecognizer:swipe];
    }
    [self.view addSubview:self.landView];
}

- (void)back
{
    if (_dismiss) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.view window]) {
        self.view = nil;
        self.landView = nil;
    }
    
}

@end
