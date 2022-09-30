import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debounce Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Debounce Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _changeCounter(int value) {
    setState(() {
      _counter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(initialValue: _counter),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      final newCounterValue = _counter + 1;
                      _changeCounter(newCounterValue);
                      context.read<CounterBloc>().add(
                            CounterEvent.counterChanged(newCounterValue),
                          );
                    },
                    icon: const Icon(Icons.add),
                  ),
                  BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state.map(
                          loading: (_) => const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                          loaded: (state) => Text(
                            // Using _counter rather than state.counter to so the value instantly to the user
                            '$_counter',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          error: (_) => const Text('error'),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      final newCounterValue = _counter - 1;
                      _changeCounter(newCounterValue);
                      context
                          .read<CounterBloc>()
                          .add(CounterEvent.counterChanged(newCounterValue));
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
