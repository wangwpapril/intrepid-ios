//
//  HealthViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"
#import "HealthSearchBar.h"

@interface HealthViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *tabArray;
@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic) NSInteger currentTab;
@property (nonatomic) NSInteger previousTab;

@property (strong,nonatomic) NSArray *healthItemArray;
@property (strong,nonatomic) NSMutableArray *filteredHealthItemArray;
@property IBOutlet HealthSearchBar *healthItemSearchBar;

//
//@property (nonatomic, strong) UITableView *conditionsTable;
//@property (nonatomic, strong) UITableView *symptomsTable;
//@property (nonatomic, strong) UITableView *medicationsTable;


@property (nonatomic, strong) MenuController *mController;

@end
