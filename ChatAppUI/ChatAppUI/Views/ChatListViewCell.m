//
//  ChatListViewCell.m
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ChatListViewCell.h"
#import "UILabel+MyLabel.h"

@interface ChatListViewCell ()

@property (nonatomic,strong) UILabel *userNameLabel,*messageLabel,*timeSecondsLabel;
@property (nonatomic,strong) UIView *backgroundViewForCell,*circleView;
@property (nonatomic,strong) UIImageView *cellImageView;

@end

@implementation ChatListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    
    return self;
}

- (void)createViews {
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.backgroundViewForCell = [[UIView alloc] init];
    self.backgroundViewForCell.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backgroundViewForCell];
    
    self.cellImageView = [[UIImageView alloc] init];
    self.cellImageView.backgroundColor = [UIColor redColor];
    self.cellImageView.clipsToBounds = YES;
    [self.backgroundViewForCell addSubview:self.cellImageView];
    
    self.userNameLabel = [[UILabel alloc] initWithText:@"" textColor:[UIColor blackColor] textAlginMnet:NSTextAlignmentLeft font:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.backgroundViewForCell addSubview:self.userNameLabel];
    
    self.messageLabel = [[UILabel alloc] initWithText:@"" textColor:[UIColor blackColor] textAlginMnet:NSTextAlignmentLeft font:[UIFont fontWithName:@"Helvetica" size:16]];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.adjustsFontSizeToFitWidth =YES;
    [self.backgroundViewForCell addSubview:self.messageLabel];
    
    self.timeSecondsLabel = [[UILabel alloc] initWithText:@"" textColor:[UIColor grayColor] textAlginMnet:NSTextAlignmentLeft font:[UIFont fontWithName:@"Helvetica" size:14]];
    [self.backgroundViewForCell addSubview:self.timeSecondsLabel];
    
    self.circleView = [[UIView alloc] init];
    self.circleView.alpha = 0.5;
    self.circleView.layer.cornerRadius = 5;
    self.circleView.backgroundColor = [UIColor blueColor];
    [self.backgroundViewForCell addSubview:self.circleView];
}

- (void)updateViewsWithData:(NSDictionary *)dataDict {
    
    NSDictionary *subDict = [dataDict objectForKey:@"latestMessage"];
    
    self.userNameLabel.text = [subDict objectForKey:@"fromUserDisplayName"] ? [subDict objectForKey:@"fromUserDisplayName"]:@"";
    self.messageLabel.text = [subDict objectForKey:@"message"] ? [subDict objectForKey:@"message"]:@"";
    
    NSString *dateString = [subDict objectForKey:@"msgDate"];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"TZ"];
    dateString = [[dateString componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @" "];
    
    self.timeSecondsLabel.text = dateString ? dateString:@"";
    
    [self findTimeIntervalinHoursFromDate:dateString];
    NSLog(@"msgread %@",[subDict objectForKey:@"msgRead"]);
    
    self.circleView.hidden = ([[subDict objectForKey:@"msgRead"] intValue] == 0) ? NO:YES;
}

- (void)findTimeIntervalinHoursFromDate:(NSString *)timeString {
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    // Set the date format according to your needs
    //[df setDateFormat:@"MM/dd/YYYY hh:mm a"]; //for 12 hour format
    [df setDateFormat:@"MM/dd/YYYY HH:mm "];  // for 24 hour format
    NSDate *currentDate = [NSDate date];
    NSDate *timeToCheck = [df dateFromString:timeString];
    NSTimeInterval distanceBetweenDates = [timeToCheck timeIntervalSinceDate:currentDate];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    NSLog(@"time Integre %ld",(long)hoursBetweenDates);
    
    //return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundViewForCell.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 20);
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.backgroundViewForCell.frame.size.width - (startXPos*2 + 30);
    float fullHeight = self.backgroundViewForCell.frame.size.height - (startYPos*2);
    
    self.cellImageView.frame = CGRectMake(startXPos, startYPos, 100, 100);
    self.cellImageView.layer.cornerRadius = 50.0;
    self.userNameLabel.frame = CGRectMake((self.cellImageView.frame.origin.x + self.cellImageView.frame.size.width + 5), startYPos, fullWidth - (self.cellImageView.frame.origin.x + self.cellImageView.frame.size.width + 5), fullHeight / 3);
    self.messageLabel.frame = CGRectMake((self.cellImageView.frame.origin.x + self.cellImageView.frame.size.width + 5), self.userNameLabel.frame.size.height + self.userNameLabel.frame.origin.y, fullWidth - (self.cellImageView.frame.origin.x + self.cellImageView.frame.size.width + 5), fullHeight / 3);
    self.timeSecondsLabel.frame = CGRectMake((self.cellImageView.frame.origin.x + self.cellImageView.frame.size.width + 5), self.messageLabel.frame.size.height + self.messageLabel.frame.origin.y, fullWidth - (self.cellImageView.frame.origin.x + self.cellImageView.frame.size.width + 5), fullHeight / 3);
    
    self.circleView.frame = CGRectMake(fullWidth + 5, fullHeight / 2, 10, 10);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
