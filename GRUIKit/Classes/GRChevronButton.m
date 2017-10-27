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
}

- (void) commonInit;
- (void) updatePath;

@end

@implementation GRChevronButton

@synthesize size;

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
}

- (void) setBounds:(CGRect)bounds {
	[super setBounds:bounds];
	shapeLayer.frame = self.bounds;
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

- (CAShapeLayer *) chevronLayer {
	return shapeLayer;
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
