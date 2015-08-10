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
#define APP_FONT_BOLD @"ProximaNova-Bold"

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
#define APP_TEXT_COLOR [UIColor colorWithHue:0.57 saturation:0.33 brightness:0.29 alpha:1]

#define APP_BG_COLOR [UIColor colorWithRed:0.2 green:0.25 blue:0.28 alpha:1]
#define APP_SEARCH_COLOR [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1]
#define APP_BORDER_COLOR [[UIColor colorWithRed:0.91 green:0.9 blue:0.9 alpha:1] CGColor]
#define APP_TOGGLE_SELECTED [UIColor colorWithRed:1 green:1 blue:1 alpha:1]
#define APP_TOGGLE_UNSELECTED [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1]

#define NAVIGATION_BG_COLOR [UIColor colorWithRed:0.2 green:0.25 blue:0.28 alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// system
#define kOFFSET_FOR_KEYBOARD 50.0
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

// Server URLs
#define BASE_URL @"https://api.intrepid247.com/v1/"
#define CURRENCY_URL @"https://openexchangerates.org/api/latest.json?app_id=14073d8e6b8c4687951ed926cbbd3589"
#define EMAIL_URL @"https://mandrillapp.com/api/1.0/messages/send.json"

// Demo user fields (only uncomment 1/3)
//#define APP_NAME @"intrepid_navigator"
//#define FROM_EMAIL @"do-not-reply@intrepid247.com"
//#define FROM_NAME @"Intrepid 24/7"
//#define ACTIVATE_URL @"https://app.intrepid247.com/users/activate/"

// ACE user fields (only uncomment 1/3)
//#define APP_NAME @"ACE_travel_smart"
//#define FROM_EMAIL @"do-not-reply@acetravelsmart.com"
//#define FROM_NAME @"ACE Travel Smart"
//#define ACTIVATE_URL @"https://app.acetravelsmart.com/users/activate/"

// RBC user fields (only uncomment 1/3)
#define APP_NAME @"RBC_navigator"
#define FROM_EMAIL @"do-not-reply@intrepid247.com
#define FROM_NAME @"RBC Insurance"
#define ACTIVATE_URL @"https://app.intrepid247.com/users/activate/"

#endif
