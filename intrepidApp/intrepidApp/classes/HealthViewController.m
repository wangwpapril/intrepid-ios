//
//  HealthViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthViewController.h"
#import "Constants.h"
#import "QuartzCore/QuartzCore.h"
#import "HealthCell.h"
#import "HealthItem.h"
#import "MenuController.h"

@implementation HealthViewController

@synthesize tabArray;
@synthesize contentArray;
@synthesize tableArray;
@synthesize currentTab;
@synthesize previousTab;
@synthesize mController;


@synthesize healthItemArray;
@synthesize filteredHealthItemArray;
@synthesize healthItemSearchBar;
//@synthesize conditionsTable;
//@synthesize symptomsTable;
//@synthesize medicationsTable;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTabs];
    [self addTableViews];
    [self populateContentArray];
    
    [healthItemSearchBar setBackgroundImage:[UIImage new]];
    [healthItemSearchBar setTranslucent:YES];
    [healthItemSearchBar setPlaceholder:@"Tap to Search"];
    
    
    self.filteredHealthItemArray = [NSMutableArray new];
    // Reload the table
    self.navigationItem.title = @"Health";
    mController = [[MenuController alloc] init];
    [mController displayMenuWithParent:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UI Setup

- (void)addTabs {
    int i = 0;
    tabArray = [NSMutableArray new];
    
    while (i < 3) {
        
        // create the tab
        UIButton *tab = [UIButton buttonWithType:UIButtonTypeCustom];
        tab.frame = CGRectMake(107*i, 0, 107, 35);
        NSString *title;
        switch (i) {
            case 0:
                title = @"Conditions";
                break;
            case 1:
                title = @"Symptoms";
                break;
            case 2:
                title = @"Medications";
                break;
                
            default:
                break;
        }
        [tab setTitle:title forState:UIControlStateNormal];
        [tab setTitleColor:NAVIGATION_TEXT_COLOR forState:UIControlStateNormal];
        tab.titleLabel.font = [UIFont fontWithName:APP_FONT size:15];
        [tab setBackgroundColor:NAVIGATION_BG_COLOR];
        tab.tag = i; // for tracking which one is clicked
        [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        [tabArray addObject:tab];
        [self.view addSubview:tab];
        i++;
    }
    currentTab = 1;
    [self tabSelected:[tabArray objectAtIndex:1]];
}

- (void) addTableViews {
    tableArray = [NSMutableArray new];
    int i = 0;
    while (i < 3) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake((i-1)*320, 70, 320, self.view.frame.size.height - 70) style:UITableViewStylePlain];
        table.rowHeight = 45;
        table.tag = i;
        table.dataSource = self;
        table.backgroundColor = [UIColor whiteColor];
        table.alpha = 0.8;
        [tableArray addObject:table];
        i++;
    }
    [self.view addSubview:[tableArray objectAtIndex:1]];

}

// handle animations
- (void)viewDidAppear:(BOOL)animated {
    
}

#pragma mark - Content Handling

- (void)populateContentArray {
    // done in the background to speed up user response
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {        
        
       NSArray *conditions = [NSArray arrayWithObjects:
                              [HealthItem healthItemOfCategory:@"conditions" image:@"common.png" name:@"dang-it fever" common: TRUE],
                           [HealthItem healthItemOfCategory:@"conditions" image:@"common.png" name:@"dieaggoriea" common: FALSE],
                              [HealthItem healthItemOfCategory:@"conditions" image:@"common.png" name:@"death" common: TRUE], nil];
                              
                        
        NSArray *symptoms  = [NSArray arrayWithObjects:
                            [HealthItem healthItemOfCategory:@"symptoms" image:@"common.png" name:@"constipation" common: FALSE],
                           [HealthItem healthItemOfCategory:@"symptoms" image:@"common.png" name:@"heartburn" common: TRUE],
                           [HealthItem healthItemOfCategory:@"conditions" image:@"common.png" name:@"stomach ache" common: FALSE], nil];
     
        
        NSArray *medication  = [NSArray arrayWithObjects:
                              [HealthItem healthItemOfCategory:@"symptoms" image:@"common.png" name:@"placebo" common: FALSE],
                              [HealthItem healthItemOfCategory:@"symptoms" image:@"common.png" name:@"aspirin" common: TRUE],
                              [HealthItem healthItemOfCategory:@"conditions" image:@"common.png" name:@"milk of the poppy" common: FALSE], nil];
        contentArray = [[NSMutableArray alloc] initWithObjects:conditions, symptoms, medication, nil];
        
    });
}

- (void)tabSelected:(id)sender {
    NSLog(@"tab selected");
    UIButton *clickedTab = (UIButton *)sender;
    previousTab = currentTab;
    for (UIButton *tab in tabArray) {
        // select that tab
        if (tab.tag == clickedTab.tag) {
            [tab setTitleColor:NAVIGATION_BG_COLOR forState:UIControlStateNormal];
            [tab setBackgroundColor:NAVIGATION_TEXT_COLOR];
        }
        
        // make sure tab is inactive
        else {
            [tab setTitleColor:NAVIGATION_TEXT_COLOR forState:UIControlStateNormal];
            [tab setBackgroundColor:NAVIGATION_BG_COLOR];
        }
    }
    if (currentTab !=clickedTab.tag) {
        clickedTab.userInteractionEnabled = NO;
        currentTab = clickedTab.tag;
        [UIView animateWithDuration:0.3 animations:^{
            NSInteger offset;
            if (currentTab == 0) {
                offset = 320 * previousTab;
            }
            
            if (currentTab == 1) {
                if (previousTab == 0) {
                    offset = -320;
                }
                else {
                    offset = 320;
                }
            }
            
            if (currentTab == 2) {
                offset = -320 * (2- previousTab);
            }
            
            [self.view addSubview:[tableArray objectAtIndex:currentTab]];
            for (UITableView *tableView in tableArray) {
                [tableView setFrame:CGRectMake(tableView.frame.origin.x + offset, 70, 320, self.view.frame.size.height - 70)];
            }
        }
        completion:^(BOOL finished){
            [[tableArray objectAtIndex:previousTab] removeFromSuperview];
            clickedTab.userInteractionEnabled = YES;
//            for (UIButton * tab in tabArray) {
//                tab.userInteractionEnabled = YES;
//            }
        }];
    }
}



# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredHealthItemArray count];
    } else {
        return [[contentArray objectAtIndex:currentTab] count];
    }
    
//    return [[contentArray objectAtIndex:currentTab] count];
//    NSLog(@"tableview #ofrows tag: %i", tableView.tag);
//    return [[contentArray objectAtIndex:tableView.tag] count];
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"makin CELL HO");
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
//    HealthCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if(cell == nil) {
//        cell = [[HealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
//    
//    cell.textLabel.text = [[contentArray objectAtIndex:tableView.tag] objectAtIndex:indexPath.row];
//    [cell setupWithName:@"blah" withStatus:TRUE withImageURL:@"bleh"];
//    return cell;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    HealthCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[HealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    // Create a new Candy Object
    HealthItem *healthItem = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        healthItem = [filteredHealthItemArray objectAtIndex:indexPath.row];
    } else {
        healthItem = [[contentArray objectAtIndex:currentTab] objectAtIndex:indexPath.row];
    }
    
    [cell setupWithHealthItem:healthItem];
    // Configure the cell
    
//    cell.textLabel.text = healthItem.name;
//    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//    
//    if (healthItem.common == TRUE) {
//        [cell setupWithName:@"blah" withStatus:TRUE withImageURL:@"common@2x.png"];
//    }
//    else {
//        [cell setupWithName:@"blah" withStatus:FALSE withImageURL:@"uncommon@2x.png"];
//    }
    
    return cell;
    
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredHealthItemArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    filteredHealthItemArray = [NSMutableArray arrayWithArray:[[contentArray objectAtIndex:currentTab] filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
