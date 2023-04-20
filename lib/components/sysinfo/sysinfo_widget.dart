import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/sysinfo/sysinfo_controller.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';

class SysInfoWidget extends StatelessWidget {
  const SysInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SysInfoController>().infos;
    final List<Map<String, dynamic>> cpus = data
        .map(
          (e) => {"time": e.formatTime(), "cpu": e.cpu * 100},
        )
        .toList();
    final List<Map<String, dynamic>> memories = data
        .map(
          (e) => {"time": e.formatTime(), "memory": e.memory / (1024 * 1024)},
        )
        .toList();
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppStyle.light.withOpacity(0.75),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: AppStyle.chartWidth,
                height: AppStyle.chartHeight,
                child: Chart(
                  data: cpus,
                  variables: {
                    'Time': Variable(
                      accessor: (Map map) => map['time'] as String,
                      scale: OrdinalScale(tickCount: 5),
                    ),
                    'Cpu': Variable(
                      accessor: (Map map) => (map['cpu'] ?? double.nan) as num,
                    ),
                  },
                  marks: [
                    AreaMark(
                      shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
                      color: ColorEncode(
                          value: Defaults.colors10.first.withAlpha(80)),
                    ),
                    LineMark(
                      shape: ShapeEncode(value: BasicLineShape(smooth: true)),
                      size: SizeEncode(value: 0.5),
                    ),
                  ],
                  axes: [
                    Defaults.horizontalAxis,
                    Defaults.verticalAxis,
                  ],
                  selections: {
                    'touchMove': PointSelection(
                      on: {
                        GestureType.scaleUpdate,
                        GestureType.tapDown,
                        GestureType.longPressMoveUpdate
                      },
                      dim: Dim.x,
                    )
                  },
                  tooltip: TooltipGuide(
                    followPointer: [false, true],
                    align: Alignment.topLeft,
                    offset: const Offset(-20, -20),
                  ),
                  crosshair: CrosshairGuide(followPointer: [false, true]),
                ),
              ),
              SizedBox(
                width: AppStyle.chartWidth,
                height: AppStyle.chartHeight,
                child: Chart(
                  data: memories,
                  variables: {
                    'Time': Variable(
                      accessor: (Map map) => map['time'] as String,
                      scale: OrdinalScale(tickCount: 5),
                    ),
                    'Memory': Variable(
                      accessor: (Map map) =>
                          (map['memory'] ?? double.nan) as num,
                    ),
                  },
                  marks: [
                    AreaMark(
                      shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
                      color: ColorEncode(
                          value: Defaults.colors10.first.withAlpha(80)),
                    ),
                    LineMark(
                      shape: ShapeEncode(value: BasicLineShape(smooth: true)),
                      size: SizeEncode(value: 0.5),
                    ),
                  ],
                  axes: [
                    Defaults.horizontalAxis,
                    Defaults.verticalAxis,
                  ],
                  selections: {
                    'touchMove': PointSelection(
                      on: {
                        GestureType.scaleUpdate,
                        GestureType.tapDown,
                        GestureType.longPressMoveUpdate
                      },
                      dim: Dim.x,
                    )
                  },
                  tooltip: TooltipGuide(
                    followPointer: [false, true],
                    align: Alignment.topLeft,
                    offset: const Offset(-20, -20),
                  ),
                  crosshair: CrosshairGuide(followPointer: [false, true]),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                width: AppStyle.chartWidth,
                child: Center(
                  child: Text("CPU占用，单位：%"),
                ),
              ),
              SizedBox(
                width: AppStyle.chartWidth,
                child: Center(
                  child: Text("内存占用，单位：MB"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
