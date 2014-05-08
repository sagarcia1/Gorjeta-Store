//
//  CLSAppDelegate.h
//  gorjeta
//
//  Created by Celo on 17/12/13.
//  Copyright (c) 2013 Celo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;




@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
