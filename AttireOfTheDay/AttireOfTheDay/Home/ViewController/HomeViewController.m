//
//  HomeViewController.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "SuggestionViewController.h"
#import "MyPreferencesViewController.h"


@interface HomeViewController ()<HomeViewDelegate>

@property (nonatomic,strong) HomeView *homeView;

@end

@implementation HomeViewController

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
    self.homeView = [[HomeView alloc] init];
    self.homeView.backgroundColor = [UIColor whiteColor];
    self.homeView.homeViewDeleagte = self;
    self.view = self.homeView;
}

- (void)homeView:(HomeView *)homeView selectedHomeViewButonTitle:(NSString *)buttonString
{
    if ([buttonString isEqualToString:@"Suggestion"])
    {
        SuggestionViewController *suggestionViewController = [[SuggestionViewController alloc] init];
        [self navigateToViewController:suggestionViewController];
    }
    else if ([buttonString isEqualToString:@"My Preferences"])
    {
        MyPreferencesViewController *myPreferncesViewController = [[MyPreferencesViewController alloc] init];
        [self navigateToViewController:myPreferncesViewController];
                                                                   
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Home";
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
