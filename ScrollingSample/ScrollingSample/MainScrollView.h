//
//  MainScrollView.h
//  ScrollingSample
//
//  Created by Muthuraj M on 1/30/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *horizontalScrollView;
@property (nonatomic,strong) UIScrollView *verticalScrollView;

@end
