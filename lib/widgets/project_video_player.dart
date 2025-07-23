import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:video_player/video_player.dart';

class ProjectVideoPlayerDialog extends StatefulWidget {
  final String videoUrl;
  const ProjectVideoPlayerDialog({super.key, required this.videoUrl});

  @override
  State<ProjectVideoPlayerDialog> createState() =>
      _ProjectVideoPlayerDialogState();
}

class _ProjectVideoPlayerDialogState extends State<ProjectVideoPlayerDialog> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ClipRRect(
        borderRadius: BorderRadius.circular(kOuterBorderRadius),
        child:
            _controller.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
