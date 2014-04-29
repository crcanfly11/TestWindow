//
//  CRViewController.m
//  TestWindow
//
//  Created by 金成日 on 14-4-18.
//  Copyright (c) 2014年 金成日. All rights reserved.
//

#import "CRViewController.h"

#define Myswitch NO

@interface CRViewController ()
@property (nonatomic, strong) NSMutableArray *progressViews;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, strong) UIProgressDensityLeft *myProgressDensityLeftView;
@end

@implementation CRViewController

@synthesize sliderLabel =_sliderLabel;
@synthesize progressViewLabel = _progressViewLabel;
@synthesize progressView = _progressView;
@synthesize buttonLabel = _buttonLabel;
@synthesize sysProgressView = _sysProgressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.progressViews = [NSMutableArray array];
    
    UIProgressDensityLeft *progressDensityLeft = [[UIProgressDensityLeft alloc]initWithFrame:CGRectMake(20, 200, 234, 22)];
    //progressDensityLeft.progress = 0.4;
    [progressDensityLeft setProgress:0.4 animated:Myswitch];
    [self.progressViews addObject:progressDensityLeft];
    [self.view addSubview:progressDensityLeft];
    self.myProgressDensityLeftView = progressDensityLeft;
    
    for (UIView *subView in [NSArray arrayWithArray:self.view.subviews]) {
        NSString *subViewNanme = [NSString stringWithFormat:@"%@",[subView class]];
        if ([subViewNanme isEqualToString:@"UISlider"]) {
            [self.progressViews addObject:subView];
        }
    }
    
    [_progressView setProgress:0.4 animated:Myswitch];
    _progressView.progressTintColor = [UIColor redColor];
    
}

#pragma mark - setValue
//UIProgressDensityLeft 使用animated属性后 加速效果不明显，组建加载速度越慢，效果越明显。
- (IBAction)changeValue:(UISegmentedControl *)sender {
    for (UIView *subView in self.progressViews) {
        NSString *subViewNanme = [NSString stringWithFormat:@"%@",[subView class]];
        if ([subViewNanme isEqualToString:@"UISlider"]) {
            UISlider *sliderView = (UISlider *)subView;
            sliderView.value = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] floatValue];
            [self changeSlider:sliderView];
        }
        else if ([subViewNanme isEqualToString:@"UIProgressDensityLeft"]) {
            UIProgressDensityLeft *progressView = (UIProgressDensityLeft *)subView;
//            progressView.progress = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] floatValue]/100;
            [progressView setProgress:[[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] floatValue]/100
                             animated:Myswitch];
            [self changeProgressView:progressView];
        }
    }
}

- (IBAction)changeSlider:(UISlider *)sender
{
    _sliderLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
//    _progressViewLabel.text = [NSString stringWithFormat:@"%.02f",sender.value/100];
    
    for (UIView *subView in self.progressViews) {
        NSString *subViewNanme = [NSString stringWithFormat:@"%@",[subView class]];
        if ([subViewNanme isEqualToString:@"UIProgressDensityLeft"]) {
            UIProgressDensityLeft *progressView = (UIProgressDensityLeft *)subView;
            progressView.progress = sender.value/100;
            [self changeProgressView:progressView];
        }
    }
    
    [_progressView setProgress:sender.value/100 animated:Myswitch];
}

- (IBAction)changeProgressView:(UIProgressDensityLeft *)sender
{
    _progressViewLabel.text = [NSString stringWithFormat:@"%.02f",sender.progress];
}

- (IBAction)showProgressView:(id)sender
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(setProgressView) userInfo:nil repeats:YES];
}

- (void)setProgressView
{
    static double cnt = 0;
    
    cnt++;
    
    [self.myProgressDensityLeftView setProgress:cnt/100];
    [_progressView setProgress:cnt/100];
    
    if (cnt == 100) {
//        [self.progressTimer setFireDate:[NSDate distantFuture]];   //停止计时器
        [self.progressTimer invalidate];  //关闭计时器
        
        cnt = 0;
        [self.myProgressDensityLeftView setProgress:0];
        [_progressView setProgress:0];
    }
    
    _buttonLabel.text = [NSString stringWithFormat:@"%.0f",cnt];
    _sysProgressView.text = [NSString stringWithFormat:@"%.0f",cnt];
    [self changeProgressView:self.myProgressDensityLeftView];
}

#pragma mark - PopupVIew
- (IBAction)popupViewButton:(id)sender
{
    UIView *subView = [[UIView alloc]initWithFrame:self.view.bounds];
    [subView setBackgroundColor:[UIColor redColor]];

    UIAlertViewTouchQuitAnyWhere *alterViewTouchQuitAnyWhere = [[UIAlertViewTouchQuitAnyWhere alloc]initWithTitle:@"testWindow AlterView Test"
                                                       message:@"You can tip anywhere."
                                                      delegate:self
                                             cancelButtonTitle:@"Cancle"
                                             otherButtonTitles:@"Others", nil];
    
    //[subView addSubview:alterViewTouchQuitAnyWhere];
//    [self.view addSubview:subView];
    
    [self.view addSubview:alterViewTouchQuitAnyWhere];
    
    //UIAlertView 展示的时候 提示框以外的部分 收不到信息  怎么解决。
    //[alterView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex:%d",buttonIndex);
    
    for (UIView *subView in self.view.subviews) {
        NSString *subViewName = [NSString stringWithFormat:@"%@",[subView class]];
        if ([subViewName isEqualToString:@"UIView"]) {
            [subView removeFromSuperview];
        }
    }
}

- (void)touchAnyWhere
{
    NSLog(@"touch test.");
}


#pragma mark - 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
