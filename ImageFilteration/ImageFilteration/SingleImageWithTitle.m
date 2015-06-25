//
//  SingleImageWithTitle.m
//  ImageFilteration
//
//  Created by Muthuraj M on 3/21/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "SingleImageWithTitle.h"
#import "ImageDownloader.h"
#import "ImageCache.h"

@interface SingleImageWithTitle ()<ImageDownloaderDeleagte>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong)  NSURL *imageURL;

@property (nonatomic,strong) UIActivityIndicatorView *loadingBar;

@end

@implementation SingleImageWithTitle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0;
        
        [self createViews];
    }
    
    return self;
}

- (void)createViews
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.imageView];
    
    self.title = [[UILabel alloc] init];
    self.title.text = @"Test";
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = [UIColor whiteColor];
    [self addSubview:self.title];
    
    self.loadingBar = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingBar.center = self.imageView.center;
    [self.loadingBar startAnimating];
    self.loadingBar.hidesWhenStopped = YES;
    [self.imageView addSubview:self.loadingBar];
}

- (void)updateViewWithData:(NSDictionary *)dataDict
{
    NSLog(@"Data Dict %@",dataDict);
    
    self.title.text = [dataDict objectForKey:@"name"];
    self.imageView.image = [UIImage imageNamed:@""];
    
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/75148599/SampleImages/%@",[dataDict objectForKey:@"image"]]];
    
    [self startDownloadingImage:imageUrl];
}

- (void)startDownloadingImage:(NSURL *)imageURL
{
    self.imageURL = imageURL;
    
    if ([[ImageCache getSharedInstance] getImageForkey:[imageURL absoluteString]])
    {
        UIImage *image = [[ImageCache getSharedInstance] getImageForkey:[imageURL absoluteString]];
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
    self.imageView.image = image;
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    
    
    float startXPos = 0;
    float startYPos = 0;
    float fullWidth = self.frame.size.width - startXPos;
    float fullHeight = self.frame.size.height - startYPos;
    
    self.imageView.frame = CGRectMake(startXPos, startYPos, fullWidth, fullHeight);
    self.title.frame = CGRectMake(startXPos, fullHeight - 70, fullWidth, 50);
    
    self.loadingBar.frame = CGRectMake(0, 0, 50, 30);
}

@end
