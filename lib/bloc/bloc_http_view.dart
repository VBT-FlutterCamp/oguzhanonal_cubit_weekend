import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oguzhanonal_cubit/bloc/cats_cubit.dart';
import 'package:oguzhanonal_cubit/bloc/cats_repo.dart';
import 'package:oguzhanonal_cubit/bloc/cats_state.dart';

class BlocView extends StatefulWidget {
  BlocView({Key? key}) : super(key: key);

  @override
  State<BlocView> createState() => _BlocViewState();
}

class _BlocViewState extends State<BlocView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CatsCubit(SampleCatsRepository()),
        child: buildScaffold());
  }

  Scaffold buildScaffold() => Scaffold(
        //floatingActionButton: newMethod(),
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: BlocConsumer<CatsCubit, CatState>(
          listener: (context, state) {
            if (state is CatsError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is CatInitial) {
              return Center(
                child: Column(
                  children: [Text('Hello'), CallButton(context)],
                ),
              );
            } else if (state is CatsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CatsCompleted) {
              return ListView.builder(
                itemBuilder: ((context, index) =>
                    Text(state.response[index].email!)),
                itemCount: state.response.length,
              );
            } else {
              final error = state as CatsError;
              return Text(error.message);
            }
          },
        ),
      );

  FloatingActionButton CallButton(context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<CatsCubit>(context).getCats();
      },
    );
  }
}
