// MyApplication.java (create this file if it doesn't exist in your project)

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
// import vn.hunghd.flutterdownloader.FlutterDownloaderPlugin;

import io.flutter.plugins.GeneratedPluginRegistrant;

public class MyApplication extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {
    @Override
    public void registerWith(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }
}