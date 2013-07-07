//
//  HealthViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *tabArray;
@property (nonatomic, strong) NSMutableArray *tableArray;
//@property (nonatomic, strong) UITableView *table;
@property (nonatomic) NSInteger currentTab;
@property (nonatomic) NSInteger previousTab;
//
//@property (nonatomic, strong) UITableView *conditionsTable;
//@property (nonatomic, strong) UITableView *symptomsTable;
//@property (nonatomic, strong) UITableView *medicationsTable;


@end
