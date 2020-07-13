//
//  AppCoronaDelegate.h
//  TemplateApp
//
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoronaDelegate.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>
//#import <FlutterPluginRegistrant-umbrella.h>

@interface AppCoronaDelegate : NSObject< CoronaDelegate , FlutterAppLifeCycleProvider>
@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
