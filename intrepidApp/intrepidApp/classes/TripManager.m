//
//  TripManager.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/31/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "TripManager.h"
#import "CityEntity.h"

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
    NSLog(@"city Array count: %i", cityArray.count);
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
    NSLog(@"POP TRIPS IS CALLED");
    
    // mexico
    [self createTripWithCityImage:@"Mexico@2x.png" withCityName:@"Mexico City" withContinent:@"South America" withCultureText:@"The ethnic makeup of Mexico is Mestizos (people of mixed European and Native American background): 60-80% - Amerindian (Totonac, Maya, Zapotec, Mixtec, Otomi and Nahuatl): 10% to 30% - European: 9 to 17%. Religions in Mexico include: Roman Catholic 83%, Protestant 9%, Other 8%. The official language of Mexico is Spanish. Although as many as 100 native languages are spoken, 80% of those Mexicans who speak an indigenous language also speak Spanish.The local currency is the Mexican Peso. US dollar travellers’ cheques and notes are readily converted into local currency. International debit and credit cards are widely accepted for payment and in ATMs. It is not possible to exchange cash at hotel receptions - this can only be done at banks and bureaux de change or Cambios. In Mexico, personal space is usually closer than it is for some other cultures: about an arm distance. It is expected for females to shake hands and kiss on one cheek, particularly in a social setting." withCultureImage:@"overview-culture.png" withGeneralText:@"Mexico is bordered to the north by the states of California, Arizona, New Mexico, and Texas, to the west and south by the Pacific Ocean, to the east by the Gulf of Mexico, and to the southeast by Belize, Guatemala, and the Caribbean Sea. Mexico City is located at 7,349 feet (2,240 meters) ASL, Mexico City is temperate and relatively cool but heavily affected by smog due to its limited air circulation. It is surrounded on three sides by mountains and thus the cold fronts from the north make southward intrusions only during the Northern Hemisphere winter and spring. The difference between summer and winter mean temperatures is approximately 6 to 8 °C. The current population of Mexico is 19.5 million. A visa is not required to visit Mexico as a tourist, but you do need a tourist card, which you can obtain on arrival by completing an immigration form, available at border crossings or on-board flights to Mexico. You need a tourist card to leave Mexico. If lost, a tourist card can be replaced at the immigration office at any international airport in Mexico. The cost of a replacement is 295 Mexican Pesos." withGeneralImage:@"overview-history@2x.png" withLocalImage:@"mexicoBackBigger@2x" withLocalText:@"The electricity in Mexico City is the North American standard and converters are not required, with the exception of adaptors for three-prong to two-prong in some older hotels. Travellers to Mexico City may develop traveller’s diarrhea from consuming contaminated water or food. Water precautions should be observed, including avoiding drinks served with ice that may have been made with contaminated water. Communication includes: Telephone networks, including cellular networks are readily available and reliable in Mexico City." withPoliticalImage:@"security-political.png" withPoliticaltext:@"Short-term opportunistic kidnapping does occur, particularly in urban areas. Victims of “express kidnapping” are forced to withdraw funds from credit or debit cards at a cash point to secure their release. Street crime is a serious problem in Mexico City. Pick-pocketing is common on the Mexico City Metro. Dress in an under-stated manner and avoid wearing expensive jewellery. Limit the amount of cash or credit/debit cards you carry with you. Avoid withdrawing money from ATMs or exchanging money at bureaux de change at night. There have been several co-ordinated muggings in the Parque Nacional de las Cumbres del Ajusco in the south of Mexico City. Take extreme care in this area. Earthquakes do occur periodlically in Mexico City. An earthquake measuring 8.1 on the Richter Scale hit Mexico City in 1985 and was reasponsible for the deaths of 10,000 people.  If an earthquake occurs during your stay in Mexico City, drop to the ground; take cover by getting under a sturdy table or other piece of furniture; and hold on until the shaking stops. If there isn’t a table or desk near you, cover your face and head with your arms and crouch in an inside corner of the building. Stay inside until the shaking stops and it is safe to go outside. Do not exit a building during the shaking. While Mexico City has its own security issues, the decision to travel outside of Mexico City should not be taken lightly, as many parts of Mexico have exceptionally high rates of violent crime associated with drug activity."
     withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=latinamerica&country=mexico&city=mexico%20city" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=mexico&city=mexico%20city" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=latinamerica&country=mexico&city=mexico%20city"
     withCADToNative:12.19];
    
    // miami
    [self createTripWithCityImage:@"Miami-USA@2x.png" withCityName:@"Miami" withContinent:@"North America" withCultureText:@"Miami has a polation of408,750 people. 69.7% White,  20.3% African American and Black, 0.20% Native American, 1.4% Asian, 0.01% Pacific Islander, 4.60% from other races, and 3.80% from two or more races. Religions in Miami include: Roman Catholic 61%, Jewish 14%, Southern Baptist 9%, Other 16%. English and Spanish are spoken promiinently. Florida explicitly imposes a criminal penalty for noncompliance with the obligation to identify oneself if requested to do so by a police officer. Remember to have identification with you at all times." withCultureImage:@"Miami-Culture@2x.png" withGeneralText:@"Miami is classified as having a tropical monsoon climate. Temperatures range from 61F to 89 F. Due to its location between two major bodies of water known for tropical activity, Miami is also statistically the most likely major city in the world to be struck by a hurricane. Entry requirements vary depending on nationality. Europeans and many South American nationals require a visa whereas Canadians do not. All those travelling under the Visa Waiver Programme arriving by air or sea should provide details online at least 72 hours before travel. This is known as an Electronic System for Travel Authorization, or ESTA. Those who do not have an ESTA will be refused travel to the USA." withGeneralImage:@"Miami-Overview@2x.png" withLocalImage:@"Miami-Local@2x.png" withLocalText:@"The power grid and water is of first-world standard. The water can be consumed.Telephone networks, including cellular networks are readily available and reliable in Miami. The local currency is the US Dollar. Foreign exchange is readily available for other currencies." withPoliticalImage:@"Miami-Political@2x.png" withPoliticaltext:@"Although Miami has a high murder and aggravated assault rate, attacks on tourists are relatively rare. The high drug-related crime statistics that were synonomous with Miami in the 1980s have subsided but occassional gang-related or racial tensions do occur. Pickpockets, armed robbery and sexual assault do occur and districts such as Overtown, Little Haiti and Liberty City should be avoided if possible. Avoid walking in isolated areas after dark. Miami is likely to be affected by tropical stroms and hurricanes. Rip currents can be present in the spring and winter and present a danger for travellers participating in many water sports." withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=usa&country=united%20states&city=miami" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=united%20states&city=miami" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=usa&country=united%20states&city=miami" withCADToNative:0.96];
    
    // other trips!
    [self createTripWithCityImage:@"Guadala@2x.png" withCityName:@"Guadalajara" withContinent:@"North America" withCultureText:@"The ethnic makeup of Mexico is Mestizos (people of mixed European and Native American background): 60-80% - Amerindian (Totonac, Maya, Zapotec, Mixtec, Otomi and Nahuatl): 10% to 30% - European: 9 to 17%. Religions in Mexico include: Roman Catholic 83%, Protestant 9%, Other 8%. The official language of Mexico is Spanish. Although as many as 100 native languages are spoken, 80% of those Mexicans who speak an indigenous language also speak Spanish.The local currency is the Mexican Peso. US dollar travellers’ cheques and notes are readily converted into local currency. International debit and credit cards are widely accepted for payment and in ATMs. It is not possible to exchange cash at hotel receptions - this can only be done at banks and bureaux de change or Cambios. In Mexio, personal space is usually closer than it is for some other cultures: about an arm distance. It is expected for females to shake hands and kiss on one cheek, particularly in a social setting." withCultureImage:@"Guada-Culture@2x.png" withGeneralText:@"Mexico is bordered to the north by the states of California, Arizona, New Mexico, and Texas, to the west and south by the Pacific Ocean, to the east by the Gulf of Mexico, and to the southeast by Belize, Guatemala, and the Caribbean Sea. Mexico City is located at 7,349 feet (2,240 meters) ASL, Mexico City is temperate and relatively cool but heavily affected by smog due to its limited air circulation. It is surrounded on three sides by mountains and thus the cold fronts from the north make southward intrusions only during the Northern Hemisphere winter and spring. The difference between summer and winter mean temperatures is approximately 6 to 8 °C. The current population of Mexico is 19.5 million. A visa is not required to visit Mexico as a tourist, but you do need a tourist card, which you can obtain on arrival by completing an immigration form, available at border crossings or on-board flights to Mexico. You need a tourist card to leave Mexico. If lost, a tourist card can be replaced at the immigration office at any international airport in Mexico. The cost of a replacement is 295 Mexican Pesos." withGeneralImage:@"Guada-Overview@2x.png" withLocalImage:@"Guada-Local@2x.png" withLocalText:@"The electricity in Guadalajara is the North American standard and converters are not required, with the exception of adaptors for three-prong to two-prong in some older hotels. Travellers to Guadalajara may develop traveller’s diarrhea from consuming contaminated water or food. Water precautions should be observed, including avoiding drinks served with ice that may have been made with contaminated water. Telephone networks, including cellular networks, are readily available and reliable in Guadalajara." withPoliticalImage:@"Guada-Political@2x.png" withPoliticaltext:@"Guadalajara is the second largest city in Mexico. Guadalajara has a well-earned crime rating of “high-plus”. Petty street crime—such as purse or jewelry snatching, pick-pocketing, and theft from vehicles—is very common. Areas of the greatest concern include the downtown district at night and areas east of downtown. Violent crime, to include kidnapping, car-jacking and armed robbery, occurs with some frequency. There were 112 bank robberies in the Guadalajara Metropolitan Zone in 2011. Narco-related violence remained steady throughout the year. In the last six months of 2011, authorities in Guadalajara tracked an average of 117 total security-related incidents per month. Narco-related violence tends to occur in places less likely to attract American citizen residents or tourists. Crime in the Guadalajara area has been rated at “medium”. While residential burglars usually rely on stealth, attempting to break into the home when residents are away, home invasions by armed criminals have also occurred, where the owner was inside the residence or arrived home at the time of the attempt. In these circumstances, you should not resist. Rather, use slow, deliberate movements to avoid confusion that could result in injury or death at the hands of a nervous criminal. General residential security guidelines include: closing and locking all windows and doors (to include garage and gate); regularly checking outside lighting and replacing light bulbs as necessary; installing and using a security alarm; installing quality locks (preferably deadbolts) on doors and gates; and never leaving “hidden” keys anywhere outside your home." withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=latinamerica&country=mexico&city=guadalajara" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=mexico&city=guadalajara" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=latinamerica&country=mexico&city=guadalajara" withCADToNative:12.19];
    

    [self createTripWithCityImage:@"Puerto@2x.png" withCityName:@"Puerto Plata" withContinent:@"North America" withCultureText:@"The ethnic make-up includes Mixed African Amerindian and European: 75%, white: 16%, black 11%. The religions include Roman Catholic 81% and Others comprising 19%. tHe language premoinently spoken is Spanish.There are severe penalties for all drug offences. Possession of even small quantities can lead to a long prison sentence and a hefty fine. All sentences are served in the Dominican Republic. Travellers entering the Dominican Republic for tourist purposes must purchase a tourist card, at a cost of US$10, which is valid for 30 days. Those wishing to stay for a longer period must pay a surcharge at the airport upon departure or request an extension by visiting the Department of Immigration in Santo Domingo. Those wishing to work in the Dominican Republic must apply for a business visa. Foreigners may gain the right to reside in the Dominican Republic by acquiring a residence visa from the Foreign Relations Ministry and a temporary or permanent residence card from the Immigration Department. A student visa is also required.  A departure tax of US$20 is charged for stays of up to 30 days. The departure tax for stays longer than 30 days varies depending on length of stay and nationality. The tax applies to all international flights, and may be included in the price of the airline ticket." withCultureImage:@"Puerto-Culture@2x.png" withGeneralText:@"The Dominican Republic is located on the Island of Hispaniola, which it shares with its much smaller neighbor to the west - Haiti. The country has an area of 48,442 square kilometers, which take up about 2/3 of the island. The island has the Atlantic Ocean to the north and the Caribbean Sea to the south. The Mona Passage, a channel about 130 km wide, separates the country (and Hispaniola) from Puerto Rico. Puerto Plata is located at the very northern tip of the island. Tropical climate with hot, dry summers and warm, very wet winters. The hurricane season in the Dominican Republic runs from June 01 to November 30. The population consists of 321,597 people." withGeneralImage:@"Puerto-Overview@2x.png" withLocalImage:@"Puerto-Local@2x.png" withLocalText:@"The local currency is the Dominican Peso. USD and Euro readily convertible. The electricity is 110 volts in major cities and vacation destination hotels. Surge protectors are recommended. The water is not fit for consumption and bottled water is recommended. The Dominican Republic boasts an extensive fibre optic and microwave-based landline network, as well as an efficient mobile network." withPoliticalImage:@"Puerto-Political@2x.png" withPoliticaltext:@"The Dominican Republic suffers from a high crime rate, ranging from opportunistic crime like bag-snatching and pick-pocketing, to violent crime. Take particular care in remote areas, especially at night. If you leave your hotel complex, do not wear expensive jewellery or carry large amounts of cash or expensive items like cameras. Use a hotel safe whenever possible. Do not leave your bags or other possessions on chairs or tables when sitting in outside restaurants or bars. If you lose your passport or it is stolen, get a police report before contacting the embassy. POLITUR (The Tourist Police) can be contacted on the free telephone number 1-809-200-3500. Unaccompanied female travellers should exercise caution. Incidents of assault, rape and sexual aggression against foreigners have been reported, including at beach resorts. The ocean can be dangerous during the storm season. Lifeguards may not be present at swimming pools or on beaches, and safety and rescue equipment may not be available. The Dominican Republic is located in a seismic zone and earthquakes can occur. Observe earthquake protocols." withClinicsURL:@"http://m.intrepid247.com/ppn.html#/?region=latinamerica&country=Dominican%20republic&city=puerto%20plata" withAlertsURL:@"http://m.intrepid247.com/alert.html#/?country=Dominican%20republic&city=puerto%20plata" withWeatherURL:@"http://m.intrepid247.com/weather.html#/?region=latinamerica&country=Dominican%20republic&city=puerto%20plata" withCADToNative:40.38];

    
}

-(void) createTripWithCityImage:(NSString *)cityImage
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

    
}

@end
