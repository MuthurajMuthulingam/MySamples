//
//  ImageCollectionViewCell.m
//  ImageFilteration
//
//  Created by Muthuraj M on 3/21/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "SingleImageWithTitle.h"

@interface ImageCollectionViewCell ()

@property (nonatomic,strong) SingleImageWithTitle *singleImageView;

@end

@implementation ImageCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createViews];
    }
    
    return self;
}


- (void)createViews
{
    self.singleImageView = [[SingleImageWithTitle alloc] init];
    [self.contentView addSubview:self.singleImageView];
}

- (void)updateViewWithData:(NSDictionary *)dataDict
{
    [self.singleImageView updateViewWithData:dataDict];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.singleImageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

@end
