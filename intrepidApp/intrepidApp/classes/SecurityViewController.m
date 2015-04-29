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
#import "EmbassyDetailedViewController.h"
#import "EmbassyEntity.h"
#import "TripManager.h"

@implementation SecurityViewController

@synthesize tableList;
@synthesize embassyArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 2;
    self.navigationItem.title = @"Security";
    
    NSInteger height = self.view.bounds.size.height;
    CGRect frame = CGRectMake(0, 0, 320, height);
    CityEntity *city = [self getCity];
    
    SlidingTextView *political = [[SlidingTextView alloc] initWithFrame:frame];
    [political setupWithImageName1x:city.safetyImage1x withImageName2x:city.safetyImage2x withImageName3x:city.safetyImage3x withTitle:@"Safety"];
    NSMutableArray *politicalArray = [NSMutableArray new];
    if (city.safety) {
        [politicalArray addObject:@[@"Safety", city.safety, @"safety-icon"]];
    }
    if (city.otherConcerns) {
        [politicalArray addObject:@[@"Other Concerns", city.otherConcerns, @"political-icon"]];
    }
    [political addTextAreaWithText:politicalArray];
    
    SlidingTextView *medical = [[SlidingTextView alloc] initWithFrame:frame];
    [medical setupWithImageName1x:city.medicalImage1x withImageName2x:city.medicalImage2x withImageName3x:city.medicalImage3x withTitle:@"Medical"];
    NSMutableArray *medicalArray = [NSMutableArray new];
    if (city.healthCareQuality) {
        [medicalArray addObject:@[@"Health Care Quality", city.healthCareQuality, @"healthcare-icon"]];
    }
    if (city.vaccinationsAndPreTripMedical) {
        [medicalArray addObject:@[@"Vaccines and Pre-trip Medical", city.vaccinationsAndPreTripMedical, @"vaccines-icon"]];
    }
    if (city.healthConditions) {
        [medicalArray addObject:@[@"Health Conditions", city.healthConditions, @"conditions-icon"]];
    }
    [medical addTextAreaWithText:medicalArray];
    
    SlidingTextView *embassy = [[SlidingTextView alloc] initWithFrame:frame];
    [self populateEmbassyItems];    
    if (embassyArray.count > 0) {
        EmbassyEntity *embassyEntity = embassyArray[0];
        [embassy setupWithImageName1x:embassyEntity.image1x withImageName2x:embassyEntity.image2x withImageName3x:embassyEntity.image3x withTitle:@"Embassy"];
    } else {
        [embassy setupWithImageName1x:@"" withImageName2x:@"" withImageName3x:@"" withTitle:@"Embassy"];
    }

    // embassies
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 273,  320, height - 308)];
    tableList.dataSource = self;
    tableList.delegate = self;
    tableList.scrollEnabled = YES;
    [embassy addTableViewWithRows:embassyArray.count withTableView:tableList];
    
    NSMutableArray *views = [NSMutableArray arrayWithObjects:political, medical, embassy, nil];
    [self addViews:views withVerticalOffset:0];

    NSArray *names = [NSArray arrayWithObjects:@"SAFETY", @"MEDICAL", @"EMBASSY", nil];
    [self addTabs:names];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    } else {
        [self moveAllSubviewsDown];
    }
}

- (void)moveAllSubviewsDown {
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (void)populateEmbassyItems {
    CityEntity *city = [self getCity];
    
    embassyArray = [[TripManager getInstance] getEmbassyItemsWithCity:city];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.currentTab == 0) {
        [[SEGAnalytics sharedAnalytics] screen:@"Safety"];
    } else if (self.currentTab == 1) {
        [[SEGAnalytics sharedAnalytics] screen:@"Embassy"];
    }
}

- (void)viewSwitched {
    if (self.currentTab == 0) {
        [[SEGAnalytics sharedAnalytics] screen:@"Safety"];
    } else if (self.currentTab == 1) {
        [[SEGAnalytics sharedAnalytics] screen:@"Embassy"];
    }
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
    [cell setupWithEmbassy:embassy];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EmbassyEntity *selectedItem = [embassyArray objectAtIndex:indexPath.row];
    EmbassyDetailedViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"embassyDetailed"];
    viewController.embassyItem = selectedItem; // MUST CHANGE, same for detailed controller
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
