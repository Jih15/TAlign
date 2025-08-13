import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';

class CustomFileUpload extends StatefulWidget {
  final String label;
  final Function(String fileName)? onFilePicked;

  const CustomFileUpload({
    super.key,
    required this.label,
    this.onFilePicked,
  });

  @override
  State<CustomFileUpload> createState() => _CustomFileUploadState();
}

class _CustomFileUploadState extends State<CustomFileUpload> {
  String? fileName;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.single;
      final extension = pickedFile.extension?.toLowerCase();

      if (extension == "pdf") {
        setState(() {
          fileName = pickedFile.name;
        });
        widget.onFilePicked?.call(fileName!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Hanya file PDF yang diperbolehkan!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String shortenFilename(String name, {int maxLength = 30}) {
    if (name.length <= maxLength) return name;

    final extensionIndex = name.lastIndexOf(".");
    if (extensionIndex != -1) {
      // ada ekstensi file
      final ext = name.substring(extensionIndex); // contoh ".pdf"
      final mainName = name.substring(0, maxLength - ext.length - 3);
      return "$mainName...$ext";
    }
    return "${name.substring(0, maxLength - 3)}...";
  }


  void clearFile() {
    setState(() {
      fileName = null;
    });
    widget.onFilePicked?.call("");
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: fileName == null ? pickFile : null,
      child: Container(
        width: width,
        height: height * 0.16,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkMode ? ThemeApp.grayscaleMedium : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: fileName == null
                    ? Column(
                  key: const ValueKey("noFile"),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.file_upload_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(widget.label),
                  ],
                )
                    : Column(
                  key: const ValueKey("withFile"),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 40,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Tooltip(
                            message: fileName!,
                            child: Text(
                              shortenFilename(fileName!),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Tombol hapus di kiri bawah
            if (fileName != null)
            Positioned(
              bottom: 0,
              left: 0,
              child: InkWell(
                onTap: fileName != null ? clearFile : null,
                child: Container(
                  width: 84,
                  height: 36,
                  decoration: BoxDecoration(
                    color: fileName != null
                        ? ThemeApp.darkRed
                        : Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Hapus",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
            else SizedBox()
          ],
        ),
      ),
    );
  }
}
