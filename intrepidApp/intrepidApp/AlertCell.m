//
//  AlertCell.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-01-23.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "AlertCell.h"

@implementation AlertCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // arrow
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {

}

- (void)setupWithAlert:(AlertEntity *)alert {
    
}

@end
