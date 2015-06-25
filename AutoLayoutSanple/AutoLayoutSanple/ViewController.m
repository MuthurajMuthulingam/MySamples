//
//  ViewController.m
//  AutoLayoutSanple
//
//  Created by Muthuraj M on 4/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ViewController.h"
#import "SampleView.h"

@interface ViewController ()

@property (nonatomic,strong) SampleView *sampleView;

@end

@implementation ViewController

@synthesize sampleView;

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        
     }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self createViews];
}

- (void)createViews
{
    self.sampleView = [[SampleView alloc] init];
    self.sampleView.backgroundColor = [UIColor greenColor];
    self.sampleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.sampleView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(sampleView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[sampleView]|" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[sampleView]|" options:0 metrics:0 views:views]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
