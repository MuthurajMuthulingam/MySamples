//
//  SuggestionView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"

@class SuggestionView;

@protocol suggestionViewDelegate <NSObject>

- (void)suggestionView:(SuggestionView *)suggestionView addButtonClicked:(UIButton *)addAtireBtn;
- (void)suggestionView:(SuggestionView *)suggestionView bookmarkButtonClicked:(UIButton *)bookmarkButton andSeletedAttirePairDict:(NSDictionary *)selectedAttirePairDict;
- (void)suggestionView:(SuggestionView *)suggestionView dislikeButtonClicked:(UIButton *)dislikeButton andSeletedAttirePairDict:(NSDictionary *)selectedAttirePairDict;
- (void)suggestionView:(SuggestionView *)suggestionView selectedAttire:(NSDictionary *)selectedAttire;

@end

@interface SuggestionView : BaseView

@property (nonatomic,weak) id<suggestionViewDelegate>suggestionViewdelegate;

- (void)showNoAttireView:(BOOL)isShow;
- (void)updateViewWithData:(NSArray *)attiresList;
@end
