//
//  Mapa.m
//  proyectoFinal
//
//  Created by Luis Verduzco on 4/23/13.
//
//

#import "Mapa.h"

@interface Mapa ()

@end

@implementation Mapa
@synthesize mapView;

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
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
    [lpgr release];
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
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:annot];
    [annot release];
    
    CLLocationCoordinate2D usuario = mapView.userLocation.coordinate;
    CLLocationCoordinate2D paquete = annot.coordinate;
    int epsilon = .00000010;
    
    NSLog(@"Usuario latitud:%f", usuario.latitude);
    NSLog(@"Usuario longitud:%f", usuario.longitude);
    NSLog(@"Paquete latitud:%f", paquete.latitude);
    NSLog(@"Paquete longitud:%f", paquete.longitude);
    
    if((fabs(usuario.latitude - paquete.latitude) <= epsilon && fabs(usuario.longitude - paquete.longitude) <= epsilon)){
        NSLog(@"SI");
    }
    
}

@end
