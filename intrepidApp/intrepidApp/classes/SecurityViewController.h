//
//  SecurityViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "ScrollerTabViewController.h"
#import "EmbassyDetailedViewController.h"
#import "EmbassyItem.h"

@interface SecurityViewController : ScrollerTabViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSArray *embassyArray;

@end
