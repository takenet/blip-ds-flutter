## 0.0.63

- Fixed line height for all DSTexts subtypes.

## 0.0.62

- [DSInputChip] Changed remove button icon from leading to trailing.
- [DSTextField] Removed Row CrossAxisAlignment
- [TagEditor] Formated file

## 0.0.61

- [DSToast] Fixed rendering of toast when action type was 'none'.

## 0.0.60

- [DSDialogService] fixing overflow of title on dialog 

## 0.0.59

- [DSTextFormField] fixing border color when focus change 
- [DSPhoneInput] Add a flag to show label text, and always show de flag 

## 0.0.58

- [DSInputChip] Fix text padding

## 0.0.57

- Upgraded major version of some packages
- [DSTextFormField] New widget to use inside a [Form]
- [DSContactMessageBubble] New widget to show the content of a WhatsApp contact message [Form]

## 0.0.56

- [DSDashedBorder] New widget that creates a dashed border container.
- [DSExpandedImage] New widget that show an imagem and opens up an image visualizer when tapped.
- [DSInputContainerShape] New enum that represents the shape of an input container.
- [DSVideoBody] New widget to video display (same layout as DSVideoMessageBubble, but without the bubble).
- [DSSurveyMessageBubble] New widget to display survey bubble.
- [Typography] Added line height props to all styles 
- [Typography] Fixed text height distribution behavior.
- [Typography] Fixed linkify when using WidgetSpan.
- [DSBottomSheetCountries] Fixed icon background color.
- [DSSearchInput] Improved color props.
- [DSFileExtensionIcon] Added defaultColor prop.
- [DSTextField] Removed requirement of controller prop.
- [DSInputContainer] Added shape selector prop.
- [Sample] Fixed sample bottom sheet showcase name.
- [DSTextField] Changed from DSTextFormField to DSTextField.

## 0.0.55

- [DSPhoneInput] Somes adjustment
- [DSMessageBubbleAvatarConfig] Create hideReceivedAvatar param

## 0.0.54

- [DSPhoneInput] Add country callback and text editing controller.

## 0.0.53

- [DSPhoneInput] Add phone input widget with selectable country.
- [DSSearchInput] Add search input widget.
  
## 0.0.52

- [DSSelectInput] Create a default scrollPhysics option.

## 0.0.51

- [DSDialogService] Fixed hasDialogOpen method. Created isDialogOpen property instead.

## 0.0.50

- [DSDialogService] Create hasDialogOpen method.

## 0.0.49

- Add font style prop to typography widgets.
- [DSBottomsheetService] Improve grabber visibility.
- [DSHeadlineLargeText] Fix default font weight.
- [DSSelectInput] Add select field (LOV) widget.

## 0.0.48

- [DSTextFormField] Fixing focus on DSTextFormField.

## 0.0.47

- [DSTextFormField] Add onTap and onTapOutside on DSTextFormField.

## 0.0.46

- [DSToast] Toast layout adjustment.

## 0.0.45

- [DSAudioPlayer] Fixed audio player on iOS when reproducing .ogg files.

## 0.0.44

- Pipeline Fix

## 0.0.41

- [DSProgressBar] Added animation in progress bar.

## 0.0.40

- [DSProgressBar] Created the widget.

## 0.0.39

- New Widgets:
  - DSRecordStatus
  - DSAudioPlayer
  - DSAudioSeekBar
  - DSAudioSpeedButton
  - DSAudioCancelButton
  - DSAudioIconButton
  - DSAudioResumeButton
  - DSCustomRepliesIconButton
  - DSInputDecoration
- Changed Widgets:
  - [DSRoundedPlayButton] Now it uses an SVG as the main icon.
  - [DSPlayButton] Now it uses an SVG as the main icon.
  - [DSPauseButton] Now it uses an SVG as the main icon.
  - [DSButton] Changed padding between elements from 6.0 to 4.0.
  - [DSAudioPlayerController] Renamed from DSAudioMessageBubbleController
  - [DSAudioMessageBubble] The audio player (new DSAudioPlayer) was separated from this bubble, alongside with his seek bar and speed button.
  - [DSTextFormField] The input decoration (new DSInputDecoration) was separated from this widget.
- Miscellaneous:
  - Fixed some properties default values.
  - [Library] Removed comments to help indentation.
  - [Pubspec] Replaced ffmpeg_kit_flutter_audio (deprecated) by ffmpeg_kit_flutter.
- Tests
  - Updated goldens.

## 0.0.38

- [DSMessageBubble] Added hasSpacer attribute

## 0.0.37

- [DSMessageBubbleDetail] Fixed message status report expand

## 0.0.36

- [DSMessageBubbleDetail] Added detailWidget attribute
- [DSHeader] Added default value for systemOverlayStyle attribute
- [DSSystemOverlayStyle] Created new abstract class, with some default overlay styles

## 0.0.35

- [DSHeader] Added default StatusBar color

## 0.0.34

- [DSHeader] Adding bottom property on appbar
- [DSHeader] Fixes to use with media preview page

## 0.0.33

- [DSHeader] Ajust layout with horizontal screen

## 0.0.32

- [DSToast] Fixed toast overlap

## 0.0.31

- [DSText] Added selectable text feature

## 0.0.30

- [DSVideoPlayer] Alter to use FFmpegKit to encode video

## 0.0.29

- Fix Dart Analyzer warnings
- [DSDialogService] Change primaryButton to be nullable

## 0.0.28

- [DSAnimate] Created a utils class for animations

## 0.0.27

- [DSDialogService] Improved readability
- [DSToast] Fixed icon size from undefined to 24.0
- [DSGroupCard] Added scroll controller property
- [DSLinearGradient] Added linear gradient widget

## 0.0.26

- [DSImageMessageBubble] Fixed image loading container
- [Sample] Updated deployment target version of iOS from 11.0 to 12.1

## 0.0.25

- [DSAudioMessageBubble] Fixes for ogg audio files
- [DSToastService] Added default duration for toasts
- [DSGroupCard] Added `formattedTicketId` in ticket card

## 0.0.24

- [DSInputChip] Fixes some problems with scroll

## 0.0.23

- Created a new design system widget `DSInputChip`

## 0.0.22

- [DSToast] Fixed animation when navigating between screens
- [DSBottomSheet] Removed `child` and created `builder` parameter
- General fixes

## 0.0.21

- Fix DSUserAvatar when user name contains number only

## 0.0.20

- Added support for ticket message style
- Added new loading spinner
- Bottom sheet fix

## 0.0.19

- Added support to web link bubble

## 0.0.18

- Some widget fixes and improvements

## 0.0.17

- Added unit e goldens tests
- Added support for email in text
- Added suport for Carousel message bubble

## 0.0.16

- Added support for design system Toast
- Added support for modal bottom sheet
- Added support for document select bubble
- Improved group card logic

## 0.0.15

- Added suport for ticket type bubble
- Added suport for image select menu
- Improved show more options in text and image bubble

## 0.0.14

- Added suport for Quick Reply and Select
- Added suport for Video messages
- Image message bubble size fixe

## 0.0.13

- Added delivery report & timestamp message widget
- Added DSHeader
- Added DSGroupCard
- Added DSRadio and DSRadioTile
- Added link preview to messages bubbles

## 0.0.12

- Add button styles
- Add unsupported content bubble
- Add file message bubble
- Add typing dots message bubble
- Add animated dots

## 0.0.11

- Add typography styles
- Add audio message bubble
- Add text message bubble

## 0.0.10

- Updated README thumbnail

## 0.0.9

- Updated README thumbnail

## 0.0.8

- Updated README thumbnail

## 0.0.7

- Updated README thumbnail

## 0.0.6

- Updated README thumbnail

## 0.0.6

- Updated README

## 0.0.4

- Updated README

## 0.0.3

- Changed pub credentials location

## 0.0.2

- Created CI Action

## 0.0.1

- Created project structure
