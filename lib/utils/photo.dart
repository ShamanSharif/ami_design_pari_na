// this class is used to make a object that will help to get
// all the individual photos form the json result

class Photo {
  final int _albumId;
  final int _id;
  final String _title;
  final String _thumbnailUrl;
  final String _url;

  Photo(this._albumId, this._id, this._title, this._thumbnailUrl, this._url);

  String get url => _url;
  String get thumbnailUrl => _thumbnailUrl;
  String get title => _title;
  int get id => _id;
  int get albumId => _albumId;

  @override
  String toString() {
    return 'Title: $_title\n\nPhoto Id: $_id\nAlbum ID: $_albumId';
  }
}
