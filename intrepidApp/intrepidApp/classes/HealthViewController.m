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

@implementation HealthViewController

@synthesize tabArray;
@synthesize contentArray;
@synthesize table;
@synthesize currentTab;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:APP_BG_COLOR];
    [self addTabs];
    [self addTableView];
    [self populateContentArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Content Handling

- (void)populateContentArray {
    // done in the background to speed up user response
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        NSArray *conditions = [[NSArray alloc] initWithObjects:@"dang-it fever", @"dieaggoriea", @"death", nil];
        NSArray *symptoms = [[NSArray alloc] initWithObjects:@"constipation", @"heartburn", @"stomach ache", nil];
        NSArray *medication = [[NSArray alloc] initWithObjects:@"placebo", @"aspirin", @"milk of the poppy", nil];
        contentArray = [[NSMutableArray alloc] initWithObjects:conditions, symptoms, medication, nil];
        
        table.dataSource = self;
        table.delegate = self;
        
    });
}

- (void)tabSelected:(id)sender {
    UIButton *clickedTab = (UIButton *)sender;
     NSLog(@"dat tag: %i", clickedTab.tag);
    for (UIButton *tab in tabArray) {
        
        // select that tab
        if (tab.tag == clickedTab.tag) {
            [tab setTitleColor:APP_BG_COLOR forState:UIControlStateNormal];
            [tab setBackgroundColor:APP_TEXT_COLOR];
        }
        
        // make sure tab is inactive
        else {
            [tab setTitleColor:APP_TEXT_COLOR forState:UIControlStateNormal];
            [tab setBackgroundColor:APP_BG_COLOR];
        }
    }
    if (currentTab !=clickedTab.tag) {
        currentTab = clickedTab.tag;
        [table reloadData];
    }
}

# pragma mark - UI Setup

- (void)addTabs {
    int i = 0;
    tabArray = [NSMutableArray new];
    
    while (i < 3) {
        
        // create the tab
        UIButton *tab = [UIButton buttonWithType:UIButtonTypeCustom];
        tab.frame = CGRectMake(28 + 88*i, 10, 90, 35);
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
        [tab setTitleColor:APP_TEXT_COLOR forState:UIControlStateNormal];
        tab.titleLabel.font = [UIFont fontWithName:APP_FONT size:15];
        [tab setBackgroundColor:APP_BG_COLOR];
        tab.layer.borderColor = APP_TEXT_COLOR.CGColor;
        tab.layer.borderWidth = 2;
        tab.tag = i; // for tracking which one is clicked
        [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        [tabArray addObject:tab];
        [self.view addSubview:tab];
        i++;
    }
    currentTab = 1;
    [self tabSelected:[tabArray objectAtIndex:1]];
}

- (void) addTableView {
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 320, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    table.alpha = 0;
    table.rowHeight = 45;
    [self.view addSubview: table];
}

// handle animations
- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.3 animations:^{
        table.alpha = 1;
    }];
    
}


# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"track each time this is called");
    return [[contentArray objectAtIndex:currentTab] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    HealthCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[HealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.text = [[contentArray objectAtIndex:currentTab] objectAtIndex:indexPath.row];
    [cell setupWithName:@"blah" withStatus:TRUE withImageURL:@"bleh"];
    return cell;
}




@end
