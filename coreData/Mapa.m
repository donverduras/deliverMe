//
//  Mapa.m
//  proyectoFinal
//
//  Created by Luis Verduzco on 4/23/13.
//
//

#import "Mapa.h"
#define METERS_PER_MILE 1609.344

@interface Mapa ()

@end

@implementation Mapa
@synthesize mapView;
@synthesize ubicacionPaquete;
@synthesize ubicacionUsuario;
@synthesize ubicacionGuardada;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mapView.showsUserLocation = YES;
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
    [lpgr release];
}

-(void)viewDidAppear:(BOOL)animated{
    //Se obtiene la ubicacion del usuario y se agrega al mapa
    ubicacionUsuario = mapView.userLocation.coordinate;
    NSLog(@"Usuario latitud:%f", ubicacionUsuario.latitude);
    NSLog(@"Usuario longitud:%f", ubicacionUsuario.longitude);
    
    //Se realiza un zoom para desplegar solo una pequeña area en donde se ubica actualmente el usuario
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(ubicacionUsuario, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [mapView setRegion:viewRegion animated:YES];
    
    //Se remueven las anotaciones anteriores agregadas por otros paquetes
    NSMutableArray * annotationsToRemove = [mapView.annotations mutableCopy];
    [annotationsToRemove removeObject:mapView.userLocation];
    [mapView removeAnnotations:annotationsToRemove];
    
    //Si el paquete actualmente ya tiene una ubicacion guardada se agrega al mapa para desplegarse
    if(ubicacionGuardada.latitude != 0.0){
        MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
        annot.coordinate = ubicacionGuardada;
        [self.mapView addAnnotation:annot];
        [annot release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [mapView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}


//Este metodo reconoce cuando se mantiene presionado el mapa para establecer una nueva ubicacion de un paquete
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        //Primero se eliminan las anotaciones anteriores en caso de que existan
        NSMutableArray * annotationsToRemove = [mapView.annotations mutableCopy];
        [annotationsToRemove removeObject:mapView.userLocation];
        [mapView removeAnnotations:annotationsToRemove];
        
        //Se obtienen las coordenadas que se presionaron
        CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        //Se agrega una anotacion en el mapa con las coordenedas obtenidas
        MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
        annot.coordinate = touchMapCoordinate;
        [self.mapView addAnnotation:annot];
        [annot release];
        
        ubicacionPaquete = annot.coordinate;
        NSLog(@"Paquete latitud:%f", ubicacionPaquete.latitude);
        NSLog(@"Paquete longitud:%f", ubicacionPaquete.longitude);
    }
}

@end
