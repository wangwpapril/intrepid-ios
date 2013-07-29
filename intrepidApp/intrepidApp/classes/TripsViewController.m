//
//  TripsViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripsViewController.h"
#import "MenuController.h"


@implementation TripsViewController

@synthesize mController;
@synthesize tableList;
@synthesize tripsArray;
@synthesize filteredArray;
@synthesize searchBar;
@synthesize xButton;
@synthesize selectedItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 7;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self populateContentArray];
    [self addIntreSearchBar];
    
    self.navigationItem.title = @"Health";
    self.navigationItem.backBarButtonItem.title = @" ";
    
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.bounds.size.height - 44) style:UITableViewStylePlain];
    [self.view addSubview:tableList];
    tableList.delegate = self;
    tableList.dataSource = self;
    
    mController = [[MenuController alloc] init];
    [mController displayMenuWithParent:self];
}

- (void)populateContentArray {
    tripsArray = [NSArray arrayWithObjects:@"hello", @"why not", nil];
    filteredArray = [NSMutableArray new];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSString *item = nil;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        item = [filteredArray objectAtIndex:indexPath.row];
    } else {
        item = [tripsArray objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = item;
//    [cell setupWithHealthItem:healthItem];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
//        NSLog(@"text is not default, instead it's :%@", searchBar.text);
//        selectedItem = (HealthItem *)[filteredHealthItemArray objectAtIndex:indexPath.row];
//    }
//    else {
//        NSLog(@"text is default : %@", searchBar.text);
//        selectedItem = (HealthItem *)[[contentArray objectAtIndex:currentTab] objectAtIndex:indexPath.row];
//    }
//    [searchBar resignFirstResponder];
//    HealthViewDetailController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"healthDetails"];
//    viewController.healthItem = selectedItem;
//    [self.navigationController pushViewController:viewController animated:YES];
//}


#pragma mark Content Filtering
-(void)filterContent{
    
    [self.filteredArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchBar.text];
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
    NSLog(@"text changed");
    
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
