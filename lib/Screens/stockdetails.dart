import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockscan/Model/stockmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockDetail extends StatefulWidget {
  List<StockModel> stockdata;
  final index;
  StockDetail(this.stockdata, this.index, {super.key});

  @override
  State<StockDetail> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  late SharedPreferences prefs;
  @override
  void initState() {
    localstorage();
    // TODO: implement initState
    super.initState();
  }

// To store Variable data locally
  localstorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.stockdata[widget.index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: ListView.builder(
            itemCount: widget.stockdata[widget.index].criteria.length,
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //  height: 50,
                  color: Colors.grey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          children: [
                            for (String word in widget
                                .stockdata[widget.index].criteria[index].text
                                .split(' '))
                              if (word.startsWith('\$')) ...[
                                TextSpan(
                                  text: '$word ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      prefs.remove('selectedVariable');
                                      showBottomSheet(
                                          context,
                                          widget.stockdata[widget.index]
                                              .criteria[index].variable![word]);
                                    },
                                )
                              ] else ...[
                                TextSpan(text: '$word ')
                              ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })));
  }

// Display bottomsheet after click
  showBottomSheet(BuildContext context, variable) {
    List<num> numbers = variable.values;
    final List<String> strs = numbers.map((e) => e.toString()).toList();
    prefs.setStringList('selectedVariable', strs);
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10.0),
                variable.type == "indicator"
                    ? SizedBox(
                        height: 250,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("MinValue"),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      initialValue:
                                          variable.minValue.toString(),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("MaxValue"),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      initialValue:
                                          variable.maxValue.toString(),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(variable.parameterName),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      initialValue:
                                          variable.defaultValue.toString(),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: variable.values.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  variable.values[index].toString(),
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          );
                        }),
              ],
            ),
          ),
        );
      },
    );
  }
}
