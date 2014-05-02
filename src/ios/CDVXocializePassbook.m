//
//  CDVXocializePassbook.m
//  Xocialize
//
//  Created by Dustin Nielson on 1/4/14.
//
//


#import "CDVXocializePassbook.h"


@implementation CDVXocializePassbook

- (void) cordovaGetPasses:(CDVInvokedUrlCommand *)command {
    
   
    
    passLib = [[PKPassLibrary alloc] init];
    
    if (![PKPassLibrary isPassLibraryAvailable])
    {
        /* Pass Library Didn't load let the app know there is no pass library */
        
        return;
    }
    
    _passes = [passLib passes];
    
    CDVPluginResult *pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsMultipart:_passes];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    

}



- (void) cordovaAddPass:(CDVInvokedUrlCommand *)command {

        __block CDVPluginResult* pluginResult = nil;
            
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString* passedUrl = [command.arguments objectAtIndex:0];
            
            NSURL *url = [NSURL URLWithString:passedUrl];
            
            NSError *error = nil;
            NSData *image = [NSData dataWithContentsOfURL:url options:0 error:&error];
            if(!error && image && [image length] > 0) {
                
                //init a pass object with the data
                PKPass *pass = [[PKPass alloc] initWithData:image error:&error];
                if(error) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
                    [alertView show];
                    
                } else {
                
                    passLib = [[PKPassLibrary alloc] init];
                
                    if([passLib containsPass:pass]) {
                    
                        [passLib replacePassWithPass:pass];
                        //pass already exists in library, show an error message
                        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Pass Exists" message:@"Updated Existing Pass." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alertView show];
                    
                    } else {
                    
                        //present view controller to add the pass to the library
                        PKAddPassesViewController *vc = [[PKAddPassesViewController alloc] initWithPass:pass];
                        if( vc==nil){
                            
                            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Pass Issue" message:@"Unable to process pass." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alertView show];
                        
                        } else {
                            [vc setDelegate:(id)self];
                            [self.viewController presentViewController:vc animated:YES completion:nil];
                        }
                    }
                }
                pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:passedUrl];
                
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            
            } else {
            
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
                [alertView show];
            
            };
        });
}

- (void) cordovaGetBC:(CDVInvokedUrlCommand *)command {
    
    
    
    passLib = [[PKPassLibrary alloc] init];
    
    if (![PKPassLibrary isPassLibraryAvailable])
    {
        /* Pass Library Didn't load let the app know there is no pass library */
        
        return;
    }
    
    _passes = [passLib passes];
    
    CDVPluginResult *pluginResult=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsMultipart:_passes];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    
}


@end
