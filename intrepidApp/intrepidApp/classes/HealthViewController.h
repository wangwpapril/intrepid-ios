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


@interface HealthViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *largeLetterArray;
@property (nonatomic, strong) NSMutableArray *tabArray;
@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic) NSInteger currentTab;
@property (nonatomic) NSInteger previousTab;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) MenuController *mController;

@property (strong,nonatomic) NSArray *healthItemArray;
@property (strong,nonatomic) NSMutableArray *filteredHealthItemArray;
@property (nonatomic, strong) IntreSearchBar * searchBar;
@property (nonatomic, strong) HealthItem *selectedItem;

@property (nonatomic, strong) IBOutlet UILabel *navLabelC;
@property (nonatomic, strong) IBOutlet UILabel *navLabelS;
@property (nonatomic, strong) IBOutlet UILabel *navLabelM;


@end
