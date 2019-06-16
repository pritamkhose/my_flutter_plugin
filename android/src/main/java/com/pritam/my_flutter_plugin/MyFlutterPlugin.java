package com.pritam.my_flutter_plugin;

import android.content.Context;
import android.os.BatteryManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static android.content.Context.BATTERY_SERVICE;

// https://github.com/flutter/plugins/blob/master/packages/battery/android/src/main/java/io/flutter/plugins/battery/BatteryPlugin.java
// https://proandroiddev.com/build-your-own-plugin-for-flutter-cfee1a08ea3a
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages

/** MyFlutterPlugin */
public class MyFlutterPlugin implements MethodCallHandler {
  /** Plugin registration. */
  static Context context;
  public static void registerWith(Registrar registrar) {
    context = registrar.context();
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "my_flutter_plugin");
    channel.setMethodCallHandler(new MyFlutterPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("getBatteryPercent")) {
      result.success(getBatteryLevel());
    }
    else {
      result.notImplemented();
    }
  }

  private String getBatteryLevel() {
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
      BatteryManager bm = (BatteryManager)  context.getSystemService(BATTERY_SERVICE);
      int batLevel = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
      return batLevel + "";
    } else {
      return  "NA";
    }
  }

}
