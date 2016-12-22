//
//  DetailPageView.m
//  GetStarted
//
//  Created by VS on 12/22/16.
//  Copyright © 2016 VS-Deepika-MacBookPro. All rights reserved.
//

#import "DetailPageView.h"

@implementation DetailPageView{
    

    __weak IBOutlet UILabel *textLabel;
    
    __weak IBOutlet UIImageView *imageView;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)updateTextLabelWithText:(NSString *)text AndImageViewWithImage:(UIImage *)image{
    
    textLabel.text = text;
    imageView.image = image;
    
}
@end
