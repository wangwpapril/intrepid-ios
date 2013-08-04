//
//  AssistanceViewController.h
//  intrepidApp
//
//  Created by Ian Page on 2013-08-04.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"

@interface AssistanceViewController : UIViewController {
    UISwitch *onOff;
    UIScrollView *scrollView;
}

@property (nonatomic, strong) MenuController *mController;
@property (retain, nonatomic) IBOutlet UISwitch *onOff;

@end
