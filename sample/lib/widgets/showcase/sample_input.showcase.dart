import 'dart:developer';

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
          DSSearchInput(
            onClear: () {},
            onSearch: (_) {},
          ),
          DSPhoneInput(
            controller: controller,
            onChangeCountry: (country) => log(country.code),
            shouldFocus: true,
            hintText: '(54) 99209-9544',
            labelText: 'Telefone',
          ),
          DSPhoneInput(
            controller: controller,
            onChangeCountry: (country) => log(country.code),
            hintText: 'Telefone',
          ),
          const DSTextFormField(
            textInputType: TextInputType.name,
            labelText: 'Name',
          ),
        ],
      ),
    );
  }
}
