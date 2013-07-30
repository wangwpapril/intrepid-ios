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
    [political addTextAreaWithText:@"Short-term opportunistic kidnapping does occur, particularly in urban areas. Victims of “express kidnapping” are forced to withdraw funds from credit or debit cards at a cash point to secure their release. Street crime is a serious problem in Mexico City. Pick-pocketing is common on the Mexico City Metro. Dress in an under-stated manner and avoid wearing expensive jewellery. Limit the amount of cash or credit/debit cards you carry with you. Avoid withdrawing money from ATMs or exchanging money at bureaux de change at night. There have been several co-ordinated muggings in the Parque Nacional de las Cumbres del Ajusco in the south of Mexico City. Take extreme care in this area. Earthquakes do occur periodlically in Mexico City. An earthquake measuring 8.1 on the Richter Scale hit Mexico City in 1985 and was reasponsible for the deaths of 10,000 people.  If an earthquake occurs during your stay in Mexico City, drop to the ground; take cover by getting under a sturdy table or other piece of furniture; and hold on until the shaking stops. If there isn’t a table or desk near you, cover your face and head with your arms and crouch in an inside corner of the building. Stay inside until the shaking stops and it is safe to go outside. Do not exit a building during the shaking. While Mexico City has its own security issues, the decision to travel outside of Mexico City should not be taken lightly, as many parts of Mexico have exceptionally high rates of violent crime associated with drug activity."];
    
    SlidingTextView *embassy = [[SlidingTextView alloc] initWithFrame:frame];
    [embassy setupWithImageName:@"security-embassy.png" withTitle:@"Embassy" withIconName:@"embassy-icon.png"];
    
    SlidingTextView *local = [[SlidingTextView alloc] initWithFrame:frame];
    [local setupWithImageName:@"mexicoBackBigger@2x.png" withTitle:@"Local" withIconName:@"currency-label.png"];
    [local addTextAreaWithText:@"The electricity in Mexico City is the North American standard and converters are not required, with the exception of adaptors for three-prong to two-prong in some older hotels. Travellers to Mexico City may develop traveller’s diarrhea from consuming contaminated water or food. Water precautions should be observed, including avoiding drinks served with ice that may have been made with contaminated water. Communication includes: Telephone networks, including cellular networks are readily available and reliable in Mexico City."];
    
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
