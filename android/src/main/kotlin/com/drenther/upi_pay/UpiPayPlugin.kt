package com.drenther.upi_pay

import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.net.Uri
import android.util.Base64
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.ByteArrayOutputStream


class UpiPayPlugin internal constructor(registrar: Registrar, channel: MethodChannel) : MethodCallHandler, ActivityResultListener {
    private val activity = registrar.activity()

    private var result: Result? = null
    private var requestCodeNumber = 201119

    var hasResponded = false;

    override fun onMethodCall(call: MethodCall, result: Result) {
        hasResponded = false;

        this.result = result

        when (call.method) {
            "initiateTransaction" -> this.initiateTransaction(call)
            "getInstalledUpiApps" -> this.getInstalledUpiApps()
            else -> result.notImplemented()
        }
    }

    private fun initiateTransaction(call: MethodCall) {
        val app: String? = call.argument("app")
        val pa: String? = call.argument("pa")
        val pn: String? = call.argument("pn")
        val mc: String? = call.argument("mc")
        val tr: String? = call.argument("tr")
        val tn: String? = call.argument("tn")
        val am: String? = call.argument("am")
        val cu: String? = call.argument("cu")
        val url: String? = call.argument("url")

        try {
            val uriBuilder = Uri.Builder()
            uriBuilder.scheme("upi").authority("pay")
            uriBuilder.appendQueryParameter("pa", pa)
            uriBuilder.appendQueryParameter("pn", pn)
            uriBuilder.appendQueryParameter("tr", tr)
            uriBuilder.appendQueryParameter("am", am)
            uriBuilder.appendQueryParameter("cu", cu)
            uriBuilder.appendQueryParameter("mode", "intent")
            if (url != null) {
                uriBuilder.appendQueryParameter("url", url)
            }
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
        } catch (ex: Exception) {
            Log.e("upi_pay", ex.toString())
            this.success("failed_to_open_app")
        }
    }

    private fun getInstalledUpiApps() {
        val uriBuilder = Uri.Builder()
        uriBuilder.scheme("upi").authority("pay")
        uriBuilder.appendQueryParameter("pa", "abc@ybl")
        uriBuilder.appendQueryParameter("pn", "abc")
        uriBuilder.appendQueryParameter("tr", "123")
        uriBuilder.appendQueryParameter("am", "10")
        uriBuilder.appendQueryParameter("cu", "INR")
        uriBuilder.appendQueryParameter("mode", "intent")

        val uri = uriBuilder.build()
        val intent = Intent(Intent.ACTION_VIEW, uri)

        val packageManager = activity.packageManager

        try {
            val activities = packageManager.queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY)

            // Convert the activities into a response that can be transferred over the channel.
            val activityResponse = activities.map {
                val packageName = it.activityInfo.packageName
                val drawable = packageManager.getApplicationIcon(packageName)

                val bitmap = getBitmapFromDrawable(drawable)
                val icon = if (bitmap != null) {
                    encodeToBase64(bitmap)
                } else {
                    null
                }

                mapOf(
                        "packageName" to packageName,
                        "icon" to icon,
                        "priority" to it.priority,
                        "preferredOrder" to it.preferredOrder
                )

            }


            result?.success(activityResponse)
        } catch (ex: Exception) {
            Log.e("upi_pay", ex.toString())
            result?.error("getInstalledUpiApps", "exception", ex)
        }

    }

    private fun encodeToBase64(image: Bitmap): String? {
        val byteArrayOS = ByteArrayOutputStream()
        image.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOS)
        return Base64.encodeToString(byteArrayOS.toByteArray(), Base64.NO_WRAP)
    }

    private fun getBitmapFromDrawable(drawable: Drawable): Bitmap? {
        val bmp: Bitmap = Bitmap.createBitmap(drawable.intrinsicWidth, drawable.intrinsicHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bmp)
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight())
        drawable.draw(canvas)
        return bmp
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
