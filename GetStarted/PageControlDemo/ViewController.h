//
//  ViewController.h
//  PageControlDemo
//
//  Created by VS-Deepika-MacBookPro on 3/14/16.
//  Copyright © 2016 VS-Deepika-MacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate ,UIPageViewControllerDelegate>
{
   IBOutlet UIPageControl *myControl;
    IBOutlet UIScrollView *Scroller;
    NSArray *imagesArray;
    
}

@end

