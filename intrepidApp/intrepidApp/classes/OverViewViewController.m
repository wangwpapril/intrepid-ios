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

@implementation OverViewViewController

@synthesize tableList;
@synthesize currencyArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 2;
    [self populateCurrencyItems];
    self.navigationItem.title = @"Mexico Overview";
     
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    
    SlidingTextView *history = [[SlidingTextView alloc] initWithFrame:frame];
    [history setupWithImageName:@"overview-history.png" withTitle:@"General" withIconName:@"descriptionAndSideEffectLogo.png"];
    [history addTextAreaWithText:@"Mexico is bordered to the north by the states of California, Arizona, New Mexico, and Texas, to the west and south by the Pacific Ocean, to the east by the Gulf of Mexico, and to the southeast by Belize, Guatemala, and the Caribbean Sea. Mexico City is located at 7,349 feet (2,240 meters) ASL, Mexico City is temperate and relatively cool but heavily affected by smog due to its limited air circulation. It is surrounded on three sides by mountains and thus the cold fronts from the north make southward intrusions only during the Northern Hemisphere winter and spring. The difference between summer and winter mean temperatures is approximately 6 to 8 °C. The current population of Mexico is 19.5 million. A visa is not required to visit Mexico as a tourist, but you do need a tourist card, which you can obtain on arrival by completing an immigration form, available at border crossings or on-board flights to Mexico. You need a tourist card to leave Mexico. If lost, a tourist card can be replaced at the immigration office at any international airport in Mexico. The cost of a replacement is 295 Mexican Pesos."];
    
    SlidingTextView *culture = [[SlidingTextView alloc] initWithFrame:frame];
    [culture setupWithImageName:@"overview-culture.png" withTitle:@"Culture" withIconName:@"culture-icon.png"];
    [culture addTextAreaWithText:@"The ethnic makeup of Mexico is Mestizos (people of mixed European and Native American background): 60-80% - Amerindian (Totonac, Maya, Zapotec, Mixtec, Otomi and Nahuatl): 10% to 30% - European: 9 to 17%. Religions in Mexico include: Roman Catholic 83%, Protestant 9%, Other 8%. The official language of Mexico is Spanish. Although as many as 100 native languages are spoken, 80% of those Mexicans who speak an indigenous language also speak Spanish.The local currency is the Mexican Peso. US dollar travellers’ cheques and notes are readily converted into local currency. International debit and credit cards are widely accepted for payment and in ATMs. It is not possible to exchange cash at hotel receptions - this can only be done at banks and bureaux de change or Cambios. In Mexio, personal space is usually closer than it is for some other cultures: about an arm distance. It is expected for females to shake hands and kiss on one cheek, particularly in a social setting."];

    SlidingTextView *currency = [[SlidingTextView alloc] initWithFrame:frame];
    [currency setupWithImageName:@"overview-currency.png" withTitle:@"Currency" withIconName:@"currency-Icon.png"];
    
    // table
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
}

-(void)populateCurrencyItems {
    currencyArray = [NSArray arrayWithObjects:
                           [CurrencyItem currencyItemOfCountry:@"Mexican Peso" flag:@"MXN.png" value:@"1"],
                            [CurrencyItem currencyItemOfCountry:@"Canadian Dollar" flag:@"CAD.png" value:@"0.081"],
                            [CurrencyItem currencyItemOfCountry:@"UK Pound" flag:@"GBP.png" value:@"0.051"],
                     [CurrencyItem currencyItemOfCountry:@"Brazilian Real" flag:@"BRL.png" value:@"0.177"],
                     [CurrencyItem currencyItemOfCountry:@"Australian Dollar" flag:@"AUS.png" value:@"0.085"],
                     [CurrencyItem currencyItemOfCountry:@"US Dollar" flag:@"USD.png" value:@"0.078"],
                     [CurrencyItem currencyItemOfCountry:@"Euro" flag:@"EUR.png" value:@"0.059"],
                     [CurrencyItem currencyItemOfCountry:@"Chinese Yen" flag:@"CNY.png" value:@"0.483"],
                     [CurrencyItem currencyItemOfCountry:@"Swiss Franc" flag:@"CHF.png" value:@"0.073"],
                     [CurrencyItem currencyItemOfCountry:@"Malaysian Ringgit" flag:@"MYR.png" value:@"0.252"],
                     [CurrencyItem currencyItemOfCountry:@"Thai Bhat" flag:@"THB.png" value:@"2.456"],
                     [CurrencyItem currencyItemOfCountry:@"Indian Rupee" flag:@"INR.png" value:@"4.66"],
                     [CurrencyItem currencyItemOfCountry:@"Dominican Peso" flag:@"DOP.png" value:@"3.29"],nil];
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
