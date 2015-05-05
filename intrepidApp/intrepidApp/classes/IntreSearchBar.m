//
//  IntreSearchBar.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/13/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "IntreSearchBar.h"

@implementation IntreSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self setBackgroundColor:APP_SEARCH_COLOR];
    [self setText:@"Tap to Search"];
    [self setTextColor:[UIColor colorWithRed:0.19 green:0.25 blue:0.29 alpha:1]];
    [self setTintColor:[UIColor colorWithRed:0.19 green:0.25 blue:0.29 alpha:1]];
    [self setFont: [UIFont fontWithName:@"ProximaNova-Regular" size:17]];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self setReturnKeyType:UIReturnKeyDone];
    self.alpha = 0.9;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 50, bounds.origin.y+2, bounds.size.width - 90, bounds.size.height-2);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 50, bounds.origin.y+2, bounds.size.width - 90, bounds.size.height-2);
    return inset;
}


@end
