import 'package:covid_19_app/Services/stats_services.dart';
import 'package:covid_19_app/View/detailed_screen.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      backgroundColor: const Color(0xff666666),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff666666),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.white),
                  hintText: 'Search with Country Name',
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.countriesListAPI(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator(color: Colors.white,)));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailedScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                    style: const TextStyle(
                                        color: Color(0xffC2C2C2),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag'],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (name.toLowerCase().contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailedScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag'],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
