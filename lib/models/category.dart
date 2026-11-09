import 'package:flutter/material.dart';

enum Category {
  greetings('Greetings and Goodbyes', Icons.waving_hand),
  daily('Daily Conversations', Icons.chat_bubble_outline),
  education('Education', Icons.school),
  introductions('Introductions', Icons.handshake),
  food('Food and Drinks', Icons.restaurant),
  howAreYou('How are you', Icons.sentiment_satisfied),
  endingAndStarting(
    'Ending and Starting a Conversation',
    Icons.chat_bubble_outline,
  );

  const Category(this.label, this.icon);

  final String label;
  final IconData icon;

  List<Subcategory> get subcategories =>
      Subcategory.values.where((s) => s.parent == this).toList();
}

enum Subcategory {
  generalGreetings('General Greetings', Icons.waving_hand, Category.greetings),
  greetingsForVariousTimes(
    'Greetings for Various Times',
    Icons.access_time,
    Category.greetings,
  ),
  longTimeNoSee(
    'Greeting Someone You Haven\'t Seen in a Long Time',
    Icons.history,
    Category.greetings,
  ),
  expressingSurprise(
    'Expressing Surprise at Meeting Someone',
    Icons.celebration,
    Category.greetings,
  ),
  simpleGoodbyes('Simple Goodbyes', Icons.front_hand, Category.greetings),
  leavingPlace('Leaving a Place', Icons.directions_walk, Category.greetings),
  keepInTouch('How to Keep in Touch', Icons.phone_in_talk, Category.greetings),
  introduceYourself('Introduce Yourself', Icons.person, Category.introductions),
  introducingSomeoneToSomeoneElse(
    'Introducing Someone to Someone Else',
    Icons.people,
    Category.introductions,
  ),
  justIntroduced(
    'When You Have Just Been Introduced',
    Icons.handshake,
    Category.introductions,
  ),
  faceToFace(
    'So We Finally Meet Face-to-Face',
    Icons.face,
    Category.introductions,
  ),
  askingHowSomeoneIs(
    '01 Asking How Someone is',
    Icons.help_outline,
    Category.howAreYou,
  ),
  askingHowThingsAreGoing(
    '02 Asking Someone How Things are Going',
    Icons.update,
    Category.howAreYou,
  ),
  whatToSayIfOkay(
    '03 What to say if you are okay',
    Icons.thumb_up_alt_outlined,
    Category.howAreYou,
  ),
  neitherOkayNorBad(
    'If you\'re neither okay nor bad',
    Icons.sentiment_neutral,
    Category.howAreYou,
  ),
  explainingBusy(
    '04 Explaining that you have been busy',
    Icons.hourglass_bottom,
    Category.howAreYou,
  ),
  startingInformalConversation(
    '01 Starting an informal conversation',
    Icons.waving_hand,
    Category.endingAndStarting,
  ),
  invitingSomeoneToTalk(
    '02 Inviting someone to talk',
    Icons.forum_outlined,
    Category.endingAndStarting,
  ),
  requestingGetToPoint(
    '03 Requesting that the speaker get to the point',
    Icons.flag_outlined,
    Category.endingAndStarting,
  ),
  variousConversationalPhrases(
    '04 Various conversational phrases',
    Icons.format_quote,
    Category.endingAndStarting,
  ),
  encouragingPlainSpeech(
    '05 Encouraging someone to speak plainly',
    Icons.record_voice_over,
    Category.endingAndStarting,
  ),
  repeatingWhatYouSaid(
    '06 Repeating what you have said',
    Icons.repeat,
    Category.endingAndStarting,
  ),
  repetitiveSpeaker(
    '07 When someone is being repetitious',
    Icons.loop,
    Category.endingAndStarting,
  ),
  answersHowDidYouFindOut(
    '08 Answers to "How did you find out?"',
    Icons.search,
    Category.endingAndStarting,
  ),
  commonKnowledge(
    '09 When something is common knowledge',
    Icons.lightbulb_outline,
    Category.endingAndStarting,
  ),
  endingConversation(
    '10 How to end a conversation',
    Icons.check_circle_outline,
    Category.endingAndStarting,
  ),
  endingAbruptly(
    '11 Ending a conversation abruptly',
    Icons.directions_run,
    Category.endingAndStarting,
  );

  const Subcategory(this.label, this.icon, this.parent);

  final String label;
  final IconData icon;
  final Category parent;
}
