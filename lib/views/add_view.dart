import 'dart:ffi';
import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitpack/functions/dialog_handler.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

typedef RepoCheckDart = int Function(Pointer<Utf8>);
typedef RepoCheck = Int Function(Pointer<Utf8>);

class _AddViewState extends State<AddView> {

  static int repoCheckHandler(String repoPath){
    final dynamicLib=DynamicLibrary.open(Platform.isMacOS ? 'core.dylib' : 'core.dll');
    final RepoCheckDart checkRepo=dynamicLib
    .lookup<NativeFunction<RepoCheck>>("RepoCheck")
    .asFunction();

    return checkRepo(repoPath.toNativeUtf8());
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) async {
        String repoPath=detail.files.first.path;
        final type = await FileSystemEntity.type(repoPath);
        if(type!=FileSystemEntityType.directory && context.mounted){
          warnDialog(context, "打开Git仓库失败", "这不是一个目录");
          return;
        }

        final isRepo=await compute(repoCheckHandler, repoPath);

        if(isRepo!=1 && context.mounted){
          warnDialog(context, "打开Git仓库失败", "不是一个合法的Git仓库或者没有.gitignore文件");
        }
      },
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: (){}, 
                  icon: Icon(Icons.add_rounded),
                ),
                const SizedBox(height: 5,),
                Text("选择Git仓库或者拖拽到这里"),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: IconButton(
              onPressed: ()=>showAbout(context), 
              icon: const Icon(Icons.info_rounded)
            )
          )
        ],
      ),
    );
  }
}