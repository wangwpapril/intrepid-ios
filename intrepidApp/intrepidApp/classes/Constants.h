//
//  Constants.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/4/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#ifndef intrepidApp_Constants_h
#define intrepidApp_Constants_h

// font and font size
#define APP_FONT @"ProximaNova-Regular"


#define PARA_SMALL 9
#define PARA_MEDIUM 12
#define PARA_LARGE 15
#define LIST_SMALL 12
#define LIST_MEDIUM 15
#define LIST_LARGE 17
#define HEADER_SMALL 15
#define HEADER_MEDIUM 18
#define HEADER_LARGE 24

#define APP_TEXT_COLOR [UIColor colorWithRed: 66.0/255 green: 58.0/255 blue: 56.0/255 alpha: 1.0]

#define APP_BG_COLOR [UIColor colorWithRed: 248.0/255 green: 248.0/255 blue: 248.0/255 alpha: 1.0]
#define APP_SEARCH_COLOR [UIColor colorWithRed: 231.0/255 green: 238.0/255 blue: 226.0/255 alpha: 1]

#define APP_TOGGLE_SELECTED [UIColor colorWithRed: 202.0/255 green: 199.0/255 blue: 194.0/255 alpha: 1.0]
#define APP_TOGGLE_UNSELECTED [UIColor colorWithRed: 160.0/255 green: 156.0/255 blue: 155.0/255 alpha: 1.0]

#define NAVIGATION_BG_COLOR [UIColor colorWithRed:66/255.0f green:58/255.0f blue:56/255.0f alpha:1]

//#define NAVIGATION_TEXT_COLOR [UIColor colorWithRed:231/255.0f green:238/255.0f blue:226/255.0f alpha:1.0f]
//#define NAVIGATION_TEXT_OFF_COLOR [UIColor colorWithRed:189/255.0f green:185/255.0f blue:177/255.0f alpha:1.0f]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kOFFSET_FOR_KEYBOARD 80.0





#endif
