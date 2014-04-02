//
//  PooViewController.m
//  PooAlerView
//
//  Created by crazypoo on 14-4-2.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooViewController.h"
#import "PooAlertView.h"

@interface PooViewController ()
@property (nonatomic, retain) UIButton *otherButton;
@property (nonatomic, retain) UITextField *inputCode;
@end

@implementation PooViewController
@synthesize otherButton = _otherButton;
@synthesize inputCode = _inputCode;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [otherButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    otherButton.frame = CGRectMake(self.view.frame.size.width / 2.0f, 0, self.view.frame.size.width / 2.0f, 100);
    [self.view addSubview:otherButton];
}

- (void)pooAlertViewButtonTouchUpInside:(PooAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        UIAlertView *lol = [[UIAlertView alloc] initWithTitle:@"提交成功" message:@"大家好,吃蜜棗" delegate:self cancelButtonTitle:@"NICE" otherButtonTitles:nil, nil];
        [lol show];
    }
    
}

- (UIView *)createGetCodeView
{
    UIView *getCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    
    self.inputCode = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 150, 40)];
    self.inputCode.font = [UIFont systemFontOfSize:21];
    self.inputCode.placeholder = @"請輸入驗證碼！";
    self.inputCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputCode.keyboardType = UIKeyboardTypeNumberPad;
    self.inputCode.backgroundColor = [UIColor clearColor];
    [getCodeView addSubview:self.inputCode];
    
    self.otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.otherButton addTarget:self action:@selector(alertViewbottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.otherButton setTitle:@"有碼！" forState:UIControlStateNormal];
    [self.otherButton setBackgroundColor:[UIColor clearColor]];
    self.otherButton.frame = CGRectMake(175, 5, 100, 40);
    [getCodeView addSubview:self.otherButton];
    
    return getCodeView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bottomButtonClicked:(id)sender
{
    PooAlertView *alview = [[PooAlertView alloc]initWithParentView:self.view];
    [alview setContainerView:[self createGetCodeView]];
    [alview setButtonTitles:[NSMutableArray arrayWithObjects:@"關閉", @"確定", nil]];
    [alview setDelegate:self];
    [alview show];
}

- (void)alertViewbottomButtonClicked:(id)sender
{
    [self.inputCode resignFirstResponder];
    
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.otherButton setTitle:@"有碼！" forState:UIControlStateNormal];
                [self.otherButton addTarget:self action:@selector(alertViewbottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            });
        }
        else
        {
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.otherButton setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
@end
