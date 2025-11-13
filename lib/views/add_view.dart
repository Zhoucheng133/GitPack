import 'package:flutter/material.dart';
import 'package:gitpack/functions/dialog_handler.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}