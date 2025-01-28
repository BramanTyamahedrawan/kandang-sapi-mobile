import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hijauan_controller.dart';

class HijauanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menghubungkan controller ke dalam view
    final HijauanController controller = Get.find<HijauanController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Input untuk menambahkan hijauan
            TextField(
              onSubmitted: (value) {
                controller.addHijauan(value);
              },
              decoration: InputDecoration(
                labelText: 'Masukkan Hijauan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // List hijauan
            Obx(() => Expanded(
                  child: ListView.builder(
                    itemCount: controller.hijauanList.length,
                    itemBuilder: (context, index) {
                      final item = controller.hijauanList[index];
                      return ListTile(
                        title: Text(item),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.removeHijauan(item);
                          },
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
