//
//  ViewController.m
//  RealmThreadingBug
//
//  Created by Maximilian Clarke on 1/07/2015.
//  Copyright (c) 2015 VIMN. All rights reserved.
//

#import "ViewController.h"
#import "RealmIssueManifester.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTestObjects];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self manifestRealmIssue];
}

- (void)createTestObjects
{
    for (int counter=0; counter < 100; counter++)
    {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        Person *object = [[Person alloc] init];
        object.identifier = [[NSUUID UUID] UUIDString];
        [[RLMRealm defaultRealm] addObject:object];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        counter++;
    }
}

- (void)manifestRealmIssue
{
    for (Person *person in [Person allObjects])
    {
        UIImage *anImage = [UIImage imageNamed:@"an_image.png"];
        [RealmIssueManifester manifestIssueUsingKey:person.identifier imageData:UIImagePNGRepresentation(anImage)];
    }
}

@end
