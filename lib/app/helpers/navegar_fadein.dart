part of 'helpers.dart';

/// Navegar hacia culaquier pagina con animacion fadein
Route navigatePageFadeIn(BuildContext context, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: Duration(milliseconds: 300),//300
    transitionsBuilder: (context, animation, _, child) {

      return FadeTransition(
          child: child,
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut))
      );
    },
  );
}
