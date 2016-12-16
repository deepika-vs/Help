//
//  Utility.h
//  HelpController
//
//  Created by VS on 12/16/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject


+ (CGSize)getTheSizeForText:(NSString *)text andFont:(UIFont*)font toFitInWidth:(CGFloat)width;

+ (CGSize)getTheSizeForTextFixedHeight:(NSString *)text andFont:(UIFont*)font toFitInHeight:(CGFloat)height;

+ (CGFloat)getHeightForMessage:(NSString *)message andAvailableWidth:(CGFloat)width;


@end
