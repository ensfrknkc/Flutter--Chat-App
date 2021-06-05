import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kbu_app/services/storage_base.dart';

class FirebaseStorageService implements StorageBase{

  Reference _storageReference ;

  @override
  Future<String> uploadFile(String userID, String fileType, File uploadFile) async{

    _storageReference =  FirebaseStorage.instance.ref().child(userID).child(fileType).child("profil_foto.png");
     await _storageReference.putFile(uploadFile);

    String url = await downloadURLExample(userID, fileType);
    return url;
  }

  @override
  Future<String> uploadStory(String userID, String fileType, File uploadFile,String description) async{

    _storageReference =  FirebaseStorage.instance.ref().child(userID).child(fileType).child(description);
    await _storageReference.putFile(uploadFile);

    String url = await downloadStoryURLExample(userID, fileType,description);
    return url;
  }

  Future<String> downloadURLExample(String userID, String fileType) async {
    String downloadURL = await FirebaseStorage.instance
        .ref().child(userID).child(fileType).child("profil_foto.png")
        .getDownloadURL();
    print("resim adresi "+downloadURL);
    return downloadURL;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<String> downloadStoryURLExample(String userID, String fileType,String description) async {
    String downloadURL = await FirebaseStorage.instance
        .ref().child(userID).child(fileType).child(description)
        .getDownloadURL();
    print("resim adresi "+downloadURL);
    return downloadURL;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<String> downloadNewsURLExample(String userID, String fileType) async {
    String downloadURL = await FirebaseStorage.instance
        .ref().child(userID).child(fileType).child("haberfoto.png")
        .getDownloadURL();
    print("resim adresi "+downloadURL);
    return downloadURL;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  @override
  Future<String> uploadNewsFile(String documentID, String fileType, File uploadFile) async{

    _storageReference =  FirebaseStorage.instance.ref().child(documentID).child(fileType).child("haberfoto.png");
    await _storageReference.putFile(uploadFile);

    String url = await downloadNewsURLExample(documentID, fileType);
    return url;
  }

  @override
  Future<String> uploadGroupFile(String documentID, String fileType, File uploadFile, String description) async{
    _storageReference =  FirebaseStorage.instance.ref().child(documentID).child(fileType).child(description);
    await _storageReference.putFile(uploadFile);

    String url = await downloadStoryURLExample(documentID, fileType,description);
    return url;
  }


}