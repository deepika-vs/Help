//
//  Utility.m
//  HelpController
//
//  Created by VS on 12/16/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import "Utility.h"
#import "Constants.h"

@implementation Utility



+ (CGSize)getTheSizeForText:(NSString *)text andFont:(UIFont*)font toFitInWidth:(CGFloat)width
{
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, 999)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return textRect.size;
}



+ (CGSize)getTheSizeForTextFixedHeight:(NSString *)text andFont:(UIFont*)font toFitInHeight:(CGFloat)height
{
    
    CGSize textRect = [text sizeWithAttributes:
                       @{NSFontAttributeName: font}];
    // Values are fractional -- you should take the ceilf to get equivalent values
    CGSize adjustedSize = CGSizeMake(ceilf(textRect.width), height);
    
    return adjustedSize;
}



+ (CGFloat)getHeightForMessage:(NSString *)message andAvailableWidth:(CGFloat)width
{
    CGFloat viewHeight;

    CGSize chatTextSize = [Utility getTheSizeForText:message andFont:kChatFont toFitInWidth:width];
    
    viewHeight = chatTextSize.height;
    
    return viewHeight;
}





@end
