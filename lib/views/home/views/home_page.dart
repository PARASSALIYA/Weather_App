import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/provider/home_provider.dart';

import '../../../utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider providerW;
  late HomeProvider providerR;
  @override
  void initState() {
    context.read<HomeProvider>().getWetherHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();

    TextEditingController textController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: providerR.getWetherHelper == null
            ? const Center(
                heightFactor: 25,
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    height: h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          providerR.getTempBg(
                              "${providerW.wetherModel?.weather?[0].main}"),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 45, right: 8, left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, Routes.search);
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.black, size: 30),
                                ),
                                const Text(
                                  "Weather",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onLongPress: () {
                                    Navigator.pushNamed(
                                        context, Routes.bookmark);
                                  },
                                  child: IconButton(
                                    onPressed: () {
                                      String city = textController.text;
                                      providerW.bookmarkCity(city);
                                      if (providerW.bookMark.contains(city)) {
                                        providerR.bookMark
                                            .remove(providerW.wetherModel!);
                                      }
                                      providerR.bookMark
                                          .add(providerR.wetherModel!);
                                    },
                                    icon: const Icon(
                                      Icons.bookmark_add_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          TextField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: textController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              hintText: "Enter City",
                              hintStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  providerW.selectedCity = textController.text;
                                  providerR.getWetherHelper();
                                  providerR.setSearch(providerW.selectedCity);
                                  textController.clear();
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onSubmitted: (val) {
                              providerW.selectedCity = val;
                              providerW.selectedCity = textController.text;
                              providerR.getWetherHelper();
                              providerR.setSearch(providerW.selectedCity);
                              textController.clear();
                            },
                          ),
                          SizedBox(
                            height: h * 0.04,
                          ),
                          Text(
                            "${providerW.wetherModel?.name}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: h * 0.001,
                          ),
                          Text(
                            "${providerW.wetherModel?.weather?[0].main}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          SizedBox(height: h * 0.01),
                          Text(
                            "${(providerW.wetherModel?.main?.temp!.toInt())}°C",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 95,
                                color: Colors.black),
                          ),
                          SizedBox(height: h * 0.001),
                          Text(
                            "${providerW.days[DateTime.now().weekday]},${DateTime.now().day} ${providerW.months[DateTime.now().month]}",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.black),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/wind.png',
                                        width: 52,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: h * 0.01),
                                      Text(
                                        "${providerW.wetherModel?.wind?.speed?.toStringAsFixed(1)} km/h",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      SizedBox(height: h * 0.01),
                                      const Text(
                                        "Wind",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(height: h * 0.01),
                                      const Center(
                                        child: Icon(Icons.water_drop,
                                            size: 28, color: Colors.black),
                                      ),
                                      SizedBox(height: h * 0.02),
                                      Text(
                                        "${providerW.wetherModel?.main?.humidity}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: h * 0.02),
                                      const Text(
                                        "Humidity",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/gif/weather_sky.gif',
                                        width: 32,
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: h * 0.02),
                                      Text(
                                        "${providerW.wetherModel?.main?.pressure?.toStringAsFixed(1)} km/h",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: h * 0.01),
                                      const Text(
                                        "Pressure",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          Text(
                            "Visibility : ${providerW.wetherModel?.visibility}m",
                            style: const TextStyle(
                                fontSize: 25, color: Colors.black),
                          ),
                          SizedBox(height: h * 0.02),
                          const Divider(
                            color: Colors.black,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${providerW.wetherModel?.coord?.lon}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01),
                                    const Text(
                                      "Longitude",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${providerW.wetherModel?.coord?.lat}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01),
                                    const Text(
                                      "Latitude",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
