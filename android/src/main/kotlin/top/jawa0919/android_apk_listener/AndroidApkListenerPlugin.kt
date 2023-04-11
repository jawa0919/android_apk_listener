package top.jawa0919.android_apk_listener

import android.app.Activity
import android.app.Application
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/** AndroidApkListenerPlugin */
class AndroidApkListenerPlugin : FlutterPlugin, ActivityAware {

    private val TAG = "ApkListenerPlugin"

    private var methodChannel: MethodChannel? = null
    private var eventChannel: EventChannel? = null
    private var pluginBinding: FlutterPlugin.FlutterPluginBinding? = null
    private var application: Application? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.i(TAG, "onAttachedToEngine: ")
        this.pluginBinding = flutterPluginBinding
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Log.i(TAG, "onDetachedFromEngine: ")
        this.pluginBinding = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.i(TAG, "onAttachedToActivity: ")
        pluginBinding?.let {
            setup(it.binaryMessenger, it.applicationContext as Application, binding.activity)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.i(TAG, "onDetachedFromActivityForConfigChanges: ")
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.i(TAG, "onReattachedToActivityForConfigChanges: ")
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        Log.i(TAG, "onDetachedFromActivity: ")
        teardown()
    }

    private fun setup(messenger: BinaryMessenger, application: Application, activity: Activity) {
        methodChannel = MethodChannel(messenger, "android_apk_listener")
        eventChannel = EventChannel(messenger, "android_apk_listener")

        this.application = application
        this.activity = activity

        val handler = AALMethodCallHandler(activity, activity.packageManager)
        val receiver = AALBroadcastReceiver(activity)
        methodChannel?.setMethodCallHandler(handler)
        eventChannel?.setStreamHandler(receiver)
    }

    private fun teardown() {
        methodChannel?.setMethodCallHandler(null)
        eventChannel?.setStreamHandler(null)
        application = null
        activity = null
        methodChannel = null
        eventChannel = null
    }
}
