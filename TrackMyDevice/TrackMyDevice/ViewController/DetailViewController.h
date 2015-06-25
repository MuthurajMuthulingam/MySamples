//
//  DetailViewController.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "BaseViewController.h"
#import "Journey.h"

@interface DetailViewController : BaseViewController

@property (nonatomic,strong) Journey *journey;

@end
