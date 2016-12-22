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
#define kDetailPageViewNibName @"DetailPageView"

@interface ViewController () <UIScrollViewDelegate ,UIPageViewControllerDelegate>
{
    IBOutlet UIPageControl *myControl;
    IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *skipButton;
    
    }
@end

@implementation ViewController{
    
    CGFloat xPoiter;
    int i;
    int page;
    int viewWidth;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imagesArray = @[@"share.png",@"share.png",@"share.png",@"share.png"];
    _textArray = @[@"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs.",@"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs.",@"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs.", @"Applicant is now ready with the complete set of application that includes one filled-in, signed, photo-affixed PAN Application form endorsed with payment confirmation alongwith the three supporting documentary proofs."];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    xPoiter = 0;
    skipButton.layer.cornerRadius = 5;
    
    for(i  =0 ;i <[_imagesArray count]; i++)
    {
        UIView *placeHolderView = [[UILabel alloc] initWithFrame:CGRectMake(xPoiter,
                                                                       0,
                                                                       self.view.frame.size.width ,
                                                                       self.view.frame.size.height-KFixUIHeight)];
        
        
        placeHolderView.backgroundColor = [UIColor clearColor];
        DetailPageView *detailPageView = [[[NSBundle mainBundle] loadNibNamed:kDetailPageViewNibName owner:self options:nil] firstObject];
        
        [detailPageView updateTextLabelWithText:[_textArray objectAtIndex:i] AndImageViewWithImage:[UIImage imageNamed:[_imagesArray objectAtIndex:i]]];
        [detailPageView setFrame:CGRectMake(0,
                                            0,
                                            placeHolderView.frame.size.width,
                                            placeHolderView.frame.size.height)];

        [placeHolderView addSubview:detailPageView];
        [scrollView addSubview:placeHolderView];

        xPoiter += self.view.frame.size.width;
        
    }
    
    scrollView.contentOffset =CGPointMake(0, 0) ;
    scrollView.contentSize = CGSizeMake(xPoiter, self.view.frame.size.height-KFixUIHeight);
    myControl.currentPage =0;
    [myControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
   
   
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.myControl.currentPage *
}

#pragma mark -


- (void)scrollViewDidScroll:(UIScrollView *)thisScrollView{
    
    
    page = thisScrollView.contentOffset.x/thisScrollView.frame.size.width;
    
    
    myControl.currentPage =page;

    if(myControl.currentPage < 3)
    {
        [skipButton setTitle:@"SKIP" forState:UIControlStateNormal];
    }
    if(myControl.currentPage == 3)
    {
        [skipButton setTitle:@"FINISH" forState:UIControlStateNormal];
    }
    
}





- (void)changePage:(id)sender
{
        page = scrollView.contentOffset.x/scrollView.frame.size.width;

    myControl.currentPage =page;
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(myControl.currentPage+1)  , 0) animated:YES];
   
}


- (IBAction)skipButtonPressed:(UIButton *)sender {
    
    
}


@end
