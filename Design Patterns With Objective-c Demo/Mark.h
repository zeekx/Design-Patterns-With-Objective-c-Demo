//
//  Mark.h
//  Design Patterns With Objective-c Demo
//
//  Created by yubinqiang on 16/5/6.
//  Copyright © 2016年 Zeek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIGeometry.h>
#import <CoreGraphics/CGGeometry.h>
#import "MarkEnumerator.h"
#import "MarkVisitor.h"

@protocol Mark <NSObject, NSCopying, NSCoding>

@optional
- (NSEnumerator *)enumerator;

@required
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat size;

- (id)copy;
- (void)addMark:(id<Mark>)mark;
- (void)removeMark:(id<Mark>)mark;
- (id<Mark>)childMarkAtIndex:(NSUInteger)index;
- (void)drawWithContext:(CGContextRef)context;
- (void)accecptMarkVisitor:(id<MarkVisitor>)visitor;
@end
