import 'package:covid19_tracker_app/Services/states_services.dart';
import 'package:covid19_tracker_app/View/country_details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen>
    with TickerProviderStateMixin {
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices worldList = StateServices();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Country List'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: searchTextController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search Country',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: worldList.fetchCountryList(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade700,
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 90,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                      // return Expanded(
                      //     flex: 1,
                      //     child: SpinKitFadingCircle(
                      //       color: Colors.grey,
                      //       controller: _controller,
                      //     ));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String countryName = snapshot.data![index]['country'];
                          if (searchTextController.text.isEmpty) {
                            return ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context) => CountryDetails(
                                  flag: snapshot.data![index]['countryInfo']['flag'],
                                  country: snapshot.data![index]['country'],
                                  cases: snapshot.data![index]['cases'],
                                  deaths: snapshot.data![index]['deaths'],
                                  recovered: snapshot.data![index]['recovered'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                )));
                              },
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  'cases : ${snapshot.data![index]['cases']}'),
                            );
                          } else if (countryName.toLowerCase().contains(
                              searchTextController.text.toLowerCase())) {
                            return ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context) => CountryDetails(
                                  flag: snapshot.data![index]['countryInfo']['flag'],
                                  country: snapshot.data![index]['country'],
                                  cases: snapshot.data![index]['cases'],
                                  deaths: snapshot.data![index]['deaths'],
                                  recovered: snapshot.data![index]['recovered'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                )));
                              },
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  'cases : ${snapshot.data![index]['cases']}'),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
