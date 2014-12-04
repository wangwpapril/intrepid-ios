//
//  TripManager.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripManager.h"
#import "CityEntity.h"
#import "EmbassyEntity.h"

@implementation TripManager

@synthesize managedObjectContext;
//@synthesize persistentStoreCoordinator;

static TripManager *instance =nil;
+(TripManager *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            // instantiate some global variables
            instance = [[TripManager alloc] init];
        }
    }
    return instance;    
}

-(NSArray *) getCities {
    NSArray *cityArray = [self fetchCityArray];
    if (cityArray.count == 0) {
        [self populateTrips];
        cityArray = [self fetchCityArray];
    }
    NSLog(@"city Array count: %lu", (unsigned long)cityArray.count);
    return cityArray;
}

-(NSArray *)fetchCityArray {
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *intermediateArray = [managedObjectContext executeFetchRequest:request error:&error];
    return intermediateArray;
}

-(void) populateTrips {
    
    CityEntity *guadalajara =[self createTripWithCityImage:@"Guadala" withCityName:@"Guadalajara" withContinent:@"North America" withCultureText:@"The ethnic makeup of Mexico is 60% to 80% Mestizos (people of mixed European and Native American background), 10% to 30% Amerindian (Totonac, Maya, Zapotec, Mixtec, Otomi and Nahuatl), and 9% to 17% European. \n\nReligions in Mexico include: 83% Roman Catholic, 9% Protestant and 8% Other. \n\nThe official language of Mexico is Spanish. Although as many as 100 native languages are spoken, 80% of those Mexicans who speak an indigenous language also speak Spanish. \n\nThe local currency is the Mexican Peso. US dollar travellers’ cheques and notes are readily converted into local currency. International debit and credit cards are widely accepted for payment and in ATMs. It is not possible to exchange cash at hotel receptions - this can only be done at banks and bureaux de change or Cambios. \n\nIn Mexico, personal space is usually closer than it is for some other cultures: about an arm distance. It is expected for females to shake hands and kiss on one cheek, particularly in a social setting." withCultureImage:@"Guada-Culture" withGeneralText:@"Mexico is bordered to the north by the states of California, Arizona, New Mexico, and Texas, to the west and south by the Pacific Ocean, to the east by the Gulf of Mexico, and to the southeast by Belize, Guatemala, and the Caribbean Sea. \n\nA visa is not required to visit Mexico as a tourist, but you do need a tourist card, which you can obtain on arrival by completing an immigration form, available at border crossings or on-board flights to Mexico. You need a tourist card to leave Mexico. If lost, a tourist card can be replaced at the immigration office at any international airport in Mexico. The cost of a replacement is 295 Mexican Pesos.\n\nThe electricity in Guadalajara is the North American standard and converters are not required, with the exception of adaptors for three-prong to two-prong in some older hotels. \n\nTravellers to Guadalajara may develop traveller’s diarrhea from consuming contaminated water or food. Water precautions should be observed, including avoiding drinks served with ice that may have been made with contaminated water. \n\nTelephone networks, including cellular networks, are readily available and reliable in Guadalajara." withGeneralImage:@"Guada-Overview" withLocalImage:@"Guada-Local" withLocalText:@"Kidnapping for ransom has a long history in Mexico. Kidnap-for-ransom crimes continue to increase in Guadalajara, and the threat is very real throughout Mexico. Most incidents go unreported to police and are handled directly by the victim's family or an intermediary (it is recommended that local authorities be contacted immediately to help resolve any kidnapping matter). Guadalajara has not experienced the same level of 'express' kidnappings common to other Mexican cities.\n\nHowever, 'virtual' kidnappings have become increasingly common. Extortionists will telephone prospective victims, posing as kidnappers, and demand payment in return for the release of an abducted family member. Virtual kidnapping has evolved to include the scenario where the extortionist poses as an innocent citizen who requests the use of your cell phone to place an emergency call, only to call someone on your contact list and threaten that you have been kidnapped.\n\nThe safest practice from the outset is to refuse to let any stranger use your cell phone or, alternatively, to remain beside any stranger while they make an ‘emergency’ call. If you receive a call demanding ransom for the release of a family member, you should be extremely skeptical and should not overreact to the initial claim, as most are baseless. Persons receiving such calls should immediately contact the local police by dialling 066." withPoliticalImage:@"Guada-Political" withPoliticaltext:@"Guadalajara is the second largest city in Mexico. Guadalajara has a well-earned crime rating of “high-plus”. Petty street crime—such as purse or jewelry snatching, pick-pocketing, and theft from vehicles—is very common. Areas of the greatest concern include the downtown district at night and areas east of downtown. Violent crime, to include kidnapping, car-jacking and armed robbery, occurs with some frequency. \n\nThere were 112 bank robberies in the Guadalajara Metropolitan Zone in 2011. Narco-related violence remained steady throughout the year. In the last six months of 2011, authorities in Guadalajara tracked an average of 117 total security-related incidents per month.\n\nNarco-related violence tends to occur in places less likely to attract American citizen residents or tourists. Crime in the Guadalajara area has been rated at “medium”. While residential burglars usually rely on stealth, attempting to break into the home when residents are away, home invasions by armed criminals have also occurred, where the owner was inside the residence or arrived home at the time of the attempt. In these circumstances, you should not resist. Rather, use slow, deliberate movements to avoid confusion that could result in injury or death at the hands of a nervous criminal. \n\nGeneral residential security guidelines include: closing and locking all windows and doors (to include garage and gate); regularly checking outside lighting and replacing light bulbs as necessary; installing and using a security alarm; installing quality locks (preferably deadbolts) on doors and gates; and never leaving “hidden” keys anywhere outside your home." withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=latinamerica&country=mexico&city=guadalajara" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=mexico&city=guadalajara" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=latinamerica&country=mexico&city=guadalajara" withCADToNative:12.19];
    
    // mexico
    CityEntity *mexicoCity = [self createTripWithCityImage:@"Mexico" withCityName:@"Mexico City" withContinent:@"South America" withCultureText:@"The ethnic makeup of Mexico is 60% to 80% Mestizos (people of mixed European and Native American background), 10% to 30% Amerindian (Totonac, Maya, Zapotec, Mixtec, Otomi and Nahuatl), and 9% to 17% European. \n\nReligions in Mexico include: 83% Roman Catholic, 9% Protestant and 8% Other. \n\nThe official language of Mexico is Spanish. Although as many as 100 native languages are spoken, 80% of those Mexicans who speak an indigenous language also speak Spanish. \n\nThe local currency is the Mexican Peso. US dollar travellers’ cheques and notes are readily converted into local currency. International debit and credit cards are widely accepted for payment and in ATMs. It is not possible to exchange cash at hotel receptions - this can only be done at banks and bureaux de change or Cambios. \n\nIn Mexico, personal space is usually closer than it is for some other cultures: about an arm distance. It is expected for females to shake hands and kiss on one cheek, particularly in a social setting." withCultureImage:@"overview-culture" withGeneralText:@"Mexico is bordered to the north by the states of California, Arizona, New Mexico, and Texas, to the west and south by the Pacific Ocean, to the east by the Gulf of Mexico, and to the southeast by Belize, Guatemala, and the Caribbean Sea. \n\nMexico City is located at 7,349 feet (2,240 meters) ASL. It is temperate and relatively cool but heavily affected by smog due to its limited air circulation. It is surrounded on three sides by mountains and thus the cold fronts from the north make southward intrusions only during the Northern Hemisphere winter and spring. The difference between summer and winter mean temperatures is approximately 6 to 8 °C. \n\nThe current population of Mexico is 19.5 million (2012 estimate). \n\nA visa is not required to visit Mexico as a tourist, but you do need a tourist card, which you can obtain on arrival by completing an immigration form, available at border crossings or on-board flights to Mexico. You need a tourist card to leave Mexico. If lost, a tourist card can be replaced at the immigration office at any international airport in Mexico. The cost of a replacement is 295 Mexican Pesos.\n\nThe electricity in Mexico City is the North American standard and converters are not required, with the exception of adaptors for three-prong to two-prong in some older hotels. \n\nTravellers to Mexico City may develop traveller’s diarrhea from consuming contaminated water or food. Water precautions should be observed, including avoiding drinks served with ice that may have been made with contaminated water. \n\nTelephone networks, including cellular networks are readily available and reliable in Mexico City." withGeneralImage:@"overview-history" withLocalImage:@"mexicoBackBigger@2x" withLocalText:@"Earthquakes occur periodically in Mexico City. An earthquake measuring 8.1 on the Richter Scale hit Mexico City in 1985 and was responsible for the deaths of 10,000 people.  If an earthquake occurs during your stay in Mexico City, drop to the ground; take cover by getting under a sturdy table or other piece of furniture; and hold on until the shaking stops. If there isn’t a table or desk near you, cover your face and head with your arms and crouch in an inside corner of the building. Stay inside until the shaking stops and it is safe to go outside. Do not exit a building during the shaking.\n\nWhile Mexico City has its own security issues, the decision to travel outside of Mexico City should not be taken lightly, as many parts of Mexico have exceptionally high rates of violent crime associated with drug activity." withPoliticalImage:@"security-political" withPoliticaltext:@"Short-term opportunistic kidnapping does occur, particularly in urban areas. Victims of “express kidnapping” are forced to withdraw funds from credit or debit cards at a cash point to secure their release. Street crime is a serious problem in Mexico City. Pick-pocketing is common on the Mexico City Metro. \n\nDress in an under-stated manner and avoid wearing expensive jewellery. Limit the amount of cash or credit/debit cards you carry with you. Avoid withdrawing money from ATMs or exchanging money at bureaux de change at night. There have been several co-ordinated muggings in the Parque Nacional de las Cumbres del Ajusco in the south of Mexico City. Take extreme care in this area."
     withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=latinamerica&country=mexico&city=mexico%20city" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=mexico&city=mexico%20city" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=latinamerica&country=mexico&city=mexico%20city"
     withCADToNative:12.19];
    
    // miami
    CityEntity *miami =[self createTripWithCityImage:@"Miami-USA" withCityName:@"Miami" withContinent:@"North America" withCultureText:@"Miami has a population of 408,750 people: 69.7% White,  20.3% African American and Black, 0.20% Native American, 1.4% Asian, 0.01% Pacific Islander and 8.4% from other races. \n\nReligions in Miami include 61% Roman Catholic, 14% Jewish, 9% Southern Baptist, and 16% Other. \n\nEnglish and Spanish are spoken predominently. \n\nFlorida explicitly imposes a criminal penalty for noncompliance with the obligation to identify oneself if requested to do so by a police officer. Remember to have identification with you at all times." withCultureImage:@"Miami-Culture" withGeneralText:@"Miami is classified as having a tropical monsoon climate. Temperatures range from 61F to 89 F. Due to its location between two major bodies of water known for tropical activity, Miami is also statistically the most likely major city in the world to be struck by a hurricane. \n\nEntry requirements vary depending on nationality. Europeans and many South American nationals require a visa whereas Canadians do not. All those travelling under the Visa Waiver Programme arriving by air or sea should provide details online at least 72 hours before travel. This is known as an Electronic System for Travel Authorization, or ESTA. Those who do not have an ESTA will be refused travel to the USA.\n\nThe power grid and water is of first-world standard. The water can be consumed. Telephone networks, including cellular networks are readily available and reliable in Miami. \n\nThe local currency is the US Dollar. Foreign exchange is readily available for other currencies." withGeneralImage:@"Miami-Overview" withLocalImage:@"Miami-Local" withLocalText:@"Miami is likely to be affected by tropical storms and hurricanes. Rip currents can be present in the spring and winter and present a danger for travellers participating in many water sports." withPoliticalImage:@"Miami-Political" withPoliticaltext:@"Although Miami has a high murder and aggravated assault rate, attacks on tourists are relatively rare. The high drug-related crime statistics that were synonomous with Miami in the 1980s have subsided but occassional gang-related or racial tensions do occur. \n\nPickpockets, armed robbery and sexual assault do occur and districts such as Overtown, Little Haiti and Liberty City should be avoided if possible. Avoid walking in isolated areas after dark." withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=usa&country=united%20states&city=miami" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=united%20states&city=miami" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=usa&country=united%20states&city=miami" withCADToNative:0.96];
    
    CityEntity *puerto = [self createTripWithCityImage:@"Puerto" withCityName:@"Puerto Plata" withContinent:@"North America" withCultureText:@"The ethnic make-up of the Dominican Republic includes 73% Mixed African Amerindian and European, 16% Caucasian and 11% Black. \n\nReligions include 81% Roman Catholic, and 19% Other. \n\nThe language predominently spoken is Spanish. \n\nThere are severe penalties for all drug offences. Possession of even small quantities can lead to a long prison sentence and hefty fines. All sentences are served in the Dominican Republic. " withCultureImage:@"Puerto-Culture" withGeneralText:@"The Dominican Republic is located on the Island of Hispaniola, which it shares with its much smaller neighbour to the west - Haiti. \n\nThe country has an area of 48,442 square kilometers, which take up about 2/3 of the island. The island has the Atlantic Ocean to the north and the Caribbean Sea to the south. The Mona Passage, a channel about 130 km wide, separates the country (and Hispaniola) from Puerto Rico. Puerto Plata is located at the very northern tip of the island. \n\nThe population consists of 321,597 people (2010 Census). \n\nPuerto Plata has a tropical climate with hot, dry summers and warm, very wet winters. The hurricane season in the Dominican Republic runs from June 01 to November 30. \n\nTravellers entering the Dominican Republic for tourist purposes must purchase a tourist card, at a cost of US$10, which is valid for 30 days. Those wishing to stay for a longer period must pay a surcharge at the airport upon departure or request an extension by visiting the Department of Immigration in Santo Domingo. \n\nThose wishing to work in the Dominican Republic must apply for a business visa. Foreigners may gain the right to reside in the Dominican Republic by acquiring a residence visa from the Foreign Relations Ministry and a temporary or permanent residence card from the Immigration Department. A student visa is also required. \n\nA departure tax of US$20 is charged for stays of up to 30 days. The departure tax for stays longer than 30 days varies depending on length of stay and nationality.\n\nThe local currency is the Dominican Peso. USD and Euro are readily convertible. \n\nThe electricity is 110 volts in major cities and vacation destination hotels. Surge protectors are recommended. The water is not fit for consumption and bottled water is recommended. \n\nThe Dominican Republic boasts an extensive fibre optic and microwave-based landline network, as well as an efficient mobile network." withGeneralImage:@"Puerto-Overview" withLocalImage:@"Puerto-Local" withLocalText:@"The ocean can be dangerous during the storm season. Lifeguards may not be present at swimming pools or on beaches, and safety and rescue equipment may not be available.\n\nThe Dominican Republic is located in a seismic zone and earthquakes can occur. Observe earthquake protocols." withPoliticalImage:@"Puerto-Political" withPoliticaltext:@"The Dominican Republic suffers from a high crime rate, ranging from opportunistic crime like bag-snatching and pick-pocketing, to violent crime. Take particular care in remote areas, especially at night. If you leave your hotel complex, do not wear expensive jewellery or carry large amounts of cash or expensive items like cameras. Use a hotel safe whenever possible. \n\nDo not leave your bags or other possessions on chairs or tables when sitting in outside restaurants or bars. If you lose your passport or it is stolen, get a police report before contacting the embassy. Politur (The Tourist Police) can be contacted on the free telephone number 1-809-200-3500. Unaccompanied female travellers should exercise caution. Incidents of assault, rape and sexual aggression against foreigners have been reported, including at beach resorts." withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=latinamerica&country=Dominican%20republic&city=puerto%20plata" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=Dominican%20republic&city=puerto%20plata" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=latinamerica&country=Dominican%20republic&city=puerto%20plata" withCADToNative:40.38];
    
    [self createEmbassyWithCity:guadalajara withPhone:@"From Canada dial: 011-52 + (Area Code) + Number\nFrom Mexico dial: 01 + (Area Code) + Number\n\nTelephone: (33) 3671-4740"
                        withFax:@"(33) 3671-4750"
                      withEmail:@"gjara@international.gc.ca"
                      withHours:@"Monday-Friday 9am-2pm and 3pm-5pm\nThe Consular section is open Monday-Friday 10am-2pm\n\nIf you decide to visit the Consulate for any consular services, please make an appointment ahead of time by phoning (33) 3671-4740 ext. 3000"
                      withNotes:@"The Professional Association of Foreign Service Officers (PAFSO) union is currently taking strike action."
                   withServices:@"\u2022 Assistance to Canadians\n\u2022 Doing Business with Mexico: Services for Canadian businesses\n\u2022 Doing Business with Canada: Services for Mexican businesses\n\nThe Canadian Consulate in Guadalajara does not accept or process visas, but visa applicants can take advantage of the Visa Application Centre (VAC) in Guadalajara. The VAC is aimed at making the Canadian visa process more convenient for applicants.\nAll temporary resident applications (visitors, students, temporary workers and permanent resident travel documents) are encouraged to use the VAC services."
                    withAddress:@"Consulate of Canada\nWorld Trade Center\nAv. Mariano Otero #1249\nPiso 8, Torre Pacifico\nCol.Rinconada del Bosque\n44530 Guadalajara, Jalisco\nMexico"
                    withCountry:@"Canada"
                       withFlag:@"CAD"];
    
    [self createEmbassyWithCity:mexicoCity
                      withPhone:@"From Canada dial: 011-52 + (Area Code) + Number\nFrom Mexico dial: 01 + (Area Code) + Number\n\nTelephone: (55) 5724-7900"
                        withFax:@"Administration: (55) 5724-7980\nCultural: (55) 5724-7981\nPolitical Relations: (55) 5724-7985"
                      withEmail:@"mexico@international.gc.ca"
                      withHours:@"Monday-Friday 8:45am-5:15pm with the exception of the sections listed below."
                      withNotes:@"*Mexican citizens that require a notarized letter for their child or children to be able to travel to Canada must go to a Mexican Public Notary. As of July 6, 2009, and until further notice, the consular section of the Canadian Embassy will not be able to provide this service."
                   withServices:@"\n\nAll consular services with the exception of Notarial services (please see below) Monday - Friday 9am-12pm.\n\u2022 Notarial Services (certification of sigatures - any kind, power of attorney, authorization for minors to travel etc.)* Monday-Friday 9am-10:30am.\n\nImmigration and Visas:\n\u2022 Reception of visitor visas, work permits and study permits: Monday-Thursday 8am-12pm. (Applicants should use the VAC services in order to benefit from extended office hours for the submission of applications for visitor visas, work permits and study permits: www.cicmex.com/mx)\n\u2022 Reception of travel documents applications: Monday-Friday 8am-12pm.\n\u2022 Only persons invited for an interview will be allowed to enter the Embassy Monday-Thursday.\n\n\n"
                    withAddress:@"Schiller 529, Col. Bosque de Chapultepec (Polanco)\nDel. Miguel Hidalgo\n11580 Mexico City, D.F.\nMexico"
                    withCountry:@"Canada"
                       withFlag:@"CAD"];
    
    [self createEmbassyWithCity:miami
                      withPhone:@"Telephone: (305) 579-1600"
                        withFax:@"(305) 374-6774"
                      withEmail:@"miami-gr@international.gc.ca"
                      withHours:@"Monday-Friday 8:30am-4pm"
                      withNotes:@"The consulate does not provide regular passport services. For general passport enquiries, you may contact Passport Canada either toll free at 1-800-567-6868 (Monday to Friday from 7:30 a.m. to 8 p.m. Eastern Time) or via the General Inquiry Form, available on the website."
                   withServices:@"Tel: 305-579-1600 ext. 3346\nIn-Person enquiries:\n Monday - Friday 9am-12pm, 1pm-3:30pm"
                    withAddress:@"200 South Biscayne Blvd., Suite 1600\nMiami, FL 33131 USA\n\n(16th floor of the Wachovia Financial Center, a major downtown landmark."
                    withCountry:@"Canada"
                       withFlag:@"CAD"];
    
    [self createEmbassyWithCity:puerto
                      withPhone:@"Telephone: 1 (809) 586-5761"
                        withFax:@"1 (809) 586-5762"
                      withEmail:@"canada.pop@gmail.com"
                      withHours:@"Monday-Friday 9am-1pm"
                      withNotes:@"All enquiries about Canadian visas and immigration to Canada are handled by the Visa and Immigration section in Santo Domingo, rather than the Consular section. This includes enquiries from Canadian citizens who wish to sponsor their relatives to come to Canada or who wish to invite relatives or friends to come to Canada."
                   withServices:@"This office provides consular assistance, notarial services and passport and citizenship application forms to Canadian citizens. Passport and citizenship applications can be deposited at this location.\n\nFull consular services are offered at the Embassy in Santo Domingo."
                    withAddress:@"8 Villanueva St,\nEdificio Abraxas, 2nd Floor\nPuerto Plata, RD."
                    withCountry:@"Canada"
                       withFlag:@"CAD"];
}

- (void)createEmbassyWithCity:(CityEntity *)city
              withPhone:(NSString *)phone
                withFax:(NSString *)fax
              withEmail:(NSString *)email
              withHours:(NSString *)hours
              withNotes:(NSString *)notes
           withServices:(NSString *)services
            withAddress:(NSString *)address
            withCountry:(NSString *)country
               withFlag:(NSString *)flag
{
    EmbassyEntity *embassy = [NSEntityDescription insertNewObjectForEntityForName:@"EmbassyEntity" inManagedObjectContext:managedObjectContext];
    embassy.phone = phone;
    embassy.fax = fax;
    embassy.email = email;
    embassy.hours = hours;
    embassy.notes = notes;
    embassy.services = services;
    embassy.address = address;
    embassy.city = city;
    embassy.country = country;
    embassy.flag = flag;
    [city addEmbassiesObject:embassy];
    
    NSError *error = nil;
    if ([managedObjectContext save:&error]) {
        NSLog(@"saved");
    } else {
        NSLog(@"save failed");
    }
    
}

- (CityEntity *)createTripWithCityImage:(NSString *)cityImage
                   withCityName:(NSString *)cityName
                  withContinent:(NSString *)continent
                withCultureText:(NSString *)cultureText
               withCultureImage:(NSString *)cultureImage
                withGeneralText:(NSString *)generalText
               withGeneralImage:(NSString *)generalImage
                 withLocalImage:(NSString *)localImage
                  withLocalText:(NSString *)localText
             withPoliticalImage:(NSString *)politicalImage
              withPoliticaltext:(NSString *)politicalText
                 withClinicsURL:(NSString *)clinicsURL
                  withAlertsURL:(NSString *)alertsURL
                 withWeatherURL:(NSString *)weatherURL
                withCADToNative:(float) dollarRatio
{
    CityEntity *city = [NSEntityDescription insertNewObjectForEntityForName:@"CityEntity" inManagedObjectContext:managedObjectContext];

    city.cityImage = cityImage;
    city.cityName = cityName;
    city.continent = continent;
    city.cultureImage = cultureImage;
    city.cultureText = cultureText;
    city.generalImage = generalImage;
    city.generalText = generalText;
    city.localImage = localImage;;
    city.localText = localText;
    city.politicalImage = politicalImage;
    city.politicalText = politicalText;
    city.clinicsURL = clinicsURL;
    city.alertsURL = alertsURL;
    city.weatherURL = weatherURL;
    city.cadToNative = [NSNumber numberWithFloat:dollarRatio];
    
//    city.embassyItems;
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        if ([managedObjectContext save:&error]) {
            NSLog(@"saved");
        } else {
            NSLog(@"save failed");
        }
//    });
    return city;

    
}

@end
