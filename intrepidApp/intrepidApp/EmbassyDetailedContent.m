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
                                                   address:@"Consulate of Canada\nWorld Trade Center\nAv. Mariano Otero #1249\nPiso 8, Torre Pacifico\nCol.Rinconada del Bosque\n44530 Guadalajara, Jalisco\nMexico"
                                                       tel:@"From Canada dial: 011-52 + (Area Code) + Number\nFrom Mexico dial: 01 + (Area Code) + Number\n\nTelephone: (33) 3671-4740"
                                                       fax:@"(33) 3671-4750"
                                                     email:@"gjara@international.gc.ca"
                                                     hours:@"Monday-Friday 9am-2pm and 3pm-5pm\nThe Consular section is open Monday-Friday 10am-2pm\n\nIf you decide to visit the Consulate for any consular services, please make an appointment ahead of time by phoning (33) 3671-4740 ext. 3000"
                                                  services:@"• Assistance to Canadians\n• Doing Business with Mexico: Services for Canadian businesses\n• Doing Business with Canada: Services for Mexican businesses\n\nThe Canadian Consulate in Guadalajara does not accept or process visas, but visa applicants can take advantage of the Visa Application Centre (VAC) in Guadalajara. The VAC is aimed at making the Canadian visa process more convenient for applicants.\nAll temporary resident applications (visitors, students, temporary workers and permanent resident travel documents) are encouraged to use the VAC services."
                                                    notice:@"The Professional Association of Foreign Service Officers (PAFSO) union is currently taking strike action."],
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
                                                      address:@"Embassy of Canada\nSchiller 529, Col. Bosque de Chapultepec (Polanco)\nDel. Miguel Hidalgo\n11580 Mexico City, D.F.\nMexico"
                                                          tel:@"From Canada dial: 011-52 + (Area Code) + Number\nFrom Mexico dial: 01 + (Area Code) + Number\n\nTelephone: (55) 5724-7900"
                                                          fax:@"Administration: (55) 5724-7980\nCultural: (55) 5724-7981\nPolitical Relations: (55) 5724-7985"
                                                        email:@"mxico@international.gc.ca"
                                                        hours:@"Monday-Friday 8:45am-5:15pm with the exception of the sections listed below."
                                                     services:@"Assistance to Canadians (Consular Section)\n Fax (Consular): (55) 5724-7943\n Fax (Passports): (55) 5387-9305\n\n • All Consular services with the exception of Notarial services (please see below) Monday-Friday 9am-12pm.\n\n • Notarial Services (certificiation of signatures-any kind, power of attorney, authorization for minors to travel, etc.)* Monday-Friday 9am-12pm.\n\n Immigration and Visas\n\n • Reception of visitor visas, work permits, and study permits: Monday-Thursday 8am-12pm. (Applicants should use the VAC services in order to benefit from extended office hours for the submission of applications for visitor visas, work permits and study permits: www.cicmex.com.mx \n\n • Reception of travel documents applications: Monday-Friday 8am-12pm\n\n • Only persons invited for an interview will be allowed to enter the Embassy: Monday-Thursday."
                                                       notice:@"*Mexico citizens that require a notarized letter for their child or children to be able to travel to Canada must go to a Mexican Public Notary. As of July 6, 2009, and until further notice, the consular section of the Canadian Embassy will not be able to provide this service."],
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
                                                 address:@"200 South Biscayne Blvd., Suite 1600\nMiami, Fl 33131 USA\n\n(16th floor of the Wachovia Financial Center, a major downtown landmark)."
                                                     tel:@"Telephone: (305) 579-1600"
                                                     fax:@"(305) 374-6774"
                                                   email:@"miami-gr@international.gc.ca"
                                                   hours:@"Monday-Friday 8:30am-4pm"
                                                services:@"Services for Canadians\n\nTel: (305) 579-1600 ext. 3346\nEmail: miami-cs@international.gc.ca\n\nIn person enquiries: Monday-Friday 9am-12pm, 1pm-3:30pm"
                                                  notice:@"The consulate does not provide regular passport services.\n\nFor general passport enquiries, you may contact Passport Canada either toll free at 1-800-567-6868 (Monday-Friday 7:30am-8pm EST) or via the General Inquiry Form, available on the website."],
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
                                                  address:@"8 Villanueva St,\nEdificio Abraxas, 2nd Floor\nPuerto Plata, RD."
                                                      tel:@"Telephone: 1 (809) 586-5761"
                                                      fax:@"1 (809) 586-5762"
                                                    email:@"canada.pop@gmail.com"
                                                    hours:@"Monday-Friday 9am-1pm"
                                                 services:@"This office provides consular assistance, notarial services and passport and citizenship application forms to Canadian citizens. Passport and citizenship applications can be deposited at this location.\n\nFull consular services are offered at the Embassy in Santo Domingo."
                                                   notice:@"All enquiries about Canadian visas and immigration to Canada are handled by the Visa and Immigration section in Santo Domingo, rather than the Consular section. This includes enquiries from Cnaadian citizens who wish to sponsor their relatives to come to Canada or who wish to invite relatives or friends to come to Canada."],
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

}

@end
