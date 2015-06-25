//
//  SingleTableImageView.m
//  DiningTables
//
//  Created by Muthuraj M on 3/3/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "SingleTableImageView.h"
#import "ImageDownloader.h"
#import "ImageCache.h"

@interface SingleTableImageView ()<ImageDownloaderDeleagte>

@property (nonatomic,strong) UIImageView *tableImage;
@property (nonatomic,strong) UILabel *titleLabel,*priceLabel;
@property (nonatomic,strong) NSURL *imageURL;

@property (nonatomic,strong) UIActivityIndicatorView *loadingBar;
@end

@implementation SingleTableImageView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self createViews];
    }
    
    return self;
}

- (void)createViews
{
    self.tableImage = [[UIImageView alloc] init];
    self.tableImage.backgroundColor = [UIColor blackColor];
    [self addSubview:self.tableImage];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"test";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @"Price Label";
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.textColor = [UIColor blackColor];
    [self addSubview:self.priceLabel];
    
    self.loadingBar = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingBar.center = self.tableImage.center;
    [self.loadingBar startAnimating];
    self.loadingBar.hidesWhenStopped = YES;
    [self.tableImage addSubview:self.loadingBar];
    
}

- (void)startDownloadingImage:(NSURL *)imageURL
{
    if ([[ImageCache getSharedInstance] getImageForkey:[self.imageURL absoluteString]])
    {
        UIImage *image = [[ImageCache getSharedInstance] getImageForkey:[self.imageURL absoluteString]];
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
    [[ImageCache getSharedInstance] setImageForKey:[self.imageURL absoluteString] andImage:downloadedImage];
    
    [self performSelectorOnMainThread:@selector(setImageToView:) withObject:downloadedImage waitUntilDone:YES];
}

- (void)setImageToView:(UIImage *)image
{
    [self.loadingBar stopAnimating];
    self.tableImage.image = image;
}

- (void)updateViewWithData:(NSDictionary *)dataDict
{
    NSLog(@"Data details %@",dataDict);
    
    NSLog(@"image details title %@ and Price %@ and ImageURL %@",[dataDict objectForKey:@"name"],[dataDict objectForKey:@"price"],[dataDict objectForKey:@"images"]);
    
   self.titleLabel.text = [NSString stringWithFormat:@"%@",[dataDict objectForKey:@"name"]];
    self.priceLabel.text =[NSString stringWithFormat:@"Rs %@",[dataDict objectForKey:@"price"]];
    
    NSDictionary *imageDict = [dataDict objectForKey:@"image"];
    NSURL *imageURL = [NSURL URLWithString:[imageDict objectForKey:@"url"]];
    self.imageURL = imageURL;
    [self startDownloadingImage:imageURL];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 0;
    float startYPos = 0;
    float fullWidth = self.frame.size.width - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.tableImage.frame = CGRectMake(startXPos, startYPos, fullWidth, fullHeight*2/3);
    self.titleLabel.frame = CGRectMake(startXPos, self.tableImage.frame.size.height + self.tableImage.frame.origin.y, fullWidth, (fullHeight/3)*2/3);
    self.priceLabel.frame = CGRectMake(startXPos, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y, fullWidth, (fullHeight/3)/3);
    
    self.loadingBar.center = self.tableImage.center;
}

@end
