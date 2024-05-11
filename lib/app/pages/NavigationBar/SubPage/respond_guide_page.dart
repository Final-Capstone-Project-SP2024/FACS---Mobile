import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RespondGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Action Checklist'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  _callEmergencyNumber();
                },
                child: Text('Call 114'),
              ),
              SizedBox(height: 16),
              ActionItem(
                title:
                    'If fire is suspected, activate the alarm, immediately call 114 (emergency for handling fire in Vietnam), alert others, and help remove anyone who needs assistance from the immediate danger of the fire or smoke.',
              ),
              ActionItem(
                title:
                    'Close all doors to confine and delay the spread of fire and smoke as much as possible.',
              ),
              ActionItem(
                title:
                    'When you hear the evacuation alarm, move to the nearest fire exit or fire exit staircase (do not use elevators).',
              ),
              ActionItem(
                title:
                    'Proceed to the designated evacuation assembly area outside the building unless directed to an alternate location.',
              ),
              ActionItem(
                title: 'If your clothing catches on fire, stop-drop-roll!',
              ),
              ActionItem(
                title:
                    'If you are trapped in a specific area, wedge wet clothing or towels under the door to keep out the smoke. Call 911 to notify authorities of your location.',
              ),
              ActionItem(
                title:
                    'Never use the palm of your hand or fingers to test for heat. Burning your palm or fingers could hamper your ability to crawl or use a ladder for escape.',
              ),
              ActionItem(
                title:
                    'Be prepared; know where you are and where the exits to the outside are located. If heavy smoke is present, crouch low or crawl. Hold breath as long as possible or breathe through your nose using handkerchief or shirt as a filter.',
              ),
              ActionItem(
                title:
                    'If you have to move through flames, hold your breath, move as quickly as you can, cover your head, and stay low.',
              ),
              ActionItem(
                title:
                    'If fire is contained to a small area and if it is safe to do so, use a fire extinguisher; pull safety pin from handle, aim at base of fire, squeeze the trigger handle, and sweep from side to side. (Watch for re-flash). Be familiar with how fire extinguisher operates.',
              ),
              ActionItem(
                title:
                    'Do not use water on an electrical fire. Use a fire extinguisher approved for electrical fires. Know where fire suppression equipment is maintained.',
              ),
              ActionItem(
                title:
                    'Smother oil and grease fires in a kitchen area with baking soda, salt or by putting a non-flammable lid over the flame.',
              ),
              ActionItem(
                title:
                    'If you cannot escape by a door or window, hang a white or light colored piece of clothing out the window to let firefighters know your location.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _callEmergencyNumber() async {
    const url = 'tel:114';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ActionItem extends StatelessWidget {
  final String title;

  const ActionItem({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• $title',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
