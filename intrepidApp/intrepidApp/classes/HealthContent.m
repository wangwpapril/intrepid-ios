//
//  HealthContent.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/25/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "HealthContent.h"
#import "HealthItem.h"

@implementation HealthContent


-(NSMutableArray *)getContent {
    
    NSArray *symptoms = [NSArray arrayWithObjects:
                         [HealthItem healthItemOfCategory:@"conditions"
                            name:@"Altitude Sickness"
                            description:@"When the alititude exceeds 2,500 metres, the partial pressure of oxygen decreases, causing increased breathing and rapid heartbeat as well as dehydration. This collection of symptoms is called altitude sickness. "
                            details:@"Symptoms of latitude Sickness include headaches (50 percent of travellers suffer headaches at 3,500 metres), anusea, vomiting, loss of appetite, shortness of breath, swelling of the face and eyelids, palpitations, anxiety, insomnia.\n" common:TRUE symptoms:@"In high-altitude areas, drink plenty of water, eat carbohydrate-rich foods, and avoid alcohol, smoking, and sleeping pills.Being in good physical condition may help to prevent altitude sickness. Before making a climb, make sure you are fully acclimatized to your departure point. Acclimatization takes 24 to 48 hours.Climb gradually: 300 metres per day with a day of rest every 3 days for altitudes over 3000 metres. However, if acute altitude sickness symptoms occur and do not disappear within 24 hours, climb down 500 metres." immunization:@"If you suffer from altitude sickness despite your preventative efforts, you should drink plenty of water and you may take acetaminophen (e.g., Tylenol) or acetylsalicylic acid (e.g., Aspirin) to relieve headaches. You may also use low-flow oxygen during sleep. Finally acetazolamide, a prescription medication, can be an effective prophylactic."
                            image:@"Altitude-Sickness.png"],
                         [HealthItem healthItemOfCategory:@"conditions"name:@"Cholera" description:@"It is common for people to be infected with the bacterium that causes cholera and not realize it. In some benign cases, especially in children, the symptoms resemble that of gastroenteritis. Most often, the toxic infection (Infection due to a bacteria-secreting a toxin) is characterized by very abundant, watery stools, sometimes with blood, accompanied by vomiting, severe abdominal cramps, and extremely painful muscle cramps. In untreated cases, severe dehydration may be followed by circulatory collapse (Blood pressure drop) - with a fatality rate of 50 percent. However, when cholera is treated with an appropriate antibiotic and fluid therapy, mortality is 1 to 5 percent." details:@"Cholera is usually spread by the ingestion of contaminated water or food, especially raw or undercooked shellfish and fish. It is rarely transmitted from person to person. The incubation period varies from a few hours to 3 days (maximum of 7 days). Gastric achlorhydria (marked by the absence of hydrochloric acid and the inability to digest food properly. Can follow the use of certain drugs to treat ulcers) increases a person's vulnerability to the disease. Infected individuals usually become contagious 2 to 3 days before the disease becomes manifest and remain contagious up to 2 weeks after symptoms have subsided. Some people carry the bacteria for several months." common:FALSE symptoms:@"The best preventive measures include avoiding contaminated water and food and washing hands frequently. Cooking foods and boiling water thoroughly will destroy the bacteria. If you think you may be vulnerable consider taking a prophylactic antibiotic, such as doxycycline, cotrimazole, or erythromycin." immunization:@"The cholera vaccine isn't recommended very often in North America, because the infection can be easily avoided if adequate dietary precautions are taken. However, vaccination may be suggested by your physician if you are travelling to an area where the disease is common or during an epidemic or where sanitary conditions are known to be inadequate. Two vaccines are mainly used. The first one is given in a single dose (injection) and is effective in 90% of patients, 8 days after administration. Its protection lasts 6 months. It is not recommended for children less than 6 months of age, and should be avoided when possible in pregnant women. It often causes a reaction at the injection site (redness and pain).The second vaccine is administered orally and was recently marketed under the brand name Dukoral. It also protects against traveler's diarrhea caused by E. coli. It is indicated in adults and children 2 years and older. Patients take 2 or 3 doses, depending on age. Its protection starts approximately 1 week after the last dose and remains effective for 3 months for traveler's diarrhea due to E.coli and 2 years for cholera. The risk of European or North American travellers contracting cholera is so low (1 or 2 cases per 1 million trips to an endemic area) that WHO (World Health Organization) does not recommend the vaccine to travellers."
                            image:@"Cholera.png"],
                         [HealthItem healthItemOfCategory:@"conditions" name:@"Dengue Fever" description:@"Dengue fever is caused by a virus and is often confused with other infections such as malaria or typhoid fever. Clinically, it presents symptoms similar to those of the flu, including fever attacks, headaches, joint-and-muscle pain as well as nausea and/or vomiting. A skin rash may appear 3 to 4 days after the onset of fever. Onset is sudden and symptoms may last up to 10 days. Although the disease is usually benign, it can occur in a severe form known as dengue haemorrhagic fever, which is 1 of 4 known types of dengue fever, and which results in death in 5 percent of cases." details:@"Dengue fever is most often found in tropical urban areas. It has a distribution pattern similar to that of malaria. The Aedes mosquito, which also transmits yellow fever, transmits the dengue virus. This mosquito is active all day long. It is found near, and even inside, dwellings.The symptoms of dengue fever can be treated with bed rest, hydration, and acetaminophen as needed. Do not administer Aspirin and other non-steroidal anti-inflammatory medications (eg. ibuprofen) because it may aggravate the bleeding tendency associated with some dengue infections." common:FALSE symptoms:@"There is no vaccine against dengue fever. In 1997, dengue fever was the most prevalent mosquito-borne viral illness in the world. There are no travel-related requirements." immunization:@"Typical anti-mosquito precautions are essential: insect repellent, mosquito netting, and light-coloured long-sleeved shirts and long pants." image:@"Dengue-Fever.png"],
                         [HealthItem healthItemOfCategory:@"conditions" name:@"Hepatitis A" description:@"Hepatitis A is a liver infection caused by a virus that thrives in the stool of infected humans and animals (mostly primates).Hepatits A is characterized by fever, fatigue, headaches, and a loss of appetite, often accompanied by jaundice (icterus), vomiting, and diarrhea. A large proportion of infected people experience only a mild feeling of malaise with nonspecific symptoms. The classic clinical syndrome has an abrupt onset of symptoms. The incubation period lasts 15 to 50 days (25 to 30 days on average). In most patients, complete remission occurs within 2 to 4 weeks. The mortality rate of hepatitis A is 0.6 percent." details:@"Hepatitis A is acquired by direct person-to-person contact or by ingesting contaminated water (or ice), seafood from contaminated waters, or raw fruits or vegetables contaminated during handling. Infected individuals are contagious 2 to 3 weeks before symptoms appear until a week after jaundice has developed. The disease confers permanent immunity." common:FALSE symptoms:@"In many parts of the world, there are communities with high rates of hepatitis A. People who travel to rural areas or places where sanitary conditions are inadequate are at substantial risk of acquiring the disease. The following preventive measures should be followed to avoid getting infected: Wash hands before handling food; Wash hands before meals and after using the bathroom; Do not eat or drink beverages and foods that might be contaminated. Exposing the hepatitis A virus to temperatures of at least 85 degree Celsius for 1 minute will inactivate it. The virus can also be inactivated by adding chlorine or iodine to the contaminated water." immunization:@"Since the incidence of hepatitis A is common among travellers and the vaccine is safe, it is recommended that all travellers visiting countries where hepatitis A is rated endemic at a high or intermediate level should be vaccinated. In some countries where sanitary conditions are better, immunization is recommended only for travellers who expect to venture outside regular tourist areas. Those who frequently travel abroad or who stay for long periods of time should always be vaccinated. The vaccine (Havrix) is administered in 2 shots, at 6 to 12 month intervals. The vaccine confers good immunity within 2 to 4 weeks following the first shot. When 2 doses are administered, the vaccine may be effective up to 20 years.The hepatitis A vaccine is also available in combination with a hepatitis B vaccine (Twinrix). The combined vaccine is recommended in the presence of hepatitis C, when no hepatitis B antibodies have been found. Immune globulins may also be administered. They confer immediate immunity lasting about 5 months. However, they are being gradually replaced by the vaccines." image:@"Hepatitis-A.png"],
                         [HealthItem healthItemOfCategory:@"symptoms" name:@"Hepatitis B" description:@"Hepatitis B is a liver infection caused by a virus. Its incubation period lasts about 4 months (from 1 to 5 months).In young children, hepatitis B is often asymptomatic. In adults, about a third of infected individuals experience no symptoms while another third are afflicted with a flu-like syndrome of varying intensity. The rest develop a classic clinical syndrome with malaise, headaches, myalgia, nausea, loss of appetite, unusual fatigue, hepatomegaly (enlarged liver), and icterus (jaundice). Symptoms usually last 4 to 6 weeks, but can persist for up to 6 months. In 90 percent of cases, the disease is self-limiting. Among infected adults, 6 to 10 percent will become long-term carriers of the disease." details:@"The virus is present in body fluids of the infected person: blood, sperm, vaginal secretions, etc. Transmission occurs during sexual intercourse or through contact with contaminated blood (via a bloodstained instrument, for example). Infected mothers can transmit the disease to her infant during vaginal delivery. The infection is most contagious during the second and third month of the incubation period and its contagiousness can linger for several weeks after symptoms have appeared. The infection confers permanent immunity." common:FALSE symptoms:@"The risk of contracting hepatitis B while travelling is low. People who stay abroad for long periods are more at risk. To protect oneself during sexual contact, always use a latex or polyurethane condom during sexual intercourse. To prevent the transmission through contaminated instruments, only use clean, sterile injection material." immunization:@"There is a vaccine against hepatitis B (Engerix, Heptavax, Recombivax). Three intramuscular shots are required. The second dose is administered 1 month after the first, and the third dose 6 months after the first. The vaccine confers good immunity on 80 to 95 percent of people. Even if the whole vaccination schedule cannot be completed before leaving on a trip, the first two shots still confer some immunity.The Comité d'immunisation du Québec recommends a universal immunization against hepatitis B. In Québec, the hepatitis B vaccine is now part of the regular immunization schedule and it is administered to fourth graders. The vaccine is also available in combination with the hepatitis A vaccine (Twinrix)." image:@"Hepatitis-B.png"],
                         [HealthItem healthItemOfCategory:@"symptoms" name:@"Jet Lag" description:@"The time difference between your point of departure and your destination may upset your biological clock, causing you to feel out of sorts for several days. Most travellers who cross more than 3 time zones suffer from jet lag. Its effects are more severe when flying from west to east since one has the impression that the days have become shorter." details:@"Symptoms of jet lag include: sleep and digestive disturbances, headaches, fatigue, irritability, and decreased physical and mental performance. Although sleeping pills may help alleviate sleep disturbances, they will not alter your internal clock. Exposure to sunlight seems to be the best way to improve jet lag. Putting on sunscreen and spending time in the sun, without wearing sunglasses, may significantly reduce the symptoms of jet lag. If you must take a sleeping pill, experts recommend a short-acting benzodiazepine." common:TRUE symptoms:@"To diminish the effects of jet lag, try to get some sleep during the flight. Eat small meals and drink plenty of water or juice. Do not drink alcohol. On your arrival, take it easy and rest for the first 24 hours. Get as much sun as you can, as soon as possible. Do not nap during the day and you will sleep better at night. There is no effective drug treatment for jet lag. If possible, start adjusting sleeping and waking times to your new time zone days before departure." immunization:@"Melatonin is a natural health product that is used to help relieve insomnia associated with jet lag. Although melatonin may indeed be helpful, there is not enough evidence to prove its efficacy and, as a result, we cannot recommend it. Its short-term use however, does not pose a risk for most. Speak to your pharmacist. When traveling, adjustments must be made to some medication schedules - insulin in particular. See your pharmacist for more information." image:@"Jet-Lag.png"],
                        [HealthItem healthItemOfCategory:@"symptoms" name:@"Lyme Disease" description:@"Lyme disease is a systemic infection caused by a spirochete, Borrelia burgdorferi.Lyme disease evolves through 3 stages: local eruption surrounded by an aerola plus flu symptoms;neurologic and/or cardiac abnormalities; joint problems plus chronic neurologic syndromes." details:@"The infection is transmitted by ticks of the Ixodes complex. Deer are important hosts of the infected ticks. The ticks are endemic in North American woody areas, but they only carry the disease in certain areas, such as New England. There have also been reports of outbreaks of lyme disease in Ontario and British Columbia." common:FALSE symptoms:@"To reduce the risk of getting bitten, wear long pants with socks over it if you intend to go walking in woods or overgrown brush infested areas. Wear long, pale-coloured clothing to help spot the ticks. No skin should be left exposed unless treated with a repellent (DEET). Insect repellent applied to clothing is effective for longer than it may be on the skin. Extra protection is provided by treating clothing with permethrin. Only 10 percent of bites by infected ticks will cause an infection as long as ticks are removed promptly with tweezers." immunization:@"Antibiotics are used to treat lyme disease. They must be prescribed by a physician. During stage 2 or 3, administering a short course of an oral corticosteroid may help relieve symptoms." image:@"Lyme.png"],
                            [HealthItem healthItemOfCategory:@"symptoms" name:@"Malaria" description:@"Malaria's clinical presentation may be compared to a severe attack of the flu, with sudden, very high fever, shivering, excessive sweating, headaches, myalgia (muscle pain), arthralgia (joint pain), and anemia. Typically, 1 day of very high fever is followed by 2 to 3 days of respite. If the initial infection is not treated, relapses can occur at more or less regular intervals. It is estimated that 200 million individuals become infected each year worldwide, and 1 to 2 million of those infected will die from the disease." details:@"Malaria is transmitted by the female Anopheles mosquito. The female mosquito is the only one that bites, usually after sundown, and a single bite is enough to transmit the disease. The parasite (Plasmodium) multiplies in the liver during the first phase of development, which lasts 1 to 4 weeks. Then, the parasite leaves the liver and invades red blood cells and the disease becomes symptomatic. At this stage, a mosquito that bites an infected individual will become a carrier of the disease." common:FALSE symptoms:@"There is no vaccine against malaria. A prevention with chloroquine (Aralen) or mefloquine (Lariam) depending on the area and the presence of resistant strains of Plasmodium, is recommended to all travellers going to endemic areas. In areas where malaria is endemic and since the prevention is not 100 percent effective, avoid evening outdoor activities and always use an insect repellent. If you cannot sleep in a closed, air-conditioned room, hang mosquito netting around the bed. If outdoor activities are planned at dusk or dawn, wear pale-coloured clothing that covers as much of your skin as possible." immunization:@"When travelling to certain endemic regions, you may wish to consult your physician about taking along a curative treatment to be used if you get malaria despite the use of an appropriate prevention. The combination of pyrimethamine and sulfadoxine (Fansidar) is recommended for the presumptive treatment of malaria. Seek medical attention as soon as possible for all illnesses associated with high fever." image:@"Malaria.png"],
                         [HealthItem healthItemOfCategory:@"symptoms" name:@"Meningitis" description:@"Meningitis is an acute infection of the central nervous system caused by several strains of a bacterium called Nesseria meningitidis. The disease has a sudden onset with symptoms of fever, severe headache, nausea, vomiting, and stiff neck. On occasion, red spots may appear on the skin. The mortality rate, if left untreated, is around 10 to 20 percent. However, even when an appropriate treatment is administered, the mortality rate remains as high as 5 to 10 percent. In most cases, the bacterium Nesseria meningitidis causes a respiratory tract infection that will not develop into meningitis." details:@"Transmission is by direct contact, which includes saliva droplets and discharges from the nose and throat of an infected person. Some individuals do not develop the disease at this point but become carriers and propagators of the bacteria. Following contact with the bacteria, the incubation period is 2 to 10 days (3 to 4 days on average) before symptoms appear. The disease confers temporary immunity against the infecting strain." common:FALSE symptoms:@"In high-risk situations, prophylactic antibiotic treatments are administered to close-case contacts. Typically, 4 doses of rifampin 600 mg are administered at 12-hour intervals, but other schedules and products may be used." immunization:@"The meningococcal C vaccine is part of the routine immunization schedule for infants and children across Canada. Additionally, there are vaccines against several other meningococcal strains which are used during outbreaks caused by a strain found in the vaccine. At present however, no vaccine can protect against serogroup B meningococci." image:@"Meningitis.png"],
                           [HealthItem healthItemOfCategory:@"symptoms" name:@"Motion Sickness" description:@"Motion sickness is caused by a conflict between vestibular (inner ear) and visual sensations. It can occur on a boat (seasickness), on an airplane (airsickness) or on any vehicle where your body is subjected to movement (car sickness, bus sickness, amusement ride sickness). However actual movement of the body is not necessary to produce symptoms. Purely visual stimuli such as those from video games or panoramic movies can also cause motion sickness." details:@"Symptoms of motion sickness include nausea, vomiting, yawning, fatigue, sweating, and pallor." common:TRUE symptoms:@"If you suffer from motion sickness from vehicular transport, take the following preventive measures: on a plane, sit in front of the wings; in a car, sit in the front seat; on a boat, sit as close to the centre as you can. Also consider taking an antiemetic 30 minutes before departure or applying a patch 12 hours before departure. (Check with your pharmacist to determine if you have any contraindications to transdermal patches.)" immunization:@"Before climbing aboard a vehicle, eat a small meal but avoid fatty foods. During the trip, suck on lemon-flavored candies or chew a piece of gum. Make sure that your stomach is never empty. If you start to feel faint, stay calm and look toward the horizon. Do not read or smoke. Stay in a well-ventilated area." image:@"Motion-Sickness.png"],
                            [HealthItem healthItemOfCategory:@"symptoms" name:@"Rabies" description:@"Rabies is a fatal viral disease that attacks the central nervous system. Initial symptoms include extreme anxiety, headaches, fever, general malaise, and sensory problems. Subsequently the infected individual experiences paralysis, muscle spasms inhibiting swallowing, fear of water, delirium, and seizures. The disease lasts 2 to 14 days and death occurs in close to 100 percent of untreated patients. Death is caused by paralysis of respiratory muscles." details:@"Rabies is transmitted by contact with the secretions of a rabid animal or person, delivered by a bite or when infected secretions contact a wound or a mucous membrane. Wild animals and dogs serve as reservoirs for the virus. The incubation period generally lasts 2 to 8 weeks, but can sometimes last several years. In cats and dogs, the infectious period starts about 3 days before symptoms appear. An animal that has bitten should be kept under close observation for a few days to see whether it develops any rabies symptoms. A rabid animal displays unusual behaviour: for example, wild animals lose their fear of humans, domestic animals become unusually calm or attack without provocation. Cases of person-to-person transmission have never been documented." common:FALSE symptoms:@"In general, you should avoid contact with wild animals or with domestic animals of unknown vaccination status. Report any bite to a physician within 24 hours, whether the animal appears healthy or not." immunization:@"A rabies vaccine is currently available. It is generally indicated for people who expect to be in close contact with animals in areas where rabies has been reported. Three doses are administered over a 3-week period. A booster shot is recommended every 2 years, based on antibody titre results. Any individual who has been bitten by a potentially rabid animal should receive the vaccine and immunoglobulins, even if the individual has already been vaccinated. The vaccination schedule should be initiated within 24 hours of the incident; five doses are necessary (on day 0, 3, 7, 14, and 28). Washing the wound with soap and water will considerably reduce the risk of transmission. The vaccine is frequently associated with fever and a general feeling of malaise." image:@"Rabies.png"],
                            [HealthItem healthItemOfCategory:@"symptoms" name:@"Traveller's Diarrhea" description:@"Rabies is a fatal viral disease that attacks the central nervous system.Initial symptoms include extreme anxiety, headaches, fever, general malaise, and sensory problems. Subsequently the infected individual experiences paralysis, muscle spasms inhibiting swallowing, fear of water, delirium, and seizures. The disease lasts 2 to 14 days and death occurs in close to 100 percent of untreated patients. Death is caused by paralysis of respiratory muscles." details:@"Rabies is transmitted by contact with the secretions of a rabid animal or person, delivered by a bite or when infected secretions contact a wound or a mucous membrane. Wild animals and dogs serve as reservoirs for the virus. The incubation period generally lasts 2 to 8 weeks, but can sometimes last several years. In cats and dogs, the infectious period starts about 3 days before symptoms appear. An animal that has bitten should be kept under close observation for a few days to see whether it develops any rabies symptoms. A rabid animal displays unusual behaviour: for example, wild animals lose their fear of humans, domestic animals become unusually calm or attack without provocation. Cases of person-to-person transmission have never been documented." common:TRUE symptoms:@"In general, you should avoid contact with wild animals or with domestic animals of unknown vaccination status. Report any bite to a physician within 24 hours, whether the animal appears healthy or not." immunization:@"A rabies vaccine is currently available. It is generally indicated for people who expect to be in close contact with animals in areas where rabies has been reported. Three doses are administered over a 3-week period. A booster shot is recommended every 2 years, based on antibody titre results. Any individual who has been bitten by a potentially rabid animal should receive the vaccine and immunoglobulins, even if the individual has already been vaccinated. The vaccination schedule should be initiated within 24 hours of the incident; five doses are necessary (on day 0, 3, 7, 14, and 28). Washing the wound with soap and water will considerably reduce the risk of transmission. The vaccine is frequently associated with fever and a general feeling of malaise." image:@"Diarrhea.png"],
                            [HealthItem healthItemOfCategory:@"symptoms" name:@"Typhoid Fever" description:@"The bacterium, Salmonella typhi, causes typhoid fever, a disease characterized by sustained fever, headaches, loss of appetite, abdominal pain, dry cough, fatigue. and constipation. On occasion, diarrhea may follow constipation. Also the spleen may become enlarged. Some infected people remain asymptomatic. If antibiotics are not administered to combat the infection, complications can occur around the third week. Five to 20 percent of patients suffer a relapse within 2 weeks. Globally, the mortality rate of typhoid fever is 2 to 3 percent. Death usually results from intestinal hemorrhage or perforation." details:@"Salmonella typhi bacteria are transmitted by foods or beverages that have become contaminated after contact with the feces, urine, vomit, or expectoration of a healthy carrier or of a patient with the active disease. There have been reports of transmission by oysters cultivated in contaminated water and flies transporting fecal matter attached to their feet. The risk of transmission is highest in the developing parts of the world, such as India, Asia, Africa, and Latin America. The incubation period lasts 1 to 3 weeks, and rarely up to 8 weeks. People can transmit the disease from 1 week after contracting it until the end of their convalescence, sometimes up to 3 months after the appearance of the first symptoms. Some people will become lifelong chronic carriers." common:TRUE symptoms:@"Take the following measures to prevent typhoid fever: wash hands before handling food; wash hands before eating and after using the toilet; avoid potentially contaminated foods and beverages. The risk of getting typhoid fever is relatively low; only about 3 out of 100,000 travellers acquire it each month." immunization:@"A typhoid vaccine is currently available. The vaccine is given in a single dose. A booster shot should be administered every 3 years. The vaccine offers adequate protection in 70 to 90 percent of those who receive it. It is generally recommended for people who expect to travel outside the usual tourist areas. Consider vaccinations for any traveller aged 3 years and older who may come into contact with potentially contaminated water and food, and especially for those planning long stays in small towns or rural areas where the incidence of typhoid fever is highest." image:@"Typhoid.png"],
                         [HealthItem healthItemOfCategory:@"symptoms" name:@"West Nile Virus" description:@"The West Nile Virus (WNV) was identified in 1937, when it was first isolated in the blood of a patient from the West Nile province of Uganda. The virus is in the same class as the one that causes Japanese encephalitis. It is spread by mosquito bites and is found across the globe. Several bird species constitute its animal reservoir. The virus has been associated with numerous outbreaks in several African, Asian, Middle-Eastern, and European countries. In America, the virus was first observed in late summer 1999 in the New York City area. At that time, 62 cases of encephalitis and 7 deaths were reported. In October 2000, the New York City Department of Health conducted a study in people 5 years and older who lived in the neighborhood where most cases of encephalitis had occurred. The study revealed the presence of antibodies (a sign of exposure to the virus) in 2.6 percent of the population. Most of the affected individuals reported no specific symptoms, other than mild flu-like symptoms. In Canada, the virus was detected for the first time during the summer of 2001. The presence of the virus was later confirmed in birds and mosquitos. Only a few human cases were diagnosed in 2002. Most provinces now have a monitoring system in place. It is estimated that about 20 percent of those infected will develop mild symptoms. Only 1 percent of those infected will develop a severe form of the illness, and most of them will be elderly. In the New York State outbreak, 60 percent of those infected were 65 years or older." details:@"The disease usually has a sudden onset. Patients present with a fever (lasting 3 to 5 days) which is sometimes associated with the following symptoms: severe headaches, skin rash, usually on the abdomen, eye pain, swollen lymph glands, gastrointestinal upset, muscle weakness and muscle pain. The incubation period usually lasts 5 to 15 days. In most cases, the person has no symptoms or suffers from a benign flu-like syndrome. Rarely, and mostly in the elderly, it may cause encephalitis or meningitis, with or without muscle weakness.The West Nile Virus is transmitted to humans and animals by the bite of an infected mosquito. The virus is found in the salivary glands of mosquitoes that feed on infected birds. Several bird species can be infected, including crows, sparrows, and various exotic birds. This is the reason why health authorities in Canada are keeping track of the number of dead birds and are taking blood samples as a means to monitor the virus. The latest data shows that the virus can also be transmitted through blood, organ transplants, pregnancy and breastfeeding. The virus is not transmitted through person to person contact. It is impossible to catch it by kissing an infected person or caring for a person who has the virus. There is no evidence to show that the virus is transmitted from an infected bird or animal to a person. West Nile encephalitis is a seasonal illness because it depends on the presence of mosquitoes. In Canada, outbreaks are more likely to occur during late summer or fall." common:FALSE symptoms:@"In areas with West Nile Virus activity, it is estimated that less than 1 percent of all mosquitoes are infected. Nevertheless, here are a few simple measures to reduce the risk of contracting this virus: Use an insect repellent with DEET - maximum concentration of 30% in adults or 10% in children 2 years or older. In general, children under 2 years should avoid DEET-based insect repellents. In some situations where there is a high risk of complications from an insect bite, it is possible to apply a product with 10% DEET or less, but only once per day for children aged 6 months to 2 years. Avoid using repellent on the hands and face of children because of the risk of mouth or eye contact. Do not apply insect repellent on wounds or broken skin. Always wash repellent-treated skin when coming back indoors. Wear light-coloured clothing with full-length pants and sleeves during outdoor activities. In areas where mosquitoes abound, stay inside at dawn and dusk. Make sure that mosquito screens are not damaged. Reduce the mosquito population around your house by eliminating all sources of standing water and wastes. Do not touch sick or dead birds or animals with your bare hands. While there is still no evidence that WNV can be transmitted in such a way, animals can carry other diseases. If the creature must be handled, wear gloves or use a plastic bag." immunization:@"There is no specific treatment or vaccine against this disease. Evidence suggests a person cannot get West Nile disease more than once; the initial infection appears to confer lifelong immunity. Treatment is supportive and based on the patient's condition. A human vaccine is being developed. Diagnosis is based on a specific blood test. Usually 2 blood samples are drawn 14 to 21 days apart. For monitoring purposes, the presence of the virus is suspected when there is: acute febrile illness. Signs of viral encephalitis. Altered mental state or muscle weakness. No other infectious agent yet identified. This definition excludes cases of viral meningitis not associated with encephalitis. Suspected and confirmed cases of encephalitis should be immediately reported to the Public Health Branch of Health Canada." image:@"West-Nile.png"],
                            nil];
    
    NSArray *medication  = [NSArray arrayWithObjects:
                          [HealthItem healthItemOfCategory:@"medications" name:@"Arm Fracture" description:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
                            details:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." common:TRUE symptoms:@"" immunization:@"" image:@"samplePic.png"],
                            [HealthItem healthItemOfCategory:@"medications" name:@"Heartburn" description:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda" details:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda" common:TRUE symptoms:@"" immunization:@"" image:@"samplePic.png"],
                           nil];
    NSMutableArray *contentArray = [[NSMutableArray alloc] initWithObjects:symptoms, medication, nil];
    return contentArray;
    
}
@end
