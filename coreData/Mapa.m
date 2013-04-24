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
    ubicacionUsuario = mapView.userLocation.coordinate;
    NSLog(@"Usuario latitud:%f", ubicacionUsuario.latitude);
    NSLog(@"Usuario longitud:%f", ubicacionUsuario.longitude);
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(ubicacionUsuario, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [mapView setRegion:viewRegion animated:YES];
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

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
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
