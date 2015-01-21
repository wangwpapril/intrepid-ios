//
//  HealthViewDetailController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthEntity.h"


@interface HealthViewDetailController : UIViewController {    
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, strong) HealthEntity *healthItem;

@end
