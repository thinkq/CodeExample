//
//  Person.m
//  NSPredicateDemo
//
//  Created by 赵清 on 2016/11/13.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}


@end
