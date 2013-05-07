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
@synthesize latitud = _latitud;
@synthesize longitud = _longitud;
@synthesize editando;
@synthesize delegado;
@synthesize vistaMapa;
@synthesize scroller;

- (void)dealloc
{
    [_detailItem release];
    [_nombre release];
    [_fecha release];
    [_idPaquete release];
    [_latitud release];
    [_longitud release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    //if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        EntidadDatos *objeto = (EntidadDatos *) self.detailItem;
        self.nombre.text = [objeto nombre];
        self.fecha.text = [objeto.timeStamp description];
        self.idPaquete.text = [objeto idPaquete];
        self.latitud.text = [[objeto latitud] stringValue];
        self.longitud.text = [[objeto longitud] stringValue];
        self.editando = YES;
    } 
    else
    {
        self.nombre.text = @"";
        self.fecha.text = [[NSDate date] description];
        self.idPaquete.text = @"";
        self.longitud.text = @"";
        self.latitud.text = @"";
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
	//Configuracion necesaria para cargar el scrollview correctamente
    CGSize scrollableSize = CGSizeMake(320, 300);
    [scroller setScrollEnabled:YES];
    [scroller setContentSize: scrollableSize];
    [scroller setShowsVerticalScrollIndicator:YES];
    [scroller setContentOffset:CGPointMake(0, 0) animated: YES];
    scroller.hidden = NO;
    [self configureView];
}

- (void)viewDidUnload
{
    [self setNombre:nil];
    [self setFecha:nil];
    [self setIdPaquete:nil];
    [self setLatitud:nil];
    [self setLongitud:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Cuando se agrega una anotacion en el mapa se cambian los datos de los campos de texto de longitud y latitud
    if(self.vistaMapa.ubicacionPaquete.latitude != 0.0){
        self.latitud.text = [NSString stringWithFormat:@"%f", self.vistaMapa.ubicacionPaquete.latitude];
        self.longitud.text = [NSString stringWithFormat:@"%f", self.vistaMapa.ubicacionPaquete.longitude];
        CLLocationCoordinate2D temp = self.vistaMapa.ubicacionPaquete;
        temp.latitude = 0.0;
        temp.longitude = 0.0;
        self.vistaMapa.ubicacionPaquete = temp;
    }
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
        self.title = NSLocalizedString(@"Paquete", @"Paquete");
    }
    return self;
}

//Metodo que se encarga de mandar llamar el metodo para guardar los datos del detail view
- (IBAction)oprimioBoton:(id)sender {
    if(editando){
        [self.delegado modifyObject: self.nombre.text conFecha:[NSDate date] conID: self.idPaquete.text conLatitud: [self.latitud.text doubleValue] conLongitud: [self.longitud.text doubleValue] entregado:@"Pendiente"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.delegado insertNewObject: self.nombre.text conFecha: [NSDate date] conID: self.idPaquete.text conLatitud: [self.latitud.text doubleValue] conLongitud: [self.longitud.text doubleValue] entregado:@"Pendiente"];
        [self.navigationController popViewControllerAnimated:YES];
        editando = YES;
    }
}

//Metodo que reconoce cuando se presiona el boton de mapa y manda llamar a la vista y manda los datos necesarios
- (IBAction)oprimioMapa:(id)sender {
    if(!self.vistaMapa){
        self.vistaMapa = [[[Mapa alloc] initWithNibName:@"Mapa" bundle:nil] autorelease];
    }
    
    [self.vistaMapa setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self.navigationController pushViewController:self.vistaMapa animated:YES];
    
    if(self.latitud.text != NULL){
        CLLocationCoordinate2D temp;
        temp.latitude = [self.latitud.text doubleValue];
        temp.longitude = [self.longitud.text doubleValue];
        vistaMapa.ubicacionGuardada = temp;
    }
}

//Metodo para marcar el paquete como entregado revisando que la ubicacion actual y la del paquete esten dentro de los parametros aceptados
- (IBAction)oprimioEntrgar:(id)sender {
    self.entregado = @"Entregado";
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLLocationCoordinate2D ubicacionActual = appDelegate.ubicacionActual;
    
    //Se declaran las latitudes y longitudes tanto del usuario como del paquete, ademas se declara el grado de tolerancia para marcar un paquete como entregado
    double epsilon = 0.01;
    double latitudUsuario = ubicacionActual.latitude;
    double longitudUsuario = ubicacionActual.longitude;
    double longitudPaquete = [self.longitud.text doubleValue];
    double latitudPaquete = [self.latitud.text doubleValue];
    
    //Se realizan las operaciones necesarias para ver si se encuentra dentro del rango permitido, si se cumple se marca como entregado y si no se manda una alerta para avisar al usuario
    if(fabs(latitudUsuario - latitudPaquete) <= epsilon && fabs(longitudUsuario - longitudPaquete) <= epsilon){
        [self.delegado modifyObject: self.nombre.text conFecha: [NSDate date] conID: self.idPaquete.text conLatitud: [self.latitud.text doubleValue] conLongitud: [self.longitud.text doubleValue] entregado: @"Entregado"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Estas muy lejos de la ubicacion de entrega del paquete." message:@"Acercate mas a la ubicacion señalada" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
        [alert show];
        [alert release];
    }
}

//Metodo que se encarga de quitar la vista del mapa 
- (void) quitaVista:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


//Metodo que se encarga de quitar el teclado cuando se le da click al boton de return 
- (IBAction)quitaTecla:(id)sender {
     [self.nombre resignFirstResponder];
}
@end
