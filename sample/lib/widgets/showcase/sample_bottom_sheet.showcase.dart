import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class SampleBottomSheethowcase extends StatelessWidget {
  const SampleBottomSheethowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomSheetDraggable = DSBottomSheetService(
      context: context,
      fixedHeader: Container(
        color: DSColors.neutralLightSnow,
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              DSHeadlineSmallText('Header'),
            ],
          ),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DSBodyText(
            lorem(
              words: 300,
              paragraphs: 1,
            ),
            overflow: TextOverflow.clip),
      ),
    );

    final bottomSheet = DSBottomSheetService(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: DSHeadlineLargeText('Bottomsheet'),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            DSBodyText(
                lorem(
                  words: 50,
                  paragraphs: 1,
                ),
                overflow: TextOverflow.clip),
          ],
        ),
      ),
    );

    return Column(
      children: [
        DSBodyText('Bottom Sheet'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => bottomSheetDraggable
                  .showDraggable()
                  .whenComplete(() => debugPrint('closed')),
              label: 'resizable bottomsheet',
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => bottomSheet.show(),
              label: 'fixed bottomsheet',
            ),
          ],
        ),
      ],
    );
  }
}
