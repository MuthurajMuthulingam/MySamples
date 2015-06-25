//
//  MyPreferencesViewController.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/19/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "MyPreferencesViewController.h"
#import "MyPreferncesView.h"
#import "StorageHandler.h"

@interface MyPreferencesViewController ()<MyPreferncesDelegate>

@property (nonatomic,strong) MyPreferncesView *myPreferncesView;

@end

@implementation MyPreferencesViewController

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
    
    self.myPreferncesView = [[MyPreferncesView alloc] init];
    self.myPreferncesView.backgroundColor = [UIColor whiteColor];
    self.myPreferncesView.MyPreferncesDelegate = self;
    self.view = self.myPreferncesView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Bookmarks";
    
    NSArray *completeAttireList = [[StorageHandler getSharedInstance] getPreferredAttireListFromStorage];
    
    if (completeAttireList.count == 0)
    {
        NSLog(@"stored List %@",completeAttireList);
        
        [self.myPreferncesView showNoPreferencesView:NO];
    }
    else
    {
        [self.myPreferncesView showNoPreferencesView:YES];
        
        NSLog(@"stored List %@",completeAttireList);
        
        [self.myPreferncesView updateViewWithData:completeAttireList];
    }
}

#pragma Mypreferences View Delegate

- (void)myPreferencesView:(MyPreferncesView *)myPreferencesView shareBtnClicked:(commonAttireScrollView *)attireView
{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", nil);
    dispatch_async(myQueue, ^{
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:@"My Today's Attire... :)"];
        [controller addImage:[self imageWithView:attireView]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:controller animated:YES completion:Nil];
        });
    });
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
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
