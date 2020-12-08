import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart' as loc;

double score = 0;

class AutoList extends StatefulWidget {
  @override
  _AutoListState createState() => _AutoListState();
}

double calculate_score(
    var temp,
    var windspeed,
    var humidity,
    var rain,
    var imintemp,
    var imaxtemp,
    var mintemp,
    var maxtemp,
    var maxwindspeed,
    var iminhumidity,
    var imaxhumidity,
    var minhumidity,
    var maxhumidity,
    var minrain,
    var maxrain,
    var i) {
  score = 0;
  if (temp >= imintemp && temp <= imaxtemp) {
    //++
    score += 2;
  } else if (temp >= mintemp && temp <= maxtemp) {
    //+
    score += 1.5;
  } else {
    //-
  }

  if (windspeed <= maxwindspeed) {
    //++
    score += 2;
  } else {
    //-
  }

  if (humidity >= iminhumidity && humidity <= imaxhumidity) {
    //++
    score += 2;
  } else if (humidity >= minhumidity && humidity <= maxhumidity) {
    //+
    score += 1.5;
  } else {
    //-
  }
  var rain_1m =
      rain * 24 * 31; // rain for 1 month (not accurate, just prediction)
  if (rain_1m >= minrain && rain_1m <= maxrain) {
    //+
    score += 2;
  } else {
    //-
  }
  loc.crops[i].score=score;
  return score;
}

void sorting()
{
  for(int index=0;index<loc.crops.length;index++) {
    calculate_score(
        loc.temperature,
        loc.windspeed,
        loc.humidity,
        loc.rain,
        loc.crops[index].imintemp,
        loc.crops[index].imaxtemp,
        loc.crops[index].mintemp,
        loc.crops[index].maxtemp,
        loc.crops[index].maxwindspeed,
        loc.crops[index].iminhumidity,
        loc.crops[index].imaxhumidity,
        loc.crops[index].minhumidity,
        loc.crops[index].maxhumidity,
        loc.crops[index].minrain,
        loc.crops[index].maxrain,
        index);  }

  loc.crops.sort((a, b) => b.score.compareTo(a.score));
}
class _AutoListState extends State<AutoList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sorting();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "List of crops",
                style: kTempTextStyleResult,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Arranged based on predicted degree of yield score calculated from Current weather conditions of your location",
                style: kTempTextStyle,textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: loc.crops.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: Icon(Icons.arrow_forward_ios_outlined),
                          trailing: Text("${loc.crops[index].score
                              .toString()} / 8.0"
                            ,
                            style: TextStyle( color: Colors.green, fontSize: 20),
                          ),
                          title: Text("${loc.crops[index].name} ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
