//
//  vistaMapa.h
//  proyectoFinal
//
//  Created by Luis Verduzco on 4/15/13.
//
//

#import <UIKit/UIKit.h>

@protocol quitaVistaDelegado

- (void) quitaVista : (id) sender;

@end

@interface VistaMapa : UIViewController

@property (nonatomic, retain) id <quitaVistaDelegado> delegado;

@end
