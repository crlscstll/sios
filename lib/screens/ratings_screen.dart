import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sios_app/services/services.dart';
import 'package:sios_app/theme/app_theme.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Apptheme.primarylight,
      ),
      body: FutureBuilder(
        future:
            Provider.of<RankingService>(context, listen: false).getRanking(),
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(15.0),
            child: Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, int index) => Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(snapshot.data.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
