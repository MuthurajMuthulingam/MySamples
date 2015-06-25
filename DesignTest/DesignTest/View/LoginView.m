//
//  LoginView.m
//  DesignTest
//
//  Created by Muthuraj M on 6/3/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "LoginView.h"
#import "UILabel+MyLabel.h"
#import "UIView+MyView.h"
#import "UIButton+MyButton.h"

#define commonFontName @"Comfortaa"
#define commonBoldFontName @"Comfortaa-Bold"
#define helVeticaFontName @"Helvetica"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginView ()

@property (nonatomic,strong) UILabel *aisleLabel,*termsLabel,*toTheNewBeginningsLabel,*neverPostLavel,*orLabel;
@property (nonatomic,strong) UIView *underLineView;
@property (nonatomic,strong) UIButton *login_FB,*login_LinkedIn;
@property (nonatomic,strong) UIImageView *backgroundImage;

@end

@implementation LoginView

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
    self.backgroundImage = [[UIImageView alloc] init];
    self.backgroundImage.alpha = 0.5;
    self.backgroundImage.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.backgroundImage];
    
    self.aisleLabel = [[UILabel alloc] initWithText:@"aisle" alignMent:NSTextAlignmentCenter font:[UIFont fontWithName:commonBoldFontName size:40] textColor:UIColorFromRGB(0xDAD6D5)];
    [self addSubview:self.aisleLabel];
    
    self.underLineView = [[UIView alloc] initWithBackgroundColor:UIColorFromRGB(0x969495)];
    [self addSubview:self.underLineView];
    
    self.toTheNewBeginningsLabel = [[UILabel alloc] initWithText:@"to new beginnings." alignMent:NSTextAlignmentCenter font:[UIFont fontWithName:helVeticaFontName size:14] textColor:UIColorFromRGB(0xDAD6D5)];
    [self addSubview:self.toTheNewBeginningsLabel];
    
    self.login_FB = [[UIButton alloc] initWithTitleText:@"Login with Facebook" titleColor:[UIColor whiteColor] backgroundColor:UIColorFromRGB(0x3B5999)];
    self.login_FB.layer.cornerRadius = 2.0;
    self.login_FB.layer.masksToBounds = YES;
    [self.login_FB addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.login_FB];
    
    self.orLabel = [[UILabel alloc] initWithText:@"Or" alignMent:NSTextAlignmentCenter font:[UIFont fontWithName:helVeticaFontName size:14] textColor:UIColorFromRGB(0xDAD6D5)];
    [self addSubview:self.orLabel];
    
    self.login_LinkedIn = [[UIButton alloc] initWithTitleText:@"Login with Linkedin" titleColor:[UIColor whiteColor] backgroundColor:UIColorFromRGB(0x007BB6)];
    self.login_LinkedIn.layer.cornerRadius = 2.0;
    self.login_LinkedIn.layer.masksToBounds = YES;
    [self.login_LinkedIn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.login_LinkedIn];
    
    self.neverPostLavel = [[UILabel alloc] initWithText:@"We will never post on your wall." alignMent:NSTextAlignmentCenter font:[UIFont fontWithName:helVeticaFontName size:14] textColor:UIColorFromRGB(0x969495)];
    [self addSubview:self.neverPostLavel];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Terms & Privacy"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    self.termsLabel = [[UILabel alloc] initWithText:@"" alignMent:NSTextAlignmentCenter font:[UIFont fontWithName:helVeticaFontName size:14] textColor:UIColorFromRGB(0x969495)];
    self.termsLabel.attributedText = attributeString;
    [self addSubview:self.termsLabel];
}

- (void)btnClicked:(UIButton *)sender
{
    [self.delegate loginView:self loginBtnClicked:sender];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    float startXPos = 40;
    float startYPos = 0;
    float fullWidth = self.frame.size.width - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.aisleLabel.frame = CGRectMake(startXPos, fullHeight*0.3, fullWidth, 50);
    self.underLineView.frame = CGRectMake(startXPos*4, self.aisleLabel.frame.size.height + self.aisleLabel.frame.origin.y + 5, fullWidth / 5, 0.5);
    self.toTheNewBeginningsLabel.frame = CGRectMake(startXPos,self.underLineView.frame.size.height + self.underLineView.frame.origin.y, fullWidth, 50);
    
    self.login_FB.frame = CGRectMake(startXPos, self.toTheNewBeginningsLabel.frame.size.height + self.toTheNewBeginningsLabel.frame.origin.y + 20, fullWidth, 50);
    self.orLabel.frame = CGRectMake(startXPos, self.login_FB.frame.size.height + self.login_FB.frame.origin.y , fullWidth, 30);
    self.login_LinkedIn.frame = CGRectMake(startXPos, self.orLabel.frame.size.height + self.orLabel.frame.origin.y, fullWidth, 50);
    
    self.neverPostLavel.frame = CGRectMake(startXPos, self.login_LinkedIn.frame.size.height + self.login_LinkedIn.frame.origin.y, fullWidth, 30);
    
    self.termsLabel.frame = CGRectMake(startXPos, fullHeight - 60, fullWidth, 50);
    
}

@end
