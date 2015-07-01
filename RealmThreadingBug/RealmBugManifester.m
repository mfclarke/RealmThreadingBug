//
//  RealmBugManifester.m
//  
//
//  Created by Maximilian Clarke on 1/07/2015.
//
//

#import "RealmBugManifester.h"
#import "Realm.h"
#import "CustomRealmObject.h"
#import "CustomChildRealmObject.h"

@implementation RealmBugManifester

+ (dispatch_queue_t)testQueue
{
    static dispatch_queue_t sharedQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedQueue = dispatch_queue_create("TestQueue", NULL);
    });
    return sharedQueue;
}

+ (void)manifestBugForKey:(NSString *)key imageData:(NSData *)imageData
{
    NSLog(@"mainfesting...");
    dispatch_async([RealmBugManifester testQueue], ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm beginWriteTransaction];
        CustomRealmObject *customObject = [CustomRealmObject objectForPrimaryKey:key];
        
        CustomChildRealmObject *childObject = [[CustomChildRealmObject alloc] init];
        childObject.imageData = imageData;
        [customObject.customChildren addObject:childObject];
        [[RLMRealm defaultRealm] addObject:childObject];
        [realm commitWriteTransaction];
        
        customObject = [CustomRealmObject objectForPrimaryKey:key];
        NSAssert([customObject.customChildren count] > 0, @"");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CustomRealmObject *mainQueueCustomObject = [CustomRealmObject objectForPrimaryKey:key];
            NSAssert([mainQueueCustomObject.customChildren count] > 0, @"");
        });
    });
}
@end
