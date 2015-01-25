//
//  TripsViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripsViewController.h"
#import "MenuController.h"
#import "TripCell.h"
#import "OverViewViewController.h"
#import "TripManager.h"
#import "RequestBuilder.h"

@implementation TripsViewController

@synthesize tableList;
@synthesize tripsArray;
@synthesize filteredArray;
@synthesize searchBar;
@synthesize xButton;
@synthesize cities;
@synthesize selectedTrip;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self addIntreSearchBar];
    
    self.navigationItem.title = @"Trips";
    self.navigationItem.backBarButtonItem.title = @" ";
    
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height - 108) style:UITableViewStylePlain];
    [self.view addSubview:tableList];
    tableList.delegate = self;
    tableList.dataSource = self;
    
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

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(populateContentArray)
                                                 name:@"DESTINATION_UPDATE"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(populateTrip)
                                                 name:@"TRIP_UPDATE"
                                               object:nil];
    
    [RequestBuilder fetchDestinations];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"DESTINATION_UPDATE"
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"TRIP_UPDATE"
                                                  object:nil];
}

- (void)populateContentArray {
    TripManager *manager = [TripManager getInstance];
    tripsArray = [manager getDestinations];
    [tableList reloadData];
}

- (void)populateTrip {
    NSArray *savedCities = [[TripManager getInstance] getSavedCities];
    for (CityEntity *city in savedCities) {
        if ([city.destinationId isEqualToNumber:selectedTrip.destinationId]) {
            [MenuController getInstance].city = city;
            OverViewViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"overView"];
            viewController.firstLoad = true;
            [[MenuController getInstance] selectButtonWithTag:0];
            [self.navigationController pushViewController:viewController animated:YES];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            return;
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"The Internet connection appears to be offline."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void)addIntreSearchBar {
    searchBar  = [[IntreSearchBar alloc] initWithFrame:CGRectMake(0, 0, 330, 44)];
    //    [searchBar setText:@""];
    [searchBar addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:searchBar];
    searchBar.delegate = self;
    
    UIImageView *spyGlass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spyGlass.png"]];
    spyGlass.frame = CGRectMake(5, 16, 13, 13);
    [self.view addSubview:spyGlass];
    
    xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"cancel-search.png"] forState:UIControlStateNormal];
    xButton.frame = CGRectMake(270, 0, 44, 44);
    xButton.userInteractionEnabled = YES;
    [xButton addTarget:self action:@selector(deleteText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xButton];
    xButton.alpha = 0;
    
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
    
    DestinationEntity *item = nil;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        item = [filteredArray objectAtIndex:indexPath.row];
    } else {
        item = [tripsArray objectAtIndex:indexPath.row];
    }
    [cell setupWithTripItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        selectedTrip = [filteredArray objectAtIndex:indexPath.row];
    }
    else {
        selectedTrip = [tripsArray objectAtIndex:indexPath.row];
    }
    
    [RequestBuilder fetchTrip:[NSString stringWithFormat:@"%@", selectedTrip.destinationId]];
}

#pragma mark Content Filtering
-(void)filterContent{
    
    [self.filteredArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchBar.text];
    filteredArray = [NSMutableArray arrayWithArray:[tripsArray filteredArrayUsingPredicate:predicate]];
    NSLog(@"filtered array size: %lu", (unsigned long)filteredArray.count);
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