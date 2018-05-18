//
//  GPChevronButton.m
//  GRToolkit
//
//  Created by Grant Robinson on 5/19/15.
//  Copyright (c) 2015 Grant Robinson. All rights reserved.
//

#import "GRChevronButton.h"

@interface GRChevronButton () {
	UIBezierPath *path;
	CAShapeLayer *shapeLayer;
	CALayer *backgroundLayer;
}

- (void) commonInit;
- (void) updatePath;

@end

@implementation GRChevronButton

@synthesize size, backgroundSize, backgroundLayerColor, closePath;

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) init {
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void) commonInit {
	self.clipsToBounds = YES;
	[self setNeedsDisplay];
	shapeLayer = [CAShapeLayer layer];
	shapeLayer.frame = self.bounds;
	shapeLayer.fillColor = [UIColor clearColor].CGColor;
	shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
	[self.layer addSublayer:shapeLayer];
	backgroundLayer = nil;
	backgroundLayerColor = nil;
	backgroundSize = CGSizeZero;
}

- (void) setBounds:(CGRect)bounds {
	[super setBounds:bounds];
	[self updateLayerSizes];
}

- (void) setFrame:(CGRect)frame {
	[super setFrame:frame];
	[self updateLayerSizes];
}

- (void) setLineColor:(UIColor *)lineColor {
	_lineColor = lineColor;
	shapeLayer.strokeColor = _lineColor.CGColor;
	[shapeLayer setNeedsDisplay];
}

- (void) setLineWidth:(CGFloat)lineWidth {
	_lineWidth = lineWidth;
	shapeLayer.lineWidth = lineWidth;
	[shapeLayer setNeedsDisplay];
}

- (void) setSize:(CGSize)_size {
	size = _size;
	[self updatePath];
	[self setNeedsDisplay];
}

- (void) setDirection:(NSInteger)direction {
	if (direction >= 1 && direction <= 4) {
		_direction = direction;
	}
	else {
		_direction = GRCheveronRight;
	}
	[self updatePath];
	[self setNeedsDisplay];
}

- (void) setCornerRadius:(CGFloat)cornerRadius {
	[self willChangeValueForKey:@"cornerRadius"];
	self.layer.cornerRadius = cornerRadius;
	[self didChangeValueForKey:@"cornerRadius"];
	[self setNeedsDisplay];
}

- (CGFloat) cornerRadius {
	return self.layer.cornerRadius;
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

- (void) setBackgroundSize:(CGSize)_backgroundSize {
	backgroundSize = _backgroundSize;
	[self updateBackgroundLayer];
}

- (void) setBackgroundLayerColor:(UIColor *)_backgroundLayerColor {
	backgroundLayerColor = _backgroundLayerColor;
	[self updateBackgroundLayer];
}

- (void) setBorderColor:(UIColor *)borderColor {
	_borderColor = borderColor;
	self.layer.borderColor = borderColor.CGColor;
}

- (void) setBorderWidth:(CGFloat)borderWidth {
	[self willChangeValueForKey:@"borderWidth"];
	self.layer.borderWidth = borderWidth;
	[self didChangeValueForKey:@"borderWidth"];
}

- (CGFloat) borderWidth {
	return self.layer.borderWidth;
}

- (void) setClosePath:(BOOL)_closePath {
	closePath = _closePath;
	if (closePath) {
		shapeLayer.fillColor = self.lineColor.CGColor;
	}
	else {
		shapeLayer.fillColor = [UIColor clearColor].CGColor;
	}
}

- (CAShapeLayer *) chevronLayer {
	return shapeLayer;
}

- (void) updateLayerSizes {
	shapeLayer.frame = self.bounds;
	backgroundLayer.frame = CGRectMake((self.bounds.size.width / 2.0) - (backgroundSize.width / 2.0), (self.bounds.size.height / 2.0) - (backgroundSize.height / 2.0), backgroundSize.width, backgroundSize.height);
	backgroundLayer.cornerRadius = backgroundSize.width / 2.0;
	[self setNeedsDisplay];
}

- (void) updateBackgroundLayer {
	if (backgroundLayerColor && !CGSizeEqualToSize(backgroundSize, CGSizeZero)) {
		if (!backgroundLayer) {
			backgroundLayer = [CALayer layer];
			backgroundLayer.masksToBounds = YES;
			[self.layer insertSublayer:backgroundLayer below:shapeLayer];
		}
		backgroundLayer.frame = CGRectMake((self.bounds.size.width / 2.0) - (backgroundSize.width / 2.0), (self.bounds.size.height / 2.0) - (backgroundSize.height / 2.0), backgroundSize.width, backgroundSize.height);
		backgroundLayer.cornerRadius = backgroundSize.width / 2.0;
		backgroundLayer.backgroundColor = backgroundLayerColor.CGColor;
		[self setNeedsDisplay];
	}
}

- (void) updatePath {
	path = [UIBezierPath bezierPath];
	GRChevronDirection direction = self.direction;
	CGRect rect = self.bounds;
	CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
	switch (direction) {
		case GRCheveronRight:
			[path moveToPoint:CGPointMake(center.x - (size.width / 2.0), center.y - (size.height / 2.0))];
			[path addLineToPoint:CGPointMake(center.x + (size.width / 2.0), center.y)];
			[path addLineToPoint:CGPointMake(center.x - (size.width / 2.0), center.y + (size.height /2.0))];
			break;
		case GRChevronLeft:
			[path moveToPoint:CGPointMake(center.x + (size.width / 2.0), center.y - (size.height / 2.0))];
			[path addLineToPoint:CGPointMake(center.x - (size.width / 2.0), center.y)];
			[path addLineToPoint:CGPointMake(center.x + (size.width / 2.0), center.y + (size.height / 2.0))];
			break;
		case GRChevronUp:
			[path moveToPoint:CGPointMake(center.x - (size.width / 2.0), center.y + (size.height / 2.0))];
			[path addLineToPoint:CGPointMake(center.x, center.y - (size.height / 2.0))];
			[path addLineToPoint:CGPointMake(center.x + (size.width / 2.0), center.y + (size.height / 2.0))];
			break;
		case GRChevronDown:
			[path moveToPoint:CGPointMake(center.x - (size.width / 2.0), center.y - (size.height / 2.0))];
			[path addLineToPoint:CGPointMake(center.x, center.y + (size.height / 2.0))];
			[path addLineToPoint:CGPointMake(center.x + (size.width / 2.0), center.y - (size.height / 2.0))];
			break;
	}
	if (self.closePath) {
		[path closePath];
	}
	shapeLayer.path = path.CGPath;
	[shapeLayer setNeedsDisplay];
}


@end
