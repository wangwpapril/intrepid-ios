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
#import "HealthViewDetailController.h"

@implementation HealthViewController

@synthesize tabArray;
//@synthesize largeLetterArray;
@synthesize contentArray;
@synthesize tableArray;
@synthesize currentTab;
@synthesize previousTab;
@synthesize mController;
@synthesize line;

@synthesize selectedItem;
@synthesize healthItemArray;
@synthesize filteredHealthItemArray;

//@synthesize navLabelC;
//@synthesize navLabelM;
//@synthesize navLabelS;
@synthesize searchBar;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // background
    UIImage *backgroundImage = [UIImage imageNamed:@"mexicoBackBigger.png"];
    CGRect imageFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGRect whiteFrame = CGRectMake(0, 79, self.view.frame.size.width, self.view.frame.size.height - 79);
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    [myImageView setImage:backgroundImage];
    [self.view addSubview:myImageView];
    UIView *whiteLayer = [[UIView alloc] initWithFrame:whiteFrame];
    whiteLayer.backgroundColor = [UIColor whiteColor];
    whiteLayer.alpha = 0.9;
    [self.view addSubview:whiteLayer];
    
    [self addTabs];   
    [self addTableViews];
    [self populateContentArray];
    [self addIntreSearchBar];
    
    self.navigationItem.title = @"Health";
    self.navigationItem.backBarButtonItem.title = @" ";
    mController = [[MenuController alloc] init];
    [mController displayMenuWithParent:self];
    
//    //add large letters to navigation bar
//    largeLetterArray = [NSMutableArray new];
//    
//    [self capitalLabel:navLabelC withLetter:@"C"];
//    [navLabelC setTextColor:APP_TOGGLE_UNSELECTED];
//    
//    [self capitalLabel:navLabelS withLetter:@"S"];
//    [navLabelS setTextColor:APP_TOGGLE_UNSELECTED];
//    
//    [self capitalLabel:navLabelM withLetter:@"M"];
//    [navLabelM setTextColor:APP_TOGGLE_UNSELECTED];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UI Setup

-(void)addIntreSearchBar {
    searchBar  = [[IntreSearchBar alloc] initWithFrame:CGRectMake(0, 35, 330, 44)];
    [searchBar setBackgroundColor:APP_SEARCH_COLOR];
    [searchBar setPlaceholder:@"Tap to Search"];
    [searchBar setText:@""];
    [searchBar addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [searchBar setFont: [UIFont fontWithName:@"ProximaNova-Light" size:16]];
    searchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:searchBar];
    searchBar.delegate = self;
    [searchBar setReturnKeyType:UIReturnKeyDone];
    searchBar.alpha = 0.9;
    UIImageView *spyGlass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spyGlass.png"]];
    spyGlass.frame = CGRectMake(5, 51, 13, 13);
    [self.view addSubview:spyGlass];
    
    UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"cancel-search.png"] forState:UIControlStateNormal];
    xButton.frame = CGRectMake(270, 35, 44, 44);
    xButton.userInteractionEnabled = YES;
    [xButton addTarget:self action:@selector(removeText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xButton];
    
}

-(void)removeText {
    searchBar.text = @"";
    [[tableArray objectAtIndex:currentTab] reloadData];
}

//-(void)capitalLabel:(UILabel *)label withLetter:(NSString *)letter {
//    label.text = letter;
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont fontWithName:APP_FONT size:14];
//    [self.view addSubview:label];
//    [largeLetterArray addObject:label];
//}

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
                title = @"CONDITIONS";
                break;
            case 1:
                title = @"SYMPTOMS";
                break;
            case 2:
                title = @"MEDICATIONS";
                break;
                
            default:
                break;
        }
        [tab setTitle:title forState:UIControlStateNormal];
        [tab setTitleColor:APP_TOGGLE_SELECTED forState:UIControlStateNormal];
        tab.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
        [tab setBackgroundColor:APP_TEXT_COLOR];
        tab.alpha = 0.8;
        
        tab.tag = i; // for tracking which one is clicked
        [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        [tabArray addObject:tab];
        [self.view addSubview:tab];
        i++;
    }
    currentTab = 1;
    [self tabSelected:[tabArray objectAtIndex:1]];
    
    // swipe to switch tabs
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction = (UISwipeGestureRecognizerDirectionLeft);
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    swipeRight.numberOfTouchesRequired = 1;
    swipeRight.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeRight];
    
    // create line
    line = [[UILabel alloc] init];
    line.backgroundColor = APP_TOGGLE_SELECTED;
    line.frame = CGRectMake(117, 27, 80, 1);
    [self.view addSubview:line];
}

- (void) addTableViews {
    tableArray = [NSMutableArray new];
    int i = 0;
    while (i < 3) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake((i-1)*320, 79, 320, self.view.frame.size.height - 79) style:UITableViewStylePlain];
        table.rowHeight = 45;
        table.tag = i;
        table.dataSource = self;
        table.delegate = self;
        table.backgroundColor = [UIColor clearColor];
        table.opaque = NO;
        table.backgroundView = nil;
        [table setSeparatorColor:[UIColor colorWithRed:189.0/255 green:185.0/255 blue:177.0/255 alpha:1]];
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
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
    //                                             (unsigned long)NULL), ^(void) {
    
    NSArray *conditions = [NSArray arrayWithObjects:
                           [HealthItem healthItemOfCategory:@"conditions" name:@"Arm Fracture" common: TRUE],
                           [HealthItem healthItemOfCategory:@"conditions" name:@"Heartburn" common: FALSE],
                           [HealthItem healthItemOfCategory:@"conditions" name:@"Headache" common: TRUE],
                           [HealthItem healthItemOfCategory:@"conditions" name:@"Stomach Ache" common: TRUE],
                           [HealthItem healthItemOfCategory:@"conditions" name:@"Anxiety" common: FALSE],
                           [HealthItem healthItemOfCategory:@"conditions" name:@"Vomiting" common: TRUE],
                            [HealthItem healthItemOfCategory:@"conditions" name:@"Sleep Walking" common: FALSE],
                            [HealthItem healthItemOfCategory:@"conditions" name:@"Asthma" common: TRUE], nil];
    
    
    NSArray *symptoms  = [NSArray arrayWithObjects:
                          [HealthItem healthItemOfCategory:@"symptoms" name:@"Blood Pressure" common: TRUE],
                          [HealthItem healthItemOfCategory:@"symptoms" name:@"Bleeding" common: FALSE],
                          [HealthItem healthItemOfCategory:@"symptoms" name:@"Bone Pain" common: TRUE],
                        [HealthItem healthItemOfCategory:@"symptoms" name:@"Arm Pain" common: TRUE],
                        [HealthItem healthItemOfCategory:@"symptoms" name:@"Back Pain" common: FALSE],
                        [HealthItem healthItemOfCategory:@"symptoms" name:@"Dizziness" common: TRUE],
                          [HealthItem healthItemOfCategory:@"symptoms" name:@"Sleep Deprivation" common: FALSE],
                          [HealthItem healthItemOfCategory:@"symptoms" name:@"Anxiety" common: TRUE],
                          [HealthItem healthItemOfCategory:@"symptoms" name:@"Wheezing" common: TRUE], nil];
    
    
    NSArray *medication  = [NSArray arrayWithObjects:
                            [HealthItem healthItemOfCategory:@"medications" name:@"Antacid" common: TRUE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Neosporin" common: FALSE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Ibuprofen" common: TRUE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Pepto-Bismol" common: TRUE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Hydrocorisone" common: FALSE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Aspirin" common: TRUE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Benadryl" common: FALSE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Cortizone" common: TRUE],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Vicks" common: TRUE], nil];
    
    contentArray = [[NSMutableArray alloc] initWithObjects:conditions, symptoms, medication, nil];
    
    //    });
    self.filteredHealthItemArray = [NSMutableArray new];
}

- (void)tabSelected:(id)sender {
    UIButton *clickedTab = (UIButton *)sender;
    [self switchTabs:clickedTab.tag];
}

- (void) swipedRight:(UISwipeGestureRecognizer*)swipeGesture {
    NSInteger newTag = currentTab - 1;
    if (newTag >= 0) {
        [self switchTabs:newTag];
    }
}

- (void) swipedLeft:(UISwipeGestureRecognizer*)swipeGesture {
    NSInteger newTag = currentTab + 1;
    if (newTag <= 2) {
        [self switchTabs:newTag];
    }
}


-(void)switchTabs:(NSInteger)newTag{
    previousTab = currentTab;
    NSInteger index = 0;
    NSInteger lineX;
    
    // handle tabs
    for (UIButton *tab in tabArray) {
        
        // capital letter
//        UILabel *capitalLetter = ((UILabel *)[largeLetterArray objectAtIndex:index]);
        // select that tab
        
        if (tab.tag == newTag) {
            [tab setTitleColor:APP_TOGGLE_SELECTED forState:UIControlStateNormal];
//            [capitalLetter setTextColor:APP_TOGGLE_SELECTED];
            lineX = 107 * index + 13;
            
        }
        
        // make sure tab is inactive
        else {
            [tab setTitleColor:APP_TOGGLE_UNSELECTED forState:UIControlStateNormal];
//            [capitalLetter setTextColor:APP_TOGGLE_UNSELECTED];
        }
        index++;
    }
    
    if (currentTab !=newTag) {
        
//        [self removeText];
        line.frame = CGRectMake(lineX, 27, 1, 1);
        
        for (UIButton * tab in tabArray) {
            tab.userInteractionEnabled = NO;
        }
        
        currentTab = newTag;
        
        // handle views sliding
        
        UIView *tableToBe = ((UIView *)[tableArray objectAtIndex:currentTab]);
        
        if (currentTab == 0 || currentTab == 2) {
            NSInteger position = (currentTab - 1) * 320;
            if (position < 0) {
            }
            tableToBe.frame = CGRectMake(position, 79, 320, self.view.frame.size.height - 79);
        }
        else {
            if (previousTab == 0) {
                tableToBe.frame = CGRectMake(320, 79, 320, self.view.frame.size.height - 79);
            }
            else {
                tableToBe.frame = CGRectMake(-320, 79, 320, self.view.frame.size.height - 79);
            }
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            line.frame = CGRectMake(lineX, 27, 80, 1);
            NSInteger offset;
            if (currentTab - previousTab > 0) {
                offset = -320;
            }
            else {
                offset = 320;
            }
            
            [self.view insertSubview:[tableArray objectAtIndex:currentTab] belowSubview:mController.menu];
            for (UITableView *tableView in tableArray) {
                [tableView setFrame:CGRectMake(tableView.frame.origin.x + offset, 79, 320, self.view.frame.size.height - 79)];
            }
        }
                         completion:^(BOOL finished){
                             [[tableArray objectAtIndex:previousTab] removeFromSuperview];
                             for (UIButton * tab in tabArray) {
                                 tab.userInteractionEnabled = YES;
                             }
                             [self removeText];
                         }];
    }
}



# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger fCount = filteredHealthItemArray.count;
    if (![searchBar.text isEqualToString:@""]) {
        NSLog(@"fcount: %i, searhbartext: %@", fCount, searchBar.text);
        
        return fCount;
    } else {
        NSLog(@"total count: %i", [[contentArray objectAtIndex:currentTab] count]);
        return [[contentArray objectAtIndex:currentTab] count];
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
    
    HealthItem *healthItem = nil;
    if (![searchBar.text isEqualToString:@""]) {
        healthItem = [filteredHealthItemArray objectAtIndex:indexPath.row];
    } else {
        healthItem = [[contentArray objectAtIndex:currentTab] objectAtIndex:indexPath.row];
    }
    
    [cell setupWithHealthItem:healthItem];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![searchBar.text isEqualToString:@""]) {
        selectedItem = (HealthItem *)[filteredHealthItemArray objectAtIndex:indexPath.row];
    }
    else {
        selectedItem = (HealthItem *)[[contentArray objectAtIndex:currentTab] objectAtIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"details" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HealthViewDetailController *controller = segue.destinationViewController;
    controller.healthItemName = selectedItem.name;
    controller.healthItemCategory = selectedItem.category;
}

#pragma mark Content Filtering
-(void)filterContent{
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredHealthItemArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchBar.text];
    filteredHealthItemArray = [NSMutableArray arrayWithArray:[[contentArray objectAtIndex:currentTab] filteredArrayUsingPredicate:predicate]];
    [[tableArray objectAtIndex:currentTab] reloadData];
}

#pragma mark - TextField Delegate Methods

-(void)textFieldDidChange {
    NSLog(@"text changed");

    if (![searchBar.text isEqualToString:@""]) {
        [self filterContent];
    }
    else {
        [filteredHealthItemArray removeAllObjects];
        [[tableArray objectAtIndex:currentTab] reloadData];
    }
}

# pragma mark - Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
