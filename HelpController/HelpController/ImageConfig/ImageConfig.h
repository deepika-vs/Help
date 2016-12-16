//
//  ImageConfig.h
//  HelpController
//
//  Created by VS on 12/16/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotSpotConfig.h"

@class ImageDetail;

@interface ImageConfig : NSObject

@property (strong, nonatomic) NSArray <ImageDetail *> *imagesArray;

@end

@interface  ImageDetail: NSObject

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray <HotSpotConfig *> *hotspotsArray;


@end
