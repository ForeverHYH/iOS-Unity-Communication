//
//  MyDataManager.m
//  Unity-iPhone
//
//  Created by Forever.H on 15/12/23.
//
//

#import "MyDataManager.h"
//#import "UnitySubAppDelegate.h"

@implementation MyDataManager

+ (MyDataManager*) sharedManager
{
    static MyDataManager *ManagerInstace = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        ManagerInstace = [[self alloc]init];
    });
    return ManagerInstace;
}

@end
