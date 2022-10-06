import 'package:flutter/material.dart';

import 'package:blip_ds/blip_ds.dart';

/// Messages and warnings to be shown in agent and customer actions
///
/// Parameters [chatbotIdentity] and [agentIdentity] are sent to personalize the message.
/// Depending on the message type defined by the [messageType] parameter, other parameters
/// may or may not be mandatory.
class DSInformationMessage extends StatelessWidget {
  /// include the parameter [ticketNumber] to be displayed if the message type is [DSInformationMessageType.forwardedTicket]
  final String? ticketNumber;

  /// Enter [chatbotIdentity] to compose the message if it is of type [DSInformationMessageType.forwardedTicket]
  final String? chatbotIdentity;

  /// include the parameter [agentIdentity] to identify the attendant to compose the message if
  /// it is of type [DSInformationMessageType.closedAttendant]
  final String? agentIdentity;

  /// Possible message types can be [DSInformationMessageType.forwardedTicket],
  /// [DSInformationMessageType.closedAttendant] or [DSInformationMessageType.closedCustomer]
  final DSInformationMessageType messageType;

  final List<String> _message = [
    'Chatbot {chatbotIdentity} encaminhou a conversa para atendimento',
    'Atendente {agentIdentity} encerrou o atendimento',
    'Cliente encerrou o atendimento',
  ];

  DSInformationMessage({
    super.key,
    this.ticketNumber,
    this.agentIdentity,
    this.chatbotIdentity,
    required this.messageType,
  })  : assert((messageType == DSInformationMessageType.forwardedTicket)
            ? (ticketNumber != null &&
                chatbotIdentity != null &&
                ticketNumber.trim().isNotEmpty &&
                chatbotIdentity.trim().isNotEmpty)
            : true),
        assert((messageType == DSInformationMessageType.closedAttendant)
            ? (agentIdentity != null && agentIdentity.trim().isNotEmpty)
            : true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSBodyText(
          _prepareMessage(messageType),
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w400,
        ),
        if (messageType == DSInformationMessageType.forwardedTicket)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: DSBodyText(
              'Ticket $ticketNumber',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }

  String _prepareMessage(final DSInformationMessageType type) {
    switch (type) {
      case DSInformationMessageType.forwardedTicket:
        var message =
            _message.first.replaceAll('{chatbotIdentity}', chatbotIdentity!);
        return message;
      case DSInformationMessageType.closedAttendant:
        var message = _message[1].replaceAll('{agentIdentity}', agentIdentity!);
        return message;
      case DSInformationMessageType.closedCustomer:
        return _message[2];
    }
  }
}
