//
//  HomeViewController.m
//  DesignTest
//
//  Created by Muthuraj M on 6/3/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"

@interface HomeViewController ()

@property (nonatomic,strong) HomeView *homeView;

@end

@implementation HomeViewController

- (void)loadView
{
    [super loadView];
    
    [self createViews];
}

- (void)createViews
{
    self.homeView = [[HomeView alloc] init];
    self.homeView.backgroundColor = [UIColor whiteColor];
    self.view = self.homeView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Search";
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
