import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/block_controller.dart';

import '../app_config.dart';
import '../utilits.dart';

class BlockList extends StatefulWidget {
  const BlockList({Key? key}) : super(key: key);

  @override
  State<BlockList> createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Block List",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color:AppUtilits.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          size: 30,//change size on your need
          color: Colors.black45,//change color on your need
        ),
      ),
      body: GetBuilder<BlockController>(
        init: BlockController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: controller.isLoading.value
                ? Center(child: CircularProgressIndicator(),)
                :controller.blockListModel.length == 0
                ? Center(
              child: Text("Block list is empty"),
            ) : ListView.builder(
              itemCount: controller.blockListModel.length,
              itemBuilder: (_, index){
                print(controller.blockListModel);
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.grey.shade200,
                        offset: Offset(0,2)
                      )
                    ]
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      child: controller.blockListModel?[index]["image"] == null
                          ? Image.asset("assets/images/profile.jpg")
                          : Image.network(
                        "${controller.blockListModel?[index]["image"]}",
                      errorBuilder:
                      (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image.asset("assets/images/profile.jpg");
                      },
                        height: 60, width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text("${controller.blockListModel?[index]["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("You can unblock."),
                    trailing: TextButton(
                      onPressed: (){
                        controller.unblock(context, "${controller.blockListModel?[index]["userId"]}");
                      },
                      child: Text("Unblock"),
                    ),
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }

}
