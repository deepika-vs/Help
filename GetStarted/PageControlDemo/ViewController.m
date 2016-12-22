//
//  ViewController.m
//  PageControlDemo
//
//  Created by VS-Deepika-MacBookPro on 3/14/16.
//  Copyright © 2016 VS-Deepika-MacBookPro. All rights reserved.
//

#import "ViewController.h"
#import "DetailPageView.h"
#define KFixUIHeight 232

@interface ViewController ()

@end

@implementation ViewController{
    
    __weak IBOutlet UIButton *skipButton;
    NSArray *textArray;
}
CGFloat xPoiter = 0;
int i;
int page =0;
int viewWidth;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    imagesArray = @[@"share.png",@"share.png",@"share.png",@"share.png"];
    textArray = @[@"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs.",@"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs.",@"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs.", @"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs."];
    Scroller.delegate = self;
    Scroller.pagingEnabled = YES;

    skipButton.layer.cornerRadius = 5;
    
    for(i  =0 ;i <[imagesArray count]; i++)
    {
        UIView *placeHolderView = [[UILabel alloc] initWithFrame:CGRectMake(xPoiter,
                                                                       0,
                                                                       self.view.frame.size.width ,
                                                                       self.view.frame.size.height-KFixUIHeight)];
        
        
        placeHolderView.backgroundColor = [UIColor clearColor];
        DetailPageView *detailPageView = [[[NSBundle mainBundle] loadNibNamed:@"DetailPageView" owner:self options:nil] firstObject];
        
        [detailPageView updateTextLabelWithText:[textArray objectAtIndex:i] AndImageViewWithImage:[UIImage imageNamed:[imagesArray objectAtIndex:i]]];
        [detailPageView setFrame:CGRectMake(0,
                                            0,
                                            placeHolderView.frame.size.width,
                                            placeHolderView.frame.size.height)];

        [placeHolderView addSubview:detailPageView];
        [Scroller addSubview:placeHolderView];

        xPoiter += self.view.frame.size.width;
        
    }
    
    Scroller.contentOffset =CGPointMake(0, 0) ;
    Scroller.contentSize = CGSizeMake(xPoiter, self.view.frame.size.height-KFixUIHeight);
    myControl.currentPage =0;
    [myControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
   
   
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.myControl.currentPage *
}

#pragma mark -


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    int page = Scroller.contentOffset.x/Scroller.frame.size.width;
    
    
    myControl.currentPage =page;

    if(myControl.currentPage == 3)
    {
        [skipButton setTitle:@"FINISH" forState:UIControlStateNormal];
    }
    
}





- (void)changePage:(id)sender
{
    
    if(myControl.currentPage>0 )
    {
       
    }
    if(myControl.currentPage == 3)
    {
       
            }
    if(myControl.currentPage == 0)
    {
     
        
    }

    page = Scroller.contentOffset.x/Scroller.frame.size.width;

    myControl.currentPage =page;
    [Scroller setContentOffset:CGPointMake(Scroller.frame.size.width*(myControl.currentPage+1)  , 0) animated:YES];
    
    
    
}


- (IBAction)skipButtonPressed:(UIButton *)sender {
    
    
}


@end
