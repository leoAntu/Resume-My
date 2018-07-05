//
//  FMDBManager.h
//  AFNetworking-source-code
//
//  Created by 叮咚钱包富银 on 2018/7/5.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject
+ (instancetype)sharedManager;

- (void)updateTable:(NSString *)userId status:(id)status;

//count 表示需要加载的数量
- (NSArray *)loadTableWithCount:(NSInteger )count;
@end
