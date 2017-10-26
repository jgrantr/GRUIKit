//
//  GRRoundedCornerView.m
//  GRUIKit
//
//  Created by Grant Robinson on 10/26/17.
//  Copyright (c) 2017 Grant Robinson. All rights reserved.
//

#import "GRRoundedCornerView.h"

@interface GRRoundedCornerView ()
{
	CAShapeLayer *maskLayer;
	CAGradientLayer *gradientLayer;
	UIRectCorner cornersToRound;
}

@end

@implementation GRRoundedCornerView

@synthesize radius, showGradient, topColor, bottomColor;

- (instancetype) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (instancetype) init {
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void) commonInit {
	maskLayer = [CAShapeLayer layer];
	radius = 5;
	gradientLayer = [CAGradientLayer layer];
	cornersToRound = 0;
	[self setNeedsDisplay];
}

- (void) setRadius:(CGFloat)_radius {
	[self willChangeValueForKey:@"radius"];
	radius = _radius;
	[self didChangeValueForKey:@"radius"];
	[self updateShapeLayer];
}

- (void) setBounds:(CGRect)bounds {
	[super setBounds:bounds];
	[self updateShapeLayer];
	[self updateGradient];
}

- (void) setShowGradient:(BOOL)_showGradient {
	[self willChangeValueForKey:@"showGradient"];
	showGradient = _showGradient;
	[self didChangeValueForKey:@"showGradient"];
	[self updateGradient];
}

- (void) setTopColor:(UIColor *)_topColor {
	[self willChangeValueForKey:@"topColor"];
	topColor = _topColor;
	[self didChangeValueForKey:@"topColor"];
	[self updateGradient];
}

- (void) setBottomColor:(UIColor *)_bottomColor {
	[self willChangeValueForKey:@"bottomColor"];
	bottomColor = _bottomColor;
	[self didChangeValueForKey:@"bottomColor"];
	[self updateGradient];
}

- (void) updateShapeLayer {
	BOOL roundTop = YES, roundBottom = YES;
//	maskLayer.frame = self.bounds;
	if (roundTop && roundBottom) {
		maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath;
		self.layer.mask = maskLayer;
	}
	else if (roundTop) {
		maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)].CGPath;
		self.layer.mask = maskLayer;
	}
	else if (roundBottom) {
		maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)].CGPath;
		self.layer.mask = maskLayer;
	}
	else {
		self.layer.mask = nil;
	}
	[self.layer setNeedsDisplay];
}

- (void) updateGradient {
	gradientLayer.frame = self.bounds;
	if (showGradient && topColor && bottomColor) {
		if (gradientLayer.superlayer == nil) {
			[self.layer insertSublayer:gradientLayer atIndex:0];
		}
		gradientLayer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
		[self.layer setNeedsDisplay];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
