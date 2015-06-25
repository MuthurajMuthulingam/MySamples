//
//  RestaurentDetailsView.h
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/17/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface RestaurentDetailsView : BaseView<UITableViewDelegate,UITableViewDataSource>

- (void)updateTableWithData:(NSDictionary *)dataDict andSortedKeys:(NSArray *)sortedKeys;

@end
