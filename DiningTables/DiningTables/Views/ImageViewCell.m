//
//  ImageViewCell.m
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "ImageViewCell.h"
#import "SingleTableImageView.h"

@interface ImageViewCell()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) SingleTableImageView *subView1,*subView2,*subView3;
@property (nonatomic,strong) UILabel *combinedTitleLabel;

@property (nonatomic,assign) int currentPageNumber;
@property (nonatomic,assign) int totalNumberOfViews;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) int computeNumberOfTimes;

@end

@implementation ImageViewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createViews];
    }
    return self;
}

- (void)createViews
{
    self.combinedTitleLabel = [self createLabel:[UIColor blackColor] Alignment:NSTextAlignmentCenter text:@"Dining Tables" font:[UIFont fontWithName:@"Helvetica" size:18]];
    [self.contentView addSubview:self.combinedTitleLabel];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    
    self.subView1 = [[SingleTableImageView alloc] init];
    self.subView1.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.subView1];
    
    self.subView2 = [[SingleTableImageView alloc] init];
    self.subView2.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.subView2];
    
    self.subView3 = [[SingleTableImageView alloc] init];
    self.subView3.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.subView3];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    self.computeNumberOfTimes = 0;
    
}

#pragma ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.computeNumberOfTimes == 0)
    {
        self.computeNumberOfTimes = 1;
        
        int pageNumber = [self calculatePageNumber:scrollView.contentOffset.x singlePageWidth:scrollView.frame.size.width];
        self.currentPageNumber = (pageNumber == -1) ? self.currentPageNumber:pageNumber;
        NSLog(@"Page Number %d",self.currentPageNumber);
        
        // Calculate the View to be reused
        
        int viewIndex = self.currentPageNumber % 3;
        
        if (viewIndex == 0)
        {
            // [UIView animateWithDuration:0.5 animations:^{
            self.subView1.frame = CGRectMake(self.scrollView.frame.size.width * self.currentPageNumber, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            //} completion:^(BOOL finished) {
            
            // }];
            
            [self.subView1 updateViewWithData:[self.dataArray objectAtIndex:self.currentPageNumber]];
        }
        else if (viewIndex == 1)
        {
            self.subView2.frame = CGRectMake(self.scrollView.frame.size.width * self.currentPageNumber, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            
            [self.subView2 updateViewWithData:[self.dataArray objectAtIndex:self.currentPageNumber]];
        }
        else if (viewIndex == 2)
        {
            self.subView3.frame = CGRectMake(self.scrollView.frame.size.width * self.currentPageNumber, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            
            [self.subView3 updateViewWithData:[self.dataArray objectAtIndex:self.currentPageNumber]];
        }
    }
    self.computeNumberOfTimes = 0;
}

- (int)calculatePageNumber:(float)fullWidth singlePageWidth:(float)singlePageWidth
{
    int pageNumber = floorf(fullWidth/singlePageWidth);
    return pageNumber;
}


- (UILabel *)createLabel:(UIColor *)textColor Alignment:(NSTextAlignment)textAlignment text:(NSString *)text font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.text = text;
    label.font = font;
    label.textAlignment = textAlignment;
    return label;
}

- (void)updateViewsWithData:(NSArray *)resDetails
{    
    [self.dataArray removeAllObjects];
    
    if (resDetails)
    {
        [self.dataArray addObjectsFromArray:resDetails];
        self.totalNumberOfViews = self.dataArray.count;
    }
    else
    {
        self.totalNumberOfViews = 1;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 5;
    float fullWidth = self.contentView.frame.size.width - (startXPos*2);
    float fullHeight = self.contentView.frame.size.height - (startYPos*2);
    
    self.combinedTitleLabel.frame = CGRectMake(startXPos, startYPos, fullWidth, 50);
    
    self.scrollView.frame = CGRectMake(startXPos, self.combinedTitleLabel.frame.origin.x + self.combinedTitleLabel.frame.size.height, fullWidth, fullHeight - (self.combinedTitleLabel.frame.origin.x + self.combinedTitleLabel.frame.size.height));
    self.scrollView.contentSize = CGSizeMake(fullWidth*self.totalNumberOfViews, fullHeight - (self.combinedTitleLabel.frame.origin.x + self.combinedTitleLabel.frame.size.height));
    
    float singleViewWidth = self.contentView.frame.size.width;
    float singleViewHeight = self.contentView.frame.size.height;
    
    self.subView1.frame = CGRectMake(0, 0, singleViewWidth, singleViewHeight);
    self.subView2.frame = CGRectMake(singleViewWidth, 0, singleViewWidth, singleViewHeight);
    self.subView3.frame = CGRectMake(singleViewWidth*2, 0, singleViewWidth, singleViewHeight);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
