//
//  SlidingTextView.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SlidingTextView.h"
#import "QuartzCore/QuartzCore.h"
#import "UIImageView+WebCache.h"
#import "TripManager.h"
#import "DestinationEntity.h"

@implementation SlidingTextView

//@synthesize scroll;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (void)setupWithImageName1x:(NSString *)image1x withImageName2x:(NSString *)image2x withImageName3x:(NSString *)image3x withTitle:(NSString *)title withIconName:(NSString *)icon {
    
//    CGRect rect=CGRectMake(0, 0, 320, 480);
    scroll = [[UIScrollView alloc] initWithFrame:self.frame];
    scroll.showsVerticalScrollIndicator = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.scrollEnabled = YES;
    
    // top image
    UIImageView  *imageView = [[UIImageView alloc] init];
    double scaleFactor = [UIScreen mainScreen].scale;
    if (scaleFactor > 2.9 && ![image3x isEqualToString:@""]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:image3x]];
    } else if (![image2x isEqualToString:@""]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:image2x]];
    } else if (![image1x isEqualToString:@""]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:image1x]];
    } else {
        imageView.image = [UIImage imageNamed:@"overview-currency"];
    }
    
    imageView.frame = CGRectMake(0, 0, 320, 268);
    [scroll addSubview:imageView];

/*
     title background
    UIView *borderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 268, 320, 40)];
    borderLine.layer.borderColor = [UIColor colorWithRed:231.0/255 green:238.0/255 blue:226.0/255 alpha:1].CGColor;
    borderLine.layer.borderWidth = 1;
    
     actual title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 0, 159, 40)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-SemiBold" size:17];
    titleLabel.textColor = APP_TEXT_COLOR;
    [borderLine addSubview:titleLabel];
    [scroll addSubview:borderLine];
    
     icon
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    iconView.frame = CGRectMake(14, 275, 25, 25);
    [scroll addSubview:iconView];
 */
    
    [self addSubview:scroll];
}

- (void)addTableViewWithRows:(NSInteger)rows withTableView:(UITableView *)tableView {
    NSInteger height = 45 * rows;
    tableView.scrollEnabled = NO;
    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, 320, height);
    [self addSubview:tableView];
    self.contentSize = CGSizeMake(320, 330 + height); // was 308
}

- (void)addTextAreaWithText:(NSArray *)text {
    int y = 273;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    for (id section in text) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:section[2]]];
        imageView.frame = CGRectMake(14, y + 4, 25, 25);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, y + 5, 250, 25)];
        label.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = APP_TEXT_COLOR;
        label.text = section[0];
        
        NSString *content = section[1];
        CGSize size = [content boundingRectWithSize:CGSizeMake(290, 15000)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                            context:nil].size;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 290, size.height + 5)];
        textLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:16];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = APP_TEXT_COLOR;
        textLabel.text = content;
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.numberOfLines = 0;
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, y + 35, 320, size.height + 15)];
        containerView.layer.borderWidth = 1.0f;
        containerView.layer.borderColor = APP_BORDER_COLOR;
        containerView.backgroundColor = [UIColor clearColor];
        
        [scroll addSubview:imageView];
        [scroll addSubview:label];
        [containerView addSubview:textLabel];
        [scroll addSubview:containerView];
        y = containerView.frame.origin.y + size.height + 20;
    }
    
    scroll.contentSize = CGSizeMake(320, y + 80);
}

- (void)addCurrencyWithCity:(CityEntity *)city {
    TripManager *manager = [TripManager getInstance];
    self.currency = [manager getCurrencyItemWithCity:city];
    
    if (self.currency) {
        self.userField = [[UITextField alloc] initWithFrame:CGRectMake(160, 293, 125, 50)];
        self.userField.borderStyle = UITextBorderStyleRoundedRect;
        self.userField.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:22];
        self.userField.textColor = APP_TEXT_COLOR;
        self.userField.textAlignment = NSTextAlignmentCenter;
        self.userField.tintColor = APP_TEXT_COLOR;
        self.userField.keyboardType = UIKeyboardTypeDecimalPad;
        self.userField.delegate = self.parentViewController;
        self.userField.text = @"1.00";
        [self.userField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [scroll addSubview:self.userField];
        
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 293, 50, 50)];
        userImageView.layer.cornerRadius = 5;
        userImageView.layer.masksToBounds = YES;
//        userImageView.layer.borderWidth = 1.0f;
//        userImageView.layer.borderColor = APP_BORDER_COLOR;
        [scroll addSubview:userImageView];
        
        DestinationEntity *destination = [manager getDestinationItemWithCurrencyCode:manager.currentUser[@"user"][@"currency_code"]];
        if (destination) {
            double scaleFactor = [UIScreen mainScreen].scale;
            if (scaleFactor > 2.9 && ![destination.currencyImage3x isEqualToString:@""]) {
                [userImageView sd_setImageWithURL:[NSURL URLWithString:destination.currencyImage3x] placeholderImage:[UIImage imageNamed:@"unused"]];
            } else if (![destination.currencyImage2x isEqualToString:@""]) {
                [userImageView sd_setImageWithURL:[NSURL URLWithString:destination.currencyImage2x] placeholderImage:[UIImage imageNamed:@"unused"]];
            } else if (![destination.currencyImage1x isEqualToString:@""]) {
                [userImageView sd_setImageWithURL:[NSURL URLWithString:destination.currencyImage1x] placeholderImage:[UIImage imageNamed:@"unused"]];
            } else {
                userImageView.image = [UIImage imageNamed:@"unused"];
            }
        } else {
            userImageView.image = [UIImage imageNamed:@"unused"];
        }
        
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 293, 50, 50)];
        userLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
        userLabel.textColor = APP_TEXT_COLOR;
        userLabel.text = manager.currentUser[@"user"][@"currency_code"];
        [scroll addSubview:userLabel];

        
        
        self.tripField = [[UITextField alloc] initWithFrame:CGRectMake(160, 365, 125, 50)];
        self.tripField.borderStyle = UITextBorderStyleRoundedRect;
        self.tripField.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:22];
        self.tripField.textColor = APP_TEXT_COLOR;
        self.tripField.textAlignment = NSTextAlignmentCenter;
        self.tripField.tintColor = APP_TEXT_COLOR;
        self.tripField.keyboardType = UIKeyboardTypeDecimalPad;
        self.tripField.delegate = self.parentViewController;
        self.tripField.text = [NSString stringWithFormat:@"%.2f", self.currency.value.floatValue];
        [self.tripField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [scroll addSubview:self.tripField];
        
        UIImageView *tripImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 365, 50, 50)];
        tripImageView.layer.cornerRadius = 5;
        tripImageView.layer.masksToBounds = YES;
//        tripImageView.layer.borderWidth = 1.0f;
//        tripImageView.layer.borderColor = APP_BORDER_COLOR;
        [scroll addSubview:tripImageView];
        
        DestinationEntity *destination2 = [manager getDestinationItemWithCurrencyCode:self.currency.country];
        if (destination2) {
            double scaleFactor = [UIScreen mainScreen].scale;
            if (scaleFactor > 2.9 && ![destination2.currencyImage3x isEqualToString:@""]) {
                [tripImageView sd_setImageWithURL:[NSURL URLWithString:destination2.currencyImage3x] placeholderImage:[UIImage imageNamed:@"unused"]];
            } else if (![destination2.currencyImage2x isEqualToString:@""]) {
                [tripImageView sd_setImageWithURL:[NSURL URLWithString:destination2.currencyImage2x] placeholderImage:[UIImage imageNamed:@"unused"]];
            } else if (![destination2.currencyImage1x isEqualToString:@""]) {
                [tripImageView sd_setImageWithURL:[NSURL URLWithString:destination2.currencyImage1x] placeholderImage:[UIImage imageNamed:@"unused"]];
            } else {
                tripImageView.image = [UIImage imageNamed:@"unused"];
            }
        } else {
            tripImageView.image = [UIImage imageNamed:@"unused"];
        }
        
        UILabel *tripLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 375, 50, 30)];
        tripLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
        tripLabel.textColor = APP_TEXT_COLOR;
        tripLabel.text = self.currency.country;
        [scroll addSubview:tripLabel];
        
        scroll.contentSize = CGSizeMake(320, 500);
    }
}
- (void)textFieldDidChange:(id)sender {
    if (sender == self.userField) {
        self.tripField.text = [NSString stringWithFormat:@"%.2f", self.userField.text.floatValue * self.currency.value.floatValue];
    } else if (sender == self.tripField) {
        self.userField.text = [NSString stringWithFormat:@"%.2f", self.tripField.text.floatValue * (1/self.currency.value.floatValue)];
    }
}

@end
