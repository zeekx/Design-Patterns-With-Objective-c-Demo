//
//  ScribbleMemento.m
//  Design Patterns With Objective-c Demo
//
//  Created by yubinqiang on 16/6/23.
//  Copyright © 2016年 Zeek. All rights reserved.
//

#import "ScribbleMemento.h"
#import "ScribbleMemento+Friend.h"
#import "Mark.h"

@interface ScribbleMemento () {
    @private
    id<Mark> _mark;
    BOOL _completedSnapshot;
}

@end

@implementation ScribbleMemento

+ (ScribbleMemento *)mementoWithData:(NSData *)data {
    id<Mark> restoreMark = (id<Mark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    ScribbleMemento *memento = [[ScribbleMemento alloc] initWithMark:restoreMark];
    return memento;
}

- (NSData *)data {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.mark];
    return data;
}


#pragma mark - Friend
- (void)setMark:(id<Mark>)mark {
    _mark = mark;
}

- (id<Mark>)mark {
    return _mark;
}

- (BOOL)isCompletedSnapshot {
    return _completedSnapshot;
}

- (void)setCompletedSnapshot:(BOOL)completedSnapshot {
    _completedSnapshot = completedSnapshot;
}

- (instancetype)initWithMark:(id<Mark>)mark {
    self = [super init];
    if (self) {
        self.mark = mark;
    }
    return self;
}
@end
