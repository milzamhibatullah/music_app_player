
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics:  AlwaysScrollableScrollPhysics(),
          child: Column(),
        ),
      ),
    );
  }
}