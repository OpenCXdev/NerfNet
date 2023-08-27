import 'package:cognitivestudio/riverpod/router_master_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class MainViewModel extends ChangeNotifier {
  MainViewModel({
    required this.routemasterDelegate,
  });

  final RoutemasterDelegate routemasterDelegate;
}

final mainViewModelProvider = ChangeNotifierProvider<MainViewModel>((ref) {
  final routeMaster = ref.watch(routeMasterDelegateProvider.state).state;
  return MainViewModel(
    routemasterDelegate: routeMaster,
  );
});
