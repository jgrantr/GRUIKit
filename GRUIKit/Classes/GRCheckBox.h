//
//  GRCheckBox.h
//  GRUIKit
//
//  Created by Grant Robinson on 5/22/15.
//  Copyright (c) 2015 Grant Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GRCheckBox : UIControl

@property (nonatomic, getter=isChecked) IBInspectable BOOL checked;
@property (nonatomic) IBInspectable BOOL highlightOnTouch;
@property (nonatomic, assign) IBInspectable CGSize checkmarkSize;
@property (nonatomic, strong) IBInspectable UIColor *fillColor;
@property (nonatomic, strong) IBInspectable UIColor *checkmarkColor;
@property (nonatomic, strong) IBInspectable UIColor *circleColor;
@property (nonatomic, strong) IBInspectable UIColor *highlightColor;
@property (nonatomic, assign) IBInspectable CGFloat circleLineWidth;
@property (nonatomic, assign) IBInspectable CGFloat circleCornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;


@property (nonatomic) IBInspectable CGFloat strokeFactor;
@property (nonatomic) IBInspectable CGFloat insetFactor;
@property (nonatomic) IBInspectable CGFloat markInsetFactor;

- (void) setChecked:(BOOL)checked animated:(BOOL)animated;

@end
