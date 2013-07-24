//
//  IntreSearchBar.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/13/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "IntreSearchBar.h"
#import "Constants.h"

@implementation IntreSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//- (void) drawPlaceholderInRect:(CGRect)rect {
//    [APP_TEXT_COLOR setFill];
//    [[self placeholder] drawInRect:rect withFont:[UIFont fontWithName:@"ProximaNova-Light" size:16]];
//}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 25, bounds.origin.y+2, bounds.size.width - 25, bounds.size.height-2);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 25, bounds.origin.y+2, bounds.size.width - 25, bounds.size.height-2);
    return inset;
}


@end
