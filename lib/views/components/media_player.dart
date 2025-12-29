import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import "package:get/get.dart";
import "package:iot_app/controllers/orchestrator.dart";
import "package:iot_app/models/mediaplayerinfo.dart";
import "package:squiggly_slider/slider.dart";

import "../../models/orchestrator_integration_status.dart";
import "../../utils/eval_wrapper.dart";
import "../../utils/icon_map.dart";
import "generics.dart";
import "../../utils/snackbar.dart";

class IntegrationMediaPlayer extends StatefulWidget {
  final String label;
  final String integrationId;

  const IntegrationMediaPlayer({
    Key? key,
    required this.label,
    required this.integrationId,
  }) : super(key: key);

  @override
  _IntegrationMediaPlayerState createState() => _IntegrationMediaPlayerState();
}

class _IntegrationMediaPlayerState extends State<IntegrationMediaPlayer> {
  late final OrchestratorController orchestrator;
  bool online = false;
  bool enabled = false;
  bool setupChangeListener = false;
  List<Worker> _subscriptions = [];
  Duration position = Duration.zero;
  MediaPlayerInfo metadata = MediaPlayerInfo.empty();
  bool playing = false;
  int localPosition = -1;
  ColorScheme imageColors = ColorScheme.fromSeed(seedColor: Colors.lightBlue);
  Brightness brightness = Brightness.dark;

  void updateIntegrationState() {
    if (!orchestrator.orchestratorState.containsKey(widget.integrationId))
      return;
    var state = orchestrator.orchestratorState[widget.integrationId]!;
    try {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => setState(() {
          enabled = true;
          var md = orchestrator.orchestratorState[widget.integrationId]!["/metadata"];
          bool playing = orchestrator.orchestratorState[widget.integrationId]!["/playbackState"]["playing"] == "Playing";
          int pos = orchestrator.orchestratorState[widget.integrationId]!["/position"];
          Duration length = Duration.zero;
          if(md != null && md["length"] != null) {
            if(md["length"]["unit"] == "s"){
              length = Duration(seconds: md["length"]["value"].toInt());
            } else if(md["length"]["unit"] == "ms"){
              length = Duration(milliseconds: md["length"]["value"].toInt());
            }
          }

          if(md != null && md["imageUrl"] != null && (md["imageUrl"] != metadata.imageUrl || imageColors.primary == Colors.lightBlue)) {
            getAccentColor(md["imageUrl"]);
          }

          position = Duration(milliseconds: pos);
          metadata = MediaPlayerInfo(
            title: md != null && md["title"] != null ? md["title"] : "Unknown Title",
            artist: md != null && md["artist"] != null ? md["artist"] : "Unknown Artist",
            album: md != null && md["album"] != null ? md["album"] : "Unknown Album",
            imageUrl: md != null && md["imageUrl"] != null ? md["imageUrl"] : "",
            length: length,
          );
          this.playing = playing;
        }),
      );
    } catch (e) {
      print(
        "Error in evaluator script for integration ${widget.integrationId}: " +
            e.toString(),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.showSnackbar(
          "Error in evaluator script for integration ${widget.integrationId}: " +
              e.toString(),
        );
      });
    }
  }

  Future<Color> getAccentColor(String imageUrl) async {
    final palette = await ColorScheme.fromImageProvider(
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.content,
      provider: CachedNetworkImageProvider(imageUrl),
    );
    imageColors = palette;
    return palette.primary;
  }

  void checkForIntegrationData() {
    if (setupChangeListener) return;
    if (!orchestrator.haveIntegrationData.containsKey(widget.integrationId))
      return;
    setupChangeListener = true;
    _subscriptions.add(ever(orchestrator.orchestratorState[widget.integrationId]!, (_) {
      updateIntegrationState();
    }));
    updateIntegrationState();
  }

  void updateOnlineStatus() {
    print(
      "\n\n\n\tChecking online status for integration ${widget.integrationId}",
    );
    if (!orchestrator.integrationStatus.containsKey(widget.integrationId)) {
      print("\t------> Integration status not found!");
      return;
    }
    IntegrationStatus status =
        orchestrator.integrationStatus[widget.integrationId]!;
    if (status.status == "running") {
      setState(() {
        print("\t-----> Integration ${widget.integrationId} is online");
        online = true;
      });
    } else {
      setState(() {
        print("\t-----> Integration ${widget.integrationId} is offline");
        online = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    orchestrator = Get.find<OrchestratorController>();
    _subscriptions.add(ever(orchestrator.integrationStatus, (_) => updateOnlineStatus()));
    _subscriptions.add(ever(orchestrator.haveIntegrationData, (_) => checkForIntegrationData()));
    checkForIntegrationData();
    updateOnlineStatus();
  }

  @override
  void dispose() {
    for (var subscription in _subscriptions) {
      subscription.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // brightness = MediaQuery.of(context).platformBrightness;
    return LayoutBuilder(builder: (context, constraints) {
      Widget player = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: GenericIntegrationComponent(
            online: online,
            padding: EdgeInsets.all(0),
            title: widget.label,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColorFiltered( // Background w/ filter
                    colorFilter: ColorFilter.matrix(<double>[
                      0.15, 0,   0,   0, 20,
                      0,   0.15, 0,   0, 20,
                      0,   0,   0.15, 0, 20,
                      0,   0,   0,   1, 0,
                    ]),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      imageUrl: metadata.imageUrl,
                      errorWidget: (context, url, error) {
                        print("MediaPlayer@CachedNetworkImage - "+error.toString());
                        return Icon(Icons.music_note);
                      },
                    ),
                  ),

                  Positioned( // Main control stack
                    bottom: 6,
                    left: 12,
                    right: 6,
                    top: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding( // Top row: Icon + device name
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(nameToIconPath(widget.integrationId), width: 36, height: 36, color: imageColors.primary),
                              if(false) Container(
                                decoration: BoxDecoration(
                                  color: imageColors.primary,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 64,
                                  minHeight: 32,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Center(child: Text("JLab GO Air Pop", style: TextStyle(color: imageColors.onPrimary, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,))
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row( // Text + play
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  child: Column( // Text
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        metadata.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        metadata.artist,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton.filled(
                                constraints: BoxConstraints(
                                  minWidth: 56,
                                  minHeight: 32,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: imageColors.primary,
                                  // backgroundColor: darkenColor(saturateColor(imageColors.primary, 0.5), bg: imageColors.primaryContainer, amount: 0.8),
                                  foregroundColor: imageColors.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12), // reduced radius
                                  ),
                                ),
                                // iconSize: 32,
                                icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
                                onPressed: () {
                                  orchestrator.sendMessage("/${widget.integrationId}/${playing ? "pause" : "play"}", "");
                                },
                              )
                            ],
                          ),
                        ),

                        Row( // Bottom controls
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                icon: Icon(Icons.skip_previous_rounded, color: Colors.white),
                                onPressed: () {
                                  orchestrator.sendMessage("/${widget.integrationId}/previous", "");
                                },
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 2,
                                    thumbSize: MaterialStateProperty.all(Size(8,8)),
                                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                                    overlayShape: RoundSliderOverlayShape(overlayRadius: 14),
                                    activeTrackColor: imageColors.primary,
                                    inactiveTrackColor: darkenColor(imageColors.primary, amount: 0.4),
                                    thumbColor: Color.alphaBlend(imageColors.onPrimary.withAlpha((255*0.2).toInt()), imageColors.primary),
                                    // overlayColor: imageColors.primary.withOpacity(0.2),
                                  ),
                                  child: SquigglySlider(
                                    useLineThumb: playing,
                                    value: localPosition >= 0 ? localPosition.toDouble() : (position.inMilliseconds.toDouble() > metadata.length.inMilliseconds.toDouble() ? 0 : (position.inMilliseconds < 0) ? 0 : position.inMilliseconds.toDouble()),
                                    min: 0,
                                    max: metadata.length.inMilliseconds.toDouble(),
                                    squiggleAmplitude: playing ? 4 : 0,
                                    squiggleWavelength: 7,
                                    squiggleSpeed: 0.1,
                                    label: 'Progress',
                                    onChanged: (val){
                                      setState(() {
                                        localPosition = val.toInt();
                                      });
                                    },
                                    onChangeEnd: (double value) {
                                      setState(() {
                                        localPosition = -1;
                                      });
                                      orchestrator.sendMessage("/${widget.integrationId}/seek", value.toInt().toString());
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.skip_next_rounded, color: Colors.white),
                                onPressed: () {
                                  orchestrator.sendMessage("/${widget.integrationId}/next", "");
                                },
                              ),
                            ]
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // If available width is less than 264, show a horizontal scroll with 320px child
      if (constraints.maxWidth < 264) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(width: 320, child: player),
        );
      }

      // Otherwise size the child to fit the parent but not exceed 360
      double width = constraints.maxWidth;
      if (width > 360) width = 360;

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: width, child: player),
        ],
      );
    });
  }
  
  String nameToIconPath(String integrationId) {
    switch (integrationId) {
      case "spotify":
        return "assets/icons/spotify.png";
      case "local_music_player":
        return "assets/icons/music_note.png";
      case "apple_music":
        return "assets/icons/apple_music.png";
      case "youtube_music":
        return "assets/icons/youtube_music.png";
      default:
        return "assets/icons/music_note.png";
    }
  }

  Color darkenColor(Color fg, {Color bg = const Color.fromRGBO(66, 66, 66, 1), double amount = .1}) {
    return Color.alphaBlend(fg.withAlpha((255 * amount).toInt()), bg);
  }

  Color saturateColor(Color color, double amount) {
    HSVColor hsv = HSVColor.fromColor(color);
    double newSaturation = (hsv.saturation + amount).clamp(0.0, 1.0);
    return hsv.withSaturation(newSaturation).toColor();
  }
}
