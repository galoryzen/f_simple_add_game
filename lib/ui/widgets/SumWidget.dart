import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/SumController.dart';
import './OpWidget.dart';

class SumWidget extends StatelessWidget {
  const SumWidget({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    SumController controller = Get.find<SumController>();
    controller.setValues();
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(flex: 1),
                    Obx(() => Text(
                          'Score: ${controller.score}',
                          style: const TextStyle(
                            fontSize: 36,
                          ),
                          key: const Key('score'),
                        )),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.reset();
                        },
                        child: const Icon(Icons.replay),
                        key: const Key('reset'),
                      ),
                    )
                  ],
                )),
          ),
          flex: 1,
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue,
              child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OpWidget(text: controller.op1.toString()),
                        const OpWidget(text: '+'),
                        OpWidget(text: controller.op2.toString()),
                        const OpWidget(text: '='),
                        const OpWidget(text: '?'),
                      ])),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => resultButton(controller, controller.Rta[0])),
              Obx(() => resultButton(controller, controller.Rta[1])),
              Obx(() => resultButton(controller, controller.Rta[2])),
            ],
          ),
        )
      ],
    );
  }

  Widget resultButton(SumController controller, int value) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () => controller.onResultClick(value),
          child: Text(value.toString(),
              style: const TextStyle(
                fontSize: 40,
              ))),
    ));
  }
}
