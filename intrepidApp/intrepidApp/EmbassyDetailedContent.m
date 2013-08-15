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
                        [EmbassyItem embassyItemOfContinent:@"North America"
                                                name:@"United States"
                                                description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                flag:@"USD.png"
                                                address:@"address"
                                                contact:@"contact"
                                                hours:@"hours"
                                                services:@"services"
                                                notice:@"notice"
                                                assistance:@"assistance"
                                                immigration:@"immigration"],
                        [EmbassyItem embassyItemOfContinent:@"North America"
                                                       name:@"Canada"
                                                description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                       flag:@"CAD.png"
                                                    address:@"Consulate of Canada\n World Trade Center\n Av. Mariano Otero #1249\n Piso 8, Torre Pacifico\n Col. Rinconada del Bosque\n 44530 Guadalajara, Jalisco\n Mexico"
                                                    contact:@"Tel. (33) 3671-4740\n Fax. (33) 3671-4750\n\n From Canada dial: 011-52 + (Area Code) + Number\n From Mexico dial: 01 + (Area Code) + Number\n\n Email: gjara@international.gc.ca"
                                                      hours:@"Monday to Friday, 9am-2pm and 3pm-5pm\n The Consular section is open Monday to Friday, 10am-2pm\n\n If you decide to visit the Consulate for any consular services, please make an appointment ahead of time by phoning 33 3671-4740 ext. 3000"
                                                   services:@"\u2022 Assistance to Canadians\n \u2022 Doing Business with Mexico: Services for Canadian businesses\n \u2022 Doing Business with Canada: Services for Mexican businesses\n\n The Canadian Consulate in Guadalajara does not accept or process visas, but visa applicants can take advantage of the Visa Application Centre (VAC) in Guadalajara. The VAC is aimed at making the Canadian visa process more convenient for applicants.\n All temporary resident applications (visitors, students, temporary workers and permanent resident travel documents) are encouraged to use the VAC services."
                                                     notice:@"The Professional Association of Foreign Services Officers (PAFSO) union is currently taking strike action."
                                                 assistance:@""
                                                immigration:@""],
                        [EmbassyItem embassyItemOfContinent:@"Europe"
                                                       name:@"United Kingdom"
                                                description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                       flag:@"GBP.png"
                                                    address:@"address"
                                                    contact:@"contact"
                                                      hours:@"hours"
                                                   services:@"services"
                                                     notice:@"notice"
                                                 assistance:@"assistance"
                                                immigration:@"immigration"],
                        [EmbassyItem embassyItemOfContinent:@"South America"
                                                       name:@"Brazil"
                                                description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                       flag:@"BRL.png"
                                                    address:@"address"
                                                    contact:@"contact"
                                                      hours:@"hours"
                                                   services:@"services"
                                                     notice:@"notice"
                                                 assistance:@"assistance"
                                                immigration:@"immigration"],
                        [EmbassyItem embassyItemOfContinent:@"Asia"
                                                       name:@"China"
                                                description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                       flag:@"CNY.png"
                                                    address:@"address"
                                                    contact:@"contact"
                                                      hours:@"hours"
                                                   services:@"services"
                                                     notice:@"notice"
                                                 assistance:@"assistance"
                                                immigration:@"immigration"],
                        [EmbassyItem embassyItemOfContinent:@"Australia"
                                                       name:@"Australia"
                                                description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                       flag:@"AUS.png"
                                                    address:@"address"
                                                    contact:@"contact"
                                                      hours:@"hours"
                                                   services:@"services"
                                                     notice:@"notice"
                                                 assistance:@"assistance"
                                                immigration:@"immigration"],
    
                         nil];
    
    NSArray *mexicoCity = [NSArray arrayWithObjects:
                           [EmbassyItem embassyItemOfContinent:@"North America"
                                                          name:@"United States"
                                                   description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                          flag:@"USD.png"
                                                       address:@"address"
                                                       contact:@"contact"
                                                         hours:@"hours"
                                                      services:@"services"
                                                        notice:@"notice"
                                                    assistance:@"assistance"
                                                   immigration:@"immigration"],
                           [EmbassyItem embassyItemOfContinent:@"North America"
                                                          name:@"Canada"
                                                   description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                          flag:@"CAD.png"
                                                       address:@"Embassy of Canada\n Schiller 529, Col. Bosque de Chapultepec (Polanco)\n Del. Miguel Hidalgo\n 11580 Mexico City, D.F.\n Mexico"
                                                       contact:@"From Canada dial: 011-52 + (Area Code) + Number\n From Mexico dial: 01 + (Area Code) + Number \n Telephone: (55) 5724-7980\n Fax (Administration): (55) 5724-7980\n Fax (Cultural): (55) 5724-7985\n Email: mxico@international.gc.ca"
                                                         hours:@"Monday-Friday 8:45am-5:15pm with the exception of the sections listed below."
                                                      services:@""
                                                        notice:@""
                                                    assistance:@"\u2022 All Consular services with the exception of Notarial services (please see below) Monday to Friday 9am-12pm\n \u2022 Notarial Services (certification of signatures-any kind, power of attorney, authorization for minors to travel, etc.)* Monday to Friday 9am-10:30am\n\n *Mexian Citizens that require a notarized letter for their child or children to be able to travel to Canada must go to the Mexican Public Notary. As of July 6, 2009, and until further notice, the Consular section of the Canadian Embassy will not be able to provide this service."
                                                   immigration:@"\u2022 Reception of visitor visas, work permits and study permits: Monday-Thursday 8am-12pm. (Applicants should use VAC services in order to benefit from extended office hours for the submission of applications for visitor visas, work permits and study permits: www.cicmex.com.mx\n \u2022 Reception of travel documents applications: Monday-Friday 8am-12pm\n \u2022 Only persons invited for an interview will be allowed to enter the Embassy: Monday-Thursday."],
                           [EmbassyItem embassyItemOfContinent:@"Europe"
                                                          name:@"United Kingdom"
                                                   description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                          flag:@"GBP.png"
                                                       address:@"address"
                                                       contact:@"contact"
                                                         hours:@"hours"
                                                      services:@"services"
                                                        notice:@"notice"
                                                    assistance:@"assistance"
                                                   immigration:@"immigration"],
                           [EmbassyItem embassyItemOfContinent:@"South America"
                                                          name:@"Brazil"
                                                   description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                          flag:@"BRL.png"
                                                       address:@"address"
                                                       contact:@"contact"
                                                         hours:@"hours"
                                                      services:@"services"
                                                        notice:@"notice"
                                                    assistance:@"assistance"
                                                   immigration:@"immigration"],
                           [EmbassyItem embassyItemOfContinent:@"Asia"
                                                          name:@"China"
                                                   description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                          flag:@"CNY.png"
                                                       address:@"address"
                                                       contact:@"contact"
                                                         hours:@"hours"
                                                      services:@"services"
                                                        notice:@"notice"
                                                    assistance:@"assistance"
                                                   immigration:@"immigration"],
                           [EmbassyItem embassyItemOfContinent:@"Australia"
                                                          name:@"Australia"
                                                   description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                          flag:@"AUS.png"
                                                       address:@"address"
                                                       contact:@"contact"
                                                         hours:@"hours"
                                                      services:@"services"
                                                        notice:@"notice"
                                                    assistance:@"assistance"
                                                   immigration:@"immigration"],
                           
                           nil];
    
    NSArray *miami = [NSArray arrayWithObjects:
                      [EmbassyItem embassyItemOfContinent:@"North America"
                                                     name:@"United States"
                                              description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                     flag:@"USD.png"
                                                  address:@"address"
                                                  contact:@"contact"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"
                                               assistance:@"assistance"
                                              immigration:@"immigration"],
                      [EmbassyItem embassyItemOfContinent:@"North America"
                                                     name:@"Canada"
                                              description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                     flag:@"CAD.png"
                                                  address:@"200 South Biscayne Blvd., Suite 1600\n Miami, Fl 33131 USA\n\n (16th floor of the Wachovia Financial Center, a major downtown landmark)."
                                                  contact:@"Tel: 305-579-1600\n Fax: 305-374-6774\n Email: miami-gr@international.gc.ca"
                                                    hours:@"Monday-Friday 8:30am - 4pm"
                                                 services:@"Tel: 305-579-1600 ext. 3346\n Fax: 305-374-6774\n Email: miami-cs@international.gc.ca\n\n In person enquiries: Monday-Friday 9am-12pm, 1pm-3:30pm"
                                                   notice:@"The consulate does not provide regular passport services.\n\n For general passport enquiries, you may contact Passport Canada either toll free at 1-800-567-6868 (Monday-Friday 7:30am-8pm EST) or via the General Inquiry Form available on the website."
                                               assistance:@""
                                              immigration:@""],
                      [EmbassyItem embassyItemOfContinent:@"Europe"
                                                     name:@"United Kingdom"
                                              description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                     flag:@"GBP.png"
                                                  address:@"address"
                                                  contact:@"contact"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"
                                               assistance:@"assistance"
                                              immigration:@"immigration"],
                      [EmbassyItem embassyItemOfContinent:@"South America"
                                                     name:@"Brazil"
                                              description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                     flag:@"BRL.png"
                                                  address:@"address"
                                                  contact:@"contact"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"
                                               assistance:@"assistance"
                                              immigration:@"immigration"],
                      [EmbassyItem embassyItemOfContinent:@"Asia"
                                                     name:@"China"
                                              description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                     flag:@"CNY.png"
                                                  address:@"address"
                                                  contact:@"contact"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"
                                               assistance:@"assistance"
                                              immigration:@"immigration"],
                      [EmbassyItem embassyItemOfContinent:@"Australia"
                                                     name:@"Australia"
                                              description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                     flag:@"AUS.png"
                                                  address:@"address"
                                                  contact:@"contact"
                                                    hours:@"hours"
                                                 services:@"services"
                                                   notice:@"notice"
                                               assistance:@"assistance"
                                              immigration:@"immigration"],
                      
                      nil];
    
    NSArray *puerto = [NSArray arrayWithObjects:
                       [EmbassyItem embassyItemOfContinent:@"North America"
                                                      name:@"United States"
                                               description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                      flag:@"USD.png"
                                                   address:@"address"
                                                   contact:@"contact"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"
                                                assistance:@"assistance"
                                               immigration:@"immigration"],
                       [EmbassyItem embassyItemOfContinent:@"North America"
                                                      name:@"Canada"
                                               description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                      flag:@"CAD.png"
                                                   address:@"8 Villaneuva St.\n Edificio Abraxas, 2nd Floor\n Puerto Plata, RD."
                                                   contact:@"Tel: 1-809-586-5761\n Fax: 1-809-586-5762\n Email: canada.pop@gmail.com"
                                                     hours:@"Monday-Friday 9am-1pm"
                                                  services:@""
                                                    notice:@"All enquiries about Canadian visas and immigration to Canada are handled by the Visa and Immigration section in Santo Domingo, rather than the Consular section. This includes enquiries from Canadian citizens who wish to sponsor their relatives to come to Canada or who wish to invite relatives or friends to come to Canada."
                                                assistance:@"This office provides consular assistance, notarial services, and passport and citizenship application forms to Canadian citizens. Passport and citizenship applications can be deposited at this location.\n\n Full consular services are offered at the Embassy in Santo Dominigo."
                                               immigration:@"immigration"],
                       [EmbassyItem embassyItemOfContinent:@"Europe"
                                                      name:@"United Kingdom"
                                               description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                      flag:@"GBP.png"
                                                   address:@"address"
                                                   contact:@"contact"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"
                                                assistance:@"assistance"
                                               immigration:@"immigration"],
                       [EmbassyItem embassyItemOfContinent:@"South America"
                                                      name:@"Brazil"
                                               description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                      flag:@"BRL.png"
                                                   address:@"address"
                                                   contact:@"contact"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"
                                                assistance:@"assistance"
                                               immigration:@"immigration"],
                       [EmbassyItem embassyItemOfContinent:@"Asia"
                                                      name:@"China"
                                               description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                      flag:@"CNY.png"
                                                   address:@"address"
                                                   contact:@"contact"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"
                                                assistance:@"assistance"
                                               immigration:@"immigration"],
                       [EmbassyItem embassyItemOfContinent:@"Australia"
                                                      name:@"Australia"
                                               description:@"This is the content. This is where the content will go. This is the content. This is where the content will go. This is the content. This is where the content will go."
                                                      flag:@"AUS.png"
                                                   address:@"address"
                                                   contact:@"contact"
                                                     hours:@"hours"
                                                  services:@"services"
                                                    notice:@"notice"
                                                assistance:@"assistance"
                                               immigration:@"immigration"],
                       
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
