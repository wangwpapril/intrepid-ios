//
//  HealthSearchBar.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/9/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthSearchBar.h"

@implementation HealthSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setShowsCancelButton:NO animated:NO];
    
//    UITextField *cancelSearchButton = [self.subviews objectAtIndex:1];
//    UIButton *cButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cButton.frame = CGRectMake(0, 0, 20 , 20);
//    cButton.backgroundColor = [UIColor clearColor];
//    [cButton setImage:[UIImage imageNamed:@"cancel-search.png"] forState:UIControlStateNormal];//your button image.
//    cButton.contentMode = UIViewContentModeScaleToFill;
//    [cButton addTarget:self action:@selector(xButtonPressed) forControlEvents:UIControlEventTouchUpInside];//This is the custom event
//    [cancelSearchButton setRightView:cButton];
//    [cancelSearchButton setRightViewMode:UITextFieldViewModeAlways];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
