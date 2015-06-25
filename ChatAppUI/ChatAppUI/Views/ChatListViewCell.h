//
//  ChatListViewCell.h
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ChatListViewCell : UITableViewCell

- (void)updateViewsWithData:(NSDictionary *)dataDict;

@end
