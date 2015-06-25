//
//  CustomTableViewCell.m
//  ImagewithTableview
//
//  Created by Muthuraj M on 11/15/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell()

@property (nonatomic,strong) UIImageView *imageViewforCell;
//@property (nonatomic,strong) NSMutableDictionary *imageDict;

@end

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       [self createViews];
    }
    return self;
}

- (void)awakeFromNib
{
    
}

- (void)createViews
{
    //self.imageDict = [[NSMutableDictionary alloc] init];
    
    self.imageViewforCell = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageViewforCell.backgroundColor = [UIColor greenColor];
    [self addSubview:self.imageViewforCell];
}

- (void)updateImageView:(NSURL *)imageURL
{
    self.imageViewforCell.image = nil;
    
//    if ([self.imageDict objectForKey:[imageURL absoluteString]])
//    {
//        self.imageViewforCell.image = (UIImage *)[self.imageDict objectForKey:[imageURL absoluteString]];
//    }
    //else
   // {
        [self loadImageFromURL:imageURL];
   // }
}

- (void)loadImageFromURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20.0];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        UIImage *image = [UIImage  imageWithData:data];
        //[self.imageDict setObject:image forKey:[url absoluteString]];
        NSLog(@"image %@",image);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageViewforCell.image = image;
            NSLog(@"imageView %@",self.imageViewforCell);
        });
    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
