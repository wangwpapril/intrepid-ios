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

#define PARA_SMALL 18
#define PARA_MEDIUM 24
#define PARA_LARGE 30
#define LIST_SMALL 24
#define LIST_MEDIUM 30
#define LIST_LARGE 34
#define HEADER_SMALL 30
#define HEADER_MEDIUM 36
#define HEADER_LARGE 48

#define METERS_PER_MILE 1609.344

// colors
#define APP_TEXT_COLOR [UIColor colorWithRed: 0.2 green:0.25 blue:0.28 alpha:1]

#define APP_BG_COLOR [UIColor colorWithRed:0.2 green:0.25 blue:0.28 alpha:1]
#define APP_SEARCH_COLOR [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1]

#define APP_TOGGLE_SELECTED [UIColor colorWithRed:1 green:1 blue:1 alpha:1]
#define APP_TOGGLE_UNSELECTED [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1]

#define NAVIGATION_BG_COLOR [UIColor colorWithRed:0.2 green:0.25 blue:0.28 alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kOFFSET_FOR_KEYBOARD 80.0

#endif
