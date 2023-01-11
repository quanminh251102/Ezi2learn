import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive_animation/screens/pronunciation/models/pronounciation_model.dart';
import '../service/pronunciation_service.dart';
import '../data/pronounciation_data.dart' as pronounciationData;

class PronounciationExecuteService extends StatefulWidget {
  const PronounciationExecuteService({super.key});

  @override
  State<PronounciationExecuteService> createState() =>
      _PronounciationExecuteServiceState();
}

class _PronounciationExecuteServiceState
    extends State<PronounciationExecuteService> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(pronounciationData.dataPro[0].title);
  }

  void _creat() async {
    print('Doing ......');
    for (PronuciationLessonModel item in pronounciationData.dataPro) {
      print(item.title);
      print("subtile ${item.subTilte}");
      await PronounciationService.Create(item);
    }
    print('Done');
  }

  void _read() async {
    print('Doing ......');
    List<PronuciationLessonModel>? list;
    String? id;
    list = await PronounciationService.Read(id);
    for (var item in list) {
      print(item.id.toString());
      print(item.toJson().toString());
    }
    PronuciationLessonModel item = list[0];
    item.title = "kiet";
    await PronounciationService.Update(item);
    print('Done');
  }

  void _update() async {
    print('Doing ......');
    print('Done');
  }

  void _delete() async {
    print('Doing ......');
    await PronounciationService.Delete("mP8K02DKfXHndeZk33sj");
    print('Done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CRUD')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(onPressed: () => _creat(), child: Text('Create')),
            ElevatedButton(onPressed: () => _read(), child: Text('Read')),
            ElevatedButton(onPressed: () => _update(), child: Text('Update')),
            ElevatedButton(onPressed: () => _delete(), child: Text('Delete'))
          ],
        ),
      ),
    );
  }
}
