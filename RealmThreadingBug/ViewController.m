//
//  ViewController.m
//  RealmThreadingBug
//
//  Created by Maximilian Clarke on 1/07/2015.
//  Copyright (c) 2015 VIMN. All rights reserved.
//

#import "ViewController.h"
#import "RealmBugManifester.h"
#import "CustomRealmObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int counter = 0;
    while (counter < 100) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        CustomRealmObject *object = [[CustomRealmObject alloc] init];
        object.customKey = [[NSUUID UUID] UUIDString];
        [[RLMRealm defaultRealm] addObject:object];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        counter++;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (CustomRealmObject *object in [CustomRealmObject allObjects]) {
        UIImage *anImage = [UIImage imageNamed:@"an_image.png"];
        [RealmBugManifester manifestBugForKey:object.customKey imageData:UIImagePNGRepresentation(anImage)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
