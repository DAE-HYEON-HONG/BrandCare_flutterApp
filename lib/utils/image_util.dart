import 'package:image_picker/image_picker.dart';

class ImageUtil {

  Future<XFile?> getImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }

}