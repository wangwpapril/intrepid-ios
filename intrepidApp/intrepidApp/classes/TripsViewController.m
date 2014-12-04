//
//  TripsViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripsViewController.h"
#import "MenuController.h"
#import "TripItem.h"
#import "TripCell.h"
#import "OverViewViewController.h"
#import "TripManager.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@implementation TripsViewController

@synthesize tableList;
@synthesize tripsArray;
@synthesize filteredArray;
@synthesize searchBar;
@synthesize xButton;
@synthesize cities;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.tag = 7;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self populateContentArray];
    [self addIntreSearchBar];
    
    self.navigationItem.title = @"Trips";
    self.navigationItem.backBarButtonItem.title = @" ";
    
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height - 44) style:UITableViewStylePlain];
    [self.view addSubview:tableList];
    tableList.delegate = self;
    tableList.dataSource = self;
    
    TripManager *manager = [TripManager getInstance];
    cities = [manager getCities];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    } else {
        [self moveAllSubviewsDown];
    }

}

- (void) moveAllSubviewsDown{
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)populateContentArray {
    TripItem *trip1 = [[TripItem alloc] init];
    trip1.city = @"Guadalajara";
    trip1.continent = @"North America";
    trip1.image = @"Guada-icon";
    TripItem *trip2 = [[TripItem alloc] init];
    trip2.city = @"Miami";
    trip2.continent = @"North America";
    trip2.image = @"Miami-icon";
    TripItem *trip3 = [[TripItem alloc] init];
    trip3.city = @"Mexico City";
    trip3.continent = @"North America";
    trip3.image = @"Mexico-icon";
    TripItem *trip4 = [[TripItem alloc] init];
    trip4.city = @"Puerto Plata";
    trip4.continent = @"North America";
    trip4.image = @"Puerto-Plata-icon";
    tripsArray = [NSArray arrayWithObjects:trip1, trip2, trip3, trip4, nil];
    filteredArray = [NSMutableArray new];
}

-(void)addIntreSearchBar {
    searchBar  = [[IntreSearchBar alloc] initWithFrame:CGRectMake(0, 0, 330, 44)];
    //    [searchBar setText:@""];
    [searchBar addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:searchBar];
    searchBar.delegate = self;
    
    UIImageView *spyGlass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spyGlass"]];
    spyGlass.frame = CGRectMake(5, 16, 13, 13);
    [self.view addSubview:spyGlass];
    
    xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"cancel-search"] forState:UIControlStateNormal];
    xButton.frame = CGRectMake(270, 0, 44, 44);
    xButton.userInteractionEnabled = YES;
    [xButton addTarget:self action:@selector(deleteText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xButton];
    xButton.alpha = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger fCount = filteredArray.count;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {        
        return fCount;
    } else {
        return [tripsArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    TripCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[TripCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    TripItem *item = nil;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        item = [filteredArray objectAtIndex:indexPath.row];
    } else {
        item = [tripsArray objectAtIndex:indexPath.row];
    }
    
    [cell setupWithHealthItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TripItem *trip;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        NSLog(@"from trips array");
        trip = [filteredArray objectAtIndex:indexPath.row];
    }
    else {
        NSLog(@"from filtered array");
        trip = [tripsArray objectAtIndex:indexPath.row];
    }
    NSString *name = trip.city;
    CityEntity *city;
    for (CityEntity *town in cities) {
        if ([town.cityName isEqualToString:name]) {
            city = town;
        }
    }
    
    [MenuController getInstance].city = city;
    OverViewViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"overView"];
    viewController.firstLoad = true;
    [[MenuController getInstance] selectButtonWithTag:0];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark Content Filtering
-(void)filterContent{
    
    [self.filteredArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.city contains[c] %@",searchBar.text];
    filteredArray = [NSMutableArray arrayWithArray:[tripsArray filteredArrayUsingPredicate:predicate]];
    [tableList reloadData];
}

#pragma mark - TextField Delegate Methods

-(void)deleteText {
    searchBar.text = @"";
    [UIView animateWithDuration:0.1 animations:^{
        xButton.alpha = 0;
    }];
    [tableList reloadData];
}

-(void)removeText {
    searchBar.text = @"Tap to Search";
    [tableList reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [searchBar resignFirstResponder];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.text = @"Tap to Search";
    [UIView animateWithDuration:0.1 animations:^{
        xButton.alpha = 0;
    }];
}

- (void)textFieldDidChange {
    
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        [UIView animateWithDuration:0.1 animations:^{
            xButton.alpha = 1;
        }];
        [self filterContent];
    }
    else {
        [filteredArray removeAllObjects];
        [tableList reloadData];
    }
}

# pragma mark - Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}


@end
