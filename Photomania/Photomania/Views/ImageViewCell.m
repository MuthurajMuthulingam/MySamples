//
//  ImageViewCell.m
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "ImageViewCell.h"
#import "AsynchronousImageDownloader.h"

@interface ImageViewCell()

@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,strong) UILabel *imageName;
@property (nonatomic,strong) NSURL *imageURL;

@property (nonatomic,strong) UIActivityIndicatorView *loadingBar;

@end

@implementation ImageViewCell

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
    self.cellImageView = [[UIImageView alloc] init];
    self.cellImageView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.cellImageView];
    
    self.imageName = [[UILabel alloc] init];
    self.imageName.backgroundColor = [UIColor clearColor];
    self.imageName.text = @"Test";
    self.imageName.textAlignment = NSTextAlignmentCenter;
    self.imageName.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.imageName];
    
    self.loadingBar = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingBar.center = self.cellImageView.center;
    [self.loadingBar startAnimating];
    self.loadingBar.hidesWhenStopped = YES;
    [self.cellImageView addSubview:self.loadingBar];
}

- (void)updateViewsWithData:(NSDictionary *)imageDetails
{
    self.imageName.text = [imageDetails objectForKey:@"title"];
    
    NSURL *imageURL = [NSURL URLWithString:[imageDetails objectForKey:@"url"]];
    
    self.imageURL = imageURL;
    
    [self startDownloadingImage:imageURL];
}

- (void)startDownloadingImage:(NSURL *)imageURL
{
    [[AsynchronousImageDownloader sharedInstance] loadImageFromURL:[imageURL absoluteString] completionBlock:^(BOOL succeeded, UIImage *image, NSString *urlString)
    {
        if (succeeded && [imageURL isEqual:[NSURL URLWithString:urlString]])
        {
            [self.loadingBar stopAnimating];
            self.cellImageView.image = image;
        }
        else
        {
            [self.loadingBar stopAnimating];
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 5;
    float fullWidth = self.contentView.frame.size.width - (startXPos*2);
    float fullHeight = self.contentView.frame.size.height - (startYPos*2);
    
    self.imageName.frame = CGRectMake(startXPos, startYPos, fullWidth, 30);
    self.cellImageView.frame = CGRectMake(startXPos, self.imageName.frame.origin.y + self.imageName.frame.size.height, fullWidth, fullHeight - (self.imageName.frame.origin.y + self.imageName.frame.size.height));
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
