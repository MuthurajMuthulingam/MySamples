//
//  ImageViewCell.m
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "ImageViewCell.h"
#import "ImageDownloader.h"
#import "ImageCache.h"

@interface ImageViewCell()<ImageDownloaderDeleagte>

@property (nonatomic,strong) UIImageView *res_image;
@property (nonatomic,strong) UILabel *res_name,*res_offer,*res_type,*res_dist,*res_addr;
@property (nonatomic,strong) NSURL *res_image_url;

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
    self.res_image = [[UIImageView alloc] init];
    self.res_image.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.res_image];
    
    self.res_name = [self createLabel:[UIColor blackColor] Alignment:NSTextAlignmentLeft text:@"Test" font:[UIFont fontWithName:@"Helvetica" size:16]];
    [self.contentView addSubview:self.res_name];
    
    self.res_offer = [self createLabel:[UIColor grayColor] Alignment:NSTextAlignmentLeft text:@"Test" font:[UIFont fontWithName:@"Helvetica" size:14]];
    [self.contentView addSubview:self.res_offer];
    
    self.res_type = [self createLabel:[UIColor grayColor] Alignment:NSTextAlignmentLeft text:@"Test" font:[UIFont fontWithName:@"Helvetica" size:14]];
    [self.contentView addSubview:self.res_type];
    
    self.res_dist = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentLeft text:@"Test" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.contentView addSubview:self.res_dist];
    
    self.res_addr = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentLeft text:@"Test" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.contentView addSubview:self.res_addr];
    
    self.loadingBar = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingBar.center = self.res_image.center;
    [self.loadingBar startAnimating];
    self.loadingBar.hidesWhenStopped = YES;
    [self.res_image addSubview:self.loadingBar];
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

- (void)updateViewsWithData:(NSDictionary *)resDetails
{    
    self.res_name.text = [resDetails objectForKey:@"BrandName"];
    self.res_type.text = [resDetails objectForKey:@"combinedCatagoryString"];
    self.res_addr.text = [resDetails objectForKey:@"Address"];
    self.res_dist.text = [NSString stringWithFormat:@"%.2f m",[[resDetails objectForKey:@"calculatedDistance"] floatValue]];//Distance
    NSURL *imageURL = [NSURL URLWithString:[resDetails objectForKey:@"LogoURL"]];
    self.res_image_url = imageURL;
    
    [self startDownloadingImage:imageURL];
    
    
}

- (void)startDownloadingImage:(NSURL *)imageURL
{
    if ([[ImageCache getSharedInstance] getImageForkey:[self.res_image_url absoluteString]])
    {
        UIImage *image = [[ImageCache getSharedInstance] getImageForkey:[self.res_image_url absoluteString]];
        [self setImageToView:image];
    }
    else
    {
        [self.loadingBar startAnimating];
        
        ImageDownloader *imageDownloadingOperation = [[ImageDownloader alloc] initWithImageURLString:[imageURL absoluteString]];
        [imageDownloadingOperation setQualityOfService:NSQualityOfServiceBackground];
        imageDownloadingOperation.delegate = self;
        [imageDownloadingOperation start];
    }
}

- (void)downloadedImage:(UIImage *)downloadedImage
{
    [[ImageCache getSharedInstance] setImageForKey:[self.res_image_url absoluteString] andImage:downloadedImage];
    
    [self performSelectorOnMainThread:@selector(setImageToView:) withObject:downloadedImage waitUntilDone:YES];
}

- (void)setImageToView:(UIImage *)image
{
    [self.loadingBar stopAnimating];
    self.res_image.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 5;
    float fullWidth = self.contentView.frame.size.width - (startXPos*2);
    float fullHeight = self.contentView.frame.size.height - (startYPos*2);
    float imageViewWidth = fullWidth/3;
    
    self.res_image.frame = CGRectMake(startXPos, startYPos, imageViewWidth, fullHeight/2);
    self.res_name.frame = CGRectMake(self.res_image.frame.size.width + self.res_image.frame.origin.x + 5, startYPos, fullWidth - (self.res_image.frame.size.width + self.res_image.frame.origin.x + 5), fullHeight/4);
    self.res_offer.frame = CGRectMake(self.res_image.frame.size.width + self.res_image.frame.origin.x  + 5, self.res_name.frame.origin.y + self.res_name.frame.size.height, fullWidth - (self.res_image.frame.size.width + self.res_image.frame.origin.x + 5), fullHeight/4);
    
    self.res_type.frame = CGRectMake(startXPos, self.res_image.frame.origin.y + self.res_image.frame.size.height,fullWidth, fullHeight/4);
    self.res_dist.frame = CGRectMake(startXPos, self.res_type.frame.origin.y + self.res_type.frame.size.height,fullWidth/4, fullHeight/4);
    self.res_addr.frame = CGRectMake(self.res_dist.frame.origin.x + self.res_dist.frame.size.width , self.res_type.frame.origin.y + self.res_type.frame.size.height,fullWidth - (self.res_dist.frame.origin.x + self.res_dist.frame.size.width), fullHeight/4);
    
    self.loadingBar.frame = CGRectMake(0, 0, 50, 30);
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
