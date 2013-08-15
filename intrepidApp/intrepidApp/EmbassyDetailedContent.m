//
//  EmbassyDetailedContent.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyDetailedContent.h"
#import "EmbassyItem.h"

@implementation EmbassyDetailedContent

-(NSArray *)getContent {
    
    NSArray *guadala = [NSArray arrayWithObjects:
                        [EmbassyItem embassyItemOfLocation:@"United States"
                                                      name:@"United States"
                                                      flag:@"USD.png"
                                                   address:@"address"
                                                       tel:@"tel"
                                                       fax:@"fax"
                                                     email:@"email"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"],
                        [EmbassyItem embassyItemOfLocation:@"Canada"
                                                      name:@"Canada"
                                                      flag:@"CAD.png"
                                                   address:@"address"
                                                       tel:@"tel"
                                                       fax:@"fax"
                                                     email:@"email"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"],
                        [EmbassyItem embassyItemOfLocation:@"United Kingdom"
                                                      name:@"United Kingdom"
                                                      flag:@"GBP.png"
                                                   address:@"address"
                                                       tel:@"tel"
                                                       fax:@"fax"
                                                     email:@"email"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"],
                        [EmbassyItem embassyItemOfLocation:@"China"
                                                      name:@"China"
                                                      flag:@"CNY.png"
                                                   address:@"address"
                                                       tel:@"tel"
                                                       fax:@"fax"
                                                     email:@"email"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"], nil];
    
    NSArray *mexicoCity = [NSArray arrayWithObjects:
                           [EmbassyItem embassyItemOfLocation:@"United States"
                                                         name:@"United States"
                                                         flag:@"USD.png"
                                                      address:@"address"
                                                          tel:@"tel"
                                                          fax:@"fax"
                                                        email:@"email"
                                                        hours:@"hours"
                                                     services:@"services"
                                                       notice:@"notice"],
                           [EmbassyItem embassyItemOfLocation:@"Canada"
                                                         name:@"Canada"
                                                         flag:@"CAD.png"
                                                      address:@"Embassy of Canada\n Schiller 529, Col. Bosque de Chapultepec (Polanco)\n Del. Miguel Hidalgo\n 11580 Mexico City, D.F.\n Mexico"
                                                          tel:@"From Canada dial: 011-52 + (Area Code) + Number\n From Mexico dial: 01 + (Area Code) + Number\n\n Telephone: (55) 5724-7900"
                                                          fax:@"Administration: (55) 5724-7980\n Cultural: (55) 5724-7981\n Political Relations: (55) 5724-7985"
                                                        email:@"mxico@international.gc.ca"
                                                        hours:@"Monday-Friday 8:45am-5:15pm with the exception of the sections listed below."
                                                     services:@"Assistance to Canadians (Consular Section)\n Fax (Consular): (55) 5724-7943\n Fax (Passports): (55) 5387-9305\n\n • All Consular services with the exception of Notarial services (please see below) Monday-Friday 9am-12pm.\n\n • Notarial Services (certificiation of signatures-any kind, power of attorney, authorization for minors to travel, etc.)* Monday-Friday 9am-12pm.\n\n Immigration and Visas\n\n • Reception of visitor visas, work permits, and study permits: Monday-Thursday 8am-12pm. (Applicants should use the VAC services in order to benefit from extended office hours for the submission of applications for visitor visas, work permits and study permits: www.cicmex.com.mx \n\n • Reception of travel documents applications: Monday-Friday 8am-12pm\n\n • Only persons invited for an interview will be allowed to enter the Embassy: Monday-Thursday."
                                                       notice:@"*Mexico citizens that require a notarized letter for their child or children to be able to travel to Canada must go to a Mexican Public Notary. As of July 6, 2009, and until further notice, the consular section fo the Canadian Embassy will not be able to provide this service."],
                           [EmbassyItem embassyItemOfLocation:@"United Kingdom"
                                                         name:@"United Kingdom"
                                                         flag:@"GBP.png"
                                                      address:@"address"
                                                          tel:@"tel"
                                                          fax:@"fax"
                                                        email:@"email"
                                                        hours:@"hours"
                                                     services:@"services"
                                                       notice:@"notice"],
                           [EmbassyItem embassyItemOfLocation:@"China"
                                                         name:@"China"
                                                         flag:@"CNY.png"
                                                      address:@"address"
                                                          tel:@"tel"
                                                          fax:@"fax"
                                                        email:@"email"
                                                        hours:@"hours"
                                                     services:@"services"
                                                       notice:@"notice"],
                                                      nil];
    
    NSArray *miami = [NSArray arrayWithObjects:
                      [EmbassyItem embassyItemOfLocation:@"United States"
                                                    name:@"United States"
                                                    flag:@"USD.png"
                                                 address:@"address"
                                                     tel:@"tel"
                                                     fax:@"fax"
                                                   email:@"email"
                                                   hours:@"hours"
                                                services:@"services"
                                                  notice:@"notice"],
                      [EmbassyItem embassyItemOfLocation:@"Canada"
                                                    name:@"Canada"
                                                    flag:@"CAD.png"
                                                 address:@"address"
                                                     tel:@"tel"
                                                     fax:@"fax"
                                                   email:@"email"
                                                   hours:@"hours"
                                                services:@"services"
                                                  notice:@"notice"],
                      [EmbassyItem embassyItemOfLocation:@"United Kingdom"
                                                    name:@"United Kingdom"
                                                    flag:@"GBP.png"
                                                 address:@"address"
                                                     tel:@"tel"
                                                     fax:@"fax"
                                                   email:@"email"
                                                   hours:@"hours"
                                                services:@"services"
                                                  notice:@"notice"],
                      [EmbassyItem embassyItemOfLocation:@"China"
                                                    name:@"China"
                                                    flag:@"CNY.png"
                                                 address:@"address"
                                                     tel:@"tel"
                                                     fax:@"fax"
                                                   email:@"email"
                                                   hours:@"hours"
                                                services:@"services"
                                                  notice:@"notice"],
                      
                      nil];
    
    NSArray *puerto = [NSArray arrayWithObjects:
                       [EmbassyItem embassyItemOfLocation:@"United States"
                                                     name:@"United States"
                                                     flag:@"USD.png"
                                                  address:@"address"
                                                      tel:@"tel"
                                                      fax:@"fax"
                                                    email:@"email"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"],
                       [EmbassyItem embassyItemOfLocation:@"Canada"
                                                     name:@"Canada"
                                                     flag:@"CAD.png"
                                                  address:@"address"
                                                      tel:@"tel"
                                                      fax:@"fax"
                                                    email:@"email"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"],
                       [EmbassyItem embassyItemOfLocation:@"United Kingdom"
                                                     name:@"United Kingdom"
                                                     flag:@"GBP.png"
                                                  address:@"address"
                                                      tel:@"tel"
                                                      fax:@"fax"
                                                    email:@"email"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"],
                       [EmbassyItem embassyItemOfLocation:@"China"
                                                     name:@"China"
                                                     flag:@"CNY.png"
                                                  address:@"address"
                                                      tel:@"tel"
                                                      fax:@"fax"
                                                    email:@"email"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"],
                                              nil];
    
    return mexicoCity;
//    
//    NSMutableArray *embassyArray = [[NSMutableArray alloc] initWithObjects:guadala, mexicoCity, miami, puerto, nil];
//    return embassyArray;
    
//    EmbassyItem *item1 = [[EmbassyItem alloc] init];
//    item1.flag = @"USD.png";
//    item1.name = @"United States";
//    item1.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item2 = [[EmbassyItem alloc] init];
//    item2.flag = @"CAD.png";
//    item2.name = @"Canada";
//    item2.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item3 = [[EmbassyItem alloc] init];
//    item3.flag = @"GBP.png";
//    item3.name = @"United Kingdom";
//    item3.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item4 = [[EmbassyItem alloc] init];
//    item4.flag = @"BRL.png";
//    item4.name = @"Brazil";
//    item4.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item5 = [[EmbassyItem alloc] init];
//    item5.flag = @"EUR.png";
//    item5.name = @"European Union";
//    item5.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item6 = [[EmbassyItem alloc] init];
//    item6.flag = @"CHF.png";
//    item6.name = @"Switzerland";
//    item6.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item7 = [[EmbassyItem alloc] init];
//    item7.flag = @"CNY.png";
//    item7.name = @"China";
//    item7.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item8 = [[EmbassyItem alloc] init];
//    item8.flag = @"INR.png";
//    item8.name = @"India";
//    item8.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item9 = [[EmbassyItem alloc] init];
//    item9.flag = @"THB.png";
//    item9.name = @"Thailand";
//    item9.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item10 = [[EmbassyItem alloc] init];
//    item10.flag = @"AUS.png";
//    item10.name = @"Australia";
//    item10.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item11 = [[EmbassyItem alloc] init];
//    item11.flag = @"MYR.png";
//    item11.name = @"Malaysia";
//    item11.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item12 = [[EmbassyItem alloc] init];
//    item12.flag = @"DOP.png";
//    item12.name = @"Dominican Republic";
//    item11.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//    
//    EmbassyItem *item13 = [[EmbassyItem alloc] init];
//    item13.flag = @"MXN.png";
//    item13.name = @"Mexico";
//    item13.description = @"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go.";
//        
//    return [NSArray arrayWithObjects:item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, nil];
}

@end
