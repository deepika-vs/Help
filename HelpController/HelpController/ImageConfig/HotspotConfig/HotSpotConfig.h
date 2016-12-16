//
//  HotSpotConfig.h
//  HelpController
//
//  Created by VS on 12/16/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotSpotConfig : NSObject

@property (strong, nonatomic) NSNumber *xPosition;
@property (strong, nonatomic) NSNumber *yPosition;
@property (strong, nonatomic) NSNumber *width;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSString *tooltipMessage;
@property (strong, nonatomic) NSString *tooltipDirection;
@property (strong, nonatomic) NSString *action;

@end
