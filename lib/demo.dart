import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  String path = "";
  VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Video Player"), actions: [
          IconButton(
              onPressed: () async {
                XFile? video =
                    await ImagePicker().pickVideo(source: ImageSource.camera);
                path = video!.path;
                Uri uri=Uri.parse(path);
                _controller = VideoPlayerController.contentUri(uri);

                await _controller!.initialize();
                await _controller!.play();
                setState(() {
                });
              },
              icon: Icon(Icons.add))
        ]),
        body: path.isEmpty
            ? Container(
                color: Colors.black,
                child: Text("No Video Selected"),
              )
            : (_controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  )
                : Container()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller!.value.isInitialized) {
                _controller!.value.isPlaying
                    ? _controller!.pause()
                    : _controller!.play();
              }
            });
          },
          child: Icon(
            path.isNotEmpty
                ? (_controller!.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow)
                : Icons.play_arrow,
          ),
        ));
  }
}
