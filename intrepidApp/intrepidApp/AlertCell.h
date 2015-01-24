//
//  AlertCell.h
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-01-23.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertEntity.h"

@interface AlertCell : UITableViewCell

-(void)setupWithAlert:(AlertEntity *)alert;

@end
