//
//  ViewController.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "InitialViewController.h"
#import "InitialView.h"
#import "HomeViewController.h"
#import "JourneyTableViewController.h"

@interface InitialViewController ()<InitialViewDelegate>

@property (nonatomic,strong) InitialView *initialView;

@end

@implementation InitialViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)createViews
{
    [super createViews];
    
    self.initialView = [[InitialView alloc] init];
    self.initialView.delegate = self;
    [self.view addSubview:self.initialView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.journy_iPad addTarget:self action:@selector(iPadBtnPreesed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.initialView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70);
}

- (void)newJourneyBtnClick
{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self navigateToViewController:homeVC];
}

- (void)pastJourneyBtnClcik
{
    JourneyTableViewController *detailVC = [[JourneyTableViewController alloc] init];
    [self navigateToViewController:detailVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
