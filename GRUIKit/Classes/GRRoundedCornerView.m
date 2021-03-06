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

@synthesize radius, showGradient, topColor, bottomColor, middleColor, gradientStart, gradientEnd;

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
	gradientStart = CGPointMake(0.5, 0.0);
	gradientEnd = CGPointMake(0.5, 1.0);
	[self setNeedsDisplay];
}

- (void) setTopLeftRounded:(BOOL)topLeftRounded {
	_topLeftRounded = topLeftRounded;
	if (topLeftRounded) {
		cornersToRound |= UIRectCornerTopLeft;
	}
	else {
		cornersToRound &= ~(UIRectCornerTopLeft);
	}
	[self updateShapeLayer];
}

- (void) setTopRightRounded:(BOOL)topRightRounded {
	_topRightRounded = topRightRounded;
	if (topRightRounded) {
		cornersToRound |= UIRectCornerTopRight;
	}
	else {
		cornersToRound &= ~(UIRectCornerTopRight);
	}
	[self updateShapeLayer];
}

- (void) setBottomLeftRounded:(BOOL)bottomLeftRounded {
	_bottomLeftRounded = bottomLeftRounded;
	if (bottomLeftRounded) {
		cornersToRound |= UIRectCornerBottomLeft;
	}
	else {
		cornersToRound &= ~(UIRectCornerBottomLeft);
	}
	[self updateShapeLayer];
}

- (void) setBottomRightRounded:(BOOL)bottomRightRounded {
	_bottomRightRounded = bottomRightRounded;
	if (bottomRightRounded) {
		cornersToRound |= UIRectCornerBottomRight;
	}
	else {
		cornersToRound &= ~(UIRectCornerBottomRight);
	}
	[self updateShapeLayer];
}

- (void) setRadius:(CGFloat)_radius {
	radius = _radius;
	[self updateShapeLayer];
}

- (void) setBounds:(CGRect)bounds {
	[super setBounds:bounds];
	[self updateShapeLayer];
	[self updateGradient];
}

- (void) setShowGradient:(BOOL)_showGradient {
	showGradient = _showGradient;
	[self updateGradient];
}

- (void) setTopColor:(UIColor *)_topColor {
	topColor = _topColor;
	_colors = nil;
	[self updateGradient];
}

- (void) setBottomColor:(UIColor *)_bottomColor {
	bottomColor = _bottomColor;
	_colors = nil;
	[self updateGradient];
}

- (void) setMiddleColor:(UIColor *)_middleColor {
	middleColor = _middleColor;
	_colors = nil;
	[self updateGradient];
}

- (void) setGradientStart:(CGPoint)_gradientStart {
	gradientStart = _gradientStart;
	gradientLayer.startPoint = gradientStart;
	[self.layer setNeedsDisplay];
}

- (void) setGradientEnd:(CGPoint)_gradientEnd {
	gradientEnd = _gradientEnd;
	gradientLayer.endPoint = gradientEnd;
	[self.layer setNeedsDisplay];
}

- (void) setShadowColor:(UIColor *)shadowColor {
	_shadowColor = shadowColor;
	self.layer.shadowColor = shadowColor.CGColor;
	[self setNeedsDisplay];
}

- (void) setShadowOffset:(CGSize)shadowOffset {
	_shadowOffset = shadowOffset;
	self.layer.shadowOffset = shadowOffset;
	[self setNeedsDisplay];
}

- (void) setShadowRadius:(CGFloat)shadowRadius {
	_shadowRadius = shadowRadius;
	self.layer.shadowRadius = shadowRadius;
	[self setNeedsDisplay];
}

- (void) setShadowOpacity:(float)shadowOpacity {
	_shadowOpacity = shadowOpacity;
	self.layer.shadowOpacity = shadowOpacity;
	[self setNeedsDisplay];
}

- (void) setColors:(NSArray<UIColor *> *)colors {
	_colors = colors;
	topColor = nil;
	middleColor = nil;
	bottomColor = nil;
	[self updateGradient];
}


- (void) updateShapeLayer {
//	maskLayer.frame = self.bounds;
	if (_bottomRightRounded || _bottomLeftRounded || _topLeftRounded || _topRightRounded) {
		maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:cornersToRound cornerRadii:CGSizeMake(radius, radius)].CGPath;
		self.layer.mask = maskLayer;
	}
	else {
		self.layer.mask = nil;
	}
	[self.layer setNeedsDisplay];
}

- (void) updateGradient {
	gradientLayer.frame = self.bounds;
	if (showGradient && (self.colors || (topColor && bottomColor))) {
		if (gradientLayer.superlayer == nil) {
			[self.layer insertSublayer:gradientLayer atIndex:0];
		}
		if (self.colors) {
			NSMutableArray *transformed = [NSMutableArray arrayWithCapacity:self.colors.count];
			for (UIColor *color in self.colors) {
				[transformed addObject:(id)color.CGColor];
			}
			gradientLayer.colors = transformed;
		}
		else if (self.middleColor == nil) {
			gradientLayer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
		}
		else {
			gradientLayer.colors = @[(id)topColor.CGColor, (id)middleColor.CGColor, (id) bottomColor.CGColor];
		}
		[self.layer setNeedsDisplay];
	}
}

+ (NSSet *) keyPathsForValuesAffectingTopColor {
	static dispatch_once_t onceToken;
	static NSSet *paths;
	dispatch_once(&onceToken, ^{
		paths = [NSSet setWithObject:@"colors"];
	});
	return paths;
}

+ (NSSet *) keyPathsForValuesAffectingBottomColor {
	static dispatch_once_t onceToken;
	static NSSet *paths;
	dispatch_once(&onceToken, ^{
		paths = [NSSet setWithObject:@"colors"];
	});
	return paths;
}

+ (NSSet *) keyPathsForValuesAffectingMiddleColor {
	static dispatch_once_t onceToken;
	static NSSet *paths;
	dispatch_once(&onceToken, ^{
		paths = [NSSet setWithObject:@"colors"];
	});
	return paths;
}

+ (NSSet *) keyPathsForValuesAffectingColors {
	static dispatch_once_t onceToken;
	static NSSet *paths;
	dispatch_once(&onceToken, ^{
		paths = [NSSet setWithArray:@[NSStringFromSelector(@selector(topColor)), NSStringFromSelector(@selector(middleColor)), NSStringFromSelector(@selector(bottomColor))]];
	});
	return paths;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
