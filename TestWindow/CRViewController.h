//
//  CRViewController.h
//  TestWindow
//
//  Created by 金成日 on 14-4-18.
//  Copyright (c) 2014年 金成日. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIProgressDensityLeft.h"
#import "UIAlertViewTouchQuitAnyWhere.h"

@interface CRViewController : UIViewController

@property(nonatomic,retain) IBOutlet UILabel *sliderLabel;
@property(nonatomic,retain) IBOutlet UILabel *progressViewLabel;
@property(nonatomic,retain) IBOutlet UIProgressView *progressView;
@property(nonatomic,retain) IBOutlet UILabel *buttonLabel;
@property(nonatomic,retain) IBOutlet UILabel *sysProgressView;

- (IBAction)changeValue:(UISegmentedControl *)sender;
- (IBAction)changeSlider:(UISlider *)sender;
- (IBAction)changeProgressView:(UIProgressDensityLeft *)sender;

- (IBAction)showProgressView:(id)sender;
- (IBAction)popupViewButton:(id)sender;

@end
