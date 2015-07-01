//
//  AppDelegate.m
//  Logic_Task
//
//  Created by Владислав Станишевский on 7/1/15.
//  Copyright (c) 2015 Vlad Stanishevskij. All rights reserved.
//

#import "AppDelegate.h"

static long limit = 100000000;
static long summ = 0;

@interface AppDelegate ()

{
    NSArray* array;
    NSMutableArray* fArray;
    NSMutableArray* sArray;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    array = [NSMutableArray arrayWithObjects:
             @18897109, @12828837, @9461105, @6371773, @5965343, @5946800, @5582170,@5564635, @5268860, @4552402,
             @4335391, @4296250, @4224851, @4192887, @3439809, @3279833, @3095313, @2812896, @2783243, @2710489,
             @2543482, @2356285, @2226009, @2149127, @2142508, @2134411,nil];
    
    //[self firstAlgorithm];
    [self secondAlgorithm];
    
    return YES;
}

- (void)firstAlgorithm {                                // Сложность алгоритма = O(N)
                                                        // Время выполнения ~ 0.00026 second
    long answer = 0;                                    // Реализация ~ 20 min
    
    NSArray* sortArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber* a = (NSNumber *)obj1;
        NSNumber* b = (NSNumber *)obj2;
        
        return ![a compare:b];
    }];
    
    for (NSNumber* number in sortArray) {
        
        if (answer <= limit && [number integerValue] <= (limit - answer)) {
            
            answer += [number integerValue];
        }
    }
    
    NSLog(@"%ld", answer);
    
}

- (void)secondAlgorithm {                               // Сложность алгоритма = O((N/2)^3)
                                                        // Время выполнения ~ 0.002197 second
    NSMutableArray* firstArray = [NSMutableArray array];// Реализация ~ 1h
    NSMutableArray* secondArray = [NSMutableArray array];

    
    for (long i = 0; i < array.count/2; i++) {
        
        [firstArray addObject:[array objectAtIndex:i]];
    }
    
    for (long i = array.count/2; i < array.count; i++) {
        
        [secondArray addObject:[array objectAtIndex:i]];
    }
    
    NSArray* fisrtSortArray = [firstArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber* a = (NSNumber *)obj1;
        NSNumber* b = (NSNumber *)obj2;
        
        return ![a compare:b];
        
    }];
    
    NSArray* secondSortArray = [secondArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber* a = (NSNumber *)obj1;
        NSNumber* b = (NSNumber *)obj2;
        
        return [a compare:b];
        
    }];
    
    fArray = [NSMutableArray array];
    sArray = [NSMutableArray array];

    [fArray addObjectsFromArray:fisrtSortArray];
    [sArray addObjectsFromArray:secondSortArray];
    
    [self recursion];
    
}

- (void)recursion {
    
    long i, j, x = 0, y = 0;
    
    for (i = 0; i < sArray.count; i ++) {
        
        for (j = 0; j < fArray.count; j ++) {
            
            long s = [sArray[j] integerValue] + [fArray[i] integerValue];
            
            if (s < limit && s <= (limit - summ)) {
                
                summ += [sArray[j] integerValue];
                summ += [fArray[i] integerValue];
                
                x = i;
                y = j;
                
                j = fArray.count;
            }
        }
        
        i = sArray.count;
    }
    
    if (fArray.count < 1 || sArray.count < 1) {
        
        NSLog(@"%ld", summ);
        
    } else {
        
        NSLog(@"X - %ld, Y - %ld\n",x, y);
        
        [fArray removeObject:fArray[x]];
        [sArray removeObject:sArray[y]];
        
        [self recursion];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
