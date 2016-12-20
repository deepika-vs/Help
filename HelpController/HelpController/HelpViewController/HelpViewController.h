//
//  HelpViewController.h
//  HelpController
//
//  Created by VS on 12/15/16.
//  Copyright © 2016 VS-MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageConfig.h"

@interface HelpViewController : UIViewController

@property (strong, nonatomic) ImageDetail *imageDetail;
@property (assign ,nonatomic) CGFloat height;
@property (strong, nonatomic) ImageConfig *imageConfig;

@end
