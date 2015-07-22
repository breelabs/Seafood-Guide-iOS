//
//  AppDelegate.m
//  Seafood Guide
//
//  Created by Jon Brown on 8/30/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "AppDelegate.h"
#import "Seafood.h"
#import "Lingo.h"
#import "About.h"
#import "RXMLElement.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize fetchedResultsController = __fetchedResultsController;


-(void)insertRoleWithRoleName:(NSString *)seafoodName typeName:(NSString *)seafoodType descName:(NSString *)seafoodDesc goodName:(NSString *)seafoodGood badName:(NSString *)seafoodBad regName:(NSString *)seafoodRegion

{
    
    Seafood *seafood = [NSEntityDescription insertNewObjectForEntityForName:@"Seafood"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    
    seafood.name = seafoodName;
    seafood.fishtype = seafoodType;
    seafood.desc = seafoodDesc;
    seafood.good = seafoodGood;
    seafood.bad = seafoodBad;
    seafood.region = seafoodRegion;
    
    [self.managedObjectContext save:nil];
}

-(void)insertLingoWithLingoName:(NSString *)lingoTitle imageName:(NSString *)lingoImage descName:(NSString *)lingoDesc newsName:(NSString *)lingoNews

{
    
    Lingo *lingo = [NSEntityDescription insertNewObjectForEntityForName:@"Lingo"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    
    lingo.titlenews = lingoTitle;
    lingo.imageurl = lingoImage;
    lingo.descnews = lingoDesc;
    lingo.linknews = lingoNews;
    
    [self.managedObjectContext save:nil];
}

-(void)insertAboutWithAboutName:(NSString *)aboutTitle descName:(NSString *)aboutDesc newsName:(NSString *)aboutNews

{
    
    About *about = [NSEntityDescription insertNewObjectForEntityForName:@"About"
                                                 inManagedObjectContext:self.managedObjectContext];
    
    
    about.titlenews = aboutTitle;
    about.descnews = aboutDesc;
    about.linknews = aboutNews;
    
    [self.managedObjectContext save:nil];
}

- (void)importCoreDataDefaultRoles {
    
    NSString *defaultPrefsFile = [[NSBundle mainBundle] pathForResource:@"defaultPrefs" ofType:@"plist"];
    NSDictionary *defaultPreferences = [NSDictionary dictionaryWithContentsOfFile:defaultPrefsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    //IMPORT ABOUT
    NSUInteger integerFromPrefsAbout = [defaults integerForKey:@"loadabout"];
    RXMLElement *rootXMLAbout1 = [RXMLElement elementFromXMLFile:@"ios-about-1.xml"];
    RXMLElement *rootXMLAbout2 = [RXMLElement elementFromXMLFile:@"ios-about-2.xml"];
    RXMLElement *rootXMLAbout3 = [RXMLElement elementFromXMLFile:@"ios-about-3.xml"];
    RXMLElement *rxmlabout1 = [rootXMLAbout1 child:@"news"];
    RXMLElement *rxmlabout2 = [rootXMLAbout2 child:@"news"];
    RXMLElement *rxmlabout3 = [rootXMLAbout3 child:@"news"];
    NSArray *rxmlIndividualNew1 = [rxmlabout1 children:@"new"];
    NSArray *rxmlIndividualNew2 = [rxmlabout2 children:@"new"];
    NSArray *rxmlIndividualNew3 = [rxmlabout3 children:@"new"];
    
    //RELOAD DATA BY UNCOMMENTING THE BELOW
    //[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"loadabout"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    if (integerFromPrefsAbout == 0) {
        
        for (int i=0; i<rxmlIndividualNew1.count; i++) {
            
            NSString *title = [NSString stringWithString:[[rxmlIndividualNew1 objectAtIndex:i] child:@"titlenews"].text];
            NSString *desc = [NSString stringWithString:[[rxmlIndividualNew1 objectAtIndex:i] child:@"descnews"].text];
            NSString *link = [NSString stringWithString:[[rxmlIndividualNew1 objectAtIndex:i] child:@"linknews"].text];

            [self insertAboutWithAboutName:title descName:desc newsName:link];
            
        }
        
        for (int i=0; i<rxmlIndividualNew2.count; i++) {
            
            NSString *title = [NSString stringWithString:[[rxmlIndividualNew2 objectAtIndex:i] child:@"titlenews"].text];
            NSString *desc = [NSString stringWithString:[[rxmlIndividualNew2 objectAtIndex:i] child:@"descnews"].text];
            NSString *link = [NSString stringWithString:[[rxmlIndividualNew2 objectAtIndex:i] child:@"linknews"].text];
            
            [self insertAboutWithAboutName:title descName:desc newsName:link];
            
        }
        
        for (int i=0; i<rxmlIndividualNew3.count; i++) {
            
            NSString *title = [NSString stringWithString:[[rxmlIndividualNew3 objectAtIndex:i] child:@"titlenews"].text];
            NSString *desc = [NSString stringWithString:[[rxmlIndividualNew3 objectAtIndex:i] child:@"descnews"].text];
            NSString *link = [NSString stringWithString:[[rxmlIndividualNew3 objectAtIndex:i] child:@"linknews"].text];
            
            [self insertAboutWithAboutName:title descName:desc newsName:link];
            
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"loadabout"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    //IMPORT FISH LINGO
    NSUInteger integerFromPrefsLingo = [defaults integerForKey:@"loadlingo"];
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-lingo.xml"];
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //RELOAD DATA BY UNCOMMENTING THE BELOW
    //[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"loadlingo"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    if (integerFromPrefsLingo == 0) {
        
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        
        NSString *imgUrl = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [self insertLingoWithLingoName:title imageName:imgUrl descName:desc newsName:desc];
        
    }
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"loadlingo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }

    //IMPORT FISH DATA
    NSUInteger integerFromPrefs = [defaults integerForKey:@"loaddata"];
    
    //RELOAD DATA BY UNCOMMENTING THE BELOW
    //[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"loaddata"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    if (integerFromPrefs == 0) {
    
    // Mild Fish 0
        
[self insertRoleWithRoleName:@"Catfish" typeName:@"0" descName:@"Catfish is farmed in many southeastern states in the U.S. Chemical usage on catfish farms is regulated much more stringently here than in other countries. Catfish do not need wild fish to be included in their diet, so farming them does not deplete wild fish populations, as does farming of many other species. U.S.-farmed catfish are not given any added hormones, and under normal growing conditions they are antibiotic-free." goodName:@"Advice: Safe to eat, but not ideal" badName:@"0" regName:@"Type: Factory Farmed Fish"];
        
[self insertRoleWithRoleName:@"Chilean Seabass" typeName:@"0" descName:@"Marketed as Chilean sea bass, Patagonian and Antarctic toothfish are slow growing and inherently prone to overfishing. The premium price also spurred rampant illegal fishing, which has fortunately declined with an increasing percentage of legal operators." goodName:@"Advice: Unsafe to eat" badName:@"0" regName:@"Dirty Dozen"];
        
[self insertRoleWithRoleName:@"Flounder" typeName:@"0" descName:@"Flounder may contain levels of PCB contamination that pose a health risk to adults and children. Flounder are most frequently caught using bottom or otter trawls, nets that drag along the seafloor, that can damage habitat and remove or cover animals and plant life." goodName:@"Advice: Unsafe to eat" badName:@"0" regName:@"Type: Dirty Dozen"];
        
[self insertRoleWithRoleName:@"Halibut" typeName:@"0" descName:@"Halibut is not strongly associated with contaminants, but may contain some mercury. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children: www.epa.gov/ost/fish. Pacific halibut populations, including those in Alaska, British Columbia, Washington, Oregon and California, have been monitored and managed by the International Pacific Halibut Commission (IPHC) for almost 100 years." goodName:@"Advice: Unsafe to eat" badName:@"0" regName:@"Region: East California, Washington and Oregon Halibut"];
        
[self insertRoleWithRoleName:@"Pollock" typeName:@"0" descName:@"The Alaska pollock fishery, though largely unknown to the public, is the largest U.S. fishery by volume.  The fish are most often ground up for use in fish sticks, fish fillet sandwiches and imitation crab (surimi). Because of their quick growth and low trophic level on the food chain, Alaska pollock is very low in contaminants such as mercury and PCBs.  Pollock is most commonly caught by midwater pelagic trawl, which is very efficient, and is associated with little damage to ocean habitat unless it is dragged very near to the ocean floor; trawl gear that targets the ocean floor is prohibited in the pollock fishery." goodName:@"Advice: Not a sustanable choice" badName:@"0" regName:@"Type: Overfished"];
        
[self insertRoleWithRoleName:@"Haddock" typeName:@"0" descName:@"Haddock is a whitefish popular in New England cuisine and frequently found in traditional fish and chips. It is thought to be low in contaminants. Since 2004, haddock stocks have rebounded from previously declining levels, with the help of various management efforts. Now, their populations are not considered to be overfished, and overexploitation is not occurring. Of the two major stocks of haddock in New England, one, the Georges Bank population, has now reached twice its level." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: New England"];
    
[self insertRoleWithRoleName:@"Mahi-Mahi" typeName:@"0" descName:@"Mahi-mahi, also known as dolphinfish or “el dorado,” is caught in the United States in the Atlantic, the Gulf of Mexico, off the coast of Hawaii, and off the West Coast. Because mahi-mahi mature quickly, they are not highly susceptible to overfishing, nor to mercury and PCB contamination. Mahi-mahi can be caught with a variety of gear types. Troll- or hook-and-line-caught mahi-mahi is a best choice because this gear results in relatively minimal harm to other animals and the surrounding environment." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: California"];
        
    // Thicker & Flavorful Fish 1
        
[self insertRoleWithRoleName:@"Grouper" typeName:@"1" descName:@"Grouper populations are almost universally in decline. It is estimated that the Nassau grouper population has sustained a decline of 60% over the last three generations (27-30 years). Its populations are overfished and overfishing is occurring in the Caribbean, and U.S. fishery management councils have now banned fishing for Nassau grouper. Red grouper population numbers have fluctuated over time, with peak abundance occurring during the 1940s or 1950s. Red grouper is overfished, with continuing overexploitation in the South Atlantic" goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Overfished"];

[self insertRoleWithRoleName:@"King Mackerel" typeName:@"1" descName:@"King and Spanish mackerel, found in the South Atlantic and the Gulf of Mexico, are not believed to be overfished or undergoing over-exploitation, and are caught using more environmentally friendly methods such as hook-and-line and cast nets. Both of these techniques result in minimal interactions with bottom habitat and are associated with low levels of bycatch (the unintended capture of other types of marine life)." goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Overfished"];

[self insertRoleWithRoleName:@"Bluefin Tuna" typeName:@"1" descName:@"Bluefin tuna are internationally overfished, nearly to levels of extinction. They are believed to be 80% or more below their original abundance levels.The eastern and western Atlantic Ocean stocks to which bluefin tuna are native are listed as “endangered,” and “critically endangered,” respectively, in the IUCN Redlist of the world’s most threatened species.Recent efforts in late 2009 to list the bluefin tuna in the Convention on International Trade in Endangered Species (CITES) – which would have restricted trade or capture of the bluefin tuna – failed, lacking political support from industrial fishing nations." goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Overfished"];
        
[self insertRoleWithRoleName:@"Alaskan Salmon" typeName:@"1" descName:@"Alaskan salmon, consisting of Chinook (king), chum (dog), coho (silver), pink (humpback) and sockeye (red) salmon populations, is caught predominantly with hook-and-line gear, purse seines or gillnets. Most of the bycatch (non-target species) in salmon fisheries consists of other types of salmon than what the specific vessels are targeting. When wild salmon fisheries are well managed, they can maintain the fish stock as a long-term environmentally viable economic resource. The Alaskan salmon populations are not considered to be overfished" goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Atlantic Mackerel" typeName:@"1" descName:@"Atlantic mackerel is very low in contaminants. They mature at a young age and their feeding habits do not expose them to much contamination. Atlantic mackerel are found in the western Atlantic from Canada down to North Carolina. While it was overfished during the 1960s and 1970s, effective regulations helped the species rebound. Atlantic mackerel are mostly caught using purse seine nets that are set on specific schools of fish. Midwater trawling is another method used. Both of these techniques result in minimal interactions with bottom habitat and are associated with low levels of bycatch (the unintended capture of other types of marine life)." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Skipjack Tuna" typeName:@"1" descName:@"Skipjack tuna is a common component of canned light tuna. It is much lower in mercury than other types of tuna. In the U.S., the Atlantic skipjack population is stable. The smallest commercially caught tuna, skipjack have short lifespans and rapid reproduction rates, making them less prone to overfishing. Most Atlantic skipjack is caught using hook and line and other individual hand gear, which is associated with minimal bottom habitat damage and little bycatch." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
        
[self insertRoleWithRoleName:@"Sablefish (Black Cod)" typeName:@"1" descName:@"Black cod is the commonly used market name for sablefish on the Pacific Coast – although true black cod is actually a different type of fish.  This fish is high in healthy omega-3s and relatively low in mercury and PCBs for a fish of its size and lifespan. Sablefish is most abundant in the Gulf of Alaska, where it is caught primarily by longline, but it is also caught off of California, Oregon and Washington." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
        
[self insertRoleWithRoleName:@"Pacific Albacore Tuna" typeName:@"1" descName:@"Albacore tuna is found throughout the Atlantic and Pacific oceans off the U.S. coast. It is most frequently seen as canned white tuna. Albacore is not as strongly associated with contamination as bluefin or other types of tuna, but may contain some mercury. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children. Pacific albacore populations are considered high, and do not appear to be undergoing overfishing. Pacific albacore is mainly caught commercially by troll and pole-and-line gear, which are associated with minimal bottom habitat interactions and by catch." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Pacific Cod" typeName:@"1" descName:@"Unlike the Atlantic cod stock, which collapsed in the early 1990s and is currently undergoing overfishing. Pacific cod are not overfished nor are they undergoing overfishing. The populations of Pacific cod are healthy in both the Bering Sea and the Gulf of Alaska is considered healthy. To prevent depletion, the fishery is managed with seasonal closures and a total allowable catch. The management plan includes federal, state and tribal regulations, and both academics and environmental groups have been involved in its development and frequent revisal. Pacific cod are caught with trawls, longlines and pots. Pots (traps) generally result in less bycatch or habitat damage than longlines, but both are preferable to trawls, which can damage the habitat and remove or cover animals and plant life, and may also result in the catch of other marine wildlife." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
        
[self insertRoleWithRoleName:@"Pompano" typeName:@"1" descName:@"Florida pompano is found on the Atlantic and Gulf coasts of Florida. Research shows that they are probably not overfished on either coast, but the Gulf population is currently at healthier levels. Effective management is in place to prevent Florida pompano from becoming overfished, and because they are faster-growing than species like grouper, their populations are more resilient. Although this characteristic helps the fish to be less strongly associated with mercury, pompano may contain some mercury. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children: http://map1.epa.gov." goodName:@"Advice: May contain mercury" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Barramundi" typeName:@"1" descName:@"Barramundi is a tropical whitefish that is usually farmed in closed recirculating systems in the U.S., which conserve resources by re-circulating the water and treating effluent (waste) before it leaves the facility to limit pollution. No therapeutics or hormones are utilized in U.S. facilities, and they have no detectable mercury levels. Barramundi are fed a mostly vegetarian diet, and the small amount of fishmeal they consume comes partially from herring byproducts – so they are actually net protein producers, with a conversion of about .9 pounds of wild fish to produce 1 pound of farmed fish. Therefore, farming of barramundi in the U.S. does not deplete the wild fish stock as does farming of many other species that that require higher levels of fish protein in their diet. However, international production of barramundi is not as strictly regulated. Look for a U.S.-raised product." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Wreckfish" typeName:@"1" descName:@"Wreckfish is a bass-like species found in the Atlantic from South Carolina down to Florida. Although the status of the wreckfish population has not been established, the fish reproduces quickly, so it is not at great risk for overfishing. Wreckfish is generally caught by hook-and-line. Hook-and-line gear allows for non-target wildlife (bycatch) caught accidentally to be released more quickly, thus providing a higher chance of survival." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
        
    // Steak Like Fish Fish 2
        
[self insertRoleWithRoleName:@"Alaskan Salmon" typeName:@"2" descName:@"Alaskan salmon, consisting of Chinook (king), chum (dog), coho (silver), pink (humpback) and sockeye (red) salmon populations, is caught predominantly with hook-and-line gear, purse seines or gillnets. Most of the bycatch (non-target species) in salmon fisheries consists of other types of salmon than what the specific vessels are targeting. When wild salmon fisheries are well managed, they can maintain the fish stock as a long-term environmentally viable economic resource. The Alaskan salmon populations are not considered to be overfished" goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
        
[self insertRoleWithRoleName:@"Shark (Dogfish)" typeName:@"2" descName:@"Dogfish is actually a type of shark, and is very high in mercury, which can pose a health risk. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children: www.epa.gov/ost/fish/ Women and children are recommended to avoid dogfish, and men should limit consumption to one serving per month. Dogfish is commonly used as the fish component in European “fish and chips” – it’s also sometimes referred to as “rock salmon” throughout Europe. Dogfish is not especially popular in U.S. markets." goodName:@"Advice: Avoid" badName:@"0" regName:@"Type: Contains high levels of mercury"];
        
[self insertRoleWithRoleName:@"Swordfish" typeName:@"2" descName:@"Swordfish is available in a variety of product forms including headed and gutted (basically whole with head and guts removed), steaks, and loins. Swordfish is moist and flavorful with a slightly sweet taste. It has moderately high oil content and a firm, meaty texture. When raw, the flesh varies from white and ivory to pink and orange. When cooked, swordfish turns beige. Swordfish flesh should be firm. Cut surfaces should be free of ragged edges. Discolored, dull skin is a sign of mishandling or dehydration." goodName:@"Advice: Avoid" badName:@"0" regName:@"Type: Contains high levels of mercury"];

[self insertRoleWithRoleName:@"Bluefin Tuna" typeName:@"2" descName:@"Bluefin tuna are internationally overfished, nearly to levels of extinction. They are believed to be 80% or more below their original abundance levels.The eastern and western Atlantic Ocean stocks to which bluefin tuna are native are listed as “endangered,” and “critically endangered,” respectively, in the IUCN Redlist of the world’s most threatened species.Recent efforts in late 2009 to list the bluefin tuna in the Convention on International Trade in Endangered Species (CITES) – which would have restricted trade or capture of the bluefin tuna – failed, lacking political support from industrial fishing nations." goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Overfished"];

[self insertRoleWithRoleName:@"Atlantic Mackerel" typeName:@"2" descName:@"Atlantic mackerel is very low in contaminants. They mature at a young age and their feeding habits do not expose them to much contamination. Atlantic mackerel are found in the western Atlantic from Canada down to North Carolina. While it was overfished during the 1960s and 1970s, effective regulations helped the species rebound. Atlantic mackerel are mostly caught using purse seine nets that are set on specific schools of fish. Midwater trawling is another method used. Both of these techniques result in minimal interactions with bottom habitat and are associated with low levels of bycatch (the unintended capture of other types of marine life)." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Halibut" typeName:@"2" descName:@"Halibut is not strongly associated with contaminants, but may contain some mercury. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children: www.epa.gov/ost/fish. Pacific halibut populations, including those in Alaska, British Columbia, Washington, Oregon and California, have been monitored and managed by the International Pacific Halibut Commission (IPHC) for almost 100 years." goodName:@"Advice: Unsafe to eat" badName:@"0" regName:@"Region: East California, Washington and Oregon Halibut"];
        
    // Small Fish 3
        
[self insertRoleWithRoleName:@"Northern Anchovies" typeName:@"3" descName:@"Northern anchovy is native to Pacific waters from Alaska to the Gulf of California in Mexico, though 95% of all landings come from the coast of California. Although not much is known about the size of the stock, it appears to be in a healthy state, as landings have remained stable and increased in recent years. According to the National Marine Fisheries Service, the U.S. imports all anchovies intended for human consumption, and almost all of the anchovies that are caught in the United States are used for bait." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: Gulf of California and Mexico"];
        
[self insertRoleWithRoleName:@"Wild Sardines" typeName:@"3" descName:@"Pacific sardines are not overfished. In the 1950s, Pacific sardines experienced a drastic population decline but their numbers have rebuilt. Sardines swim in schools that are easily targeted by fishermen using purse nets, dip nets, drum seines and lampara nets.  These types of gear do not generally come in full contact with the seafloor, and cause relatively minimal damage.  Generally, collecting schooling fish, like sardines, results in a lower amount of non-targeted species." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: Gulf of California and Mexico"];
        
[self insertRoleWithRoleName:@"Atlantic Herring" typeName:@"3" descName:@"Atlantic herring is a keystone species; this means it is a primary food source for many predator fish (those that eat other fish), marine mammals and seabirds. Therefore, it is important to maintain the stock at a healthy level, or else the entire local ecology can be disrupted. The population of herring, which is often sold as a canned product (similar to sardines), collapsed in the 1970s due to over-exploitation." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Bad if overfished"];

        
    // Shell Fish 4
        
[self insertRoleWithRoleName:@"Geoduck Clams" typeName:@"4" descName:@"Geoduck clams (pronounced gooey-duck) are native to the Pacific Northwest, and are also commercially produced by large shellfish farming operations. Because they grow to be very large and are long-lived in comparison to most other shellfish, high levels of certain contaminants such as arsenic and mercury may build up in geoduck clam meat.  All clams are filter feeders, which means that they pull nutrients out of the water to eat – so no wild-caught fish is used in their feed." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
    
[self insertRoleWithRoleName:@"Farmed Abalone" typeName:@"4" descName:@"Abalone are native to temperate and tropical oceans around the world. Of the 100 species found worldwide, approximately 15 are farmed for human consumption." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Conch" typeName:@"4" descName:@"Queen conch is a large marine snailGlossary native to the Caribbean basin. Its range in the U.S. encompasses the Florida Keys as well as the southeastern shore of the Florida peninsula. Queen conch is slow-moving and easy to pick up by hand or with the simplest fishing gear (known as poke poles). Conch is especially vulnerable to fishing during the spawning season, when they gather in large numbers to reproduce." goodName:@"Advice: Avoid" badName:@"0" regName:@"Type: Unsustainable"];
        
[self insertRoleWithRoleName:@"Farmed Oysters" typeName:@"4" descName:@"Like clams, mussels and scallops, oysters are filter-feeding shellfish that are extremely well-suited to aquaculture. Farming oysters brings little risk of pollutionGlossary or escapees, and habitat effects from the farms are minimal." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
        
[self insertRoleWithRoleName:@"Farmed Mussles" typeName:@"4" descName:@"Mussels are cultured throughout most of the world and make up approximately 90 percent of the world consumption. The major producers are China, Spain, Italy, Thailand, France and New Zealand. The U.S. imports most of its mussels from developed nations with stringent environmental regulations." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Farmed Crawfish" typeName:@"4" descName:@"Crawfish farmed in the U.S. are grown in ponds on existing agricultural lands. No feeds are added, but minimal fertilizer is used to support an aquaticGlossary food web that crawfish can utilize. Though water exchange is infrequent and regulated, the release of particulate matter and nutrients during annual pond drainings is a moderate effluent concern." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Market Squid" typeName:@"4" descName:@"Crawfish farmed in the U.S. are grown in ponds on existing agricultural lands. No feeds are added, but minimal fertilizer is used to support an aquaticGlossary food web that crawfish can utilize. Though water exchange is infrequent and regulated, the release of particulate matter and nutrients during annual pond drainings is a moderate effluent concern." goodName:@"Type: Market is Sustainable" badName:@"0" regName:@"Advice: Avoid Indian and Mitre Squid"];
        
[self insertRoleWithRoleName:@"Crab" typeName:@"4" descName:@"Asian or Japanese shore crab is native to parts of Russia and Japan, but has become invasive along the East Coast, from Maine through North Carolina. It was probably introduced into the United States by international ship travel. Asian shore crabs are small, usually measuring not more than an inch and a half across, but are opportunistic feeders and will consume small fish, crustaceans, algae and anything else they come across. Its primary negative impact as an invasive species is displacement of native crab populations, as it competes for similar habitat to native blue crab, rock crab, and lobster." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Maine Lobster" typeName:@"4" descName:@"American or “Maine” lobster is found in the northwest Atlantic Ocean from North Carolina up through Canada. It is moderately low in contaminants like mercury, but consumers should check for current warnings to determine safe consumption levels, in particular for pregnant women, those who may become pregnant and children: www.epa.gov/ost/fish. It should also be noted that lobster meat spoils rapidly, so lobster is often kept alive until just before serving. Freezing can slow the deterioration of the meat." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
    
[self insertRoleWithRoleName:@"Asian Shore Crab" typeName:@"4" descName:@"Asian or Japanese shore crab is native to parts of Russia and Japan, but has become invasive along the East Coast, from Maine through North Carolina. It was probably introduced into the United States by international ship travel. Asian shore crabs are small, usually measuring not more than an inch and a half across, but are opportunistic feeders and will consume small fish, crustaceans, algae and anything else they come across. Its primary negative impact as an invasive species is displacement of native crab populations, as it competes for similar habitat to native blue crab, rock crab, and lobster." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];
        
[self insertRoleWithRoleName:@"Farmed Scallops" typeName:@"4" descName:@"Scallops are farmed around the world in coastal, subtidal environments. Like all bivalves, scallops are filter-feeders and rely on natural planktonGlossary populations for food. No external feeds or nutrientGlossary fertilizers are utilized in scallop culture. Since the majority of farmed scallops are grown in their native ranges, the risks from non-native escapes are minimal. Additionally, since scallops are sourced from either natural settlement or wild-caught broodstock, there are no risks of impacts on wild populations. " goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Wild Shrimp" typeName:@"4" descName:@"Unlike imported shrimp, wild-caught U.S. shrimp is unlikely to contain the drugs and chemicals that are used heavily on many foreign shrimp farms.  Rock shrimp is most commonly caught off the Gulf and Atlantic coasts of Florida, though it is also caught in other states of the South Atlantic.  Rock shrimp rarely lives more than two years, and reproduce frequently, which means that overfishing is not a major concern.  Most of the U.S. shrimp fleet has worked to decrease bycatch (untargeted marine life caught accidentally) by using devices to let sea turtles and fish escape from trawl nets.  Regulations for rock shrimp prohibit trawling over sensitive coral reef areas, and regulate net mesh size to prevent unwanted catch." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];
        
[self insertRoleWithRoleName:@"Golden Crab" typeName:@"4" descName:@"Golden crab is caught in a small fishery on the Atlantic coast of Florida. A management plan for golden crab was created at the request of the fishermen, who wanted to ensure the sustainability of the resource. Only traps, which result in very little bycatch, are used, and all the females are released so that they can continue to reproduce. The traps are placed on soft-bottom areas where they have relatively little impact on the seafloor." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

    // Other 5
        
[self insertRoleWithRoleName:@"Asian Carp" typeName:@"5" descName:@"Asian carp, as they are known in the United States, actually includes several different species, including the bighead, black and silver carp. Asian carp species are not bottomfeeders, and so are generally lower in contaminants than the common carp. Although the FDA has not yet evaluated these fish for contaminants, they are believed to be low in mercury. These fish are native to Asia and were brought to the United States primarily by catfish farmers in the 1970s to control algal blooms in aquaculture ponds." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];
        
[self insertRoleWithRoleName:@"Asian Swamp Eels" typeName:@"5" descName:@"Asian swamp eels are native to many parts of Asia, and are currently listed as invasive in three states: Hawai`i, Georgia, and Florida. In New Jersey, their status is listed as unknown but they have recently been found there The eels’ introduction to the wild probably took place accidentally in the Southeast (from an aquarium or fish farm escape) and they may have been introduced as a food fish in Hawai`i by immigrants. They have no known predators in North America." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];

[self insertRoleWithRoleName:@"Hogfish" typeName:@"5" descName:@"Hogfish may be contaminated with a tropical marine toxin that causes ciguatera, a serious foodborne illness that improves with time but has no cure.  Ciguatera is found in tropical reef fish, and cannot be cooked out of food. Be sure to ask at restaurants whether your tropical fish has been tested for the presence of this toxin. If you choose to eat tropical reef fish, consuming small portions and selecting smaller-sized fish may help you avoid the more serious side effects of this toxin." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];

[self insertRoleWithRoleName:@"Mangrove Snapper" typeName:@"5" descName:@"Mangrove snapper (also called “gray” or “mango” snapper) is caught throughout the Gulf with hook-and-line or bottom longline. Hook-and-line and hand lines allow for non-target species to be released more quickly, improving survival chances, and cause less damage to the seafloor.  A bottom longline consists of a central line strung with many baited hooked lines and a weight of some type keeping the line in place.  This method can catch many non-target species and cause damage to the seafloor. Mangrove snapper mature and reproduce quickly, making stock depletion less of a threat." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];
        
    // Dirty Dozen 7

[self insertRoleWithRoleName:@"Atlantic Cod" typeName:@"7" descName:@"Atlantic cod populations in the waters off New England are depleted and suffer from high fishing levels. Other fish species caught alongside cod in the mixed groundfish fishery, including haddock and various species of flatfish, are also depleted and/or experiencing high fishing pressure. There are also concerns over the capture of marine mammals in the gillnet fisheries in this region. For these reasons, most of the Atlantic cod from this region is considered an Avoid" goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Atlantic Flatfish" typeName:@"7" descName:@"Due to heavy fishing in the region, many Atlantic flatfish stocks are low. Flounder are most frequently caught using bottom or otter trawls, nets that drag along the seafloor, that can damage habitat and remove or cover animals and plant life. This method of fishing can catch many non-target species that are often discarded, dead or dying, after they are brought to the surface." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Caviar" typeName:@"7" descName:@"Sturgeon and paddlefish in the Mississippi River and its tributaries can be caught in 31 states, and each state has its own system of management for these species. Many states do not permit commercial fishing for sturgeon. There is minimal collaboration between states -although this is improving- in managing sturgeon populations across the Mississippi watershed. As a result it is unclear whether populations are depleted and whether current fishing effort is at a sustainableGlossary level. Management of the sturgeon and paddlefish fisheries in the Mississippi watershed is ineffective at protecting these unique fish from overfishing, and as such these fish and their caviar should be avoided." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Chilean Seabass" typeName:@"7" descName:@"Marketed as Chilean sea bass, Patagonian and Antarctic toothfish are slow growing and inherently prone to overfishing. The premium price also spurred rampant illegal fishing, which has fortunately declined with an increasing percentage of legal operators." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];
        
[self insertRoleWithRoleName:@"Eel Freshwater" typeName:@"7" descName:@"Freshwater eel have a unique life cycle: the adults spawnGlossary in salt water thousands of miles from the freshwater habitat where their offspring will grow up. Loss of freshwater habitat for eel has caused serious decline in wild populations. Ninety percent of all eel sold in the U.S. are farm raised. Rather than raising them from eggs, eel farms collect young eels from the wild, a practice that adds pressure to the already threatened wild populations." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Farmed Salmon" typeName:@"7" descName:@"Salmon farmed in open net pens are vulnerable to infection from diseases and parasites, and farms use antibiotics and pesticides to treat or control infection. Although antibiotic use in Scotland is low, there are no regulatory limits on total use should a disease outbreak occur. Pesticide use to control parasitic sea lice in Scotland is high." goodName:@"Advice: Avoid" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Farmed Shrimp" typeName:@"7" descName:@"Many of Mexico's shrimp farms are located along the Gulf of California coast - a unique and vulnerable ecosystem. These farms are adjacent to sensitive coastal wetland and mangroveGlossary habitats, and despite leaving mangroves largely intact, the ecosystem is impacted by water and effluent from these farms." goodName:@"Advice: Avoid" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Orange Roughy" typeName:@"7" descName:@"Years of heavy fishing have decimated orange roughy populations. Although there are fishery management plans in place, scientists predict it could take decades for populations to recover.Another concern with orange roughy is the way it's caught. Bottom trawls are problematic, causing damage to seafloor habitat, especially in the fragile, deep-sea ecosystems where orange roughy live." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Shark" typeName:@"7" descName:@"Although shark finning is banned in some countries, including the U.S., it still occurs in many fisheries worldwide and is a major factor in the decline of shark populations. Since sharks mature slowly and give birth to few young, most don't reproduce quickly enough to keep up with the intense level of fishing and accidental catch in other fisheries. " goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Bluefin Tuna" typeName:@"7" descName:@"Bluefin tuna are internationally overfished, nearly to levels of extinction. They are believed to be 80% or more below their original abundance levels.The eastern and western Atlantic Ocean stocks to which bluefin tuna are native are listed as “endangered,” and “critically endangered,” respectively, in the IUCN Redlist of the world’s most threatened species.Recent efforts in late 2009 to list the bluefin tuna in the Convention on International Trade in Endangered Species (CITES) – which would have restricted trade or capture of the bluefin tuna – failed, lacking political support from industrial fishing nations." goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Dirty Dozen"];
        
[self insertRoleWithRoleName:@"King Crab" typeName:@"7" descName:@"TrapGlossary fisheries are usually low in bycatchGlossary and do not cause significant harm to seafloor habitats. Any crabs caught that are too small to be legally sold can also be safely returned to the ocean.The two primary king crab populations in Alaska are healthy and abundant due to responsible fisheries management. Others have been closed to allow time to recover from previous overfishing." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Imported Basa" typeName:@"7" descName:@"Commercial farming of river catfish - known as Basa, Pangasius and Swai - in southeast Asia has increased rapidly in recent years. River catfish has a strong potential to be a sustainable aquacultureGlossary species, but there are conservation concerns with the current practice of open cage aquaculture combined with little or no management of these fish farming operations in Asia. " goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

    // All 6
        
[self insertRoleWithRoleName:@"Catfish" typeName:@"6" descName:@"Catfish is farmed in many southeastern states in the U.S. Chemical usage on catfish farms is regulated much more stringently here than in other countries. Catfish do not need wild fish to be included in their diet, so farming them does not deplete wild fish populations, as does farming of many other species. U.S.-farmed catfish are not given any added hormones, and under normal growing conditions they are antibiotic-free." goodName:@"Advice: Safe to eat, but not ideal" badName:@"0" regName:@"Type: Factory Farmed Fish"];

[self insertRoleWithRoleName:@"Flounder" typeName:@"6" descName:@"Flounder may contain levels of PCB contamination that pose a health risk to adults and children. Flounder are most frequently caught using bottom or otter trawls, nets that drag along the seafloor, that can damage habitat and remove or cover animals and plant life." goodName:@"Advice: Unsafe to eat" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Halibut" typeName:@"6" descName:@"Halibut is not strongly associated with contaminants, but may contain some mercury. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children: www.epa.gov/ost/fish. Pacific halibut populations, including those in Alaska, British Columbia, Washington, Oregon and California, have been monitored and managed by the International Pacific Halibut Commission (IPHC) for almost 100 years." goodName:@"Advice: Unsafe to eat" badName:@"0" regName:@"Region: East California, Washington and Oregon Halibut"];

[self insertRoleWithRoleName:@"Pollock" typeName:@"6" descName:@"The Alaska pollock fishery, though largely unknown to the public, is the largest U.S. fishery by volume.  The fish are most often ground up for use in fish sticks, fish fillet sandwiches and imitation crab (surimi). Because of their quick growth and low trophic level on the food chain, Alaska pollock is very low in contaminants such as mercury and PCBs.  Pollock is most commonly caught by midwater pelagic trawl, which is very efficient, and is associated with little damage to ocean habitat unless it is dragged very near to the ocean floor; trawl gear that targets the ocean floor is prohibited in the pollock fishery." goodName:@"Advice: Not a sustanable choice" badName:@"0" regName:@"Type: Overfished"];

[self insertRoleWithRoleName:@"Haddock" typeName:@"6" descName:@"Haddock is a whitefish popular in New England cuisine and frequently found in traditional fish and chips. It is thought to be low in contaminants. Since 2004, haddock stocks have rebounded from previously declining levels, with the help of various management efforts. Now, their populations are not considered to be overfished, and overexploitation is not occurring. Of the two major stocks of haddock in New England, one, the Georges Bank population, has now reached twice its level." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: New England"];

[self insertRoleWithRoleName:@"Mahi-Mahi" typeName:@"6" descName:@"Mahi-mahi, also known as dolphinfish or “el dorado,” is caught in the United States in the Atlantic, the Gulf of Mexico, off the coast of Hawaii, and off the West Coast. Because mahi-mahi mature quickly, they are not highly susceptible to overfishing, nor to mercury and PCB contamination. Mahi-mahi can be caught with a variety of gear types. Troll- or hook-and-line-caught mahi-mahi is a best choice because this gear results in relatively minimal harm to other animals and the surrounding environment." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: California"];

[self insertRoleWithRoleName:@"Grouper" typeName:@"6" descName:@"Grouper populations are almost universally in decline. It is estimated that the Nassau grouper population has sustained a decline of 60% over the last three generations (27-30 years). Its populations are overfished and overfishing is occurring in the Caribbean, and U.S. fishery management councils have now banned fishing for Nassau grouper. Red grouper population numbers have fluctuated over time, with peak abundance occurring during the 1940s or 1950s. Red grouper is overfished, with continuing overexploitation in the South Atlantic" goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Overfished"];

[self insertRoleWithRoleName:@"King Mackerel" typeName:@"6" descName:@"King and Spanish mackerel, found in the South Atlantic and the Gulf of Mexico, are not believed to be overfished or undergoing over-exploitation, and are caught using more environmentally friendly methods such as hook-and-line and cast nets. Both of these techniques result in minimal interactions with bottom habitat and are associated with low levels of bycatch (the unintended capture of other types of marine life)." goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Overfished"];

[self insertRoleWithRoleName:@"Bluefin Tuna" typeName:@"6" descName:@"Bluefin tuna are internationally overfished, nearly to levels of extinction. They are believed to be 80% or more below their original abundance levels.The eastern and western Atlantic Ocean stocks to which bluefin tuna are native are listed as “endangered,” and “critically endangered,” respectively, in the IUCN Redlist of the world’s most threatened species.Recent efforts in late 2009 to list the bluefin tuna in the Convention on International Trade in Endangered Species (CITES) – which would have restricted trade or capture of the bluefin tuna – failed, lacking political support from industrial fishing nations." goodName:@"Advice: May contain levels of mercury" badName:@"0" regName:@"Type: Overfished"];

[self insertRoleWithRoleName:@"Alaskan Salmon" typeName:@"6" descName:@"Alaskan salmon, consisting of Chinook (king), chum (dog), coho (silver), pink (humpback) and sockeye (red) salmon populations, is caught predominantly with hook-and-line gear, purse seines or gillnets. Most of the bycatch (non-target species) in salmon fisheries consists of other types of salmon than what the specific vessels are targeting. When wild salmon fisheries are well managed, they can maintain the fish stock as a long-term environmentally viable economic resource. The Alaskan salmon populations are not considered to be overfished" goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Atlantic Mackerel" typeName:@"6" descName:@"Atlantic mackerel is very low in contaminants. They mature at a young age and their feeding habits do not expose them to much contamination. Atlantic mackerel are found in the western Atlantic from Canada down to North Carolina. While it was overfished during the 1960s and 1970s, effective regulations helped the species rebound. Atlantic mackerel are mostly caught using purse seine nets that are set on specific schools of fish. Midwater trawling is another method used. Both of these techniques result in minimal interactions with bottom habitat and are associated with low levels of bycatch (the unintended capture of other types of marine life)." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Skipjack Tuna" typeName:@"6" descName:@"Skipjack tuna is a common component of canned light tuna. It is much lower in mercury than other types of tuna. In the U.S., the Atlantic skipjack population is stable. The smallest commercially caught tuna, skipjack have short lifespans and rapid reproduction rates, making them less prone to overfishing. Most Atlantic skipjack is caught using hook and line and other individual hand gear, which is associated with minimal bottom habitat damage and little bycatch." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Sablefish (Black Cod)" typeName:@"6" descName:@"Black cod is the commonly used market name for sablefish on the Pacific Coast – although true black cod is actually a different type of fish.  This fish is high in healthy omega-3s and relatively low in mercury and PCBs for a fish of its size and lifespan. Sablefish is most abundant in the Gulf of Alaska, where it is caught primarily by longline, but it is also caught off of California, Oregon and Washington." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Pacific Albacore Tuna" typeName:@"6" descName:@"Albacore tuna is found throughout the Atlantic and Pacific oceans off the U.S. coast. It is most frequently seen as canned white tuna. Albacore is not as strongly associated with contamination as bluefin or other types of tuna, but may contain some mercury. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children. Pacific albacore populations are considered high, and do not appear to be undergoing overfishing. Pacific albacore is mainly caught commercially by troll and pole-and-line gear, which are associated with minimal bottom habitat interactions and by catch." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Pacific Cod" typeName:@"6" descName:@"Unlike the Atlantic cod stock, which collapsed in the early 1990s and is currently undergoing overfishing. Pacific cod are not overfished nor are they undergoing overfishing. The populations of Pacific cod are healthy in both the Bering Sea and the Gulf of Alaska is considered healthy. To prevent depletion, the fishery is managed with seasonal closures and a total allowable catch. The management plan includes federal, state and tribal regulations, and both academics and environmental groups have been involved in its development and frequent revisal. Pacific cod are caught with trawls, longlines and pots. Pots (traps) generally result in less bycatch or habitat damage than longlines, but both are preferable to trawls, which can damage the habitat and remove or cover animals and plant life, and may also result in the catch of other marine wildlife." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Pompano" typeName:@"6" descName:@"Florida pompano is found on the Atlantic and Gulf coasts of Florida. Research shows that they are probably not overfished on either coast, but the Gulf population is currently at healthier levels. Effective management is in place to prevent Florida pompano from becoming overfished, and because they are faster-growing than species like grouper, their populations are more resilient. Although this characteristic helps the fish to be less strongly associated with mercury, pompano may contain some mercury. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children: http://map1.epa.gov." goodName:@"Advice: May contain mercury" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Barramundi" typeName:@"6" descName:@"Barramundi is a tropical whitefish that is usually farmed in closed recirculating systems in the U.S., which conserve resources by re-circulating the water and treating effluent (waste) before it leaves the facility to limit pollution. No therapeutics or hormones are utilized in U.S. facilities, and they have no detectable mercury levels. Barramundi are fed a mostly vegetarian diet, and the small amount of fishmeal they consume comes partially from herring byproducts – so they are actually net protein producers, with a conversion of about .9 pounds of wild fish to produce 1 pound of farmed fish. Therefore, farming of barramundi in the U.S. does not deplete the wild fish stock as does farming of many other species that that require higher levels of fish protein in their diet. However, international production of barramundi is not as strictly regulated. Look for a U.S.-raised product." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Wreckfish" typeName:@"6" descName:@"Wreckfish is a bass-like species found in the Atlantic from South Carolina down to Florida. Although the status of the wreckfish population has not been established, the fish reproduces quickly, so it is not at great risk for overfishing. Wreckfish is generally caught by hook-and-line. Hook-and-line gear allows for non-target wildlife (bycatch) caught accidentally to be released more quickly, thus providing a higher chance of survival." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];


[self insertRoleWithRoleName:@"Shark (Dogfish)" typeName:@"6" descName:@"Dogfish is actually a type of shark, and is very high in mercury, which can pose a health risk. Consumers should check for current warnings to determine safe consumption levels of fish, in particular for pregnant women, those who may become pregnant and children: www.epa.gov/ost/fish/ Women and children are recommended to avoid dogfish, and men should limit consumption to one serving per month. Dogfish is commonly used as the fish component in European “fish and chips” – it’s also sometimes referred to as “rock salmon” throughout Europe. Dogfish is not especially popular in U.S. markets." goodName:@"Advice: Avoid" badName:@"0" regName:@"Type: Contains high levels of mercury"];

[self insertRoleWithRoleName:@"Swordfish" typeName:@"6" descName:@"Swordfish is available in a variety of product forms including headed and gutted (basically whole with head and guts removed), steaks, and loins. Swordfish is moist and flavorful with a slightly sweet taste. It has moderately high oil content and a firm, meaty texture. When raw, the flesh varies from white and ivory to pink and orange. When cooked, swordfish turns beige. Swordfish flesh should be firm. Cut surfaces should be free of ragged edges. Discolored, dull skin is a sign of mishandling or dehydration." goodName:@"Advice: Avoid" badName:@"0" regName:@"Type: Contains high levels of mercury"];

[self insertRoleWithRoleName:@"Northern Anchovies" typeName:@"6" descName:@"Northern anchovy is native to Pacific waters from Alaska to the Gulf of California in Mexico, though 95% of all landings come from the coast of California. Although not much is known about the size of the stock, it appears to be in a healthy state, as landings have remained stable and increased in recent years. According to the National Marine Fisheries Service, the U.S. imports all anchovies intended for human consumption, and almost all of the anchovies that are caught in the United States are used for bait." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: Gulf of California and Mexico"];

[self insertRoleWithRoleName:@"Wild Sardines" typeName:@"6" descName:@"Pacific sardines are not overfished. In the 1950s, Pacific sardines experienced a drastic population decline but their numbers have rebuilt. Sardines swim in schools that are easily targeted by fishermen using purse nets, dip nets, drum seines and lampara nets.  These types of gear do not generally come in full contact with the seafloor, and cause relatively minimal damage.  Generally, collecting schooling fish, like sardines, results in a lower amount of non-targeted species." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Region: Gulf of California and Mexico"];

[self insertRoleWithRoleName:@"Atlantic Herring" typeName:@"6" descName:@"Atlantic herring is a keystone species; this means it is a primary food source for many predator fish (those that eat other fish), marine mammals and seabirds. Therefore, it is important to maintain the stock at a healthy level, or else the entire local ecology can be disrupted. The population of herring, which is often sold as a canned product (similar to sardines), collapsed in the 1970s due to over-exploitation." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Bad if overfished"];


[self insertRoleWithRoleName:@"Geoduck Clams" typeName:@"6" descName:@"Geoduck clams (pronounced gooey-duck) are native to the Pacific Northwest, and are also commercially produced by large shellfish farming operations. Because they grow to be very large and are long-lived in comparison to most other shellfish, high levels of certain contaminants such as arsenic and mercury may build up in geoduck clam meat.  All clams are filter feeders, which means that they pull nutrients out of the water to eat – so no wild-caught fish is used in their feed." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Farmed Abalone" typeName:@"6" descName:@"Abalone are native to temperate and tropical oceans around the world. Of the 100 species found worldwide, approximately 15 are farmed for human consumption." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Conch" typeName:@"6" descName:@"Queen conch is a large marine snailGlossary native to the Caribbean basin. Its range in the U.S. encompasses the Florida Keys as well as the southeastern shore of the Florida peninsula. Queen conch is slow-moving and easy to pick up by hand or with the simplest fishing gear (known as poke poles). Conch is especially vulnerable to fishing during the spawning season, when they gather in large numbers to reproduce." goodName:@"Advice: Avoid" badName:@"0" regName:@"Type: Unsustainable"];

[self insertRoleWithRoleName:@"Farmed Oysters" typeName:@"6" descName:@"Like clams, mussels and scallops, oysters are filter-feeding shellfish that are extremely well-suited to aquaculture. Farming oysters brings little risk of pollutionGlossary or escapees, and habitat effects from the farms are minimal." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Farmed Mussles" typeName:@"6" descName:@"Mussels are cultured throughout most of the world and make up approximately 90 percent of the world consumption. The major producers are China, Spain, Italy, Thailand, France and New Zealand. The U.S. imports most of its mussels from developed nations with stringent environmental regulations." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Farmed Crawfish" typeName:@"6" descName:@"Crawfish farmed in the U.S. are grown in ponds on existing agricultural lands. No feeds are added, but minimal fertilizer is used to support an aquaticGlossary food web that crawfish can utilize. Though water exchange is infrequent and regulated, the release of particulate matter and nutrients during annual pond drainings is a moderate effluent concern." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Market Squid" typeName:@"6" descName:@"Crawfish farmed in the U.S. are grown in ponds on existing agricultural lands. No feeds are added, but minimal fertilizer is used to support an aquaticGlossary food web that crawfish can utilize. Though water exchange is infrequent and regulated, the release of particulate matter and nutrients during annual pond drainings is a moderate effluent concern." goodName:@"Type: Market is Sustainable" badName:@"0" regName:@"Advice: Avoid Indian and Mitre Squid"];

[self insertRoleWithRoleName:@"Crab" typeName:@"6" descName:@"Asian or Japanese shore crab is native to parts of Russia and Japan, but has become invasive along the East Coast, from Maine through North Carolina. It was probably introduced into the United States by international ship travel. Asian shore crabs are small, usually measuring not more than an inch and a half across, but are opportunistic feeders and will consume small fish, crustaceans, algae and anything else they come across. Its primary negative impact as an invasive species is displacement of native crab populations, as it competes for similar habitat to native blue crab, rock crab, and lobster." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Maine Lobster" typeName:@"6" descName:@"American or “Maine” lobster is found in the northwest Atlantic Ocean from North Carolina up through Canada. It is moderately low in contaminants like mercury, but consumers should check for current warnings to determine safe consumption levels, in particular for pregnant women, those who may become pregnant and children: www.epa.gov/ost/fish. It should also be noted that lobster meat spoils rapidly, so lobster is often kept alive until just before serving. Freezing can slow the deterioration of the meat." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Asian Shore Crab" typeName:@"6" descName:@"Asian or Japanese shore crab is native to parts of Russia and Japan, but has become invasive along the East Coast, from Maine through North Carolina. It was probably introduced into the United States by international ship travel. Asian shore crabs are small, usually measuring not more than an inch and a half across, but are opportunistic feeders and will consume small fish, crustaceans, algae and anything else they come across. Its primary negative impact as an invasive species is displacement of native crab populations, as it competes for similar habitat to native blue crab, rock crab, and lobster." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];

[self insertRoleWithRoleName:@"Farmed Scallops" typeName:@"6" descName:@"Scallops are farmed around the world in coastal, subtidal environments. Like all bivalves, scallops are filter-feeders and rely on natural planktonGlossary populations for food. No external feeds or nutrientGlossary fertilizers are utilized in scallop culture. Since the majority of farmed scallops are grown in their native ranges, the risks from non-native escapes are minimal. Additionally, since scallops are sourced from either natural settlement or wild-caught broodstock, there are no risks of impacts on wild populations. " goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Wild Shrimp" typeName:@"6" descName:@"Unlike imported shrimp, wild-caught U.S. shrimp is unlikely to contain the drugs and chemicals that are used heavily on many foreign shrimp farms.  Rock shrimp is most commonly caught off the Gulf and Atlantic coasts of Florida, though it is also caught in other states of the South Atlantic.  Rock shrimp rarely lives more than two years, and reproduce frequently, which means that overfishing is not a major concern.  Most of the U.S. shrimp fleet has worked to decrease bycatch (untargeted marine life caught accidentally) by using devices to let sea turtles and fish escape from trawl nets.  Regulations for rock shrimp prohibit trawling over sensitive coral reef areas, and regulate net mesh size to prevent unwanted catch." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];

[self insertRoleWithRoleName:@"Golden Crab" typeName:@"6" descName:@"Golden crab is caught in a small fishery on the Atlantic coast of Florida. A management plan for golden crab was created at the request of the fishermen, who wanted to ensure the sustainability of the resource. Only traps, which result in very little bycatch, are used, and all the females are released so that they can continue to reproduce. The traps are placed on soft-bottom areas where they have relatively little impact on the seafloor." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Sustainable"];


[self insertRoleWithRoleName:@"Asian Carp" typeName:@"6" descName:@"Asian carp, as they are known in the United States, actually includes several different species, including the bighead, black and silver carp. Asian carp species are not bottomfeeders, and so are generally lower in contaminants than the common carp. Although the FDA has not yet evaluated these fish for contaminants, they are believed to be low in mercury. These fish are native to Asia and were brought to the United States primarily by catfish farmers in the 1970s to control algal blooms in aquaculture ponds." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];

[self insertRoleWithRoleName:@"Asian Swamp Eels" typeName:@"6" descName:@"Asian swamp eels are native to many parts of Asia, and are currently listed as invasive in three states: Hawai`i, Georgia, and Florida. In New Jersey, their status is listed as unknown but they have recently been found there The eels’ introduction to the wild probably took place accidentally in the Southeast (from an aquarium or fish farm escape) and they may have been introduced as a food fish in Hawai`i by immigrants. They have no known predators in North America." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];

[self insertRoleWithRoleName:@"Hogfish" typeName:@"6" descName:@"Hogfish may be contaminated with a tropical marine toxin that causes ciguatera, a serious foodborne illness that improves with time but has no cure.  Ciguatera is found in tropical reef fish, and cannot be cooked out of food. Be sure to ask at restaurants whether your tropical fish has been tested for the presence of this toxin. If you choose to eat tropical reef fish, consuming small portions and selecting smaller-sized fish may help you avoid the more serious side effects of this toxin." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];

[self insertRoleWithRoleName:@"Mangrove Snapper" typeName:@"6" descName:@"Mangrove snapper (also called “gray” or “mango” snapper) is caught throughout the Gulf with hook-and-line or bottom longline. Hook-and-line and hand lines allow for non-target species to be released more quickly, improving survival chances, and cause less damage to the seafloor.  A bottom longline consists of a central line strung with many baited hooked lines and a weight of some type keeping the line in place.  This method can catch many non-target species and cause damage to the seafloor. Mangrove snapper mature and reproduce quickly, making stock depletion less of a threat." goodName:@"Advice: Safe to eat" badName:@"0" regName:@"Type: Invasive"];


[self insertRoleWithRoleName:@"Atlantic Cod" typeName:@"6" descName:@"Atlantic cod populations in the waters off New England are depleted and suffer from high fishing levels. Other fish species caught alongside cod in the mixed groundfish fishery, including haddock and various species of flatfish, are also depleted and/or experiencing high fishing pressure. There are also concerns over the capture of marine mammals in the gillnet fisheries in this region. For these reasons, most of the Atlantic cod from this region is considered an Avoid" goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Atlantic Flatfish" typeName:@"6" descName:@"Due to heavy fishing in the region, many Atlantic flatfish stocks are low. Flounder are most frequently caught using bottom or otter trawls, nets that drag along the seafloor, that can damage habitat and remove or cover animals and plant life. This method of fishing can catch many non-target species that are often discarded, dead or dying, after they are brought to the surface." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Caviar" typeName:@"6" descName:@"Sturgeon and paddlefish in the Mississippi River and its tributaries can be caught in 31 states, and each state has its own system of management for these species. Many states do not permit commercial fishing for sturgeon. There is minimal collaboration between states -although this is improving- in managing sturgeon populations across the Mississippi watershed. As a result it is unclear whether populations are depleted and whether current fishing effort is at a sustainableGlossary level. Management of the sturgeon and paddlefish fisheries in the Mississippi watershed is ineffective at protecting these unique fish from overfishing, and as such these fish and their caviar should be avoided." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Chilean Seabass" typeName:@"6" descName:@"Marketed as Chilean sea bass, Patagonian and Antarctic toothfish are slow growing and inherently prone to overfishing. The premium price also spurred rampant illegal fishing, which has fortunately declined with an increasing percentage of legal operators." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Eel Freshwater" typeName:@"6" descName:@"Freshwater eel have a unique life cycle: the adults spawnGlossary in salt water thousands of miles from the freshwater habitat where their offspring will grow up. Loss of freshwater habitat for eel has caused serious decline in wild populations. Ninety percent of all eel sold in the U.S. are farm raised. Rather than raising them from eggs, eel farms collect young eels from the wild, a practice that adds pressure to the already threatened wild populations." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Farmed Salmon" typeName:@"6" descName:@"Salmon farmed in open net pens are vulnerable to infection from diseases and parasites, and farms use antibiotics and pesticides to treat or control infection. Although antibiotic use in Scotland is low, there are no regulatory limits on total use should a disease outbreak occur. Pesticide use to control parasitic sea lice in Scotland is high." goodName:@"Advice: Avoid" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Farmed Shrimp" typeName:@"6" descName:@"Many of Mexico's shrimp farms are located along the Gulf of California coast - a unique and vulnerable ecosystem. These farms are adjacent to sensitive coastal wetland and mangroveGlossary habitats, and despite leaving mangroves largely intact, the ecosystem is impacted by water and effluent from these farms." goodName:@"Advice: Avoid" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Orange Roughy" typeName:@"6" descName:@"Years of heavy fishing have decimated orange roughy populations. Although there are fishery management plans in place, scientists predict it could take decades for populations to recover.Another concern with orange roughy is the way it's caught. Bottom trawls are problematic, causing damage to seafloor habitat, especially in the fragile, deep-sea ecosystems where orange roughy live." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"Shark" typeName:@"6" descName:@"Although shark finning is banned in some countries, including the U.S., it still occurs in many fisheries worldwide and is a major factor in the decline of shark populations. Since sharks mature slowly and give birth to few young, most don't reproduce quickly enough to keep up with the intense level of fishing and accidental catch in other fisheries. " goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Dirty Dozen"];

[self insertRoleWithRoleName:@"King Crab" typeName:@"6" descName:@"TrapGlossary fisheries are usually low in bycatchGlossary and do not cause significant harm to seafloor habitats. Any crabs caught that are too small to be legally sold can also be safely returned to the ocean.The two primary king crab populations in Alaska are healthy and abundant due to responsible fisheries management. Others have been closed to allow time to recover from previous overfishing." goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];

[self insertRoleWithRoleName:@"Imported Basa" typeName:@"6" descName:@"Commercial farming of river catfish - known as Basa, Pangasius and Swai - in southeast Asia has increased rapidly in recent years. River catfish has a strong potential to be a sustainable aquacultureGlossary species, but there are conservation concerns with the current practice of open cage aquaculture combined with little or no management of these fish farming operations in Asia. " goodName:@"Advice: Avoid - Overfished" badName:@"0" regName:@"Type: Dirty Dozen"];
        
        
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"loaddata"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    }
    
    
    //NSLog(@"Importing Core Data Default Values for Seafood Completed!");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self importCoreDataDefaultRoles];
    
    // set the socialize api key and secret, register your app here: http://www.getsocialize.com/apps/
    //[Socialize storeConsumerKey:@"949236fa-03da-4e7b-9b6a-20ef5ce84a2b"];
    //[Socialize storeConsumerSecret:@"4188fe46-49c3-492f-bb46-7e305a06258e"];
    
    //    if (![[self.fetchedResultsController fetchedObjects] count] > 0 ) {
    //        NSLog(@"!!!!! ~~> There's nothing in the database so defaults will be inserted");
    //
    //    }
    //    else {
    //
    //        NSLog(@"There's stuff in the database so skipping the import of default data");
    //    }
    //
    
    // UIImage *navBarImage = [UIImage imageNamed:@"menubar.png"];
    
    // [[UINavigationBar appearance] setBackgroundImage:navBarImage
    //                                   forBarMetrics:UIBarMetricsDefault];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Seafood_Guide" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Seafood_Guide.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end