//
//  DetailViewController.h
//  coreData
//
//  Created by Aula Multimodal on 4/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "VistaMapa.h"

@interface DetailViewController : UIViewController<quitaVistaDelegado>

@property (strong, nonatomic) id detailItem;
@property (retain, nonatomic) MasterViewController *delegado;

@property (retain, nonatomic) IBOutlet UITextField *nombre;
@property (retain, nonatomic) IBOutlet UITextField *fecha;
@property (retain, nonatomic) IBOutlet UITextField *idPaquete;

@property BOOL editando;
@property BOOL entregado;
- (IBAction)oprimioBoton:(id)sender;
- (IBAction)oprimioMapa:(id)sender;
- (IBAction)oprimioEntrgar:(id)sender;

@property (nonatomic, retain) VistaMapa *vistaMapa;

@end
