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
    }
    return self;
}


- (void) drawPlaceholderInRect:(CGRect)rect {
    [[UIColor blueColor] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:16]];
}


@end
