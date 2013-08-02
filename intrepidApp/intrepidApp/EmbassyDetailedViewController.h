//
//  EmbassyDetailedViewViewController.h
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmbassyDetailedItem.h"
#import "EmbassyDetailedContent.h"

@interface EmbassyDetailedViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
}

//@property (nonatomic, strong) IBOutlet UILabel *embassyDetailedItemNameLabel;
//@property (nonatomic, strong) IBOutlet UILabel *embassyDetailedItemTitleLabel;
@property (nonatomic, strong) EmbassyDetailedItem *embassyDetailedItem;

@end
