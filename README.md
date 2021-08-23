[![Maven Central](https://img.shields.io/maven-central/v/app.screeb.sdk/android-sdk.svg?label=Maven%20Central)](https://search.maven.org/search?q=g:%22app.screeb.sdk%22%20AND%20a:%22android-sdk%22)

__:warning:  Android SDK has been released in beta. Please contact
us [here](https://screeb.app/get-a-demo-of-screeb/) to request a demo.__

___

# React native demo app

React Native demo app for Screeb

## Intro

This project is a starting point for a all developers that wish to integrate native Android Screeb
sdk in a React native project.

## SDK installation

First you need to add the Screeb sdk dependency in the Android build.gradle of the app, you'll find
[the instructions](https://github.com/ScreebApp/DemoAppAndroid) on the repo of the Android demo app.

## SDK configuration

Like in the Android demo app, the access point of the SDK must be created in a custom Application
class, see `MainApplication.java`. You should create a Screeb instance using the builder and
reference it in a static variable to be used later in your app.
The builder needs the channel id provided int the Screeb admin web page :

```java
@Override
public void onCreate(){
        super.onCreate();

        screeb=new Screeb.Builder()
                        .withChannelId("082b7590-1621-4f72-8030-731a98cd1448")
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

## SDK usage :

Now, to call these functions, you'll find in `App.js` some examples
using `ScreebModule` functions :

```js
  const { ScreebModule } = NativeModules;

  const onSetIdentity = () => {
      ScreebModule.setIdentity('ReactNativeUserId');
  };
```

## Troubleshooting

In case of problem, feel free to contact us or create an issue in this repository.
