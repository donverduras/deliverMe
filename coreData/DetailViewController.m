//
//  DetailViewController.m
//  coreData
//
//  Created by Aula Multimodal on 4/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "EntidadDatos.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize nombre = _nombre;
@synthesize fecha = _fecha;
@synthesize idPaquete = _idPaquete;
@synthesize entregado = _entregado;
@synthesize editando;
@synthesize delegado;

- (void)dealloc
{
    [_detailItem release];
    [_nombre release];
    [_fecha release];
    [_idPaquete release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        EntidadDatos *objeto = (EntidadDatos *) self.detailItem;
        self.nombre.text = [objeto nombre];
        self.fecha.text = [objeto.timeStamp description];
        self.editando = YES;
    } 
    else
    {
        self.nombre.text = @"";
        self.fecha.text = [[NSDate date] description];
        self.editando = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setNombre:nil];
    [self setFecha:nil];
    [self setIdPaquete:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
- (IBAction)oprimioBoton:(id)sender {
    if(editando){
        [self.delegado modifyObject: self.nombre.text conFecha: [NSDate date] conID: self.idPaquete.text ];
    }
    else
    {
        [self.delegado insertNewObject: self.nombre.text conFecha: [NSDate date] conID: self.idPaquete.text];
        editando = YES;
    }
}

- (IBAction)oprimioMapa:(id)sender {
    if(!self.vistaMapa){
        self.vistaMapa = [[[VistaMapa alloc] initWithNibName:@"VistaMapa" bundle:nil] autorelease];
    }
    
    [self.vistaMapa setDelegado:self];
    
    [self.vistaMapa setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:_vistaMapa animated:YES completion: NULL];
}

- (IBAction)oprimioEntrgar:(id)sender {
    self.entregado = YES;
    [self.delegado eliminarObjeto: self.idPaquete.text];
}

- (void) quitaVista:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
