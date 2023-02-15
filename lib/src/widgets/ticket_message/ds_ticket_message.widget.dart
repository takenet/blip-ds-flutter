import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

/// Messages and warnings to be shown in agent and customer actions
///
/// Parameters [chatbotIdentity] and [agentIdentity] are sent to personalize the message.
/// Depending on the message type defined by the [messageType] parameter, other parameters
/// may or may not be mandatory.
class DSTicketMessage extends StatelessWidget {
  /// include the parameter [ticketId] to be displayed if the message type is [DSTicketMessageType.forwardedTicket]
  final String? ticketId;

  /// Enter [chatbotIdentity] to compose the message if it is of type [DSTicketMessageType.forwardedTicket]
  final String? chatbotIdentity;

  /// include the parameter [agentIdentity] to identify the attendant to compose the message if
  /// it is of type [DSTicketMessageType.closedAttendant]
  final String? agentIdentity;

  /// Possible message types can be [DSTicketMessageType.forwardedTicket],
  /// [DSTicketMessageType.closedAttendant] or [DSTicketMessageType.closedCustomer]
  final DSTicketMessageType messageType;

  final _message = <String>[
    'Chatbot {chatbotIdentity} encaminhou a conversa para atendimento',
    'Atendente {agentIdentity} encerrou o atendimento',
    'Cliente encerrou o atendimento',
  ];

  DSTicketMessage({
    super.key,
    this.ticketId,
    this.agentIdentity,
    this.chatbotIdentity,
    required this.messageType,
  })  : assert((messageType == DSTicketMessageType.forwardedTicket)
            ? (ticketId != null &&
                chatbotIdentity != null &&
                ticketId.trim().isNotEmpty &&
                chatbotIdentity.trim().isNotEmpty)
            : true),
        assert((messageType == DSTicketMessageType.closedAttendant)
            ? (agentIdentity != null && agentIdentity.trim().isNotEmpty)
            : true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Column(
        children: [
          DSBodyText(
            _prepareMessage(messageType),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.w400,
            isSelectable: true,
          ),
          if (messageType == DSTicketMessageType.forwardedTicket)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: DSBodyText(
                'Ticket $ticketId',
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w700,
                isSelectable: true,
              ),
            ),
        ],
      ),
    );
  }

  /// Prepare messages with parameters to be displayed
  String _prepareMessage(final DSTicketMessageType type) {
    switch (type) {
      case DSTicketMessageType.forwardedTicket:
        var message =
            _message.first.replaceAll('{chatbotIdentity}', chatbotIdentity!);
        return message;
      case DSTicketMessageType.closedAttendant:
        var message = _message[1].replaceAll('{agentIdentity}', agentIdentity!);
        return message;
      case DSTicketMessageType.closedCustomer:
        return _message[2];
    }
  }
}
