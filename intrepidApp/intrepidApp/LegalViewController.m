//
//  LegalViewController.m
//  intrepidApp
//
//  Created by Ian Page on 2013-08-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "LegalViewController.h"

@interface LegalViewController ()

@end

@implementation LegalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signUp-background.png"]];
    [self.view addSubview:backgroundView];
    
    CGRect rect=CGRectMake(0, 0, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    
    UITextView *legal = [[UITextView alloc] init];
    legal.frame = CGRectMake(0, 10, 320, 2100);
    legal.text = @"YOUR ACCESS TO THIS APP IS SUBJECT TO LEGALLY BINDING TERMS AND CONDITIONS. PLEASE CAREFULLY READ THE FOLLOWING TERMS AND CONDITIONS BEFORE USING THIS APP.\n This app is operated by Ingle International Inc. operating as Intrepid 24/7. The purpose of this app is to provide health, security, and other travel-related information, as well as access to emergency assistance services offered by Intrepid 24/7, to members.\n\n Disclaimer\n CONTENTS ON THE APP ARE PROVIDED ON AN 'AS IS' AND 'AS AVAILABLE' BASIS WITH NO WARRANTIES OR CONDITIONS WHATSOEVER. INTREPID 24/7 EXPRESSLY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT OF THIRD PARTIES' RIGHTS. WITHOUT LIMITING THE FOREGOING, INTREPID 24/7 AND ITS LICENSORS AND SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES THAT: (A) THE APP WILL MEET YOUR REQUIREMENTS; (B) THE APP WILL BE AVAILABLE ON AN UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE BASIS; (C) THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF THE APP (INCLUDING ANY RESULTS OBTAINED FROM ANY DIAGNOSIS OR ASSESSMENT TOOLS), OR ANY INFORMATION, PRODUCTS, OR SERVICES OFFERED THROUGH THE APP OR OTHERWISE WILL BE ACCURATE, COMPLETE, OR RELIABLE; (D) ANY GOVERNMENT REGULATIONS REQUIRING DISCLOSURE OF INFORMATION ON PRESCRIPTION DRUG PRODUCTS HAVE BEEN SATISFIED; OR (E) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIALS OBTAINED BY YOU THROUGH THE APP, ANY THIRD PARTY APP, OR OTHERWISE WILL MEET YOUR EXPECTATIONS.\n\n Limitation of Liability\n IN NO EVENT SHALL INTREPID 24/7 BE LIABLE TO YOU BASED ON YOUR USE OR MISUSE OF AND RELIANCE ON THE CONTENT OR OTHER MATERIALS ACCESSIBLE ON OR VIA THE APP. IN NO EVENT SHALL INTREPID 24/7 BE LIABLE TO YOU OR ANY PERSON WITH RESPECT TO DAMAGES OF ANY KIND ARISING FROM OR RELATING TO ANY SERVICES OR GOODS NOT PROVIDED BY INTREPID 24/7 EVEN IF THEY ARE ADVERTISED ON THE APP OR RECEIVED THROUGH ANY LINKS PROVIDED IN THE APP. INTREPID 24/7 HAS NO LIABILITY TO YOU WHATSOEVER FOR ANY PERSONAL INJURY (INCLUDING DEATH) CAUSED BY YOUR USE OR MISUSE OF THE CONTENT OR THE APP WITHOUT LIMITING THE PRECEDING PARAGRAPHS OF THIS SECTION, THE LIMIT ON THE TOTAL CUMULATIVE LIABILITY OF INTREPID 24/7 TO YOU OR ANY PERSON, FOR ANY CLAIMS ARISING OUT OF OR RELATING TO THE APP, THE CONTENT, OR THIS AGREEMENT SHALL NOT IN ANY EVENT EXCEED $100.00 CDN.\n The limitations specified above shall ly regardless of the causes or circumstances giving rise to the claim, even if such claim is based on breach of contract, negligence or other tort, and shall survive a fundamental breach or failure of essential purpose of any limited remedy or this Agreement.\n\n Privacy\n No personal information is collected about you on this app except where you voluntarily disclose it. When you voluntarily disclose your personal information on this app, it will be used for the sole purpose of communicating with you to respond to a request or to provide information. Intrepid 24/7 will not sell, rent, or lease your personal information to any third parties. Intrepid 24/7 may access, use, and/or disclose your personal information if required by law. We may also do so where we have reasonable grounds to believe that such access or disclosure is necessary to prevent or investigate any breach of this Agreement or contravention of a law, or in urgent circumstances to protect the life, health, or security of any person. Intrepid 24/7 may also disclose your Personal Information to its successor or any assignee, as necessary, without notice to you provided that that successor or assignee agrees to comply with the then current version of this Privacy Policy. Intrepid 24/7 is committed to protecting the security of your personal information. Intrepid 24/7 uses a variety of security and information technologies and procedures to help protect your personal information from unauthorized access, use, or disclosure.\n\n Use of Content from the App and Intellectual Property Notice\n The contents of the app, including any and all information, content, links, reports, data, databases, tools, code, photographs, pictures, video, files, graphics, interfaces, web pages, text, files, software, product names, company names, trademarks, logos, trade names, or other materials contained on the app (collectively the 'Content'), including the manner in which the Content is presented or appears and all information relating thereto, are the property of their respective owners as indicated, Intrepid 24/7, or their licensors, as the case may be. Except as expressly provided, you are not granted any rights in or to the Content available on or via the app. All such rights remain with, and are reserved by, their respective owners. You are authorized to view and download the information on the app for your personal, noncommercial use as long as you do not remove any copyright and other proprietary rights notices that may be included in the Content downloaded. No other use of the Content (including linking to the Content from an external site) is permitted without Intrepid 24/7's prior written consent. Names, phrases, logos, icons, graphics, images, or designs, used throughout the app may be trade names, registered or unregistered trademarks, or services marks ('Trademarks') of Intrepid 24/7 or other entities and individuals. The display of Trademarks on this app is not an implied license to any third party for use of the Trademarks.";
    legal.editable = NO;
    legal.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
    legal.backgroundColor = [UIColor clearColor];
    legal.scrollEnabled = NO;
    legal.textColor = [UIColor whiteColor];
    legal.textAlignment = NSTextAlignmentCenter;
    
    [scrollView addSubview:legal];
    
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(320, legal.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
