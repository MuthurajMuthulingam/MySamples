//
//  InitialViewController.m
//  Photomania
//
//  Created by Muthuraj M on 12/19/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "InitialViewController.h"
#import "InitialView.h"

@interface InitialViewController ()

@property (nonatomic,strong) InitialView *initialView;

@end

@implementation InitialViewController

@synthesize initialView;

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
    self.initialView = [[InitialView alloc] initWithViewController:self];
    self.initialView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.initialView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(initialView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[initialView]|" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[initialView]|" options:0 metrics:0 views:views]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
