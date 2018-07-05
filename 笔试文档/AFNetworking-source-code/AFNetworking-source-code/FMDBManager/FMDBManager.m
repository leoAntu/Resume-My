

//
//  FMDBManager.m
//  AFNetworking-source-code
//
//  Created by 叮咚钱包富银 on 2018/7/5.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDB/FMDB.h>
static FMDBManager *_shared = nil;

@implementation FMDBManager {
    NSString *_dbName;
    NSString *_dbPath;
    FMDatabaseQueue *_dbQueue;
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[FMDBManager alloc] init];
    });
    
    return _shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dbName = @"status.db"; //数据库名字
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _dbPath = [path stringByAppendingPathComponent:_dbName]; //存储位置
        NSLog(@"path--- %@",_dbPath);
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
        
        [self createTable];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [super allocWithZone:zone];
    });
    return _shared;
}

#pragma mark -- 加载数据

- (NSArray *)loadTableWithCount:(NSInteger )count {
    //SELECT... FROM ... 表示查找
    // ORDER BY  排序
    //DESC 代表降序，ASC升序
    //LIMIT 代表限制
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_status ORDER BY userId DESC LIMIT %ld;",count];
   return [self searchRecord:sql];
}

//查找
- (NSArray *)searchRecord:(NSString *)sql {
    NSMutableArray *arrM = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        //执行查询语句，查找整个表
        FMResultSet *set = [db executeQuery:sql withArgumentsInArray:@[]];
        while ([set next]) {
            NSString *userId = [set objectForColumn:@"userId"];
            NSData *data = [set objectForColumn:@"status"]; //data类型
            NSArray *newStatus = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *dic = @{@"userId": userId, @"status":newStatus};
            [arrM addObject:dic];
        }
    }];
    
    return arrM;
}

#pragma mark -- 添加或者更新表
- (void)updateTable:(NSString *)userId status:(id)status {
#warning mark --  //status如果是字符串会崩，这里不做判断了；
    NSString *sql = @"INSERT OR REPLACE INTO t_status(userId,status) VALUES(?, ?);";
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:status options:NSJSONWritingPrettyPrinted error:nil];
    //插入更新，需要更新数据库，所以需要开启事务功能，减少性能开销，使用inTransaction ，而不是inDatabase
    //里面用了一个同步线程
    [_dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if ([db executeUpdate:sql withArgumentsInArray:@[userId,data]] == false) {
            NSLog(@"插入/更新失败");
            rollback = (BOOL *)YES;
            return;
        }
    }];
}

#pragma mark -- 创建表
- (void)createTable {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"status" ofType:@"sql"];
    NSString *sql = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db executeStatements:sql] == true) {
            NSLog(@"创建成功");
        } else {
            NSLog(@"创建失败");
        }
    }];
}

@end
