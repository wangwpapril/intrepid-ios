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
    self.view.tag = 2;
    
    
    [self populateEmbassyItems];
    self.navigationItem.title = @"Mexico Security";
    
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    
    SlidingTextView *political = [[SlidingTextView alloc] initWithFrame:frame];
    [political setupWithImageName:@"overview-history.png" withTitle:@"Political" withIconName:@"descriptionAndSideEffectLogo.png"];
    [political addTextArea];
    
    SlidingTextView *embassy = [[SlidingTextView alloc] initWithFrame:frame];
    [embassy setupWithImageName:@"overview-culture.png" withTitle:@"Embassy" withIconName:@"culture-icon.png"];
    
    SlidingTextView *local = [[SlidingTextView alloc] initWithFrame:frame];
    [local setupWithImageName:@"overview-currency.png" withTitle:@"Local" withIconName:@"currency-label.png"];
    [local addTextArea];
    
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
                     [EmbassyItem currencyItemOfCountry:@"American Embassy" flag:@"american-flag.png"],
                     [EmbassyItem currencyItemOfCountry:@"Canadian Embassy" flag:@"canadian-flag.png"],
                     [EmbassyItem currencyItemOfCountry:@"UK Embassy" flag:@"great-britain-flag.png"],
                     [EmbassyItem currencyItemOfCountry:@"Brazilian Embassy" flag:@"brasil-flag.png"], nil];
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
