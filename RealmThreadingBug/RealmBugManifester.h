//
//  RealmBugManifester.h
//  
//
//  Created by Maximilian Clarke on 1/07/2015.
//
//

#import <Foundation/Foundation.h>

@interface RealmBugManifester : NSObject

+ (void)manifestBugForKey:(NSString *)key imageData:(NSData *)imageData;

@end
