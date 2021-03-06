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
#import "AlertCell.h"

@interface AlertsViewController ()

@end

@implementation AlertsViewController

@synthesize tableList;
@synthesize alertsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 3;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    tableList.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableList];
    tableList.delegate = self;
    tableList.dataSource = self;
    
    CityEntity *currentCity = [MenuController getInstance].city;
    alertsArray = [[TripManager getInstance] getAlertItemsWithCity:currentCity];
    if (alertsArray.count < 1) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 50)];
        titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:18];
        titleLabel.textColor = APP_TEXT_COLOR;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"No recent alerts.";
        [self.view addSubview:titleLabel];
    } else {
        [tableList reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"Alerts"];
    
    [[MenuController getInstance] displayMenuWithParent:self];
}

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return alertsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    AlertCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[AlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    AlertEntity *alert = alertsArray[indexPath.row];
    [cell setupWithAlert:alert];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    AlertEntity *alert = alertsArray[indexPath.row];    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    height = [alert.text boundingRectWithSize:CGSizeMake(290, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Regular" size:15]}
                                           context:nil].size.height;
    if (height < 25) {
        height = 25;
    }
    return height + 90;
}

@end
