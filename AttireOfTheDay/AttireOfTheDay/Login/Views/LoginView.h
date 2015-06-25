//
//  LoginView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"

@class LoginView;

@protocol LoginViewDelegate <NSObject>

- (void)loginView:(LoginView *)loginView loginButonCliked:(UIButton *)loginButton;

@end

@interface LoginView : BaseView

@property (nonatomic,weak)id<LoginViewDelegate>loginViewDelegate;

@end
