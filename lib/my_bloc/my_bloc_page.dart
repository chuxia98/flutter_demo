import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class MyBlocPage extends StatelessWidget {
  final String title;

  const MyBlocPage({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyBloc>(
          create: (context) => MyBloc(),
        ),
        BlocProvider<MyCubit>(
          create: (context) => MyCubit(),
        ),
      ],
      child: _ContentView(title: title),
    );
  }
}

class _ContentView extends StatelessWidget {
  final String title;

  const _ContentView({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'bloc use'),
      ),
      body: Column(
        children: [
          BlocListener<MyBloc, MyState>(
            listener: (context, state) {
              context.read<MyCubit>().increment(count: 12);
              // if (state is MyTitleChangeSuccess) {
              //   pageContext.read<MyCubit>().increment(count: 10);
              // }
            },
            child: _TextView(),
          ),
          ElevatedButton(
            child: Text(
              'change text ',
            ),
            onPressed: () {
              BlocProvider.of<MyBloc>(context).add(
                MyTitleChanged(title: 'changed title'),
              );
            },
          )
        ],
      ),
    );
  }
}

class _TextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final pageContext = context;
    return BlocBuilder<MyBloc, MyState>(
      builder: (context, state) {
        if (state is MyTitleChangeSuccess) {
          return Container(
            padding: EdgeInsets.all(10),
            color: Colors.amber,
            child: Column(
              children: [
                Text(state.title),
                BlocBuilder<MyCubit, int>(
                  builder: (context, state) {
                    return Text('[cx] $state');
                  },
                ),
              ],
            ),
          );
        }
        return Container(
          padding: EdgeInsets.all(10),
          color: Colors.amber,
          child: Text('初始化'),
        );
      },
    );
  }
}
