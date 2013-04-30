//
//  EntidadDatos.h
//  coreData
//
//  Created by Aula Multimodal on 4/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface EntidadDatos : NSObject

@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *idPaquete;
@property (nonatomic, retain) NSDate *timeStamp;
@property (nonatomic, retain) NSNumber *latitud;
@property (nonatomic, retain) NSNumber *longitud;
@property CLLocationCoordinate2D ubicacionPaquete;

@end
