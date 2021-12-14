package app.screeb.screebreactdemoapp;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

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
    public void setIdentity(String userId) {
        Log.d("ScreebModule", "Called setIdentity : " + userId);
        screeb.setIdentity(userId);
    }

    @ReactMethod
    public void trackEvent(String eventId) {
        Log.d("ScreebModule", "Called trackEvent : " + eventId);
        screeb.trackEvent(eventId, null);
    }

    @ReactMethod
    public void trackScreen(String screen) {
        Log.d("ScreebModule", "Called trackScreen : " + screen);
        screeb.trackScreen(screen, null);
    }

    @ReactMethod
    public void setVisitorProperties(ReadableMap properties) {
        Log.d("ScreebModule",
              "Called setVisitorProperties with " + properties.toHashMap().size() + " properties");
        screeb.setVisitorProperties(properties.toHashMap());
    }
}
