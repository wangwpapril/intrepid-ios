//
//  HealthViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "HealthCell.h"
#import "MenuController.h"
#import "HealthViewDetailController.h"
#import "RequestBuilder.h"
#import "TripManager.h"
#import "SlidingTextView.h"

@implementation HealthViewController

@synthesize contentArray;
@synthesize tableArray;
@synthesize selectedItem;
@synthesize filteredHealthItemArray;
@synthesize searchBar;
@synthesize spyGlass;
@synthesize xButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
            
    self.view.tag = 1;
    [self populateContentArray];
    
    tableArray = [NSMutableArray new];
    int i = 0;
    while (i < 2) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
        [tableArray addObject:table];
        i++;
    }
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    CityEntity *city = [self getCity];
    
    SlidingTextView *medical = [[SlidingTextView alloc] initWithFrame:frame];
    [medical setupWithImageName1x:city.medicalImage1x withImageName2x:city.medicalImage2x withImageName3x:city.medicalImage3x withTitle:@"Medical"];
    NSMutableArray *medicalArray = [NSMutableArray new];
    if (city.healthCareQuality) {
        [medicalArray addObject:@[@"Health Care Quality", city.healthCareQuality, @"healthcare-icon"]];
    }
    if (city.vaccinationsAndPreTripMedical) {
        [medicalArray addObject:@[@"Vaccines and Pre-trip Medical", city.vaccinationsAndPreTripMedical, @"vaccines-icon"]];
    }
    if (city.healthConditions) {
        [medicalArray addObject:@[@"Health Conditions", city.healthConditions, @"conditions-icon"]];
    }
    [medical addTextAreaWithText:medicalArray];
    
    [tableArray addObject:medical];
    
    [self addViews:tableArray withVerticalOffset:0 withTableOffset:79];
    [self addIntreSearchBar];
    
    NSArray *names = [NSArray arrayWithObjects:@"CONDITIONS", @"MEDICATIONS", @"MEDICAL", nil];
    [self addTabs:names];
    
    self.navigationItem.title = @"Health";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self viewSwitched];
    NSLog(@"%@", searchBar.text);
}

- (void)viewSwitched {
    if (self.currentTab == 0) {
        searchBar.hidden = NO;
        spyGlass.hidden = NO;
        xButton.hidden = NO;
        [[SEGAnalytics sharedAnalytics] screen:@"Conditions"];
        [self deleteText];
    } else if (self.currentTab == 1) {
        searchBar.hidden = NO;
        spyGlass.hidden = NO;
        xButton.hidden = NO;
        [[SEGAnalytics sharedAnalytics] screen:@"Medications"];
        [self deleteText];
    } else if (self.currentTab == 2) {
        searchBar.hidden = YES;
        spyGlass.hidden = YES;
        xButton.hidden = YES;
        [searchBar resignFirstResponder];
    }
}

# pragma mark - UI Setup

- (void)addIntreSearchBar {
    searchBar = [[IntreSearchBar alloc] initWithFrame:CGRectMake(0, 35, 320, 44)];
    [searchBar addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:searchBar];
    searchBar.delegate = self;
    
    spyGlass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spyGlass"]];
    spyGlass.frame = CGRectMake(20, 49, 18, 18);
    [self.view addSubview:spyGlass];
    
    xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"cancel-search"] forState:UIControlStateNormal];
    xButton.frame = CGRectMake(270, 35, 44, 44);
    [xButton addTarget:self action:@selector(deleteText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xButton];
    xButton.alpha = 0;
}

#pragma mark - Content Handling

- (void)populateContentArray {
    CityEntity * currentCity = [MenuController getInstance].city;
    contentArray = [[TripManager getInstance] getHealthItemsWithCity:currentCity];
    
    self.filteredHealthItemArray = [NSMutableArray new];
}

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger fCount = filteredHealthItemArray.count;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        NSLog(@"fcount: %li, searhbartext: %@", (long)fCount, searchBar.text);
        
        return fCount;
    } else {
        NSLog(@"total count: %lu", (unsigned long)[[contentArray objectAtIndex:self.currentTab] count]);
        return [[contentArray objectAtIndex:self.currentTab] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    HealthCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[HealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    HealthEntity *healthItem = nil;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        healthItem = [filteredHealthItemArray objectAtIndex:indexPath.row];
    } else {
        healthItem = [[contentArray objectAtIndex:self.currentTab] objectAtIndex:indexPath.row];
    }
    
    [cell setupWithHealthItem:healthItem];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        selectedItem = (HealthEntity *)[filteredHealthItemArray objectAtIndex:indexPath.row];
    }
    else {
        selectedItem = (HealthEntity *)[[contentArray objectAtIndex:self.currentTab] objectAtIndex:indexPath.row];
    }
    HealthViewDetailController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"healthDetails"];
    viewController.healthItem = selectedItem;
    
    if (self.currentTab == 0) {
        [[SEGAnalytics sharedAnalytics] track:@"Visit Health Detail"
                                   properties:@{@"category" : @"Conditions",
                                                @"label" : selectedItem.name}];
    } else if (self.currentTab == 1) {
        [[SEGAnalytics sharedAnalytics] track:@"Visit Health Detail"
                                   properties:@{@"category" : @"Medications",
                                                @"label" : selectedItem.name}];
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
    [self deleteText];
}

#pragma mark Content Filtering

- (void)filterContent {
    if (self.currentTab == 0) {
        [[SEGAnalytics sharedAnalytics] track:@"Keyword"
                                   properties:@{@"category" : @"Conditions",
                                                @"label" : searchBar.text}];
    } else if (self.currentTab == 1) {
        [[SEGAnalytics sharedAnalytics] track:@"Keyword"
                                   properties:@{@"category" : @"Medications",
                                                @"label" : searchBar.text}];
    }
    
    [self.filteredHealthItemArray removeAllObjects];
    
    if (self.currentTab == 0 || self.currentTab == 1) {
        // Filter the array using NSPredicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchBar.text];
        filteredHealthItemArray = [NSMutableArray arrayWithArray:[[contentArray objectAtIndex:self.currentTab] filteredArrayUsingPredicate:predicate]];
        [[tableArray objectAtIndex:self.currentTab] reloadData];
    }
}

#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == searchBar) {
        if (self.currentTab == 0) {
            [[SEGAnalytics sharedAnalytics] track:@"Search Field"
                                       properties:@{@"category" : @"Conditions"}];
        } else if (self.currentTab == 1) {
            [[SEGAnalytics sharedAnalytics] track:@"Search Field"
                                       properties:@{@"category" : @"Medications"}];
        }
    }
    return YES;
}

- (void)deleteText {
    if (self.currentTab == 0) {
        [[SEGAnalytics sharedAnalytics] track:@"Cancel Search"
                                   properties:@{@"category" : @"Conditions"}];
    } else if (self.currentTab == 1) {
        [[SEGAnalytics sharedAnalytics] track:@"Cancel Search"
                                   properties:@{@"category" : @"Medications"}];
    }
    
    searchBar.text = @"";
    [UIView animateWithDuration:0.1 animations:^{
        xButton.alpha = 0;
    }];
    [searchBar resignFirstResponder];
    
    if (self.currentTab == 0 || self.currentTab == 1) {
        [[tableArray objectAtIndex:self.currentTab] reloadData];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [searchBar resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
}

- (void)textFieldDidChange {
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        [UIView animateWithDuration:0.1 animations:^{
            xButton.alpha = 1;
        }];
        [self filterContent];
    }
    else {
        [filteredHealthItemArray removeAllObjects];
    }
}

# pragma mark - Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
