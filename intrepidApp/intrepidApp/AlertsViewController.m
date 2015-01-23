//
//  AlertsViewController.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-01-23.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "AlertsViewController.h"
#import "MenuController.h"
#import "TripManager.h"

@interface AlertsViewController ()

@end

@implementation AlertsViewController

@synthesize mController;
@synthesize tableList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 6;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:tableList];
    tableList.delegate = self;
    tableList.dataSource = self;
//    [self.view addSubview:tableList];
    
    [self addContent];
}

- (void)viewWillAppear:(BOOL)animated {
    mController = [MenuController getInstance];
    [mController displayMenuWithParent:self];
}

- (void)addContent {
    self.alertsArray = [NSMutableArray new];
    
    TripManager *manager = [TripManager getInstance];
//    NSArray *alerts = [manager getAlerts];
    
//    for (DestinationEntity *destination in destinations) {
//        TripItem *trip = [[TripItem alloc] init];
//        trip.city = destination.name;
//        trip.destinationId = destination.destinationId;
//        trip.continent = @"Europe";
//        trip.image = @"Guada-icon.png";
//        [tripsArray addObject:trip];
//    }
    [tableList reloadData];
}

@end
