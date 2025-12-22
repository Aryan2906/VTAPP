import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'version_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateService {
  static Future<void> check(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;

    final snap = await FirebaseFirestore.instance
        .collection('app_config')
        .doc('version')
        .get();

    if (!snap.exists) return;

    final data = snap.data()!;
    final minRequired = data['minReqVersion'];
    final apkurl = data['apkurl'];

    if (isVersionLower(currentVersion, minRequired)) {
      _showForceUpdateDialog(context, apkurl);
    }
  }

  static void _showForceUpdateDialog(
      BuildContext context, String url) {
    showDialog(
      context: context,
      barrierDismissible: false,  
      builder: (_) => AlertDialog(
        title: const Text("Update Required"),
        content: const Text(
          "Please update the app to continue using VTAPP.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
