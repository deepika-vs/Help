//
//  ViewController.m
//  HelpController
//
//  Created by VS on 12/15/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import "ViewController.h"
#import "HelpViewController.h"


@interface ViewController ()

@end

@implementation ViewController{
    HelpViewController *controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    controller = (HelpViewController *)[[UIStoryboard storyboardWithName:@"Main"
                                                                  bundle:NULL] instantiateViewControllerWithIdentifier:@"HelpView"];
     [self configureData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configureData{
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HelpJson" ofType:@"json"];
    
    NSString *helpJson = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [helpJson dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonObject) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        
        controller.imageConfig = [[ImageConfig alloc] init];
        controller.imageConfig.imagesArray = [jsonObject valueForKey:@"images"];
        
    }
    
    
    NSMutableArray <ImageDetail *> *imagesArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in controller.imageConfig .imagesArray) {
        
        ImageDetail *imageDetail = [[ImageDetail alloc] init];
        imageDetail.name = [dict valueForKey:@"name"];
        imageDetail.ID =  [dict valueForKey:@"id"];
        NSArray *array =  [dict valueForKey:@"hotSpots"];
        NSMutableArray <HotSpotConfig *> *hotspotsArray = [[NSMutableArray alloc] init];
        
        
        for (NSDictionary *item in array) {
            
            HotSpotConfig *hotspotConfig = [[HotSpotConfig alloc] init];
            
            hotspotConfig.xPosition = [item valueForKey:@"x"];
            hotspotConfig.yPosition = [item valueForKey:@"y"];
            hotspotConfig.width = [item valueForKey:@"width"];
            hotspotConfig.height = [item valueForKey:@"height"];
            
            hotspotConfig.tooltipMessage = [item valueForKey:@"TooltipMessage"];
            hotspotConfig.tooltipMessage = [item valueForKey:@"tooltipDirection"];
            hotspotConfig.action =[item valueForKey:@"action"];
            
            [hotspotsArray addObject:hotspotConfig];
        }
        
        imageDetail.hotspotsArray = hotspotsArray;
        [imagesArray addObject:imageDetail];
    }
    controller.imageConfig.imagesArray = imagesArray;
    controller.imageDetail = [controller.imageConfig.imagesArray objectAtIndex:0 ];
}


- (IBAction)helpButtonPressed:(id)sender {
    
   
    
    [self.navigationController pushViewController:controller animated:NO];
}

@end
