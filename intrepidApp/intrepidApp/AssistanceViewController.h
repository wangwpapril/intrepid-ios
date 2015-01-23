//
//  AssistanceViewController.h
//  intrepidApp
//
//  Created by Ian Page on 2013-08-04.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"
#import "MapKit/MapKit.h"

@interface AssistanceViewController : UIViewController <UIActionSheetDelegate, MKMapViewDelegate> {
    UIScrollView *scrollView;
}

@property (nonatomic, strong) MenuController *mController;

@end
