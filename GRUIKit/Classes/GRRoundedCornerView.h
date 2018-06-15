//
//  GRRoundedCornerView.h
//  GRUIKit
//
//  Created by Grant Robinson on 10/26/17.
//  Copyright (c) 2017 Grant Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GRRoundedCornerView : UIView

@property (nonatomic, assign) IBInspectable BOOL topLeftRounded;
@property (nonatomic, assign) IBInspectable BOOL topRightRounded;
@property (nonatomic, assign) IBInspectable BOOL bottomLeftRounded;
@property (nonatomic, assign) IBInspectable BOOL bottomRightRounded;
@property (nonatomic, assign) IBInspectable CGFloat radius;

@property (nonatomic, strong) IBInspectable UIColor *topColor;
@property (nonatomic, strong) IBInspectable UIColor *middleColor;
@property (nonatomic, strong) IBInspectable UIColor *bottomColor;
@property (nonatomic) IBInspectable BOOL showGradient;
@property (nonatomic, assign) IBInspectable CGPoint gradientStart;
@property (nonatomic, assign) IBInspectable CGPoint gradientEnd;

@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
@property (nonatomic) IBInspectable CGSize shadowOffset;
@property (nonatomic) IBInspectable CGFloat shadowRadius;
@property (nonatomic) IBInspectable float shadowOpacity;

/**
 If you need more than the three colors, you can specify them programatically.  They go in top to bottom order,
 so index 0 is considered the topColor, and index (count - 1) is considered the bottom color
 */
@property (nonatomic, strong) NSArray<UIColor*> *colors;

@end
