//
//  HealthCell.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthItem.h"

@interface HealthCell : UITableViewCell


-(void)setupWithHealthItem:(HealthItem *)healthItem;

@end
