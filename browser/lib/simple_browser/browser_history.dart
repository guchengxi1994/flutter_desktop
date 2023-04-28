// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

typedef FetchData = Future<List<String>> Function(int);

const String sep = "===>";

class HistoryDetails {
  final String url;
  final String date;
  final String time;
  final int hour;
  HistoryDetails(
      {required this.date,
      required this.time,
      required this.url,
      required this.hour});
}

class BrowserHistoryWidget extends StatefulWidget {
  const BrowserHistoryWidget({super.key, required this.fetchData});
  final FetchData fetchData;

  @override
  State<BrowserHistoryWidget> createState() => _BrowserHistoryWidgetState();
}

class _BrowserHistoryWidgetState extends State<BrowserHistoryWidget> {
  Map<String, List<HistoryDetails>> data = {};
  int currentIndex = 0;
  bool hasMore = true;
  bool isLoading = false; //是否正在加载数据

  final ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint('滑动到了最底部');
        _getMore();
      }
    });
  }

  void listToMap(List<String> ls) {
    for (final s in ls) {
      final l = s.split(sep);
      final time = l.removeAt(0);
      final url = l.join("");
      final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time) * 1000);
      final _date = "${date.year}年${date.month}月${date.day}日";
      if (data.keys.contains(_date)) {
        data[_date]!.add(HistoryDetails(
            date: _date,
            time: "${date.hour}:${date.minute}",
            url: url,
            hour: date.hour));
      } else {
        data[_date] = [
          HistoryDetails(
              date: _date,
              time: "${date.hour}:${date.minute}",
              url: url,
              hour: date.hour)
        ];
      }
    }
  }

  Future getData() async {
    final l = await widget.fetchData(currentIndex);
    if (l.length < 20) {
      hasMore = false;
    } else {
      currentIndex += 1;
    }
    listToMap(l);
    setState(() {});
  }

  Future _onRefresh() async {
    currentIndex = 0;
    await getData();
  }

  Future _getMore() async {
    if (hasMore) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        await getData();
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: data.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '加载中...',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 1.0,
                  )
                ],
              )
            : const Text("无记录"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.chevron_left),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemBuilder: _renderRow,
          itemCount: data.length + 1,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < data.length) {
      final key = data.keys.toList()[index];
      final v = data[key];
      if (v == null) {
        return Card(
          elevation: 4,
          child: Container(
            height: 50,
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key),
            ),
          ),
        );
      }
      return Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(key),
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(15),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: v
              //       .map((e) => SizedBox(
              //             height: 30,
              //             child: Row(
              //               children: [Text(e.time), Text(e.url)],
              //             ),
              //           ))
              //       .toList(),
              // ),
              child: _buildRecords(v),
            )
          ],
        ),
      );
    }
    return Visibility(
        visible: isLoading,
        maintainSize: true,
        maintainState: true,
        maintainAnimation: true,
        child: _getMoreWidget());
  }

  Widget _buildRecordRow(HistoryDetails d) {
    return Row(
      children: [
        Text(d.time),
        const SizedBox(
          width: 25,
        ),
        Text(d.url)
      ],
    );
  }

  Widget _buildRecords(List<HistoryDetails> d) {
    if (d.isEmpty) {
      return const Text("无记录");
    }
    List<Widget> w = [];
    for (int i = 0; i < d.length; i++) {
      if (i == 0) {
        w.add(SizedBox(
          height: 30,
          child: _buildRecordRow(d[i]),
        ));
      } else {
        if (d[i].hour != d[i - 1].hour) {
          w.add(const SizedBox(
            height: 30,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
          ));
        } else {
          w.add(SizedBox(
            height: 30,
            child: _buildRecordRow(d[i]),
          ));
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: w,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
