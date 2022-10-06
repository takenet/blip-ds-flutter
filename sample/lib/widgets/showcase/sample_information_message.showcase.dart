import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

class SampleInformationMessage extends StatelessWidget {
  const SampleInformationMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSInformationMessage(
          messageType: DSInformationMessageType.forwardedTicket,
          ticketNumber: '#2022000123',
          chatbotIdentity: 'Papagaio',
        ),
        const SizedBox(height: 20.0),
        DSInformationMessage(
          messageType: DSInformationMessageType.closedAttendant,
          agentIdentity: 'Jhon Doe',
        ),
        const SizedBox(height: 20.0),
        DSInformationMessage(
          messageType: DSInformationMessageType.closedCustomer,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
