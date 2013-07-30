//
//  TripCell.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripItem.h" 

@interface TripCell : UITableViewCell

@property (nonatomic, strong) UIImageView *tripImage;
@property (nonatomic, strong) UILabel *continentLabel;


-(void)setupWithHealthItem:(TripItem *)tripItem;
@end
