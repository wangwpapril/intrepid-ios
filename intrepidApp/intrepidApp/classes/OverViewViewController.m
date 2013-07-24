//
//  OverViewViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "OverViewViewController.h"
#import "SlidingTextView.h"
#import "CurrencyCell.h"

@implementation OverViewViewController

@synthesize tableList;
@synthesize currencyArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Mexico Overview";
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    
    SlidingTextView *history = [[SlidingTextView alloc] initWithFrame:frame];
    [history setupWithImageName:@"MexicoBackBigger.png" withTitle:@"History" withIconName:@"stethoscope-pic.png"];
    [history addTextArea];
    
    SlidingTextView *culture = [[SlidingTextView alloc] initWithFrame:frame];
    [culture setupWithImageName:@"MexicoBackBigger.png" withTitle:@"Culture" withIconName:@"stethoscope-pic.png"];
    [culture addTextArea];
    
    currencyArray = [NSArray arrayWithObjects:@"one", @"two", @"three", nil];
    SlidingTextView *currency = [[SlidingTextView alloc] initWithFrame:frame];
    [currency setupWithImageName:@"MexicoBackBigger.png" withTitle:@"Currency" withIconName:@"stethoscope-pic.png"];
    
    // table
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 308,  320, height - 308)];
    tableList.dataSource = self;
    tableList.delegate = self;
    [currency addSubview:tableList];
    
    NSMutableArray *views = [NSMutableArray arrayWithObjects:history, culture, currency, nil];
    [self addViews:views withVerticalOffset:0];
    NSLog(@"added views");
    
    NSArray *names = [NSArray arrayWithObjects:@"HISTORY", @"CULTURE", @"CURRENCY", nil];
    NSLog(@"names array made");
    [self addTabs:names];
    NSLog(@"added tabs");
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currencyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    CurrencyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[CurrencyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell setupWithImageName:@"stethoscope-pic.png" withCountry:@"USD" withValue:@"1"];
    
    return cell;
}

@end
