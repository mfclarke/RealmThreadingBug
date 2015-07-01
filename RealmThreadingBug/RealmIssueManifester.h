//
//  RealmBugManifester.h
//  
//
//  Created by Maximilian Clarke on 1/07/2015.
//
//

#import <Foundation/Foundation.h>

@interface RealmIssueManifester : NSObject

+ (void)manifestIssueUsingKey:(NSString *)key imageData:(NSData *)imageData;

@end
