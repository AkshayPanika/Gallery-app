import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key,});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:4.0),
        child: MasonryGridView.builder(
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:1,
          ),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey,
              child: Image.network('https://source.unsplash.com/random?sig=$index'),
            );
          },),
      ),
    );
  }
}
