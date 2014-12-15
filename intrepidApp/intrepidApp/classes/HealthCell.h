//
//  HealthCell.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthEntity.h"

@interface HealthCell : UITableViewCell

@property (nonatomic, strong) UIImageView *commonImage;


-(void)setupWithHealthItem:(HealthEntity *)healthItem;

@end
