package com.drenther.upi_pay

import android.content.Intent
import android.net.Uri
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.Registrar

class UpiPayPlugin internal constructor(registrar: Registrar, channel: MethodChannel) : MethodCallHandler, ActivityResultListener {
    private val activity = registrar.activity()

    private var result: Result? = null
    private var requestCodeNumber = 201119

    var hasResponded = false;

    override fun onMethodCall(call: MethodCall, result: Result) {
        hasResponded = false;

        this.result = result
        if (call.method == "initiateTransaction") {
            val app: String? = call.argument("app")
            val pa: String? = call.argument("pa")
            val pn: String? = call.argument("pn")
            val mc: String? = call.argument("mc")
            val tr: String? = call.argument("tr")
            val tn: String? = call.argument("tn")
            val am: String? = call.argument("am")
            val cu: String? = call.argument("cu")

            try {
                val uriBuilder = Uri.Builder()
                uriBuilder.scheme("upi").authority("pay")
                uriBuilder.appendQueryParameter("pa", pa)
                uriBuilder.appendQueryParameter("pn", pn)
                uriBuilder.appendQueryParameter("tr", tr)
                uriBuilder.appendQueryParameter("am", am)
                uriBuilder.appendQueryParameter("cu", cu)
                uriBuilder.appendQueryParameter("mode", "intent")
                if (mc != null) {
                    uriBuilder.appendQueryParameter("mc", mc)
                }
                if (tn != null) {
                    uriBuilder.appendQueryParameter("tn", tn)
                }

                val uri = uriBuilder.build()
                val intent = Intent(Intent.ACTION_VIEW, uri)
                intent.setPackage(app)


                if (intent.resolveActivity(activity.packageManager) == null) {
                    this.success("activity_unavailable")
                    return
                }

                activity.startActivityForResult(intent, requestCodeNumber)
                this.result = result
            } catch (ex: Exception) {
                Log.d("upi_pay", ex.toString())
                this.success("failed_to_open_app")
            }
        } else {
            result.notImplemented()
        }
    }

    private fun success(o: String) {
        if (!hasResponded) {
            hasResponded = true
            result?.success(o);
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCodeNumber == requestCode && result != null) {
            if (data != null) {
                try {
                    val response = data.getStringExtra("response")
                    this.success(response)
                } catch (ex: Exception) {
                    this.success("invalid_response")
                }
            } else {
                this.success("user_cancelled")
            }
        }
        return true
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "upi_pay")
            val plugin = UpiPayPlugin(registrar, channel)
            registrar.addActivityResultListener(plugin)
            channel.setMethodCallHandler(plugin)
        }
    }
}
