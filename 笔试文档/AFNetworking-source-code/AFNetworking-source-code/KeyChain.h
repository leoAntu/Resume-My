//
//  KeyChain.h
//  AFNetworking-source-code
//
//  Created by 叮咚钱包富银 on 2018/7/5.
//  Copyright © 2018年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

//更详细的操作使用可以参考 https://www.jianshu.com/p/3afc39f6b9a8

@interface KeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;

+ (id)readForKey:(NSString *)key;

+ (void)deleteWithService:(NSString *)service;

+ (void)addKeychainData:(id)data forKey:(NSString *)key;

+ (void)addShareKeyChainData:(id)data forKey:(NSString *)key;

+ (void)updateKeychainData:(id)data forKey:(NSString *)key;

@end
