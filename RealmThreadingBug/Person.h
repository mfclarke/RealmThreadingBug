//
//  CustomRealmObject.h
//  
//
//  Created by Maximilian Clarke on 1/07/2015.
//
//

#import "RLMObject.h"
#import "RLMArray.h"
#import "Dog.h"

@interface Person : RLMObject

@property NSString *identifier;
@property RLMArray <Dog> *dogs;

@end
