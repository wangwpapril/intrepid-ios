//
//  TripCell.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationEntity.h"

@interface TripCell : UITableViewCell

-(void)setupWithTripItem:(DestinationEntity *)destination;

@end