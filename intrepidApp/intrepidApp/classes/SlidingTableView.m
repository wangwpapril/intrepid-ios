//
//  SlidingTableView.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SlidingTableView.h"
#import "QuartzCore/QuartzCore.h"
#import "Constants.h"

@implementation SlidingTableView

@synthesize tableList;
@synthesize dataArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setupWithImageName:(NSString *)image withTitle:(NSString *)title withIconName:(NSString *)icon withArray:(NSArray *)array {
    
    // top image
    UIImageView  *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.frame = CGRectMake(0, 0, 320, 268);
    [self addSubview:imageView];
    
    // title background
    UIView *borderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 268, 320, 40)];
    borderLine.layer.borderColor = [UIColor colorWithRed:231.0/255 green:238.0/255 blue:226.0/255 alpha:1].CGColor;
    borderLine.layer.borderWidth = 1;
    
    // actual title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 0, 159, 40)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:16];
    titleLabel.textColor = APP_TEXT_COLOR;
    [borderLine addSubview:titleLabel];
    [self addSubview:borderLine];
    
    // icon
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    iconView.frame = CGRectMake(14, 275, 25, 25);
    [self addSubview:iconView];
    
    
    // table
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 308,  320, self.bounds.size.height - 308)];
    tableList.dataSource = self;
    tableList.delegate = self;
    [self addSubview:tableList];
    
    // source
    dataArray = array;
}

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];

    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (![searchBar.text isEqualToString:@""]) {
//        selectedItem = (HealthItem *)[filteredHealthItemArray objectAtIndex:indexPath.row];
//    }
//    else {
//        selectedItem = (HealthItem *)[[contentArray objectAtIndex:currentTab] objectAtIndex:indexPath.row];
//    }
//    [self performSegueWithIdentifier:@"details" sender:self];
//}


@end
