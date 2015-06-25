//
//  LoginView.h
//  DesignTest
//
//  Created by Muthuraj M on 6/3/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@protocol LoginViewDelegate <NSObject>

-(void)loginView:(LoginView *)loginView loginBtnClicked:(UIButton *)clickedButton;

@end

@interface LoginView : UIView

@property (nonatomic,weak) id<LoginViewDelegate>delegate;

@end
