//
//  HelpViewController.m
//  HelpController
//
//  Created by VS on 12/15/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import "HelpViewController.h"
#import "Constants.h"

#import "ToolTipTextView.h"
#import "Utility.h"

@interface HelpViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HelpViewController{
    
    NSNumber *horizontalScaleFactor;
    NSNumber *verticalScaleFactor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setScalefactors];
    
    NSArray *hotspotsArray = _imageDetail.hotspotsArray;
    
    for (int i = 0; i<[hotspotsArray count]; i++ ) {
        HotSpotConfig *hotspotConfig = [hotspotsArray objectAtIndex:i];
        
        CGRect frame = CGRectMake([hotspotConfig.xPosition doubleValue]*[horizontalScaleFactor doubleValue],
                                  [hotspotConfig.yPosition doubleValue]*[verticalScaleFactor doubleValue],
                                  [hotspotConfig.width doubleValue]*[horizontalScaleFactor doubleValue],
                                  [hotspotConfig.height doubleValue]*[verticalScaleFactor doubleValue]);
        [self createButtonWithFrame:frame forIndex:i];
        [hotspotConfig setXPosition:[NSNumber numberWithDouble:frame.origin.x]];
        [hotspotConfig setYPosition:[NSNumber numberWithDouble:frame.origin.y]];
        [hotspotConfig setWidth:[NSNumber numberWithDouble:frame.size.width]];
        [hotspotConfig setHeight:[NSNumber numberWithDouble:frame.size.height]];
        
        [self createToolTipTextViewForHotspot:hotspotConfig];
    }
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    UIImage *image = [UIImage imageNamed:_imageDetail.name ];
    [_imageView setFrame:CGRectMake(0, kNavBarHeight,self.view.frame.size.width*.85 , self.view.frame.size.height*.85)];
    [_imageView setImage:image];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private methods

-(void)createButtonWithFrame:(CGRect)frame forIndex:(int )index{

    
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setTitle:@"" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor blueColor]];
    [addButton setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];

    addButton.tag = kButtonTag + index;
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

-(void)pushScreen:(UIButton *)sender{
    int buttonIndex = sender.tag % kButtonTag;
    HelpViewController *controller = (HelpViewController *)[[UIStoryboard storyboardWithName:@"Main"
                                                                                  bundle:NULL] instantiateViewControllerWithIdentifier:@"HelpView"];
    NSString *action = [[_imageDetail.hotspotsArray objectAtIndex:buttonIndex] action];
    if ([action isEqualToString:@"back"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        controller.imageDetail = [_imageConfig.imagesArray objectAtIndex:[action intValue]-1];
        controller.imageConfig = _imageConfig;
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    
}


@end
