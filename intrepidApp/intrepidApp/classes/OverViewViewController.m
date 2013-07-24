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
#import "CurrencyItem.h"

@implementation OverViewViewController

@synthesize tableList;
@synthesize currencyArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateCurrencyItems];
    self.navigationItem.title = @"Mexico Overview";
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    
    SlidingTextView *history = [[SlidingTextView alloc] initWithFrame:frame];
    [history setupWithImageName:@"overview-history.png" withTitle:@"History" withIconName:@"descriptionAndSideEffectLogo.png"];
    [history addTextArea];
    
    SlidingTextView *culture = [[SlidingTextView alloc] initWithFrame:frame];
    [culture setupWithImageName:@"overview-culture.png" withTitle:@"Culture" withIconName:@"culture-icon.png"];
    [culture addTextArea];

    SlidingTextView *currency = [[SlidingTextView alloc] initWithFrame:frame];
    [currency setupWithImageName:@"overview-currency.png" withTitle:@"Currency" withIconName:@"currency-label.png"];
    
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

-(void)populateCurrencyItems {
    currencyArray = [NSArray arrayWithObjects:
                           [CurrencyItem currencyItemOfCountry:@"USD" flag:@"american-flag.png" value:@"1"],
                            [CurrencyItem currencyItemOfCountry:@"CAD" flag:@"canadian-flag.png" value:@"0.15"],
                            [CurrencyItem currencyItemOfCountry:@"GBP" flag:@"great-britain-flag.png" value:@"1.34"],
                            [CurrencyItem currencyItemOfCountry:@"BRA" flag:@"brasil-flag.png" value:@"0.11"], nil];
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
    
//    cell.textLabel.text = [currencyArray objectAtIndex:indexPath.row];
    
    return cell;
}

@end