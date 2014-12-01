//
//  HealthViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"
#import "HealthItem.h"
#import "IntreSearchBar.h"
#import "ScrollerTabViewController.h"


@interface HealthViewController : ScrollerTabViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *tableArray;
@property (strong,nonatomic) NSMutableArray *filteredHealthItemArray;
@property (nonatomic, strong) IntreSearchBar * searchBar;
@property (nonatomic, strong) UIButton *xButton;
@property (nonatomic, strong) HealthItem *selectedItem;

@end
