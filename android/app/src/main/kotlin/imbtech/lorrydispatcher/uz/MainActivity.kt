package imbtech.lorrydispatcher.uz

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        // MapKitFactory.setLocale("YOUR_LOCALE")
        MapKitFactory.setApiKey("0aa67633-9718-497f-87ba-625e5f9eeeb3")
        super.configureFlutterEngine(flutterEngine)
    }
}