//
//  OverViewViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SliderTabViewController.h"

@interface OverViewViewController : SliderTabViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSArray *currencyArray;

@end