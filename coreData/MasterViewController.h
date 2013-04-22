//
//  MasterViewController.h
//  coreData
//
//  Created by Aula Multimodal on 4/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) NSManagedObject *selectedObject;

- (void) agregaObjeto;
- (void)modifyObject: (NSString *) nombre conFecha: (NSDate *) fecha conID: (NSString *) idPaquete;
- (void)insertNewObject: (NSString *) nombre conFecha: (NSDate *) fecha conID: (NSString *) idPaquete;

@end
