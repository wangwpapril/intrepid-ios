//
//  EmbassyDetailedViewViewController.h
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmbassyItem.h"

@interface EmbassyDetailedViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
}
@property (nonatomic, strong) EmbassyItem * embassyItem;


@end
