//
//  PooAlerView.h
//  PooAlerView
//
//  Created by crazypoo on 14-4-2.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PooAlertView : UIView

@property (nonatomic, retain) UIView *parentView;
@property (nonatomic, retain) UIView *dialogView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIView *buttonView;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSMutableArray *buttonTitles;

- (id)initWithParentView: (UIView *)_parentView;
- (void)show;
- (void)close;
- (void)setButtonTitles: (NSMutableArray *)buttonTitles;
- (void)pooAlertViewButtonTouchUpInside:(id)sender;

@end
