//
//  Person.m
//  AFNetworking-source-code
//
//  Created by 叮咚钱包富银 on 2018/7/5.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@ --- age:%ld",self.name,self.age];
}

@end
