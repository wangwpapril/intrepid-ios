//
//  OverViewViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SliderTabViewController.h"

@interface OverViewViewController : SliderTabViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSArray *currencyArray;

@end

/*
//
//  HealthViewDetailController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthItem.h"


@interface HealthViewDetailController : UIViewController {
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, strong) IBOutlet UILabel *healthItemNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *healthItemTitleLabel;
@property (nonatomic, strong) HealthItem *healthItem;


@end
*/