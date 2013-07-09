//
//  HealthViewDetailController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HealthViewDetailController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *healthItemNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionDesignationLabel;

@property (nonatomic, strong) NSString *healthItemName;
@property (nonatomic, strong) NSString *healthItemCategory;

@property (nonatomic, strong) IBOutlet UILabel *sideEffectsLabel;
@property (nonatomic, strong) IBOutlet UILabel *sideEffectsDesignationLabel;

@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UITextView *sideEffectsText;

@property (nonatomic, strong) IBOutlet UILabel *descriptionImageLabel;
@property (nonatomic, strong) IBOutlet UILabel *sideEffectsImageLabel;

@end
