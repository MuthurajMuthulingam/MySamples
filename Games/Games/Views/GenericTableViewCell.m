//
//  GenericTableViewCell.m
//  Games
//
//  Created by Muthuraj M on 5/6/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "GenericTableViewCell.h"
#import "ImageCache.h"
#import "ImageDownloader.h"

@interface GenericTableViewCell ()<ImageDownloaderDeleagte>

@property (nonatomic,strong) UIImageView *cellImage;
@property (nonatomic,strong) UILabel *cellTitleLabel,*detailLabel;

@property (nonatomic,strong) NSURL *imageURL;

@end

@implementation GenericTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
    self.cellImage = [[UIImageView alloc] init];
    self.cellImage.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.cellImage];
    
    self.cellTitleLabel = [self createLabel:[UIColor blackColor] andAlignmnet:NSTextAlignmentLeft andText:@"Test"];
    [self.contentView addSubview:self.cellTitleLabel];
    
    self.detailLabel = [self createLabel:[UIColor blackColor] andAlignmnet:NSTextAlignmentLeft andText:@"Test Details"];
    [self.contentView addSubview:self.detailLabel];
}

- (UILabel *)createLabel:(UIColor *)textColor andAlignmnet:(NSTextAlignment)textAlign andText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textAlignment = textAlign;
    label.textColor = textColor;
    
    return label;
}

- (void)layoutSubviews
{
    float startXPos = 5;
    float startYPos = 5;
    float fullWidth = self.contentView.frame.size.width - (startXPos*2);
    float fullHeight = self.contentView.frame.size.height - (startYPos*2);
    
    self.cellImage.frame = CGRectMake(startXPos, startYPos, fullWidth / 2 - 5, fullHeight);
    self.cellTitleLabel.frame = CGRectMake(fullWidth/2 + 5, startYPos, fullWidth/2 - 5, fullHeight / 4);
    self.detailLabel.frame = CGRectMake(fullWidth /2 + 5, self.cellTitleLabel.frame.size.height + self.cellTitleLabel.frame.origin.y, fullWidth/2 - 5, fullHeight - (self.cellTitleLabel.frame.size.height + self.cellTitleLabel.frame.origin.y));
}

- (void)updateViewWithData:(NSDictionary *)dataDict
{
    self.cellTitleLabel.text = ([dataDict objectForKey:@"title"]) ? [dataDict objectForKey:@"title"]:@"";
    self.detailLabel.text = ([dataDict objectForKey:@"titleNoFormatting"]) ? [dataDict objectForKey:@"titleNoFormatting"]:@"";
    self.imageURL = [NSURL URLWithString:[dataDict objectForKey:@"url"]];
    
    if (self.imageURL)
    {
        dispatch_queue_t myque = dispatch_queue_create("myQueue1", nil);
        
        dispatch_async(myque, ^{
            
             [self startDownloadingImage:self.imageURL];
        });
        
       
    }
    
}

- (void)startDownloadingImage:(NSURL *)imageURL
{
    if ([[ImageCache getSharedInstance] retriveImageWithName:[imageURL absoluteString]])
    {
        UIImage *image = [[ImageCache getSharedInstance] retriveImageWithName:[imageURL absoluteString]];
        [self performSelectorOnMainThread:@selector(setImageToView:) withObject:image waitUntilDone:YES];
    }
    else
    {
        
        ImageDownloader *imageDownloadingOperation = [[ImageDownloader alloc] initWithImageURLString:[imageURL absoluteString]];
        [imageDownloadingOperation setQualityOfService:NSQualityOfServiceBackground];
        imageDownloadingOperation.delegate = self;
        [imageDownloadingOperation start];
    }
}

- (void)downloadedImage:(UIImage *)downloadedImage
{
    [[ImageCache getSharedInstance] storeImageToLocal:downloadedImage andImageName:[self.imageURL absoluteString]];
    
    [self performSelectorOnMainThread:@selector(setImageToView:) withObject:downloadedImage waitUntilDone:YES];
}

- (void)setImageToView:(UIImage *)image
{
    self.cellImage.image = image;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
