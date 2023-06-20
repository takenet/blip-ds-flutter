import 'package:blip_ds/blip_ds.dart';
import 'package:flutter/material.dart';

class SampleInputShowcase extends StatelessWidget {
  SampleInputShowcase({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Wrap(
        runSpacing: 8.0,
        children: [
          DSPhoneInput(
            controller: controller,
            // ignore: avoid_print
            onChangeCountry: (country) => print(country.code),
          ),
          DSSearchInput(
            onClear: () {},
            onSearch: (_) {},
          ),
          const DSTextFormField(
            textInputType: TextInputType.name,
          ),
        ],
      ),
    );
  }
}
