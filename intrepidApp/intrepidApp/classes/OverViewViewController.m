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
#import "Constants.h"
#import "RequestBuilder.h"
#import "CurrencyEntity.h"
#import "TripManager.h"

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
    [history setupWithImageName1x:city.generalImage1x withImageName2x:city.generalImage2x withImageName3x:city.generalImage3x withTitle:@"General" withIconName:@"history-icon"];
    NSMutableArray *historyArray = [NSMutableArray new];
    if (city.location) {
        [historyArray addObject:@{@"Location" : city.location}];
    }
    if (city.climate) {
        [historyArray addObject:@{@"Climate" : city.climate}];
    }
    if (city.typeOfGovernment) {
        [historyArray addObject:@{@"Type Of Government" : city.typeOfGovernment}];
    }
    if (city.visaRequirements) {
        [historyArray addObject:@{@"Visa Requirements" : city.visaRequirements}];
    }
    if (city.communicationInfrastructure) {
        [historyArray addObject:@{@"Communication Infrastructure" : city.communicationInfrastructure}];
    }
    if (city.electricity) {
        [historyArray addObject:@{@"Electricity" : city.electricity}];
    }
    if (city.development) {
        [historyArray addObject:@{@"Development" : city.development}];
    }
    [history addTextAreaWithText:historyArray withIconName:@"history-icon"];
    
    
    SlidingTextView *culture = [[SlidingTextView alloc] initWithFrame:frame];
    [culture setupWithImageName1x:city.cultureImage1x withImageName2x:city.cultureImage2x withImageName3x:city.cultureImage3x withTitle:@"Culture" withIconName:@"culture-icon"];
    NSMutableArray *cultureArray = [NSMutableArray new];
    if (city.location) {
        [cultureArray addObject:@{@"Language" : city.language}];
    }
    if (city.climate) {
        [cultureArray addObject:@{@"Religion" : city.religion}];
    }
    if (city.electricity) {
        [cultureArray addObject:@{@"Ethnic Makeup" : city.ethnicMakeup} ];
    }
    if (city.development) {
        [cultureArray addObject:@{@"Cultural Norms" : city.culturalNorms}];
    }
    [culture addTextAreaWithText:cultureArray withIconName:@"culture-icon"];

//    NSMutableArray *cultureArrayImages = [[NSMutableArray alloc] init];
//    if (city.location) {
//        [cultureArrayImages addObject:[UIImage imageNamed:@"diversity-icon"]];
//    }
//    if (city.climate) {
//        [cultureArrayImages addObject:[UIImage imageNamed:@"diversity-icon"]];
//    }
//    if (city.electricity) {
//        [cultureArrayImages addObject:[UIImage imageNamed:@"diversity-icon"]];
//    }
//    if (city.development) {
//        [cultureArrayImages addObject:[UIImage imageNamed:@"diversity-icon"]];
//    }
    
    SlidingTextView *currency = [[SlidingTextView alloc] initWithFrame:frame];
    [currency setupWithImageName1x:@"" withImageName2x:@"" withImageName3x:@"" withTitle:@"Currency (approx.)" withIconName:@"currency-icon"];
    
    // currency table
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 273,  320, height - 308)];
    tableList.dataSource = self;
    tableList.delegate = self;
    tableList.scrollEnabled = YES;
    tableList.allowsSelection = NO;
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

- (void)populateCurrencyItems {
    CityEntity *city = [self getCity];
    currencyArray = [[TripManager getInstance] getCurrencyItemsWithCity:city];
}

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currencyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    CurrencyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[CurrencyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CurrencyEntity *item = [currencyArray objectAtIndex:indexPath.row];
    [cell setupWithCountry:item.country withValue:item.value];
    
//    UIView *bgColorView = [[UIView alloc] init];
//    [bgColorView setBackgroundColor:UIColorFromRGB(0xdaf1f4)];
//    [cell setSelectedBackgroundView:bgColorView];
//    
//    if (cell.selected) {
//        cell.detailTextLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16];
//    }
    
    return cell;
}

@end
