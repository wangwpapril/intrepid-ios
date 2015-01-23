//
//  MenuController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/7/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityEntity.h"
#import <CoreLocation/CoreLocation.h>

@interface MenuController : NSObject

@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, strong) UIImageView *menu;
@property (nonatomic) NSInteger viewHeight;
@property (nonatomic) CGRect botPosition;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UIImage *upRight;
@property (nonatomic, strong) UIImage *flipped;
@property (nonatomic) BOOL hiding;
@property (nonatomic, strong) CityEntity *city;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIButton *outsideMenu;
@property (strong, nonatomic) CLLocation *location;

+(MenuController *)getInstance;
-(void)displayMenuWithParent:(UIViewController *)controller;
-(void)showMenu;
- (void)selectButtonWithTag:(NSInteger)tag;
@end
