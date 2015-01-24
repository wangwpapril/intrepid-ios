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

@implementation HealthViewController

@synthesize contentArray;
@synthesize tableArray;
@synthesize selectedItem;
@synthesize filteredHealthItemArray;
@synthesize searchBar;
@synthesize xButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
            
    self.view.tag = 1;
//    UIImage *backgroundImage = [UIImage imageNamed:@"mexicoBackBigger"];
//    CGRect imageFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    CGRect whiteFrame = CGRectMake(0, 79, self.view.frame.size.width, self.view.frame.size.height - 79);
//    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:imageFrame];
//    [myImageView setImage:backgroundImage];
//    [self.view insertSubview:myImageView atIndex:0];
//    
//    // white layer to make the tableview 90% opaque
//    UIView *whiteLayer = [[UIView alloc] initWithFrame:whiteFrame];
//    whiteLayer.backgroundColor = [UIColor whiteColor];
//    whiteLayer.alpha = 0.9;
//    [self.view insertSubview:whiteLayer atIndex:1];
    
    [self populateContentArray];
    
     tableArray = [NSMutableArray new];

    int i = 0;
    while (i < 2) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.rowHeight = 45;
        table.tag = i;
        table.dataSource = self;
        table.delegate = self;
        table.backgroundColor = [UIColor clearColor];
        table.opaque = NO;
        table.backgroundView = nil;
        table.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
        [table setSeparatorColor:[UIColor colorWithRed:189.0/255 green:185.0/255 blue:177.0/255 alpha:1]];
        [tableArray addObject:table];
        i++;
    }
    
    [self addViews:tableArray withVerticalOffset:79];
    [self addIntreSearchBar];
    
    NSArray *names = [NSArray arrayWithObjects:@"CONDITIONS", @"MEDICATIONS", nil];
    [self addTabs:names];
    
    self.navigationItem.title = @"Health";
    
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
    [searchBar resignFirstResponder];
    [[tableArray objectAtIndex:0] reloadData];
    [[tableArray objectAtIndex:1] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UI Setup

-(void)addIntreSearchBar {
    searchBar  = [[IntreSearchBar alloc] initWithFrame:CGRectMake(0, 35, 330, 44)];
    
    [searchBar addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:searchBar];
    searchBar.delegate = self;
    
    UIImageView *spyGlass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spyGlass"]];
    spyGlass.frame = CGRectMake(5, 51, 13, 13);
    [self.view addSubview:spyGlass];
    
    xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"cancel-search"] forState:UIControlStateNormal];
    xButton.frame = CGRectMake(270, 35, 44, 44);
    xButton.userInteractionEnabled = YES;
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

- (void)viewSwitched {
    [[tableArray objectAtIndex:self.currentTab] reloadData];
}

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
        NSLog(@"text is not default, instead it's :%@", searchBar.text);
        selectedItem = (HealthEntity *)[filteredHealthItemArray objectAtIndex:indexPath.row];
    }
    else {
        NSLog(@"text is default : %@", searchBar.text);
        selectedItem = (HealthEntity *)[[contentArray objectAtIndex:self.currentTab] objectAtIndex:indexPath.row];
    }
    HealthViewDetailController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"healthDetails"];
    viewController.healthItem = selectedItem;
    [self.navigationController pushViewController:viewController animated:YES];
//    [searchBar resignFirstResponder];
}


#pragma mark Content Filtering
-(void)filterContent{
    
    [self.filteredHealthItemArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchBar.text];
    filteredHealthItemArray = [NSMutableArray arrayWithArray:[[contentArray objectAtIndex:self.currentTab] filteredArrayUsingPredicate:predicate]];
    [[tableArray objectAtIndex:self.currentTab] reloadData];
}

#pragma mark - TextField Delegate Methods

-(void)deleteText {
    NSLog(@"deleting text");
    searchBar.text = @"";
    [UIView animateWithDuration:0.1 animations:^{
        xButton.alpha = 0;
    }];
    [[tableArray objectAtIndex:self.currentTab] reloadData];
}

-(void)removeText {
    NSLog(@"removing text");
    searchBar.text = @"Tap to Search";
    [[tableArray objectAtIndex:self.currentTab] reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [searchBar resignFirstResponder];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"text field ended editing");
}

- (void)textFieldDidChange {
    NSLog(@"text changed");
    
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
