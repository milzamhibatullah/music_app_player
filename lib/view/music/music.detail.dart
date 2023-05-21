import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicDetail extends StatelessWidget {
  var imageMusic =
      'https://is3-ssl.mzstatic.com/image/thumb/Music116/v4/44/d2/fd/44d2fd29-60f8-cbe2-d362-e369fcb8d301/cover.jpg/100x100bb.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
        ),
        title: Text(
          'Tayri & Hoop Records',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60.0,
                ),

                ///image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: imageMusic,
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height / 4,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),

                ///title and artist section
                Text(
                  'DRAMA QUEEN',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Tayri & Hoop Records',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                ///slider bar player
                SizedBox(
                  width: double.infinity,
                  child: SliderTheme(
                    data: SliderThemeData(
                        trackHeight: 5.0,
                        overlayShape: SliderComponentShape.noOverlay,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10.0)),
                    child: Slider(
                      value: 20.0,
                      min: 0,
                      max: 100,

                      // label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),

                ///duration
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '0:00',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Text('3:00', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),

                ///player
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          size: 60.0,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_circle_fill_rounded,
                          size: 80.0,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_next_rounded, size: 60.0)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}