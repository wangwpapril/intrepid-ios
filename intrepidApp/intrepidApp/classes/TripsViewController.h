//
//  TripsViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MenuController.h"
#import "IntreSearchBar.h"

@interface TripsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableList;
@property (strong, nonatomic) NSMutableArray *tripsArray;
@property (strong, nonatomic) NSMutableArray *filteredArray;
@property (nonatomic, strong) IntreSearchBar * searchBar;
@property (nonatomic, strong) UIButton *xButton;
@property (nonatomic, strong) NSMutableArray *cities;
@end