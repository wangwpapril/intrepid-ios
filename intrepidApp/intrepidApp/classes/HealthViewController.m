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
#import "HealthContent.h"

@implementation HealthViewController

//@synthesize tabArray;
//@synthesize largeLetterArray;
@synthesize contentArray;
//@synthesize tableArray;
//@synthesize currentTab;
//@synthesize previousTab;
//@synthesize mController;
//@synthesize line;

@synthesize selectedItem;
//@synthesize healthItemArray;
@synthesize filteredHealthItemArray;

//@synthesize navLabelC;
//@synthesize navLabelM;
//@synthesize navLabelS;
@synthesize searchBar;
@synthesize xButton;

//@synthesize tableList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 1;
    //    self.navigationItem.hidesBackButton = YES;
    //
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    //    // background
    UIImage *backgroundImage = [UIImage imageNamed:@"mexicoBackBigger.png"];
    CGRect imageFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGRect whiteFrame = CGRectMake(0, 79, self.view.frame.size.width, self.view.frame.size.height - 79);
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    [myImageView setImage:backgroundImage];
    [self.view addSubview:myImageView];
    
    // white layer to make the tableview 90% opaque
    UIView *whiteLayer = [[UIView alloc] initWithFrame:whiteFrame];
    whiteLayer.backgroundColor = [UIColor whiteColor];
    whiteLayer.alpha = 0.9;
    [self.view addSubview:whiteLayer];
    
    [self populateContentArray];
    
    NSMutableArray *tableArray = [NSMutableArray new];

    int i = 0;
    while (i < 2) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 133) style:UITableViewStylePlain]; // bar and status height :/
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
    
    //    [self.view addSubview:[tableArray objectAtIndex:0]];
    [self addViews:tableArray withVerticalOffset:79];
    [self addIntreSearchBar];
    
    NSArray *names = [NSArray arrayWithObjects:@"SYMPTOMS", @"MEDICATIONS", nil];
    [self addTabs:names];
        
    self.navigationItem.title = @"Health";
    [self.view bringSubviewToFront:self.scroll];
    
    //    mController = [[MenuController alloc] init];
    //    [mController displayMenuWithParent:self];
    
}

//- (void) viewWillAppear:(BOOL)animated {
//    mController = [MenuController getInstance];
//    [mController displayMenuWithParent:self];
//}

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
    
    UIImageView *spyGlass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spyGlass.png"]];
    spyGlass.frame = CGRectMake(5, 51, 13, 13);
    [self.view addSubview:spyGlass];
    
    xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"cancel-search.png"] forState:UIControlStateNormal];
    xButton.frame = CGRectMake(270, 35, 44, 44);
    xButton.userInteractionEnabled = YES;
    [xButton addTarget:self action:@selector(deleteText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xButton];
    xButton.alpha = 0;
    
}

//-(void)capitalLabel:(UILabel *)label withLetter:(NSString *)letter {
//    label.text = letter;
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont fontWithName:APP_FONT size:14];
//    [self.view addSubview:label];
//    [largeLetterArray addObject:label];
//}

//- (void)addTabs {
//
//    int i = 0;
//    tabArray = [NSMutableArray new];
//
//    while (i < 2) {
//
//        // create the tab
//        UIButton *tab = [UIButton buttonWithType:UIButtonTypeCustom];
//        tab.frame = CGRectMake(160*i, 0, 160, 35);
//        NSString *title;
//        switch (i) {
//            case 0:
//                title = @"CONDITIONS";
//                break;
//            case 1:
//                title = @"MEDICATIONS";
//                break;
//
//            default:
//                break;
//        }
//        [tab setTitle:title forState:UIControlStateNormal];
//        [tab setTitleColor:APP_TOGGLE_SELECTED forState:UIControlStateNormal];
//        tab.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
//        [tab setBackgroundColor:APP_TEXT_COLOR];
//        tab.alpha = 0.8;
//
//        tab.tag = i; // for tracking which one is clicked
//        [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
//        [tabArray addObject:tab];
//        [self.view addSubview:tab];
//        i++;
//    }
//    currentTab = 0;
//    [self tabSelected:[tabArray objectAtIndex:0]];
//
//    // swipe to switch tabs
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
//    swipeLeft.numberOfTouchesRequired = 1;
//    swipeLeft.direction = (UISwipeGestureRecognizerDirectionLeft);
//    [self.view addGestureRecognizer:swipeLeft];
//
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
//    swipeRight.numberOfTouchesRequired = 1;
//    swipeRight.direction = (UISwipeGestureRecognizerDirectionRight);
//    [self.view addGestureRecognizer:swipeRight];
//
//    // create line
//    line = [[UILabel alloc] init];
//    line.backgroundColor = APP_TOGGLE_SELECTED;
//    line.frame = CGRectMake(38, 27, 80, 1);
//    [self.view addSubview:line];
//}
//
//- (void)addTableViews {
//    tableArray = [NSMutableArray new];
//    int i = 0;
//    while (i < 2) {
//        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(i*320, 79, 320, self.view.frame.size.height - 133) style:UITableViewStylePlain]; // bar and status height :/
//        table.rowHeight = 45;
//        table.tag = i;
//        table.dataSource = self;
//        table.delegate = self;
//        table.backgroundColor = [UIColor clearColor];
//        table.opaque = NO;
//        table.backgroundView = nil;
//        [table setSeparatorColor:[UIColor colorWithRed:189.0/255 green:185.0/255 blue:177.0/255 alpha:1]];
//        [tableArray addObject:table];
//        i++;
//    }
//    [self.view addSubview:[tableArray objectAtIndex:0]];
//
//}

// handle animations

#pragma mark - Content Handling

- (void)populateContentArray {
    HealthContent *content = [[HealthContent alloc] init];
    contentArray = [content getContent];
    
    self.filteredHealthItemArray = [NSMutableArray new];
}

//- (void)tabSelected:(id)sender {
//    UIButton *clickedTab = (UIButton *)sender;
//    [self switchTabs:clickedTab.tag];
//}
//
//- (void) swipedRight:(UISwipeGestureRecognizer*)swipeGesture {
//    NSInteger newTag = currentTab - 1;
//    if (newTag >= 0) {
//        [self switchTabs:newTag];
//    }
//}
//
//- (void) swipedLeft:(UISwipeGestureRecognizer*)swipeGesture {
//    NSInteger newTag = currentTab + 1;
//    if (newTag <= 1) {
//        [self switchTabs:newTag];
//    }
//}
//
//
//-(void)switchTabs:(NSInteger)newTag{
//    NSInteger previousTab = currentTab;
//    NSInteger index = 0;
//    NSInteger lineX;
//
//    // handle tabs
//    for (UIButton *tab in tabArray) {
//
//        // capital letter
////        UILabel *capitalLetter = ((UILabel *)[largeLetterArray objectAtIndex:index]);
//        // select that tab
//
//        if (tab.tag == newTag) {
//            [tab setTitleColor:APP_TOGGLE_SELECTED forState:UIControlStateNormal];
////            [capitalLetter setTextColor:APP_TOGGLE_SELECTED];
//            lineX = 160 * index + 38;
//
//        }
//
//        // make sure tab is inactive
//        else {
//            [tab setTitleColor:APP_TOGGLE_UNSELECTED forState:UIControlStateNormal];
////            [capitalLetter setTextColor:APP_TOGGLE_UNSELECTED];
//        }
//        index++;
//    }
//
//    if (currentTab !=newTag) {
//        [searchBar resignFirstResponder];
////        [self removeText];
//        line.frame = CGRectMake(lineX, 27, 1, 1);
//
//        for (UIButton * tab in tabArray) {
//            tab.userInteractionEnabled = NO;
//        }
//
//        currentTab = newTag;
//
//        // handle views sliding
//
// //       UIView *tableToBe = ((UIView *)[tableArray objectAtIndex:currentTab]);
//
////        tableToBe.frame = CGRectMake(0, 79, 320, self.view.frame.size.height - 79);
//
////        if (currentTab == 0 || currentTab == 2) {
////            NSInteger position = (currentTab - 1) * 320;
////            if (position < 0) {
////            }
////            tableToBe.frame = CGRectMake(position, 79, 320, self.view.frame.size.height - 79);
////        }
////        else {
////            if (previousTab == 0) {
////                tableToBe.frame = CGRectMake(320, 79, 320, self.view.frame.size.height - 79);
////            }
////            else {
////                tableToBe.frame = CGRectMake(-320, 79, 320, self.view.frame.size.height - 79);
////            }
////        }
//
//        [UIView animateWithDuration:0.3 animations:^{
//            line.frame = CGRectMake(lineX, 27, 80, 1);
//            NSInteger offset;
//            if (currentTab == 0) {
//                offset = 320;
//            }
//            else {
//                offset = -320;
//            }
//
//            [self.view insertSubview:[tableArray objectAtIndex:currentTab] belowSubview:mController.menu];
//            for (UITableView *tableView in tableArray) {
//                [tableView setFrame:CGRectMake(tableView.frame.origin.x + offset, 79, 320, self.view.frame.size.height - 79)];
//            }
//        }
//                         completion:^(BOOL finished){
//                             [[tableArray objectAtIndex:previousTab] removeFromSuperview];
//                             for (UIButton * tab in tabArray) {
//                                 tab.userInteractionEnabled = YES;
//                             }
//                             [self removeText];
//                         }];
//    }
//}

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger fCount = filteredHealthItemArray.count;
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@"Tap to Search"]) {
        NSLog(@"fcount: %i, searhbartext: %@", fCount, searchBar.text);
        
        return fCount;
    } else {
        NSLog(@"total count: %i", [[contentArray objectAtIndex:self.currentTab] count]);
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
    
    HealthItem *healthItem = nil;
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
        selectedItem = (HealthItem *)[filteredHealthItemArray objectAtIndex:indexPath.row];
    }
    else {
        NSLog(@"text is default : %@", searchBar.text);
        selectedItem = (HealthItem *)[[contentArray objectAtIndex:self.currentTab] objectAtIndex:indexPath.row];
    }
    [searchBar resignFirstResponder];
    HealthViewDetailController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"healthDetails"];
    viewController.healthItem = selectedItem;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark Content Filtering
-(void)filterContent{
    
    [self.filteredHealthItemArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchBar.text];
    filteredHealthItemArray = [NSMutableArray arrayWithArray:[[contentArray objectAtIndex:self.currentTab] filteredArrayUsingPredicate:predicate]];
    //    [[tableArray objectAtIndex:currentTab] reloadData];
}

#pragma mark - TextField Delegate Methods

-(void)deleteText {
    searchBar.text = @"";
    [UIView animateWithDuration:0.1 animations:^{
        xButton.alpha = 0;
    }];
    //    [[tableArray objectAtIndex:currentTab] reloadData];
}

-(void)removeText {
    searchBar.text = @"Tap to Search";
    //    [[tableArray objectAtIndex:currentTab] reloadData];
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
        [filteredHealthItemArray removeAllObjects];
        //        [[tableArray objectAtIndex:currentTab] reloadData];
    }
}

# pragma mark - Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
