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
          ticketId: '2022000123',
          chatbotIdentity: 'Papagaio',
          contentStatus: 'waiting',
        ),
        const SizedBox(height: 20.0),
        DSTicketMessage(
          messageType: DSTicketMessageType.closedAttendant,
          agentIdentity: 'Jhon Doe',
          contentStatus: 'waiting',
        ),
        const SizedBox(height: 20.0),
        DSTicketMessage(
          messageType: DSTicketMessageType.closedCustomer,
          contentStatus: 'waiting',
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
