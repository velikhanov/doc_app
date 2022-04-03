import 'package:doc_app/chat/user_model.dart';

class Message {
  final User sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;

  Message(
    this.sender,
    this.time,
    this.text,
    this.unread,
  );
}

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    ironMan,
    '5:30 PM',
    'Hey dude! Even dead I\'m the hero. Love you 3000 guys.',
    true,
  ),
  Message(
    captainAmerica,
    '4:30 PM',
    'Hey, how\'s it going? What did you do today?',
    true,
  ),
  Message(
    blackWindow,
    '3:30 PM',
    'WOW! this soul world is amazing, but miss you guys.',
    false,
  ),
  Message(
    spiderMan,
    '2:30 PM',
    'I\'m exposed now. Please help me to hide my identity.',
    true,
  ),
  Message(
    hulk,
    '1:30 PM',
    'HULK SMASH!!',
    false,
  ),
  Message(
    thor,
    '12:30 PM',
    'I\'m hitting gym bro. I\'m immune to mortal deseases. Are you coming?',
    false,
  ),
  Message(
    scarletWitch,
    '11:30 AM',
    'My twins are giving me headache. Give me some time please.',
    false,
  ),
  Message(
    captainMarvel,
    '12:45 AM',
    'You\'re always special to me nick! But you know my struggle.',
    false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    ironMan,
    '5:30 PM',
    'Hey dude! Event dead I\'m the hero. Love you 3000 guys.',
    false,
  ),
  Message(
    currentUser,
    '4:30 PM',
    'We could surely handle this mess much easily if you were here.',
    true,
  ),
  Message(
    ironMan,
    '3:45 PM',
    'Take care of peter. Give him all the protection & his aunt.',
    true,
  ),
  Message(
    ironMan,
    '3:15 PM',
    'I\'m always proud of her and blessed to have both of them.',
    true,
  ),
  Message(
    currentUser,
    '2:30 PM',
    'But that spider kid is having some difficulties due his identity reveal by a blog called daily bugle.',
    true,
  ),
  Message(
    currentUser,
    '2:30 PM',
    'Pepper & Morgan is fine. They\'re strong as you. Morgan is a very brave girl, one day she\'ll make you proud.',
    true,
  ),
  Message(
    currentUser,
    '2:30 PM',
    'Yes Tony!',
    true,
  ),
  Message(
    ironMan,
    '2:00 PM',
    'I hope my family is doing well.',
    true,
  ),
];