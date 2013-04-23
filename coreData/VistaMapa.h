//
//  vistaMapa.h
//  proyectoFinal
//
//  Created by Luis Verduzco on 4/15/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol quitaVistaDelegado

- (void) quitaVista : (id) sender;

@end

@interface VistaMapa : UIViewController <MKMapViewDelegate>{
    MKMapView *mapView;
}

@property (nonatomic, retain) id <quitaVistaDelegado> delegado;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end