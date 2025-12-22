import 'package:flutter/material.dart';
import 'package:vtapp/models/spotlight_model.dart';
import 'package:vtapp/parser/spotlight_parser.dart';
import 'package:vtapp/session.dart';
import 'package:vtapp/parser/spotlightdta.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotlightWid extends StatefulWidget {
  const SpotlightWid({super.key});

  @override
  State<SpotlightWid> createState() => _SpotlightWidState();
}

class _SpotlightWidState extends State<SpotlightWid> {
  bool _loading = true;

  Future<void> fetchSpotlightinSession() async {
    Session.spotlighthtml = await GetDataSpotlight().fetchSpotlight();
    Session.spotlightItem = parseSpotlight();
    setState(() => _loading = false);
  }
  @override
  void initState(){
    super.initState();
    fetchSpotlightinSession();
  }
  @override
  Widget build(BuildContext context) {
    final spotlight = Session.spotlightItem;
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children:[Text("Spotlight",style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),),
      Expanded(child: ListView.builder(itemCount:spotlight!.length ,itemBuilder: (context,index)
          {
            SpotlightItem items = spotlight[index];
            print(items.type);
            if (items.type == SpotlightItemType.download){
              return Card(
              child: ListTile(
                title: Text(items.title),
                leading: IconButton(onPressed: () async{
                  await launchUrl(Uri.parse(items.url),mode: LaunchMode.externalApplication);
                }, icon: Icon(Icons.download)),
              ),
            );
            }
            else if (items.type == SpotlightItemType.externalLink){
              return Card(
              child: ListTile(
                title: Text(items.title),
                leading: IconButton(onPressed: () async{
                  await launchUrl(Uri.parse(items.url),mode: LaunchMode.externalApplication);
                }, icon: Icon(Icons.link_sharp)),
              ),
            );
            }
            return Card(
              child: ListTile(
                title: Text(items.title),
                onTap: () async{
                  final uri = Uri.parse("${items.type}");
                  if (!await launchUrl(uri)){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Couldnt Open link"),duration: Duration(seconds: 2),));
                  }
                },
              ),
            );
          }))] 
      );
  }
}