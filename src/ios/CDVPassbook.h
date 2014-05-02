//
//  CDVPassbook.h
//  Xocialize
//
//  Created by Dustin Nielson on 1/4/14.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>
#import "PassKit/PassKit.h"

//@class CDVPassbookViewController;

@class UIViewController;

@interface CDVPassbook : CDVPlugin <UIViewControllerAnimatedTransitioning>{
     NSArray *_passes;
     NSString *yourUrl;
     PKPassLibrary *passLib;
     //UIViewController *presentViewController;
    
}



- (void) cordovaGetPasses:(CDVInvokedUrlCommand *)command;

- (void) cordovaAddPass:(CDVInvokedUrlCommand *)command;

- (void) cordovaGetBC:(CDVInvokedUrlCommand *)command;

@end

