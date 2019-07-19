#import "SupremeHandlerPlugin.h"

@implementation SupremeHandlerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"supreme_handler"
                                     binaryMessenger:[registrar messenger]];
    SupremeHandlerPlugin* instance = [[SupremeHandlerPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"clearCookies" isEqualToString:call.method]) {
        [self clearCookiesIos9AndLater:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)clearCookiesIos9AndLater:(FlutterResult)result {
    if (@available(iOS 9.0, *)) {
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             int counter = 0;
                             for (WKWebsiteDataRecord *record  in records)
                             {
                                 if ( [record.displayName containsString:@"supreme"])
                                 {
                                counter++;
                                     @synchronized (self) {
                                         [[WKWebsiteDataStore defaultDataStore]
                                          removeDataOfTypes:record.dataTypes
                                          forDataRecords:@[record]
                                          completionHandler:^{
                                              NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                              result(@(YES));
                                          }];
                                     }
                                 }
                             }
                             if(counter == 0){
                                 result(@(YES));
                             }

                         }];
    } else {
        // support for iOS8 tracked in https://github.com/flutter/flutter/issues/27624.
        NSLog(@"Clearing cookies is not supported for Flutter WebViews prior to iOS 9.");
    }
}

@end
