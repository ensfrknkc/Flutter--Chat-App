import 'dart:io';

abstract class StorageBase {
  Future<String> uploadFile(String userID, String fileType, File uploadFile);

  Future<String> uploadStory(
      String userID, String fileType, File uploadFile, String description);

  Future<String> uploadGroupFile(
      String documentID, String fileType, File uploadFile, String description);

  Future<String> uploadNewsFile(
    String documentID,
    String fileType,
    File uploadFile,
  );
}
