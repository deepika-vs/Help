//
//  HelpViewController.m
//  HelpController
//
//  Created by VS on 12/15/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import "HelpViewController.h"
#import "Constants.h"
#import "ImageConfig.h"
#import "ToolTipTextView.h"
#import "Utility.h"

@interface HelpViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) ImageConfig *imageConfig;
@property (assign ,nonatomic) CGFloat height;
@property (strong, nonatomic) NSArray <ImageConfig *> *imageConfigArray;

@end

@implementation HelpViewController{
    
    NSNumber *horizontalScaleFactor;
    NSNumber *verticalScaleFactor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureData];
    
     UIImage *image = [UIImage imageNamed:[[_imageConfig.imagesArray objectAtIndex:0] name] ];
    [_imageView setFrame:CGRectMake(0, kNavBarHeight,self.view.frame.size.width*.85 , self.view.frame.size.height*.85)];
    [_imageView setImage:image];
    
    [self setScalefactors];
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    
   
    NSArray *hotspotsArray = [[_imageConfig.imagesArray objectAtIndex:0] hotspotsArray];
    
    for (HotSpotConfig *hotspotConfig in hotspotsArray) {
        
     
        CGRect frame = CGRectMake([hotspotConfig.xPosition doubleValue]*[horizontalScaleFactor doubleValue],
                                  [hotspotConfig.yPosition doubleValue]*[verticalScaleFactor doubleValue],
                                  [hotspotConfig.width doubleValue]*[horizontalScaleFactor doubleValue],
                                  [hotspotConfig.height doubleValue]*[verticalScaleFactor doubleValue]);
        [self createButtonWithFrame:frame];
        [hotspotConfig setXPosition:[NSNumber numberWithDouble:frame.origin.x]];
        [hotspotConfig setYPosition:[NSNumber numberWithDouble:frame.origin.y]];
        [hotspotConfig setWidth:[NSNumber numberWithDouble:frame.size.width]];
        [hotspotConfig setHeight:[NSNumber numberWithDouble:frame.size.height]];
        
        [self createToolTipTextViewForHotspot:hotspotConfig];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private methods

-(void)configureData{
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HelpJson" ofType:@"json"];
    
    //création d'un string avec le contenu du JSON
    NSString *helpJson = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [helpJson dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonObject) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
     
            _imageConfigArray = [jsonObject valueForKey:@"images"];
    
    }
    
    _imageConfig = [[ImageConfig alloc] init];
    NSMutableArray <ImageDetail *> *imagesArray = [[NSMutableArray alloc] init];
    
    ImageDetail *imageDetail = [[ImageDetail alloc] init];
    imageDetail.name = [[_imageConfigArray objectAtIndex:0] valueForKey:@"name"];
    imageDetail.ID =  [[_imageConfigArray objectAtIndex:0] valueForKey:@"id"];
    NSArray *array =  [[_imageConfigArray objectAtIndex:0] valueForKey:@"hotSpots"];
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
    _imageConfig.imagesArray = imagesArray;
}

-(void)createButtonWithFrame:(CGRect)frame{

    
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setTitle:@"" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor blueColor]];
    [addButton setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];

    [addButton addTarget:self action:@selector(pushScreen:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:addButton];
    [self.imageView bringSubviewToFront:addButton];
    [self.imageView setUserInteractionEnabled:YES];
    
}

-(void)setScalefactors{
    
    if (self.view.frame.size.width == 320 && self.view.frame.size.height == 480 ) {
        horizontalScaleFactor = [NSNumber numberWithFloat:1.0];
        verticalScaleFactor = [NSNumber numberWithFloat:1.183];
    }
    else if (self.view.frame.size.width == 320 && self.view.frame.size.height == 568 ){
        
        horizontalScaleFactor = [NSNumber numberWithFloat:1.0];
        verticalScaleFactor = [NSNumber numberWithFloat:1.0];
    }
    else if (self.view.frame.size.width == 375 && self.view.frame.size.height == 667 ){
        
        horizontalScaleFactor = [NSNumber numberWithFloat:1.171];
        verticalScaleFactor = [NSNumber numberWithFloat:1.174];
    }
    else if (self.view.frame.size.width == 414 && self.view.frame.size.height == 736 ){
        
        horizontalScaleFactor = [NSNumber numberWithFloat:1.291];
        verticalScaleFactor = [NSNumber numberWithFloat:1.295];
    }
}

-(void)createToolTipTextViewForHotspot:(HotSpotConfig *)hotspotConfig{
  
    _height = [Utility getHeightForMessage:hotspotConfig.tooltipMessage andAvailableWidth:[hotspotConfig.width doubleValue]];

    CGPoint origin = [self getTooTipTextOriginForHotSpotConfig:hotspotConfig];
    CGRect frame = CGRectMake(origin.x,
                              origin.y - kArrowHeight,
                              [hotspotConfig.width doubleValue],
                              _height + kArrowHeight);
    ToolTipTextView *toolTipTextView = [[ToolTipTextView alloc] initWithFrame:frame];
    
    toolTipTextView.direction = hotspotConfig.tooltipDirection;
    toolTipTextView.message = hotspotConfig.tooltipMessage;
    
    [_imageView addSubview:toolTipTextView];

}

-(CGPoint)getTooTipTextOriginForHotSpotConfig:(HotSpotConfig *)hotSpotConfig{
    
    CGPoint origin;
    if ([hotSpotConfig.tooltipDirection isEqualToString:kToolTipTextDirectionUp]) {
        
        origin = CGPointMake([hotSpotConfig.xPosition doubleValue] ,[hotSpotConfig.yPosition doubleValue]+ [hotSpotConfig.height doubleValue] + kButtonToToolTipTextViewPadding );
    }
    else if ([hotSpotConfig.tooltipDirection isEqualToString:kToolTipTextDirectionDown]) {
        
        origin = CGPointMake([hotSpotConfig.xPosition doubleValue] ,[hotSpotConfig.yPosition doubleValue] - _height );
        
    }
    else if ([hotSpotConfig.tooltipDirection isEqualToString:kToolTipTextDirectionLeft]) {
        
        origin = CGPointMake([hotSpotConfig.xPosition doubleValue] + [hotSpotConfig.width doubleValue] ,[hotSpotConfig.yPosition doubleValue] );
        
    }
    else if ([hotSpotConfig.tooltipDirection isEqualToString:kToolTipTextDirectionRight]) {
        
        origin = CGPointMake([hotSpotConfig.xPosition doubleValue] - [hotSpotConfig.width doubleValue] ,[hotSpotConfig.yPosition doubleValue] );
        
    }
    
    
    return origin;
}


#pragma mark - action Methods
- (IBAction)closeButtonPressed:(id *)sender {
     [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - selector Methods

-(void)pushScreen:(id *)sender{
    HelpViewController *controller = (HelpViewController *)[[UIStoryboard storyboardWithName:@"Main"
                                                                                  bundle:NULL] instantiateViewControllerWithIdentifier:@"HelpView"];
    [self.navigationController pushViewController:controller animated:NO];
}


@end
