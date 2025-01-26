import 'package:el_asalto/providers/board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/widgets/appbar.dart';
import 'game/game.dart';
import 'config_game/post_config.dart';
import 'config_game/pre_config.dart';
import 'end/end.dart';

class PagesView extends StatefulWidget {
  const PagesView({super.key});

  @override
  State<PagesView> createState() => _PagesViewState();
}

class _PagesViewState extends State<PagesView> with TickerProviderStateMixin {
  late PageController _controller;

  late List<Widget> children = [PreConfigGameView(onEndConfig: onEndConfig)];
  int _count = 0;

  final _duration = Duration(milliseconds: 1000);
  final _curve = Curves.easeOutCubic;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future animateToPage(int page, {int delay = 0, int? count}) async {
    await Future.delayed(Duration(milliseconds: delay));
    if (count != null) setState(() => _count = count);
    await _controller.animateToPage(page, duration: _duration, curve: _curve);
  }

  void onEndConfig() async {
    context.read<Board>().initialize(onEnd: onEndGame);
    setState(() {
      children = [PreConfigGameView(onEndConfig: onEndConfig), GameView()];
    });
    await animateToPage(1, delay: 100, count: 2);
    setState(() {
      children[0] = PostConfigGameView(onResetConfig: onResetConfig);
    });
  }

  void onResetConfig() {
    setState(() {
      children = [PreConfigGameView(onEndConfig: onEndConfig)];
      _count = 0;
      _controller.jumpToPage(0);
    });
  }

  void onRestartGame() async {
    await animateToPage(1, count: 2);
    setState(() {
      children = [PostConfigGameView(onResetConfig: onResetConfig), GameView()];
    });
  }

  void onEndGame() {
    setState(() {
      children = [
        PostConfigGameView(onResetConfig: onResetConfig),
        GameView(),
        EndView()
      ];
    });
    animateToPage(2, count: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        restartButton: children[0].runtimeType == PostConfigGameView,
        onRestart: onRestartGame,
      ),
      body: PageView(
        children: children,
        controller: _controller,
      ),
      bottomNavigationBar: Visibility(
        visible: _count != 0,
        child: BottomAppBar(
          padding: EdgeInsets.all(0),
          height: 30,
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.topCenter,
            child: SmoothPageIndicator(
              controller: _controller,
              count: _count,
              axisDirection: Axis.horizontal,
              onDotClicked: animateToPage,
              effect: WormEffect(
                activeDotColor: Theme.of(context).indicatorColor,
                dotColor: Theme.of(context).indicatorColor.withAlpha(100),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
