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

@property (nonatomic, assign) IBInspectable BOOL roundTopLeft;
@property (nonatomic, assign) IBInspectable BOOL roundTopRight;
@property (nonatomic, assign) IBInspectable BOOL roundBottomLeft;
@property (nonatomic, assign) IBInspectable BOOL roundBottomRight;
@property (nonatomic, assign) IBInspectable CGFloat radius;
@property (nonatomic, strong) IBInspectable UIColor *topColor;
@property (nonatomic, strong) IBInspectable UIColor *bottomColor;
@property (nonatomic) IBInspectable BOOL showGradient;

@end
