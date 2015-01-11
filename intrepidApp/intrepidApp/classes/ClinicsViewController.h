//
//  ClinicsViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2015-01-08.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "ScrollerTabViewController.h"
#import "MenuController.h"

@interface ClinicsViewController : ScrollerTabViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITableView *clinicsTable;

@end
