import 'package:covid19_tracker_app/View/country_list.dart';
import 'package:covid19_tracker_app/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatesModel.dart';
import '../Services/states_services.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  final colorList = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red,
  ];
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FutureBuilder(
                  future: stateServices.fetchWorldStateRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      print('null');
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.grey,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PieChart(
                            dataMap: {
                              'Total': double.parse(
                                  snapshot.data!.cases!.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              'Death': double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 0.2,
                            chartType: ChartType.ring,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                                legendShape: BoxShape.rectangle,
                                legendTextStyle: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w300,
                                )),
                            animationDuration: Duration(milliseconds: 2500),
                            colorList: colorList,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ResuableCards(
                                  title: 'Cases',
                                  value: snapshot.data!.cases.toString(),
                                ),
                                ResuableCards(
                                  title: 'Today Cases',
                                  value: snapshot.data!.todayCases.toString(),
                                ),
                                ResuableCards(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                ResuableCards(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                ResuableCards(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString(),
                                ),
                                ResuableCards(
                                  title: 'Active Cases',
                                  value: snapshot.data!.active.toString(),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:(context) => CountryListScreen()));
                    },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                    child: Text(
                                  'TRACK COUNTRIES',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                )),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ResuableCards extends StatelessWidget {
  String title, value;
  ResuableCards({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: Text(
                title,
                style: kResuableCardStyle,
              )),
              Text(
                value,
                style: kResuableCardStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
