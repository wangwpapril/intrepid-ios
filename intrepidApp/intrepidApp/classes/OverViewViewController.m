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
#import "Constants.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation OverViewViewController

@synthesize tableList;
@synthesize currencyArray;
@synthesize firstLoad;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 0;
    [self populateCurrencyItems];
    self.navigationItem.title = @"Overview";
         
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    
    CityEntity *city = [self getCity];
    
    SlidingTextView *history = [[SlidingTextView alloc] initWithFrame:frame];
    [history setupWithImageName:city.generalImage withTitle:@"General" withIconName:@"descriptionAndSideEffectLogo"];
    [history addTextAreaWithText:city.generalText];
    
    
    SlidingTextView *culture = [[SlidingTextView alloc] initWithFrame:frame];
    [culture setupWithImageName:city.cultureImage withTitle:@"Culture" withIconName:@"culture-icon"];
    [culture addTextAreaWithText:city.cultureText];
    

    SlidingTextView *currency = [[SlidingTextView alloc] initWithFrame:frame];
    [currency setupWithImageName:@"overview-currency" withTitle:@"Currency (approx.)" withIconName:@"Currency-Icon"];
    
    // currency table
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 308,  320, height - 308)];
    tableList.dataSource = self;
    tableList.delegate = self;
    tableList.scrollEnabled = YES;
    [currency addTableViewWithRows:currencyArray.count withTableView:tableList];
    
    NSMutableArray *views = [NSMutableArray arrayWithObjects:history, culture, currency, nil];
    [self addViews:views withVerticalOffset:0];
    
//    [self.view bringSubviewToFront:self.mController.menu];
    NSArray *names = [NSArray arrayWithObjects:@"GENERAL", @"CULTURE", @"CURRENCY", nil];
    [self addTabs:names];
    
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



-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    [tableList selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        if (firstLoad) {
            [[MenuController getInstance] showMenu];
            firstLoad = false;
        }
}

-(void)populateCurrencyItems {
    CityEntity *city = [self getCity];
    float CADtoNative = [city.cadToNative floatValue];

    NSString* CAD = [NSString stringWithFormat:@"%.02f", 1.0];
    NSString* USD = [NSString stringWithFormat:@"%.02f", 0.96];
    NSString* MXN = [NSString stringWithFormat:@"%.02f", 12.19];
    NSString* GBP = [NSString stringWithFormat:@"%.02f", 0.63];
    NSString* BRL = [NSString stringWithFormat:@"%.02f", 2.20];
    NSString* AUS = [NSString stringWithFormat:@"%.02f", 1.08];
    NSString* EUR = [NSString stringWithFormat:@"%.02f", 0.72];
    NSString* CNY = [NSString stringWithFormat:@"%.02f", 5.90];
    NSString* CHF = [NSString stringWithFormat:@"%.02f", 0.89];
    NSString* MYR = [NSString stringWithFormat:@"%.02f", 3.14];
    NSString* THB = [NSString stringWithFormat:@"%.02f", 30.09];
    NSString* INR = [NSString stringWithFormat:@"%.02f", 58.81];
    NSString* DOP = [NSString stringWithFormat:@"%.02f", 40.38];
    
    currencyArray = [NSMutableArray arrayWithObjects:
                     [CurrencyItem currencyItemOfCountry:@"Canadian Dollar" flag:@"CAD" value:CAD],
                     [CurrencyItem currencyItemOfCountry:@"Mexican Peso" flag:@"MXN" value:MXN],
                     [CurrencyItem currencyItemOfCountry:@"US Dollar" flag:@"USD" value:USD],
                     [CurrencyItem currencyItemOfCountry:@"Euro" flag:@"EUR" value:EUR],
                     [CurrencyItem currencyItemOfCountry:@"UK Pound" flag:@"GBP" value:GBP],
                     [CurrencyItem currencyItemOfCountry:@"Chinese Yen" flag:@"CNY" value:CNY],
                     [CurrencyItem currencyItemOfCountry:@"Brazilian Real" flag:@"BRL" value:BRL],
                     [CurrencyItem currencyItemOfCountry:@"Australian Dollar" flag:@"AUS" value:AUS],
                     [CurrencyItem currencyItemOfCountry:@"Swiss Franc" flag:@"CHF" value:CHF],
                     [CurrencyItem currencyItemOfCountry:@"Indian Rupee" flag:@"INR" value:INR],
                     [CurrencyItem currencyItemOfCountry:@"Thai Bhat" flag:@"THB" value:THB],
                     [CurrencyItem currencyItemOfCountry:@"Malaysian Ringgit" flag:@"MYR" value:MYR],
                     [CurrencyItem currencyItemOfCountry:@"Dominican Peso" flag:@"DOP" value:DOP],nil];

    NSString* native = [NSString stringWithFormat:@"%.02f", CADtoNative];

    BOOL foundNative = false;
    NSInteger i = 0;
    NSInteger limit = currencyArray.count;
    while (i < limit && !foundNative) {
        CurrencyItem *item = [currencyArray objectAtIndex:i];
        if ([item.value isEqualToString:native]){
            CurrencyItem *toAdd = item;
            [currencyArray removeObject:item];
            [currencyArray insertObject:toAdd atIndex:1];
            foundNative = true;
        }
        i++;
    }
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
    }
    
    CurrencyItem *item = [currencyArray objectAtIndex:indexPath.row];
    [cell setupWithImageName:item.flag withCountry:item.country withValue:item.value];
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:UIColorFromRGB(0xdaf1f4)];
    [cell setSelectedBackgroundView:bgColorView];
    
    if (cell.selected) {
        cell.detailTextLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16];
    }    
    
    return cell;
}

@end
