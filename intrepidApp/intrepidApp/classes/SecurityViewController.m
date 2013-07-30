//
//  SecurityViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SecurityViewController.h"
#import "SlidingTextView.h"
#import "EmbassyCell.h"
#import "EmbassyItem.h"
#import "Constants.h"


@implementation SecurityViewController

@synthesize tableList;
@synthesize embassyArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 0;
    
    
    [self populateEmbassyItems];
    self.navigationItem.title = @"Mexico Security";
    
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    
    SlidingTextView *political = [[SlidingTextView alloc] initWithFrame:frame];
    [political setupWithImageName:@"security-political.png" withTitle:@"Political" withIconName:@"descriptionAndSideEffectLogo.png"];
    [political addTextAreaWithText:@"blah"];
    
    SlidingTextView *embassy = [[SlidingTextView alloc] initWithFrame:frame];
    [embassy setupWithImageName:@"security-embassy.png" withTitle:@"Embassy" withIconName:@"embassy-icon.png"];
    
    SlidingTextView *local = [[SlidingTextView alloc] initWithFrame:frame];
    [local setupWithImageName:@"mexicoBackBigger@2x.png" withTitle:@"Local" withIconName:@"currency-label.png"];
    [local addTextAreaWithText:@"bleh"];
    
    // table
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 308,  320, height - 308)];
    tableList.dataSource = self;
    tableList.delegate = self;
    tableList.scrollEnabled = YES;
    [embassy addSubview:tableList];
    
    NSMutableArray *views = [NSMutableArray arrayWithObjects:political, embassy, local, nil];
    [self addViews:views withVerticalOffset:0];
    
    [self.view bringSubviewToFront:self.mController.menu];
    NSArray *names = [NSArray arrayWithObjects:@"POLITICAL", @"EMBASSY", @"LOCAL", nil];
    [self addTabs:names];

}

-(void)populateEmbassyItems {
    embassyArray = [NSArray arrayWithObjects:
                     [EmbassyItem currencyItemOfCountry:@"United States" flag:@"USD.png"],
                     [EmbassyItem currencyItemOfCountry:@"Canadian" flag:@"CAD.png"],
                     [EmbassyItem currencyItemOfCountry:@"United Kingdom" flag:@"GBP.png"],
                     [EmbassyItem currencyItemOfCountry:@"Brazil" flag:@"BRL.png"],
                    [EmbassyItem currencyItemOfCountry:@"European Union" flag:@"EUR.png"],
                    [EmbassyItem currencyItemOfCountry:@"Switzerland" flag:@"CHF.png"],
                    [EmbassyItem currencyItemOfCountry:@"China" flag:@"CNY.png"],
                    [EmbassyItem currencyItemOfCountry:@"India" flag:@"INR.png"],
                    [EmbassyItem currencyItemOfCountry:@"Thailand" flag:@"THB.png"],
                    [EmbassyItem currencyItemOfCountry:@"Australia" flag:@"AUS.png"],
                    [EmbassyItem currencyItemOfCountry:@"Malaysia" flag:@"MYR.png"],
                    [EmbassyItem currencyItemOfCountry:@"Dominican Republic" flag:@"DOP.png"],
                    [EmbassyItem currencyItemOfCountry:@"Mexico" flag:@"MXN.png"], nil];
}

# pragma mark - tableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return embassyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    EmbassyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[EmbassyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    EmbassyItem *item = [embassyArray objectAtIndex:indexPath.row];
    [cell setupWithImageName:item.flag withCountry:item.country];
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:UIColorFromRGB(0xdaf1f4)];
    [cell setSelectedBackgroundView:bgColorView];
    
    if (cell.selected) {
        cell.detailTextLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
