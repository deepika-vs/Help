//
//  ToolTipTextView.m
//  HelpController
//
//  Created by VS on 12/15/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import "ToolTipTextView.h"
#import "Constants.h"
#import "Utility.h"


#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@implementation ToolTipTextView

-(instancetype)init{
    
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *fillPath = [UIBezierPath bezierPath];
    
    [fillPath moveToPoint:CGPointMake(0, self.bounds.origin.y+kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width/2-(kArrowHeight/2), kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width/2, 0)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width/2+(kArrowHeight/2), kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width, kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [fillPath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [fillPath closePath];
    
    CGContextAddPath(context, fillPath.CGPath);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    [self rotateView];
    [self addandRotateTextLabel];
}

-(void)addandRotateTextLabel{
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.backgroundColor = [UIColor greenColor];
    textLabel.text = _message;
    textLabel.textColor = [UIColor blueColor];
    textLabel.font = kChatFont;
    textLabel.numberOfLines = 20;
    [self addSubview:textLabel];
    if ([_direction isEqualToString:kToolTipTextDirectionUp]){
        
        [textLabel setFrame:CGRectMake(0,
                                       0 + kArrowHeight,
                                       self.frame.size.width,
                                       self.frame.size.height - kArrowHeight)];
        
    }
    else if ([_direction isEqualToString:kToolTipTextDirectionDown]){
        
        [textLabel setFrame:CGRectMake(0,
                                       0 + kArrowHeight,
                                       self.frame.size.width ,
                                       self.frame.size.height - kArrowHeight)];
        double rads = DEGREES_TO_RADIANS(180);
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        textLabel.transform = transform;
        
    }
    else if ([_direction isEqualToString:kToolTipTextDirectionLeft]){
        
        double rads = DEGREES_TO_RADIANS(90);
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        textLabel.transform = transform;
        
        [textLabel setFrame:CGRectMake(0 ,
                                       0+ kArrowHeight ,
                                       self.frame.size.height ,
                                       self.frame.size.width - kArrowHeight)];
        
    }
    else if ([_direction isEqualToString:kToolTipTextDirectionRight]){
        
        double rads = DEGREES_TO_RADIANS(270);
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        textLabel.transform = transform;
        [textLabel setFrame:CGRectMake(0 ,
                                       0 +kArrowHeight,
                                       self.frame.size.height,
                                       self.frame.size.width - kArrowHeight
                                       )];
        
        
        
    }
    
    
}

-(void)rotateView{
    
    if ([_direction isEqualToString:kToolTipTextDirectionDown]){
        
        double rads = DEGREES_TO_RADIANS(180);
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        self.transform = transform;
        
    }
    else if ([_direction isEqualToString:kToolTipTextDirectionLeft]){
        
        double rads = DEGREES_TO_RADIANS(270);
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        self.transform = transform;
        
    }
    else if ([_direction isEqualToString:kToolTipTextDirectionRight]){
        
        double rads = DEGREES_TO_RADIANS(90);
        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
        self.transform = transform;
        
    }
    
    
}

@end
