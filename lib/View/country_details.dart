import 'package:covid19_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  String country, flag;
  int cases, deaths, recovered, active, critical;
  CountryDetails({super.key,
    required this.flag,
    required this.country,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.critical,
  });

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067,right: 5,left: 5),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          ResuableCards(
                            title: 'country ',
                            value: widget.country.toString(),
                          ),
                          ResuableCards(
                            title: 'Cases ',
                            value: widget.cases.toString(),
                          ),
                          ResuableCards(
                            title: 'deaths ',
                            value: widget.deaths.toString(),
                          ),
                          ResuableCards(
                            title: 'recovered ',
                            value: widget.recovered.toString(),
                          ),
                          ResuableCards(
                            title: 'active ',
                            value: widget.active.toString(),
                          ),
                          ResuableCards(
                            title: 'critical ',
                            value: widget.critical.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(widget.flag.toString(),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
