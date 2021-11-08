import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Statistical extends StatefulWidget {
  @override
  _StatisticalPage createState() => _StatisticalPage();
}
bool isViewAbsent = false;
List<String> content = ["Phần trăm tham dự", "Số người tham dự", "Só người vắng mặt", "Số người xem tài liệu"];
List<IconData> icon = [Icons.bar_chart, Icons.person_add, Icons.do_disturb_off_outlined, Icons.mark_chat_read];
List<String> data = ["91.04%", "437", "43", "301"];
class _StatisticalPage extends State<Statistical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_drop_down, size: 40.0,),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
        title: const Text(
          'Thống kê',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildChart(),
            _buildStatistical(),
            if(isViewAbsent == false)
              Text(
                'Nhấn vào cột vắng mặt để xem chi tiết lý do',
                style: TextStyle(
                  fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade400
                ),
              ),
            if(isViewAbsent == true)
              _buildAbsent(),
            //_buildStartPresent(),
          ],
        ),
      ),
    );
  }
  final List<ChartData> present = [
    ChartData('08:30', 54),
    ChartData('10:00', 47),
    ChartData('13:30', 78),
    ChartData('15:30', 38),
    ChartData('16:30', 48),
    ChartData('18:00', 68),
  ];

  final List<ChartData> absent = [
    ChartData('', 11),
    ChartData('', 12),
    ChartData('', 8),
    ChartData('', 2),
    ChartData('', 3),
    ChartData('', 7),
  ];

  final List<ChartData> viewDoc = [
    ChartData('', 50),
    ChartData('', 47),
    ChartData('', 68),
    ChartData('', 30),
    ChartData('', 48),
    ChartData('', 58),
  ];

  Widget _buildStatistical() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: MediaQuery.of(context).size.width * 0.9,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: false,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.indigo,
                      width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(
                          icon[index],
                          size: 30.0,
                          color:  Colors.indigo,
                        ),
                      ),
                      Container(
                        child: Text(
                          '${data[index]}',
                          style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${content[index]}',
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.blueGrey.shade400,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                );
            }
        ),
      ),
    );
  }

  Widget _buildChart(){
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              // Axis will be rendered based on the index values
                arrangeByIndex: true
            ),
            title: ChartTitle(text: 'Thống kê điểm danh cuộc họp theo ngày'),
            legend: Legend(isVisible: true),
            series: <ChartSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                color: Colors.indigo,
                dataSource: present,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                name: 'Tham dự',
              ),
              ColumnSeries<ChartData, String>(
                color: Colors.blueGrey,
                dataSource: viewDoc,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                name: 'Xem tài liệu',
              ),
              ColumnSeries<ChartData, String>(
                  color: Colors.redAccent,
                  dataSource: absent,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  name: 'Vắng mặt',
                  onPointTap: (ChartPointDetails details) {
                    print(details.pointIndex);
                    print(details.seriesIndex);
                    setState(() {
                      isViewAbsent = true;
                    });
                  }
              ),
            ]
        )
    );
  }

  Widget _buildAbsent() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          margin: EdgeInsets.only(top: 5.0),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.indigo,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              for(int i = 0; i < 2; i++)
                ListTile(
                  // leading: Container(
                  //   padding: EdgeInsets.all(10.0),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //     ),
                  //     borderRadius: BorderRadius.circular(30.0),
                  //
                  //   ),
                  //   child: Icon(
                  //     Icons.person,
                  //     size: 20.0,
                  //   ),
                  // ),
                  title: const Text('Nguyễn Văn A'),
                  subtitle: Container(
                    margin: EdgeInsets.only(left: 20.0),
                      child: Text('Có công tác tại thành phồ Bứu Điện để kiểm tra công việc điện')),
                  // trailing: Icon(Icons.delete, color: Colors.redAccent,),
                ),
            ],
          ),
        ),
        Positioned(
            left: 20,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              color: Colors.white,
              child: Text(
                'Lý do vắng mặt',
                style: TextStyle(color: Colors.indigo, fontSize: 12),
              ),
            )),
      ],
    );
  }

  Widget _buildStartPresent(){
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.12,
        margin: EdgeInsets.only(top: 10.0),
        child: GestureDetector(
          onTap: () {
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blueAccent
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.indigo
            ),
            child: const Text(
              "Bắt đầu điểm danh",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }

}
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
