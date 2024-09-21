package `in`.axivise.realtbox
import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.provider.MediaStore
import android.content.ContentValues
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity: FlutterActivity() {

     private val CHANNEL = "in.axivise.realtbox/download"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "saveFile") {
                val filePath = call.argument<String>("filePath")
                val fileName = call.argument<String>("fileName")
                if (filePath != null && fileName != null) {
                    val saveResult = saveFileToDownloads(filePath, fileName)
                    result.success(saveResult)
                } else {
                    result.error("INVALID_ARGUMENT", "File path or name is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun saveFileToDownloads(filePath: String, fileName: String): String {
        val file = File(filePath)
        val contentResolver = applicationContext.contentResolver
        val downloadsUri = MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        val contentValues = ContentValues().apply {
            put(MediaStore.Downloads.DISPLAY_NAME, fileName)
            //put(MediaStore.Downloads.MIME_TYPE, "application/pdf")
            put(MediaStore.Downloads.RELATIVE_PATH, "Download/")
        }
        val uri = contentResolver.insert(downloadsUri, contentValues) ?: return "Failed to create file"
        contentResolver.openFileDescriptor(uri, "w").use { parcelFileDescriptor ->
            parcelFileDescriptor?.let {
                FileOutputStream(it.fileDescriptor).use { outputStream ->
                    file.inputStream().use { inputStream ->
                        inputStream.copyTo(outputStream)
                    }
                }
            }
        }
        file.delete()
        return "Download completed: $fileName"
    }
}
