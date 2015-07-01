//
//  CustomRealmObject.h
//  
//
//  Created by Maximilian Clarke on 1/07/2015.
//
//

#import "RLMObject.h"
#import "RLMArray.h"
#import "CustomChildRealmObject.h"

@interface CustomRealmObject : RLMObject

@property NSString *customKey;
@property RLMArray <CustomChildRealmObject> *customChildren;

@end
