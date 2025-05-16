## 0.3.9

- Fixed iOS audio player reproduction.

## 0.3.8

- Remove dependency from ffmpeg_kit_flutter_full_gpl package

## 0.3.7

- [DSGroupCard] Added dark color to scroll button.

## 0.3.6

- Improved link color contrast in Dark Mode.

## 0.3.5

- Added support for Reactions.

## 0.3.4

- Added support to Dark Mode.

## 0.3.3

- [DSTabBar] Added new widget based on Material TabBar.

## 0.3.2

- [DSGroupCard] Fixed avatar with `simpleStyle` param.

## 0.3.1

- [DSGroupCard] Improved the scrolling of reply messages

## 0.3.0

- Added support to new Flutter version (3.27.1)

## 0.2.6

- [DSVideoMessageBubble] Fix when thumbnail is unavailable.

## 0.2.5

- [DSImageMessageBubble] Fix when channel is instagram.

## 0.2.4

- [DSSecurityService] Add service to manage security features.

## 0.2.3

- [DSPhoneInput] Add support to select current country code.

## 0.2.2

- [DSButton] Removed border color when `borderColor` property is not informed.

## 0.2.0

- [DSEndCallsMessageBubble] Fixed layout when used by small screens.

## 0.1.9

- [DSEndCallsMessageBubble] Removed load recording state when session doesn't have available recording.
  
## 0.1.8

- Added translation to all hard coded texts.

## 0.1.7

- Upgraded dependencies.

## 0.1.6

- Added several widgets to support Blip Calls.

## 0.1.5

- [DSDarkColors] Added new Dark theme colors.

## 0.1.4

- [DSInteractiveVoiceCallMessageBubble] Added new bubble to render the request call message.

## 0.1.3

- [DSIcons] Added new icons.

## 0.1.2

- [DSLocationMessageBubble] Added app selection when touching the map preview.

## 0.1.1

- [DSVideoMessageBubble] Added title to this bubble.
- [DSUrlPreview] Added visual feedback when tapped.

## 0.1.0

- [DSExpandedImage] Fixed image layout when expanded.

## 0.0.99

- [DSTicketMessage] Added ```contentStatus``` property.
- [DSStringExtension] Added a new string extension ```DSStringExtension``` .

## 0.0.98

- [DSGroupCard] Added ```key``` property to DSCard.

## 0.0.97

- [DSFileMessageBubble] Added media ```text``` as property so it'll be displayed along with the file itself.
- [DSUserAvatar] Fixed overflow when passing a custom ```textStyle```.

## 0.0.96

- [DSHeadlineExtraLargeTextStyle] Created text style primarily used by extra large titles.
- [DSHeadlineExtraLargeText] Created text that uses ```DSHeadlineExtraLargeTextStyle``` as style.
- [DSUserAvatar] Added ```textStyle``` property to allow customizing the style of font used by name initials.

## 0.0.95

- [DSFileService] Fixed ```getExtensionFromMimeType``` method to get mime type based on RegEx.

## 0.0.94

- [DSExpandedImage] Centered the circular progress loading.

## 0.0.93

- [DSColors] Added a new color.

## 0.0.92

- [DSMediaFormatService] Added a method to compress images.

## 0.0.91

- [DSSelectMenu] Added check to see if options exists before building them.
- [DSExpandedImage] Centered icon that appears when the image is broken.

## 0.0.90

- [DSReplyContainer] Created the widget.
- [DSUploading] Created the widget.

## 0.0.89

- [DSInteractiveButtonMessageBubble] Fixed border radius behavior.
- [DSInteractiveListMessageBubble] Fixed border radius behavior.

## 0.0.88

- [DSApplicationJsonMessageBubble] Added support for interactive lists and buttons.

## 0.0.87

- [DSCircularProgress] Added widget to build circular progress indicator.
- [DSSearchInput] Added ```enabled``` property.

## 0.0.86

- [DSMediaFormatService] Added service to format all kinds of media, like audios and videos.
- [DSAudioPlayer] Play audio from local storage when available.
- [DSFileService] Improved download method to get extension based on mime type.

## 0.0.85

- [DSVideoMessageBubble] Added a progressive loading

## 0.0.84

- [DSImageMessageBubble] Improved the performance of the image bubble
- [DSVideoMessageBubble] Improved the video storage

## 0.0.83

- [DSCard] Accept reply messages
- [DSMessageContentType] Add reply as content type 

## 0.0.82

- [DSAudioPlayer] Improved the audio player initialization 

## 0.0.81

- [FFMPEG] Downgraded ffmpeg dependency version from 6.0.2 to 5.1.0

## 0.0.80

- [FFMPEG] Upgraded ffmpeg dependency version from 5.1.0 to 6.0.3
- [FFMPEG] Added double quotes in commands

## 0.0.79

- [FFMPEG] Downgraded ffmpeg dependency version from 6.0.2 to 5.1.0

## 0.0.78

- [DSSpinnerLoading] Set a default color

## 0.0.77

- [DSFileService] Created new `getFileExtensionFromMimeType` method
- [DSFileMessageBubble] Removed `shouldLinkify` prop from `DSText`
- [DSCard] Added fallback to filename when it's null

## 0.0.76

- [DSColors] Added a new color
- [DSDeliveryStatusReport] Added new status report
- [DSDeliveryReportIcon] Add new icon to new status report type

## 0.0.75

- [DSChip] Added a new height param to widget
- [DSMessageItemModel] Added new customer map property
- [DSCard] Added new customer map property; Improve Media view for tunnel users

## 0.0.74

- [DSChip] Set shape to circle when text is null;
- [DSLocationMessageBubble] Add a broken file image when receive invalid coordinates

## 0.0.73

- [DSColors] Fixed system color;

## 0.0.72

- [DSColors] Fixed system color;
- [DSAnimate] Added check to see if scrollController has clients.

## 0.0.71

- [DSGroupCard] Changed to check date difference in seconds;

## 0.0.70

- [DSLocationMessageBubble] Fixed card when latitude or longitude have invalid values;

## 0.0.69

- [DSTextField] Added new param to set autofocus;

## 0.0.68

- [DSApplicationJsonMessageBubble] New widget to support DSUnsupportedContentMessageBubble;
- Fix overflow on DSUnsupportedContentMessageBubble;
- Add DSApplicationJsonMessageBubble in DSCard;

## 0.0.67

- [DSColors] Added new color.
- [DSVideoMessageBubble] Fix to play videos from instagram.

## 0.0.66

- [DSRequestLocationButton] New widget to show the button of request of location.
- [DSRequestLocationMessageBubble] New widget to show the request of location.
- [DSBubbleUtils] New widget to utils bubble.

## 0.0.65

- [DSLocationMessageBubble] Fixed parse when latitude and longitude value is large.

## 0.0.64

- [DSLocationMessageBubble] New widget to show the content of location card
- [DSTextField] Altered to show the error message on input validation
- [DSInputContainer] Added a hasError param to show an error border

## 0.0.63

- [DSAuthService] New service that handles HTTP Requests authentication.
- Added ```shouldAuthenticate``` prop to media widgets so they can use the new HTTP authorization header.
- Improved exception handling of all media widgets, services and utils.
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
