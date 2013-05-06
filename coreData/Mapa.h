//
//  Mapa.h
//  proyectoFinal
//
//  Created by Luis Verduzco on 4/23/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@interface Mapa : UIViewController

@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@property CLLocationCoordinate2D ubicacionUsuario;
@property CLLocationCoordinate2D ubicacionPaquete;
@property CLLocationCoordinate2D ubicacionGuardada;

@end
