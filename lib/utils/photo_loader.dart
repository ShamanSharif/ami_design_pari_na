// this class is used for getting all the photos from given url

import 'package:ami_design_pari_na/utils/network.dart';

class PhotoLoader {
  Future<dynamic> getAlbumData() async {
    NetworkHelper networkHelper = NetworkHelper(
        url: Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var fetchedData = await networkHelper.getData();
    return fetchedData;
  }
}
