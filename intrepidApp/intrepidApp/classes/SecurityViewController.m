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
//#import "EmbassyItem.h"
#import "Constants.h"
#import "EmbassyDetailedViewController.h"
#import "EmbassyEntity.h"
//#import "CityEntity.h"
//#import "EmbassyDetailedContent.h"


@implementation SecurityViewController

@synthesize tableList;
@synthesize embassyArray;
//@synthesize firstLoad;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 2;

//    EmbassyDetailedContent *content = [[EmbassyDetailedContent alloc] init];
    embassyArray = [self.mController.city.embassies allObjects]; // makes array from set
    self.navigationItem.title = @"Security";
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    CityEntity *city = [self getCity];
    SlidingTextView *political = [[SlidingTextView alloc] initWithFrame:frame];
    
    [political setupWithImageName:city.politicalImage withTitle:@"Political" withIconName:@"Political-icon@2x.png"];
    [political addTextAreaWithText:city.politicalText];
    
    SlidingTextView *embassy = [[SlidingTextView alloc] initWithFrame:frame];
    [embassy setupWithImageName:@"security-embassy.png" withTitle:@"Embassy" withIconName:@"embassy-icon.png"];
    
    SlidingTextView *local = [[SlidingTextView alloc] initWithFrame:frame];
    [local setupWithImageName:city.localImage withTitle:@"Local" withIconName:@"Tourist-icon1@2x.png"];
    [local addTextAreaWithText:city.localText];
    
    // embassies
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 308,  320, height - 308)];
    tableList.dataSource = self;
    tableList.delegate = self;
    tableList.scrollEnabled = YES;
    [embassy addTableViewWithRows:embassyArray.count withTableView:tableList];
    
    NSMutableArray *views = [NSMutableArray arrayWithObjects:political, embassy, local, nil];
    [self addViews:views withVerticalOffset:0];

    NSArray *names = [NSArray arrayWithObjects:@"POLITICAL", @"EMBASSY", @"LOCAL", nil];
    [self addTabs:names];

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
    
    EmbassyEntity *embassy = [embassyArray objectAtIndex:indexPath.row];
    [cell setupWithImageName:embassy.flag withCountry:embassy.country]; // dsnt exist yet
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:UIColorFromRGB(0xdaf1f4)];
    [cell setSelectedBackgroundView:bgColorView];
    
    if (cell.selected) {
        cell.detailTextLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:16];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EmbassyEntity *selectedItem = [embassyArray objectAtIndex:indexPath.row];
    EmbassyDetailedViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"embassyDetailed"];
    viewController.embassyItem = selectedItem; // MUST CHANGE, same for detailed controller
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
