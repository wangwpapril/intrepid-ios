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
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionDesignationLabel;

@property (nonatomic, strong) HealthItem *healthItem;

@property (nonatomic, strong) IBOutlet UILabel *sideEffectsLabel;
@property (nonatomic, strong) IBOutlet UILabel *sideEffectsDesignationLabel;

@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UITextView *sideEffectsText;

@property (nonatomic, strong) IBOutlet UILabel *descriptionImageLabel;
@property (nonatomic, strong) IBOutlet UILabel *sideEffectsImageLabel;

@end
