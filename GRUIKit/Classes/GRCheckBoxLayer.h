//
//  GRCheckBoxLayer.h
//  GRUIKit
//
//  Created by Grant Robinson on 5/22/15.
//  Copyright (c) 2015 Grant Robinson. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface GRCheckBoxLayer : CALayer

@property CGColorRef tintColor;


@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *checkmarkColor;


@property (nonatomic) BOOL highlighted;
@property (nonatomic, strong) UIColor *highlightColor;

@property (getter=isChecked) BOOL checked;

@property (nonatomic) CGSize checkmarkSize;
@property (nonatomic) CGFloat circleLineWidth;
@property (nonatomic) CGFloat circleCornerRadius;

@property (nonatomic) CGFloat strokeFactor;
@property (nonatomic) CGFloat insetFactor;
@property (nonatomic) CGFloat markInsetFactor;

- (void) setChecked:(BOOL)checked animated:(BOOL)animated;

@end
