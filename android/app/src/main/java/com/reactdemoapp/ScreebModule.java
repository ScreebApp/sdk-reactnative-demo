package com.reactdemoapp;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import androidx.annotation.NonNull;

public class ScreebModule extends ReactContextBaseJavaModule {

    ScreebModule(ReactApplicationContext context) {
        super(context);
    }

    @NonNull
    @Override
    public String getName() {
        return "ScreebModule";
    }

    @ReactMethod
    public void setIdentity(String userId) {
        Log.d("ScreebModule", "Called setIdentity : " + userId);
        MainApplication.screeb.setIdentity(userId);
    }

    @ReactMethod
    public void trackEvent(String eventId) {
        Log.d("ScreebModule", "Called trackEvent : " + eventId);
        MainApplication.screeb.trackEvent(eventId, null);
    }

    @ReactMethod
    public void trackScreen(String screen) {
        Log.d("ScreebModule", "Called trackScreen : " + screen);
        MainApplication.screeb.trackScreen(screen, null);
    }

    @ReactMethod
    public void setVisitorProperties(ReadableMap properties) {
        Log.d("ScreebModule",
              "Called setVisitorProperties with " + properties.toHashMap().size() + " properties");
        MainApplication.screeb.setVisitorProperties(properties.toHashMap());
    }
}
