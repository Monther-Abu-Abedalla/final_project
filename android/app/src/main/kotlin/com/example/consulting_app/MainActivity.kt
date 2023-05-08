package com.consuliting.app


import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: io.flutter.embedding.android.FlutterFragmentActivity() {

    private val CHANNEL = "poc.deeplink.flutter.dev/channel"
    private var startString: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val intent = intent
    startString = intent.data?.toString()
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                if (startString != null) {
                    result.success(startString)
                }
            }
        }
    }




fun createChangeReceiver(events: EventChannel.EventSink): BroadcastReceiver? {
    return object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) { // NOTE: assuming intent.getAction() is Intent.ACTION_VIEW
            val dataString = intent.dataString ?:
            events.error("UNAVAILABLE", "Link unavailable", null)
            events.success(dataString)
        }
    }
}
}