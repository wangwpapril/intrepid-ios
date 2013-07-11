//
//  Constants.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#ifndef intrepidApp_Constants_h
#define intrepidApp_Constants_h

#define APP_FONT @"Helvetica Neue"
#define APP_BG_COLOR [UIColor colorWithRed: 248.0/255 green: 248.0/255 blue: 248.0/255 alpha: 1.0]
#define APP_TEXT_COLOR [UIColor colorWithRed: 79.0/255 green: 79.0/255 blue: 79.0/255 alpha: 1.0]
#define NAVIGATION_BG_COLOR [UIColor colorWithRed:69/255.0f green:64/255.0f blue:62/255.0f alpha:1.0f]
#define NAVIGATION_TEXT_COLOR [UIColor colorWithRed:231/255.0f green:238/255.0f blue:226/255.0f alpha:1.0f]
#define NAVIGATION_TEXT_OFF_COLOR [UIColor colorWithRed:189/255.0f green:185/255.0f blue:177/255.0f alpha:1.0f]
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]





#endif
