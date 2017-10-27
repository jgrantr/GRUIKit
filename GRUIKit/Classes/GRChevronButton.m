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

@synthesize size, backgroundSize, backgroundLayerColor;

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
	[self willChangeValueForKey:@"lineColor"];
	_lineColor = lineColor;
	[self didChangeValueForKey:@"lineColor"];
	shapeLayer.strokeColor = _lineColor.CGColor;
	[shapeLayer setNeedsDisplay];
}

- (void) setLineWidth:(CGFloat)lineWidth {
	[self willChangeValueForKey:@"lineWidth"];
	_lineWidth = lineWidth;
	[self didChangeValueForKey:@"lineWidth"];
	shapeLayer.lineWidth = lineWidth;
	[shapeLayer setNeedsDisplay];
}

- (void) setSize:(CGSize)_size {
	[self willChangeValueForKey:@"size"];
	size = _size;
	[self didChangeValueForKey:@"size"];
	[self updatePath];
	[self setNeedsDisplay];
}

- (void) setDirection:(NSInteger)direction {
	[self willChangeValueForKey:@"direction"];
	if (direction >= 1 && direction <= 4) {
		_direction = direction;
	}
	else {
		_direction = GRCheveronRight;
	}
	[self didChangeValueForKey:@"direction"];
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

- (void) setBackgroundSize:(CGSize)_backgroundSize {
	[self willChangeValueForKey:@"backgroundSize"];
	backgroundSize = _backgroundSize;
	[self didChangeValueForKey:@"backgroundSize"];
	[self updateBackgroundLayer];
}

- (void) setBackgroundLayerColor:(UIColor *)_backgroundLayerColor {
	[self willChangeValueForKey:@"backgroundLayerColor"];
	backgroundLayerColor = _backgroundLayerColor;
	[self didChangeValueForKey:@"backgroundLayerColor"];
	[self updateBackgroundLayer];
}

- (void) setBorderColor:(UIColor *)borderColor {
	[self willChangeValueForKey:@"borderColor"];
	_borderColor = borderColor;
	[self didChangeValueForKey:@"borderColor"];
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

- (CAShapeLayer *) chevronLayer {
	return shapeLayer;
}

- (void) updateLayerSizes {
	shapeLayer.frame = self.bounds;
	backgroundLayer.frame = CGRectMake((self.bounds.size.width / 2.0) - (backgroundSize.width / 2.0), (self.bounds.size.height / 2.0) - (backgroundSize.height / 2.0), backgroundSize.width, backgroundSize.height);
	backgroundLayer.cornerRadius = backgroundSize.width / 2.0;
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
	shapeLayer.path = path.CGPath;
	[shapeLayer setNeedsDisplay];
}


@end
