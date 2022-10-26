import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class SampleBottomSheethowcase extends StatelessWidget {
  const SampleBottomSheethowcase({Key? key}) : super(key: key);

  Widget body(String text, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: DSHeadlineLargeText('Bottomsheet'),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        DSBodyText(text, overflow: TextOverflow.clip),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheetDraggable = DSBottomSheetService(
      context: context,
      child: body(
          lorem(
            words: 300,
            paragraphs: 1,
          ),
          context),
    );

    final bottomSheet = DSBottomSheetService(
      context: context,
      child: body(
          lorem(
            words: 50,
            paragraphs: 1,
          ),
          context),
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
