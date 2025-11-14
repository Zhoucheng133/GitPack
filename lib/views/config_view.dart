import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpack/getx/controller.dart';
import 'package:gitpack/views/components/config_item.dart';
import 'package:path/path.dart' as p;

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {

  final Controller controller=Get.find();

  bool keepGit=false;
  String format='zip';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Column(
        children: [
          Obx(()=>
            ConfigItem(
              label: "仓库", 
              gap: 15,
              child: Text(
                p.basename(controller.repoPath.value),
                textAlign: TextAlign.left,
              ),
            )
          ),
          Obx(()=>
            ConfigItem(
              label: "路径", 
              gap: 15,
              child: Text(
                controller.repoPath.value,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ),
          ConfigItem(
            label: "保留Git信息", 
            gap: 5,
            child: Transform.scale(
              scale: 0.75,
              child: Switch(
                splashRadius: 0,
                value: keepGit, 
                onChanged: (val){
                  setState(() {
                    keepGit=val;
                  });
                }
              ),
            )
          ),
          const SizedBox(height: 5,),
          ConfigItem(
            label: "输出为", 
            height: null,
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: "zip", 
                      groupValue: format, 
                      splashRadius: 0,
                      onChanged: (val){
                        if(val!=null){
                          setState(() {
                            format=val;
                          });
                        }
                      }
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          format="zip";
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text("打包为zip文件")
                      )
                    )
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Radio(
                      value: "folder", 
                      groupValue: format, 
                      splashRadius: 0,
                      onChanged: (val){
                        if(val!=null){
                          setState(() {
                            format=val;
                          });
                        }
                      }
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          format="folder";
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text("导出目录")
                      )
                    )
                  ],
                ),
              ],
            )
          ),
          Expanded(child: Container()),
          Row(
            children: [
              Expanded(child: Container()),
              TextButton(
                onPressed: (){
                  controller.repoPath.value="";
                }, 
                child: Text("关闭")
              ),
              const SizedBox(width: 10,),
              FilledButton(
                onPressed: (){
                  // TODO 导出
                }, 
                child: Text("导出")
              )
            ],
          )
        ],
      ),
    );
  }
}