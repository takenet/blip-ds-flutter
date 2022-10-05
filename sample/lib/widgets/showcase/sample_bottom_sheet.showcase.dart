import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleBottomSheethowcase extends StatelessWidget {
  const SampleBottomSheethowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomSheet = DSBottomSheetService(
      context: context,
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
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: DSHeadlineLargeText('Bottomsheet'),
              ),
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          DSBodyText('This is a exemple'),
        ],
      ),
    );

    return Column(
      children: [
        DSBodyText('Bottom Sheet'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DSPrimaryButton(
              onPressed: () => bottomSheet.showDraggable(),
              label: 'resizable bottomsheet',
            ),
          ],
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
