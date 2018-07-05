//
//  Person.h
//  AFNetworking-source-code
//
//  Created by 叮咚钱包富银 on 2018/7/5.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end
