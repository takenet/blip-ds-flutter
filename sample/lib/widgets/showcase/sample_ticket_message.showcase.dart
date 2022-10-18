import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

class SampleTicketMessage extends StatelessWidget {
  const SampleTicketMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSTicketMessage(
          messageType: DSTicketMessageType.forwardedTicket,
          ticketNumber: '#2022000123',
          chatbotIdentity: 'Papagaio',
        ),
        const SizedBox(height: 20.0),
        DSTicketMessage(
          messageType: DSTicketMessageType.closedAttendant,
          agentIdentity: 'Jhon Doe',
        ),
        const SizedBox(height: 20.0),
        DSTicketMessage(
          messageType: DSTicketMessageType.closedCustomer,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
