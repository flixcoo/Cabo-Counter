import 'package:flutter/cupertino.dart';

class InformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Über'),
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Cabo Counter',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed '
              'diam nonumy eirmod tempor invidunt ut labore et dolore '
              'magna aliquyam erat, sed diam voluptua. At vero eos et '
              'accusam et justo duo dolores et ea rebum. Stet clita kasd '
              'gubergren, no sea takimata sanctus est Lorem ipsum dolor '
              'sit amet. Lorem ipsum dolor sit amet, consetetur '
              'sadipscing elitr, sed diam nonumy eirmod tempor invidunt '
              'ut labore et dolore magna aliquyam erat, sed diam '
              'voluptua. At vero eos et accusam et justo duo dolores et '
              'ea rebum. Stet clita kasd gubergren, no sea takimata '
              'sanctus est Lorem ipsum dolor sit amet.Lorem ipsum dolor '
              'sit amet, consetetur sadipscing elitr, sed diam nonumy '
              'eirmod tempor invidunt ut labore et dolore magna aliquyam '
              'erat, sed diam voluptua. At vero eos et accusam et justo '
              'duo dolores et ea rebum. Stet clita kasd gubergren, no '
              'sea takimata sanctus est Lorem ipsum dolor sit amet. ',
              textAlign: TextAlign.center,
            )
          ],
        )));
  }
}
