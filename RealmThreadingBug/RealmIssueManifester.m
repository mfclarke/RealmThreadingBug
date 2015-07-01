//
//  RealmBugManifester.m
//  
//
//  Created by Maximilian Clarke on 1/07/2015.
//
//

#import "RealmIssueManifester.h"
#import "Realm.h"
#import "Person.h"
#import "Dog.h"

@implementation RealmIssueManifester

+ (dispatch_queue_t)testQueue
{
    static dispatch_queue_t sharedQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedQueue = dispatch_queue_create("TestQueue", NULL);
    });
    return sharedQueue;
}

+ (void)manifestIssueUsingKey:(NSString *)key imageData:(NSData *)imageData
{
    dispatch_async([RealmIssueManifester testQueue], ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        Person *person = [Person objectForPrimaryKey:key];
        
        [realm beginWriteTransaction];
        Dog *dog = [[Dog alloc] init];
        dog.imageData = imageData;
        [person.dogs addObject:dog];
        [[RLMRealm defaultRealm] addObject:dog];
        [realm commitWriteTransaction];
        
        // Check the person has a dog on the current thread
        person = [Person objectForPrimaryKey:key];
        NSAssert([person.dogs count] > 0, @"");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Check the person has a dog on the main thread
            Person *mainThreadPerson = [Person objectForPrimaryKey:key];
            NSAssert([mainThreadPerson.dogs count] > 0, @"");
        });
    });
}
@end
