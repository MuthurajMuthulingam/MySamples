//
//  LoginViewController.m
//  DesignTest
//
//  Created by Muthuraj M on 6/3/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "LoginView.h"

@interface LoginViewController ()<LoginViewDelegate>

@property (nonatomic,strong) LoginView *loginView;

@end

@implementation LoginViewController

- (void)loadView
{
    [super loadView];
    
    [self createViews];
}

- (void)createViews
{
    self.loginView = [[LoginView alloc] init];
    self.loginView.backgroundColor = [UIColor blackColor];
    self.loginView.delegate = self;
    self.view = self.loginView;
}

#pragma loginView delegates

- (void)loginView:(LoginView *)loginView loginBtnClicked:(UIButton *)clickedButton
{
    HomeViewController *homeView = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:homeView animated:YES];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
