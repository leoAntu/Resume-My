//
//  ViewController.m
//  Method-Swizzling
//
//  Created by leo on 2018/7/3.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    SEL originSEL = @selector(open);
    SEL swizzlSEL = @selector(close);
    
    Method originMethod = class_getInstanceMethod([self class], originSEL);
    Method swizzlMethod = class_getInstanceMethod([self class], swizzlSEL);

    //class_addMethod向class中添加对应方法名和方法实现。如果该class（不包含父类）已含有该方法名，则返回NO。
    BOOL ret = class_addMethod([self class], originSEL, method_getImplementation(swizzlMethod), method_getTypeEncoding(swizzlMethod));
    if (ret) {
        class_replaceMethod([self class],
                            swizzlSEL,
                            method_getImplementation(swizzlMethod),
                            method_getTypeEncoding(swizzlMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzlMethod);
    }
    
    [self performSelector:originSEL];
}

- (void)open {
    NSLog(@"open");
}

- (void)close {
    [self close];
    NSLog(@"close");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
