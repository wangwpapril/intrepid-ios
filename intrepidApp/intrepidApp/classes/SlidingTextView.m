//
//  SlidingTextView.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SlidingTextView.h"
#import "QuartzCore/QuartzCore.h"
#import "Constants.h"

@implementation SlidingTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setupWithImageName:(NSString *)image withTitle:(NSString *)title withIconName:(NSString *)icon {
    
    // top image
    UIImageView  *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.frame = CGRectMake(0, 0, 320, 268);
    [self addSubview:imageView];
    
    // title background
    UIView *borderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 268, 320, 40)];
    borderLine.layer.borderColor = [UIColor colorWithRed:231.0/255 green:238.0/255 blue:226.0/255 alpha:1].CGColor;
    borderLine.layer.borderWidth = 1;
    
    // actual title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 0, 159, 40)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    titleLabel.textColor = APP_TEXT_COLOR;
    [borderLine addSubview:titleLabel];
    [self addSubview:borderLine];
    
    // icon
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    iconView.frame = CGRectMake(14, 275, 25, 25);
    [self addSubview:iconView];
}

-(void) addTextArea {
    // text
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 308,  320, self.bounds.size.height - 308)];
    textView.userInteractionEnabled = NO;
    textView.textColor = APP_TEXT_COLOR;
    textView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    [self addSubview:textView];
}

@end