//
//  ImageViewCell.h
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ImageViewCell : SWTableViewCell

- (void)updateViewsWithData:(NSDictionary *)imageDetails;

@end
