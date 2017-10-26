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
@property (nonatomic, strong) IBInspectable UIColor *bottomColor;
@property (nonatomic) IBInspectable BOOL showGradient;

@end
