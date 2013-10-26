//
//  TermsOfServiceViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-30.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TermsOfServiceViewController.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface TermsOfServiceViewController ()

@end

@implementation TermsOfServiceViewController

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
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"signup-background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    CGRect rect=CGRectMake(0, 0, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;

    
    UITextView *termsOfService = [[UITextView alloc] init];
    termsOfService.frame = CGRectMake(0, 10, 320, 2250);
    termsOfService.text = @"YOUR ACCESS TO THIS APP IS SUBJECT TO LEGALLY BINDING TERMS AND CONDITIONS. PLEASE CAREFULLY READ THE FOLLOWING TERMS AND CONDITIONS BEFORE USING THIS APP. This app is operated by Ingle International Inc. operating as Intrepid 24/7. The purpose of this app is to provide information on emergency assistance services offered by Intrepid 24/7. This app also contains other general information that you may find helpful.\n\nUse of Content from the app and Intellectual Property Notice\nThe contents of the app, including any and all information, content, links, reports, data, databases, tools, code, photographs, pictures, video, files, graphics, interfaces, web pages, text, files, software, product names, company names, trademarks, logos, trade names, or other materials contained on the app (collectively the 'Content'), including the manner in which the Content is presented or appears and all information relating thereto, are the property of their respective owners as indicated, Intrepid 24/7, or their licensors, as the case may be. Except as expressly provided, you are not granted any rights in or to the Content available on or via the app. All such rights remain with, and are reserved by, their respective owners.\nYou are authorized to view and download the information on the app for your personal, non-commercial use as long as you do not remove any copyright and other proprietary rights notices that may be included in the Content downloaded. No other use of the Content (including linking to the Content from an external app) is permitted without Intrepid 24/7's prior written consent.\nNames, phrases, logos, icons, graphics, images, or designs, used throughout the app may be trade names, registered or unregistered trademarks, or services marks ('Trademarks') of Intrepid 24/7 or other entities and individuals. The display of Trademarks on this app is not an implied license to any third party for use of the Trademarks\n\nWARRANTY DISCLAIMER\nCONTENTS ON THE APP ARE PROVIDED ON AN 'AS IS' AND 'AS AVAILABLE' BASIS WITH NO WARRANTIES OR CONDITIONS WHATSOEVER. INTREPID 24/7 EXPRESSLY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT OF THIRD PARTIES' RIGHTS. WITHOUT LIMITING THE FOREGOING, INTREPID 24/7 AND ITS LICENSORS AND SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES THAT: (A) THE APP WILL MEET YOUR REQUIREMENTS; (B) THE APP WILL BE AVAILABLE ON AN UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE BASIS; (C) THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF THE APP (INCLUDING ANY RESULTS OBTAINED FROM ANY DIAGNOSIS OR ASSESSMENT TOOLS), OR ANY INFORMATION, PRODUCTS, OR SERVICES OFFERED THROUGH THE APP OR OTHERWISE WILL BE ACCURATE, COMPLETE, OR RELIABLE; (D) ANY GOVERNMENT REGULATIONS REQUIRING DISCLOSURE OF INFORMATION ON PRESCRIPTION DRUG PRODUCTS HAVE BEEN SATISFIED; OR (E) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIALS OBTAINED BY YOU THROUGH THE APP, ANY THIRD PARTY APP, OR OTHERWISE WILL MEET YOUR EXPECTATIONS.\n\nLIMITATION OF LIABILITY\nIN NO EVENT SHALL INTREPID 24/7 BE LIABLE TO YOU BASED ON YOUR USE OR MISUSE OF AND RELIANCE ON THE CONTENT OR OTHER MATERIALS ACCESSIBLE ON OR VIA THE APP.\nIN NO EVENT SHALL INTREPID 24/7 BE LIABLE TO YOU OR ANY PERSON WITH RESPECT TO DAMAGES OF ANY KIND ARISING FROM OR RELATING TO ANY SERVICES OR GOODS NOT PROVIDED BY INTREPID 24/7 EVEN IF THEY ARE ADVERTISED ON THE APP OR RECEIVED THROUGH ANY LINKS PROVIDED IN THE APP.\nINTREPID 24/7 HAS NO LIABILITY TO YOU WHATSOEVER FOR ANY PERSONAL INJURY (INCLUDING DEATH) CAUSED BY YOUR USE OR MISUSE OF THE CONTENT OR THE APP\nWITHOUT LIMITING THE PRECEDING PARAGRAPHS OF THIS SECTION, THE LIMIT ON THE TOTAL CUMULATIVE LIABILITY OF INTREPID 24/7 TO YOU OR ANY PERSON, FOR ANY CLAIMS ARISING OUT OF OR RELATING TO THE APP, THE CONTENT, OR THIS AGREEMENT SHALL NOT IN ANY EVENT EXCEED $100.00 CDN.\nThe limitations specified above shall apply regardless of the causes or circumstances giving rise to the claim, even if such claim is based on breach of contract, negligence or other tort, and shall survive a fundamental breach or failure of essential purpose of any limited remedy or this Agreement.\n\nGeneral\nThis Agreement shall be governed and construed in accordance with the laws of the Province of Ontario and the laws of Canada applicable therein. You hereby irrevocably submit to the jurisdiction of the courts of the Province of Ontario at Toronto. This Agreement (as amended from time to time), and any other legal notices on the app, constitute the entire agreement between you and Intrepid 24/7 with respect to the use of the app and the Content. If a court of competent jurisdiction deems any provision of this Agreement unenforceable, that provision will be enforced to the maximum extent permissible, and the remaining provisions will remain in full force and effect. Intrepid 24/7 may assign this Agreement, in whole, or in part, at any time, with or without notice to you. You may not assign your rights or delegate your duties under this Agreement, either in whole or in part, without the prior written consent of Intrepid 24/7. The division of this Agreement into sections and the insertion of headings are for convenience of reference only and shall not affect the construction or interpretation of this Agreement. You agree to waive any right you may have to a trial by jury. This Agreement will ensure to the benefit of and be binding upon the parties to this Agreement and their respective successors, heirs, and permitted assigns. No waiver of any provision of this Agreement shall be deemed or shall constitute a waiver of any other provision nor shall such waiver constitute a continuing waiver unless otherwise expressly provided.";
    termsOfService.editable = NO;
    termsOfService.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
    termsOfService.backgroundColor = [UIColor clearColor];
    termsOfService.scrollEnabled = NO;
    termsOfService.textColor = [UIColor whiteColor];
    termsOfService.textAlignment = NSTextAlignmentCenter;
    
    [scrollView addSubview:termsOfService];
    
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(320, termsOfService.frame.size.height);
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    } else {
        [self moveAllSubviewsDown];
    }
}
- (void) moveAllSubviewsDown{
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
