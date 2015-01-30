//
//  SlidingTextView.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverViewViewController.h"
#import "CityEntity.h"
#import "CurrencyEntity.h"

@interface SlidingTextView : UIScrollView {
    UIScrollView *scroll;
}

//@property (nonatomic, strong) UIScrollView *scroll;
@property (strong, nonatomic) OverViewViewController *parentViewController;
@property (strong, nonatomic) UITextField *userField;
@property (strong, nonatomic) UITextField *tripField;
@property (strong, nonatomic) CurrencyEntity *currency;

- (void)setupWithImageName1x:(NSString *)image1x withImageName2x:(NSString *)image2x withImageName3x:(NSString *)image3x withTitle:(NSString *)title withIconName:(NSString *)icon;
- (void)addTableViewWithRows:(NSInteger)rows withTableView:(UITableView *)tableView;
- (void)addTextAreaWithText:(NSArray *)text;
- (void)addCurrencyWithCity:(CityEntity *)city;

@end
