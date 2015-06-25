//
//  SuggestionViewController.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "SuggestionViewController.h"
#import "AddAttireViewController.h"
#import "SuggestionView.h"
#import "StorageHandler.h"

@interface SuggestionViewController ()<suggestionViewDelegate>

@property (nonatomic,strong) SuggestionView *suggestionView;

@end

@implementation SuggestionViewController

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
    self.suggestionView = [[SuggestionView alloc] init];
    self.suggestionView.suggestionViewdelegate = self;
    self.view = self.suggestionView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Suggestion";
    
    NSMutableArray *completeAttireList = [[StorageHandler getSharedInstance] getComplteAttireListFromStorage];
    
    if (completeAttireList.count == 0)
    {
        [self.suggestionView showNoAttireView:YES];
    }
    else
    {
        [self.suggestionView showNoAttireView:NO];
        
       // NSLog(@"stored List %@",completeAttireList);
        
        [self.suggestionView updateViewWithData:completeAttireList];
    }
    
    //[[StorageHandler getSharedInstance] clearStorage]; // For Testing Purpose
}


#pragma suggestion View Delegates

- (void)suggestionView:(SuggestionView *)suggestionView addButtonClicked:(UIButton *)addAtireBtn
{
    [self navigateToAddAttireView];
}

- (void)suggestionView:(SuggestionView *)suggestionView bookmarkButtonClicked:(UIButton *)bookmarkButton andSeletedAttirePairDict:(NSDictionary *)selectedAttirePairDict
{
    BOOL succes = [[StorageHandler getSharedInstance] storeAttirePairToMyPreferences:selectedAttirePairDict];
    
    if (succes)
    {
        [self showMessageInAlert:AlertTitle andMessage:@"Book Mark Saved"];
    }
}

- (void)suggestionView:(SuggestionView *)suggestionView selectedAttire:(NSDictionary *)selectedAttire
{
    if (selectedAttire)
    {
        [self showMessageInAlert:AlertTitle andMessage:@"Today's Attire Selected"];
    }
    else
    {
        [self showMessageInAlert:AlertTitle andMessage:@"No Attire Available. Please add Some Attires..."];
    }
    
}

- (void)suggestionView:(SuggestionView *)suggestionView dislikeButtonClicked:(UIButton *)dislikeButton andSeletedAttirePairDict:(NSDictionary *)selectedAttirePairDict
{
    BOOL success = [[StorageHandler getSharedInstance] deleteAttireFromCompletePairList:selectedAttirePairDict];
    
    if (success)
    {
        [self showMessageInAlert:AlertTitle andMessage:@"Attire Deleted"];
    }
}

- (void)navigateToAddAttireView
{
    AddAttireViewController *addAttireViewController = [[AddAttireViewController alloc] init];
    
    [self navigateToViewController:addAttireViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
