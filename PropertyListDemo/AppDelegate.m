//
//  AppDelegate.m
//  PropertyListDemo
//
//  Created by Ronald Hernandez on 10/4/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    NSString *pListPath = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"plist"];

    NSData * plistData = [[NSFileManager defaultManager] contentsAtPath:pListPath];

    NSError *error;
    NSArray *books = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:nil error:&error];

    if (books) {

        NSDictionary *book = [books firstObject];

        NSString *title = book[@"Title"];
        NSNumber *pageCount = book[@"Page Count"];

        NSDate *pubDate = book[@"Publication Date"];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

        [dateFormatter setDateFormat:@"MMM d, yyyy"];

        NSNumber *isAwesome = book[@"Is Awesome"];

        NSData *thumbNailData = book[@"ThumbNail"];

        UIImage * thumbNail = [UIImage imageWithData:thumbNailData];

        NSLog(@"%@", title);
        NSLog(@"%@", pageCount);
        NSLog(@"%@", pubDate);



        NSMutableDictionary *anotherBook = [[NSMutableDictionary alloc] init];

        NSError *anotherError;

        anotherBook[@"Title"] = @"Earning Medals";
        anotherBook[@"Publication Date"] = pubDate;
        anotherBook[@"Page Count"] = @(198);
        UIImage *image = [UIImage imageNamed:@"silverSocial"];
        anotherBook[@"ThumbNail"] = UIImagePNGRepresentation(image);
        NSArray *morebooks = @[book, anotherBook];

        NSData *serializedData = [NSPropertyListSerialization dataWithPropertyList:morebooks format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];


        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documents = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&anotherError];

        documents = [documents URLByAppendingPathComponent:@"more_books.plist"];
        BOOL success = [serializedData writeToURL:documents atomically:YES];

        if (success) {
            NSLog(@"Wrote to disk");

        }else{
            NSLog(@"baddd");
        }


    }

    return YES;
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
