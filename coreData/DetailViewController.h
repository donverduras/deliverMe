//
//  DetailViewController.h
//  coreData
//
//  Created by Aula Multimodal on 4/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "Mapa.h"
#import "AppDelegate.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (retain, nonatomic) MasterViewController *delegado;

@property (retain, nonatomic) IBOutlet UITextField *nombre;
@property (retain, nonatomic) IBOutlet UITextField *fecha;
@property (retain, nonatomic) IBOutlet UITextField *idPaquete;
@property (retain, nonatomic) IBOutlet UIScrollView *scroller;
@property (retain, nonatomic) IBOutlet UITextField *latitud;
@property (retain, nonatomic) IBOutlet UITextField *longitud;

@property BOOL editando;
@property (nonatomic, retain) NSString *entregado;
- (IBAction)oprimioBoton:(id)sender;
- (IBAction)oprimioMapa:(id)sender;
- (IBAction)oprimioEntrgar:(id)sender;
- (IBAction)quitaTecla:(id)sender;

@property (nonatomic, retain) Mapa *vistaMapa;

@end
