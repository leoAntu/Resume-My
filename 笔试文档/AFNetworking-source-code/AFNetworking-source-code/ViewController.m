//
//  ViewController.m
//  AFNetworking-source-code
//
//  Created by 叮咚钱包富银 on 2018/4/20.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>
#import "Person.h"
#import "KeyChain.h"
#import "FMDBManager.h"

NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self archiver1];
//    [self archiver2];
//    [self plist];
//    [self plist2];
//    [self file];
//    [self file2];
//
//    [self userdefult];

//    [self appleKeyChain];
    
    [self fmdb];
}

#pragma mark -- FMDB
- (void)fmdb {
    FMDBManager *manager = [FMDBManager sharedManager];
    //插入数据
    [manager updateTable:@"1" status:@[@"sdf"]];
    [manager updateTable:@"2" status:@[@"sdf",@"gggg",@"nhhhh"]];

    NSArray *arr =[manager loadTableWithCount:1];
    NSLog(@"%@",arr);
}

#pragma mark KeyChain
- (void)appleKeyChain {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"username" forKey:KEY_USERNAME];
    [dic setObject:@"password" forKey:KEY_PASSWORD];
    [KeyChain addKeychainData:dic forKey:@"username"];
    
    //读取
    id obj = [KeyChain readForKey:@"username"];
    NSLog(@"%@",obj);
    
}
#pragma mark --- 沙盒
- (void)userdefult {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"key"];
    [[NSUserDefaults standardUserDefaults] synchronize]; //直接同步到文件
    
    NSInteger key = [[[NSUserDefaults standardUserDefaults] objectForKey:@"key"] integerValue];
    NSLog(@"%ld",key); //1
}

#pragma mark -- 写入文件
- (void)file2 {
    NSString *filePath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [filePath stringByAppendingPathComponent:@"test.text"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",arr);
//    (
//     1,
//     2,
//     3
//    )

}

- (void)file {
    NSString *filePath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [filePath stringByAppendingPathComponent:@"test.text"];
    NSLog(@"%@",path);
    
    NSArray *arr = @[@"1",@"2",@"3"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    [data writeToFile:path atomically:YES];
    
}

#pragma mark -- plist
- (void)plist {
//    [[NSBundle mainBundle]下的文件是不能修改的，只能到沙盒中的Document  、Library ，tmp  这些目录里面去
   NSString *filePath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [filePath stringByAppendingPathComponent:@"test.plist"];
    NSLog(@"%@",path); ///Users/dingdongqianbaofuyin/Library/Developer/CoreSimulator/Devices/FFBFE85D-58A2-4E67-8C4E-9F96E9449411/data/Containers/Data/Application/49B32B88-7618-4B87-8D21-D2412A60F1CA/Documents/test.plist
    
    NSArray *arr = @[@(1),@"hello",@{@"a": @"1"}];
    BOOL ret = [arr writeToFile:path atomically:YES];
    NSLog(@"%d",ret); //1
}

- (void)plist2 {
    
    NSString *filePath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [filePath stringByAppendingPathComponent:@"test.plist"];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",arr);
//    (
//     1,
//     hello,
//     {
//         a = 1;
//     }
//    )

}

#pragma mark --- 归档
- (void)archiver1 {
    //1.归档基本数据对象，NSArray NSDictionary
    NSArray *arr = @[@"1",@"2"];
//    NSDictionary *dic = @{@"a":@"1",@"b":@"2"};
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"arr.text"];
    BOOL ret = [NSKeyedArchiver archiveRootObject:arr toFile:filePath];
    NSLog(@"%d",ret); // 1
    NSLog(@"%@",filePath); ///Users/dingdongqianbaofuyin/Library/Developer/CoreSimulator/Devices/FFBFE85D-58A2-4E67-8C4E-9F96E9449411/data/Containers/Data/Application/EF71AF4E-C0E9-4301-BCF8-831EEA9EE22E/arr.text
    //解档
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",result);  //(1,2)
}

- (void)archiver2 {
    Person *p = [[Person alloc] init];
    p.name = @"xiaoming";
    p.age = 14;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"person.text"];
    BOOL ret = [NSKeyedArchiver archiveRootObject:p toFile:filePath];
    NSLog(@"%d",ret); //1
    NSLog(@"%@",filePath); // /Users/dingdongqianbaofuyin/Library/Developer/CoreSimulator/Devices/FFBFE85D-58A2-4E67-8C4E-9F96E9449411/data/Containers/Data/Application/C17C9206-8996-4944-9D30-3DC1724AB714/person.text
    //解档
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",result); //name:xiaoming --- age:14
    
}

#pragma mark -- 关于AFNetworking 和 SDWebImage,Masonry

- (void)network {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    manager.requestSerializer.timeoutInterval = 60;
    NSError *serializationError = nil;

    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:@"http://192.168.0.168:8081/system/u/submitLogin.do" parameters:@{@"name": @"123"} error:&serializationError];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"response\n %@",responseObject);

    }];
    [dataTask resume];

    NSMutableURLRequest *request1 = [manager.requestSerializer requestWithMethod:@"POST" URLString:@"http://192.168.0.168:8081/system/u/submitLo.do" parameters:@{@"name": @"123"} error:&serializationError];

    NSURLSessionDataTask *dataTask1 = [manager dataTaskWithRequest:request1 uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"response\n %@",responseObject);

    }];
    [dataTask1 resume];


    [self.imagView sd_setImageWithURL:[NSURL URLWithString:@"http://pic1.win4000.com/pic/8/a6/7107c45f4d.jpg"] placeholderImage:nil];


    UIView *subView = [[UIView alloc] init];
    subView.backgroundColor = [UIColor redColor];
    [self.view addSubview:subView];

    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(100);
        make.width.height.mas_equalTo(100);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
