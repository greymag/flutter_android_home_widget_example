package com.example.android_widgets_example

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "example.flutter.innim.ru/android_widgets"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->

            if (call.method == "addWidget") {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    addWidget()
                    result.success(true)
                } else {
                    result.error("UNAVAILABLE",
                            "Pin request is not available. Add widget from Android menu",
                            null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun addWidget() {
        val appWidgetManager: AppWidgetManager = context.getSystemService(AppWidgetManager::class.java)
        val myProvider = ComponentName(context, FlutterExampleAppWidget::class.java)
        appWidgetManager.requestPinAppWidget(myProvider, null, null)
    }
}
