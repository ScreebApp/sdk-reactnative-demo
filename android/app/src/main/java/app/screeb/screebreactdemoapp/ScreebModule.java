package app.screeb.screebreactdemoapp;

import android.content.Context;
import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import java.util.HashMap;

import androidx.annotation.NonNull;

import static app.screeb.screebreactdemoapp.MainApplication.*;

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
    public void initSdk(String channelId, String userId, ReadableMap properties) {
        Log.d("ScreebModule", "Called setIdentity : " + userId);
        HashMap<String, Object > map = null;
        if (properties != null){
            map = properties.toHashMap();
        }
        screeb.pluginInit(channelId, userId, map);
    }

    @ReactMethod
    public void setIdentity(String userId, ReadableMap properties) {
        Log.d("ScreebModule", "Called setIdentity : " + userId);
        HashMap<String, Object > map = null;
        if (properties != null){
            map = properties.toHashMap();
        }
        screeb.setIdentity(userId, map);
    }

    @ReactMethod
    public void trackEvent(String eventId, ReadableMap properties) {
        Log.d("ScreebModule", "Called trackEvent : " + eventId);
        HashMap<String, Object > map = null;
        if (properties != null){
            map = properties.toHashMap();
        }
        screeb.trackEvent(eventId, map);
    }

    @ReactMethod
    public void trackScreen(String screen, ReadableMap properties) {
        Log.d("ScreebModule", "Called trackScreen : " + screen);
        HashMap<String, Object > map = null;
        if (properties != null){
            map = properties.toHashMap();
        }
        screeb.trackScreen(screen, map);
    }

    @ReactMethod
    public void setProperties(ReadableMap properties) {
        Log.d("ScreebModule",
              "Called setVisitorProperties with " + properties.toHashMap().size() + " properties");
        screeb.setVisitorProperties(properties.toHashMap());
    }
}
