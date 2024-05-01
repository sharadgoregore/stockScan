import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockscan/Model/stockmodel.dart';
import 'package:stockscan/Repository/stockapis.dart';
import 'package:stockscan/Screens/StockDetails.dart';
import 'package:stockscan/bloc/stockscan_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockscanBloc(Repository())..add(FetchPostEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("HomeScreen"),
        ),
        body: BlocBuilder<StockscanBloc, StockscanState>(
          builder: (context, state) {
            if (state is StockscanLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is StockscanLoadedState) {
              List<StockModel> stockdata = state.stocks;
              return ListView.builder(
                  itemCount: stockdata.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StockDetail(stockdata, index)),
                          );
                        },
                        child: Container(
                            color: Color.fromARGB(255, 64, 64, 64),
                            height: 70,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stockdata[index].name,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    stockdata[index].tag,
                                    style: TextStyle(
                                        color: stockdata[index].color == "red"
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
