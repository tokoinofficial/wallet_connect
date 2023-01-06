package io.tokoin.wallet.connect

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class WalletConnectPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wallet_connect_android")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformName") {
            result.success("Android")            
        } else if (call.method.equals("initializeForBackground")) {
            val args: ArrayList = call.arguments()
            val callBackHandle = args.get(0) as Long
            mCallbackDispatcherHandle = callBackHandle
            result.success(null)
            return
        } else if (call.method.equals("callBackgroundService")) {
            val args: ArrayList = call.arguments()
            val callbackHandle = args.get(0) as Long
            val i = Intent(mContext, BackgroundService::class.kt)
            i.putExtra(Params.CALLBACK_HANDLE_KEY, callbackHandle)
            i.putExtra(Params.CALLBACK_DISPATCHER_HANDLE_KEY, mCallbackDispatcherHandle)
            mContext.startService(i)
            result.success(null)
            return
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }

    object Params {
        const val CALLBACK_HANDLE_KEY = "callback_handle_key"
        const val CALLBACK_DISPATCHER_HANDLE_KEY = "callback_dispatcher_handle_key"
    }

}