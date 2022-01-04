// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mylib/GenericClasses/BookClasses/Book.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateFinished.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateReading.dart';

class BookGridCardLibrary extends StatefulWidget {
  final Book book;
  final VoidCallback? onStatisticsPress;
  final VoidCallback? onStatusPress;
  final VoidCallback? onDeletePress;
  final VoidCallback? onPicTureTab;

  BookGridCardLibrary({
    Key? key,
    required this.book,
    this.onStatisticsPress,
    this.onStatusPress,
    this.onDeletePress,
    this.onPicTureTab,
  }) : super(key: key);
  @override
  _BookGridCardLibraryState createState() => _BookGridCardLibraryState();
}

class _BookGridCardLibraryState extends State<BookGridCardLibrary>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  late Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 0.0, end: 360.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Color green = const Color.fromARGB(255, 48, 176, 99);
    String? author = widget.book.author;
    String title = widget.book.title;
    String? subTitle = widget.book.subTitle;
    String? imageStr = widget.book.imageLink;

    IconData stateIcon;
    ImageProvider image;

    author ??= "";
    subTitle ??= "";
    imageStr = "";
    if (imageStr == null || imageStr == "") {
      image = const AssetImage('assets/images/NoPicture.png');
    } else {
      image = Image.network(widget.book.imageLink.toString()).image;
    }
    String readingState = widget.book.readingState.toString();
    if (readingState == ReadingStateNotStarted().runtimeType.toString()) {
      stateIcon = Icons.check_box_outline_blank;
    } else if (readingState == ReadingStateReading().runtimeType.toString()) {
      stateIcon = Icons.title;
    } else if (readingState == ReadingStateFinished().runtimeType.toString()) {
      stateIcon = Icons.check_circle_outline;
    } else {
      stateIcon = Icons.check_box_outline_blank;
    }
    return InkWell(
        onTap: widget.onPicTureTab,
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3.0,
                  spreadRadius: .5,
                )
              ],
              //color: Colors.black,
              //borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: image,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  // color: Colors.yellow,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: green,
                    child: Icon(
                      stateIcon,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    IgnorePointer(
                      child: Container(
                        // comment or change to transparent color
                        // color: Colors.red,
                        height: 75.0,
                        width: 250.0,
                      ),
                    ),
                    // Transform.translate(
                    //   offset: Offset.fromDirection(getRadiansFromDegree(270),
                    //       degOneTranslationAnimation.value * 55),
                    //   child: Transform(
                    //     transform: Matrix4.rotationX(
                    //         getRadiansFromDegree(rotationAnimation.value))
                    //       ..scale(degOneTranslationAnimation.value),
                    //     alignment: Alignment.center,
                    //     child: CircleAvatar(
                    //       radius: 20,
                    //       backgroundColor: green,
                    //       child: IconButton(
                    //         iconSize: 25,
                    //         icon: Icon(
                    //           Icons.show_chart_rounded,
                    //           color: Colors.white,
                    //         ),
                    //         onPressed: () {
                    //           widget.onStatisticsPress();
                    //           if (animationController.isCompleted) {
                    //             animationController.reverse();
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(270),
                          degTwoTranslationAnimation.value * 45),
                      child: Transform(
                        transform: Matrix4.rotationX(
                            getRadiansFromDegree(rotationAnimation.value))
                          ..scale(degTwoTranslationAnimation.value),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: green,
                          child: IconButton(
                            iconSize: 25,
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              widget.onStatusPress!();
                              print(widget.book.readingState);
                              setState(() {});
                              if (animationController.isCompleted) {
                                animationController.reverse();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(270),
                          degThreeTranslationAnimation.value * 90),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value))
                          ..scale(degThreeTranslationAnimation.value),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: green,
                          child: IconButton(
                            iconSize: 25,
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              widget.onDeletePress!();
                              if (animationController.isCompleted) {
                                animationController.reverse();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.rotationX(
                          getRadiansFromDegree(rotationAnimation.value)),
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: green,
                        child: IconButton(
                          enableFeedback: true,
                          color: green,
                          iconSize: 25,
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            print('info button');
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
