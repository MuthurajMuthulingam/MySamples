//
//  ViewController.m
//  ScrollingSample
//
//  Created by Muthuraj M on 1/30/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "ViewController.h"
#import "MainScrollView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (strong,nonatomic) MainScrollView *mainView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *insideScrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    self.mainView = [[MainScrollView alloc] init];
//    self.view = self.mainView;
    self.scrollView.backgroundColor = [UIColor greenColor];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4, self.view.frame.size.height - 20);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.insideScrollView.backgroundColor = [UIColor redColor];
    self.insideScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*3);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView scrolled");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
