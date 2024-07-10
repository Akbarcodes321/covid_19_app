import 'package:covid_19_app/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailedScreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
  DetailedScreen({super.key,required this.name,required this.image,required this.totalCases,required this.totalRecovered,required this.totalDeaths,required this.active,required this.test,required this.todayRecovered,required this.critical});
  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  final colorList=<Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff666666),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff666666),
        title: Text(widget.name,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PieChart(dataMap: {
              "Total": double.parse(widget.totalCases.toString()),
              "Recovered":double.parse(widget.totalRecovered.toString()),
              "Deaths":double.parse(widget.totalDeaths.toString()),
            },
              chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true
              ),
              animationDuration: const Duration(milliseconds: 1200),
              chartRadius: 150,
              legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left,
                  legendTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)
              ),
              chartType: ChartType.ring,
              colorList: colorList,
            ),
          ),
          const SizedBox(height: 30,),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                  child: Card(
                    color: const Color(0xff666666),
                    child: Column(
                      children: [
                        const SizedBox(height: 100,),
                        ReusableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'Active', value: widget.active.toString()),
                        ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'Critical', value: widget.critical.toString()),
                        ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
          SizedBox(height: 100,)
        ],
      ),
    );
  }
}
