[![Maven Central](https://img.shields.io/maven-central/v/app.screeb.sdk/survey.svg?label=Maven%20Central)](https://search.maven.org/search?q=g:%22app.screeb.sdk%22%20AND%20a:%22survey%22)
[![Version](https://img.shields.io/cocoapods/v/Screeb.svg?style=flat)](https://cocoapods.org/pods/Screeb)

__:warning:  Android and iOS SDK have been released in beta. 
Please contact us [here](https://screeb.app/get-a-demo-of-screeb/) to request a demo.__

___

# React native demo app

React Native demo app for Screeb

![ios screenshot](reactnative-ios.png)

## Intro

This project is a starting point for a all developers who wish to integrate native Android and iOS Screeb
sdk in a React native project.

To test the demo app, git clone the project then run in a terminal : 

```bash
# Start Metro, the JavaScript bundler that ships with React Native
npx react-native start
```

And in another terminal, run one of these commands according the platform you want to target :

```bash
# For iOS :
npx react-native run-ios

# For Android :
npx react-native run-android
```

## SDK installation

For Android you need to add the Screeb sdk dependency in the Android build.gradle of the app, you'll find
[the instructions](https://github.com/ScreebApp/DemoAppAndroid) on the repo of the Android demo app.

For iOS you need to add the Screeb sdk dependency in the Podfile of the app, you'll find
[the instructions](https://github.com/ScreebApp/sdk-ios-public) on the repo of the iOS sdk.


## SDK configuration for Android

Like in the Android demo app, the access point of the SDK must be created in a custom Application
class, see `MainApplication.java`. You should create a Screeb instance using the builder and
reference it in a static variable to be used later in your app.
The builder needs the channel id provided in the Screeb admin web page :

```java
@Override
public void onCreate(){
   super.onCreate();

   screeb = new Screeb.Builder()
                   .withChannelId("<channel-id>")
                   .withContext(this)
                   .build();
}
```

At this point, the SDK is installed and configured and can be used without any more operation. But
you'll probably need to communicate with it and send tracking information, declaring user's
properties or set user's identity.

To access these commands of the `Screeb.kt` class, we need to create a `ReactContextBaseJavaModule` to configure
the interface between react native code and Android specific functions.

In this project, a `ScreebModule.java` class is provided that is configured to call Screeb
functions `setIdentity()`, `trackEvent()`, `trackScreen()` and `setVisitorProperties()`.

```java
@ReactMethod
public void setIdentity(String userId) {
    Log.d("ScreebModule", "Called setIdentity : " + userId);
    MainApplication.screeb.setIdentity(userId);
}
```

We need to provide a `ScreebPackage.java` class too, that inherits from `ReactPackage` and references
`ScreebModule`.

To finish this configuration, we have to add a ScreebPackage instance to packages list in `MainApplication.java` :

```java
@Override
protected List<ReactPackage> getPackages() {
    List<ReactPackage> packages = new PackageList(this).getPackages();
    packages.add(new ScreebPackage());
    return packages;
}
```

## SDK configuration for iOS

The Screeb SDK is written in Swift v5.0. We need to bridge the Screeb.swift file 
with objective-C to access it in React Native project.

First, we create a swift file called `ScreebWrapper.swift` and start to implement 
all functions that call the Screeb commands with the @objc annotation :

```swift
import Foundation
import Screeb
import UIKit

@objc(ScreebWrapper)
class ScreebWrapper: NSObject {
  
  @objc(initScreeb:)
  func initScreebImpl(context: UIViewController) {
    // Insert here the channelId provided in the Screeb admin web page
    Screeb.initSdk(context: context, channelId: "<channel-id>")
  }
  
  @objc(setIdentity:)
  func setIdentityImpl(_ userId: String) {
    Screeb.setIdentity(uniqueVisitorId: userId)
  }
  
  // (...)
  
}
```

Then, we create a `ScreebWrapper.m` objective-C file and declare the bridging options :

```objc
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_REMAP_MODULE(ScreebModule, ScreebWrapper, NSObject)
RCT_EXTERN_METHOD(setIdentity:(NSString *)userId)
RCT_EXTERN_METHOD(trackEvent:(NSString *)eventId)
RCT_EXTERN_METHOD(trackScreen:(NSString *)screen)
RCT_EXTERN_METHOD(setVisitorProperties:(NSDictionary<NSString *, id> *)properties)
+ (BOOL)requiresMainQueueSetup
{
  return YES;
}
@end
```

NB : You can see we have chosen to expose the ScreebWrapper file as `ScreebModule`, this
will have an importance in the next section, in the js ReactNative files.

Finally, the initialization of the SDK should be placed into the `AppDelegate.m` file, 

```objc
[[[ScreebWrapper alloc] init] initScreeb:self.window.rootViewController];
```

For more details, you can find the complete configuration in the /ios directory.

## SDK usage :

Now, to call these functions, you'll find in `App.js` some examples
using `ScreebModule` functions :

```js
const { ScreebModule } = NativeModules;

const App: () => Node = () => {
  const onSetIdentity = () => {
      ScreebModule.setIdentity('ReactNativeUserId');
  };
  const onTrackEvent = () => {
      ScreebModule.trackEvent('ReactNativeEventId');
  };
  const onTrackScreen = () => {
      ScreebModule.trackScreen('ReactNativeScreen');
  };
  const onSetVisitorProperties = () => {
      ScreebModule.setVisitorProperties(
            {
               'age': 10,
               'isReactNative': true,
               'name': 'React name',
               'price': 65.7 });
  };
```

## Troubleshooting

In case of problem, feel free to contact us or create an issue in this repository.
