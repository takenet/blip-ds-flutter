## 0.0.48

* [DSTextFormField] Fixing focus on DSTextFormField.

## 0.0.47

* [DSTextFormField] Add onTap and onTapOutside on DSTextFormField.
## 0.0.46

* [DSToast] Toast layout adjustment.

## 0.0.45

* [DSAudioPlayer] Fixed audio player on iOS when reproducing .ogg files.

## 0.0.44

* Pipeline Fix

## 0.0.41

* [DSProgressBar] Added animation in progress bar.

## 0.0.40

* [DSProgressBar] Created the widget.

## 0.0.39

* New Widgets:
  * DSRecordStatus
  * DSAudioPlayer
  * DSAudioSeekBar
  * DSAudioSpeedButton
  * DSAudioCancelButton
  * DSAudioIconButton
  * DSAudioResumeButton
  * DSCustomRepliesIconButton
  * DSInputDecoration
* Changed Widgets:
  * [DSRoundedPlayButton] Now it uses an SVG as the main icon.
  * [DSPlayButton] Now it uses an SVG as the main icon.
  * [DSPauseButton] Now it uses an SVG as the main icon.
  * [DSButton] Changed padding between elements from 6.0 to 4.0.
  * [DSAudioPlayerController] Renamed from DSAudioMessageBubbleController
  * [DSAudioMessageBubble] The audio player (new DSAudioPlayer) was separated from this bubble, alongside with his seek bar and speed button.
  * [DSTextFormField] The input decoration (new DSInputDecoration) was separated from this widget.
* Miscellaneous:
  * Fixed some properties default values.
  * [Library] Removed comments to help indentation.
  * [Pubspec] Replaced ffmpeg_kit_flutter_audio (deprecated) by ffmpeg_kit_flutter.
* Tests
  * Updated goldens.
  

## 0.0.38

* [DSMessageBubble] Added hasSpacer attribute

## 0.0.37

* [DSMessageBubbleDetail] Fixed message status report expand

## 0.0.36

* [DSMessageBubbleDetail] Added detailWidget attribute
* [DSHeader] Added default value for systemOverlayStyle attribute
* [DSSystemOverlayStyle] Created new abstract class, with some default overlay styles

## 0.0.35

* [DSHeader] Added default StatusBar color

## 0.0.34

* [DSHeader] Adding bottom property on appbar
* [DSHeader] Fixes to use with media preview page

## 0.0.33

* [DSHeader] Ajust layout with horizontal screen

## 0.0.32

* [DSToast] Fixed toast overlap

## 0.0.31

* [DSText] Added selectable text feature

## 0.0.30

* [DSVideoPlayer] Alter to use FFmpegKit to encode video

## 0.0.29

* Fix Dart Analyzer warnings
* [DSDialogService] Change primaryButton to be nullable

## 0.0.28

* [DSAnimate] Created a utils class for animations 

## 0.0.27

* [DSDialogService] Improved readability
* [DSToast] Fixed icon size from undefined to 24.0
* [DSGroupCard] Added scroll controller property
* [DSLinearGradient] Added linear gradient widget

## 0.0.26

* [DSImageMessageBubble] Fixed image loading container
* [Sample] Updated deployment target version of iOS from 11.0 to 12.1

## 0.0.25

* [DSAudioMessageBubble] Fixes for ogg audio files
* [DSToastService] Added default duration for toasts
* [DSGroupCard] Added `formattedTicketId` in ticket card

## 0.0.24

* [DSInputChip] Fixes some problems with scroll

## 0.0.23

* Created a new design system widget `DSInputChip`

## 0.0.22

* [DSToast] Fixed animation when navigating between screens
* [DSBottomSheet] Removed `child` and created `builder` parameter
* General fixes

## 0.0.21

* Fix DSUserAvatar when user name contains number only

## 0.0.20

* Added support for ticket message style
* Added new loading spinner
* Bottom sheet fix

## 0.0.19

* Added support to web link bubble

## 0.0.18

* Some widget fixes and improvements

## 0.0.17

* Added unit e goldens tests
* Added support for email in text
* Added suport for Carousel message bubble

## 0.0.16

* Added support for design system Toast
* Added support for modal bottom sheet
* Added support for document select bubble
* Improved group card logic

## 0.0.15

* Added suport for ticket type bubble
* Added suport for image select menu
* Improved show more options in text and image bubble

## 0.0.14

* Added suport for Quick Reply and Select
* Added suport for Video messages
* Image message bubble size fixe

## 0.0.13

* Added delivery report & timestamp message widget
* Added DSHeader 
* Added DSGroupCard 
* Added DSRadio and DSRadioTile
* Added link preview to messages bubbles

## 0.0.12

* Add button styles
* Add unsupported content bubble
* Add file message bubble
* Add typing dots message bubble
* Add animated dots

## 0.0.11

* Add typography styles
* Add audio message bubble
* Add text message bubble

## 0.0.10

* Updated README thumbnail

## 0.0.9

* Updated README thumbnail

## 0.0.8

* Updated README thumbnail

## 0.0.7

* Updated README thumbnail

## 0.0.6

* Updated README thumbnail

## 0.0.6

* Updated README

## 0.0.4

* Updated README

## 0.0.3

* Changed pub credentials location

## 0.0.2

* Created CI Action

## 0.0.1

* Created project structure
