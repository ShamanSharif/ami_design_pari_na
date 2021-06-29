import 'package:ami_design_pari_na/screens/khoj_screen.dart';
import 'package:ami_design_pari_na/screens/photo_viewer_screen.dart';
import 'package:ami_design_pari_na/screens/settings_screen.dart';
import 'package:ami_design_pari_na/utils/constants.dart';
import 'package:ami_design_pari_na/utils/photo.dart';
import 'package:ami_design_pari_na/utils/photo_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DekhaoScreen extends StatefulWidget {
  static const String id = 'dekhao_page';
  @override
  _DekhaoScreenState createState() => _DekhaoScreenState();
}

class _DekhaoScreenState extends State<DekhaoScreen> {
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    loadPhotoData();
  }

  void loadPhotoData() async {
    PhotoLoader _photoLoader = PhotoLoader();
    var fetchedData = await _photoLoader.getAlbumData();
    await getPhotos(fetchedData);
    setState(() {});
  }

  Future<void> getPhotos(dynamic fetchedData) async {
    var i = 0;
    for (var data in fetchedData) {
      if (i == 100) {
        break;
      } else {
        i++;
        Photo photo = Photo(
          data["albumId"],
          data["id"],
          data["title"],
          data["thumbnailUrl"],
          data["url"],
        );
        photos.add(photo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Dekhao Chobi",
          // "Welcome",
          style: TextStyle(
            color: brandColor,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: brandColor,
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SettingsScreen.id,
              );
            },
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: brandColor,
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: clickableThumbnail(context),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.search),
            label: "KHOJ The Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.image),
            label: "DEKHAO Chobi",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightJoined,
                child: KhojScreen(),
                childCurrent: DekhaoScreen(),
              ),
              (route) => false,
            );
          }
        },
      ),
    );
  }

  List<Widget> clickableThumbnail(BuildContext context) {
    List<Widget> _clickableThumbnails = [];
    for (var photo in photos) {
      _clickableThumbnails.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoViewerScreen(
                  photos: photos,
                  currentIndex: photo.id - 1,
                ),
              ),
            );
          },
          onLongPress: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                photo.toString(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: photo.thumbnailUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(FeatherIcons.xCircle),
          ),
        ),
      );
    }
    return _clickableThumbnails;
  }
}
