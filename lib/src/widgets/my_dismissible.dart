import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Curve _kResizeTimeCurve = Interval(0.4, 1.0, curve: Curves.ease);
const double _kMinFlingVelocity = 700.0;
const double _kMinFlingVelocityDelta = 400.0;
const double _kFlingVelocityScale = 1.0 / 300.0;
const double _kDismissThreshold = 0.4;
enum _FlingGestureKind { none, forward, reverse }

class MyDismissible extends StatefulWidget {
  final Widget child;
  MyDismissible({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  _MyDismissibleState createState() => _MyDismissibleState();
}

class _MyDismissibleState extends State<MyDismissible>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final movementDuration = const Duration(milliseconds: 200);
  final resizeDuration = const Duration(milliseconds: 300);

  AnimationController _moveController;
  Animation<Offset> _moveAnimation;

  AnimationController _resizeController;
  Animation<double> _resizeAnimation;

  double _dragExtent = 0.0;
  bool _dragUnderway = false;
  Size _sizePriorToCollapse;

  double get _overallDragAxisExtent {
    final Size size = context.size;
    return size.width;
  }

  bool get _isActive {
    return _dragUnderway || _moveController.isAnimating;
  }

  bool get _directionIsXAxis => true;

  DismissDirection _extentToDirection(double extent) {
    if (extent == 0.0) return null;
    if (_directionIsXAxis) {
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          return extent < 0
              ? DismissDirection.startToEnd
              : DismissDirection.endToStart;
        case TextDirection.ltr:
          return extent > 0
              ? DismissDirection.startToEnd
              : DismissDirection.endToStart;
      }
      assert(false);
      return null;
    }
    return extent > 0 ? DismissDirection.down : DismissDirection.up;
  }

  DismissDirection get _dismissDirection => _extentToDirection(_dragExtent);

  void _handleDragStart(DragStartDetails details) {
    _dragUnderway = true;
    if (_moveController.isAnimating) {
      _dragExtent =
          _moveController.value * _overallDragAxisExtent * _dragExtent.sign;
      _moveController.stop();
    } else {
      _dragExtent = 0.0;
      _moveController.value = 0.0;
    }
    setState(() {
      _updateMoveAnimation();
    });
  }

  void _updateMoveAnimation() {
    final double end = _dragExtent.sign;
    _moveAnimation = _moveController.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: Offset(end, 0.0),
      ),
    );
  }

  Future<void> _handleDismissStatusChanged(AnimationStatus status) async {
    if (status == AnimationStatus.completed && !_dragUnderway) {
      if (await _confirmStartResizeAnimation() == true)
        _startResizeAnimation();
      else
        _moveController.reverse();
    }
    updateKeepAlive();
  }

  Future<bool> _confirmStartResizeAnimation() async {
    // if (widget.confirmDismiss != null) {
    //   final DismissDirection direction = _dismissDirection;
    //   assert(direction != null);
    //   return widget.confirmDismiss(direction);
    // }
    return true;
  }

  void _startResizeAnimation() {
    assert(_moveController != null);
    assert(_moveController.isCompleted);
    assert(_resizeController == null);
    assert(_sizePriorToCollapse == null);
    if (resizeDuration == null) {
      // if (widget.onDismissed != null) {
      //   final DismissDirection direction = _dismissDirection;
      //   assert(direction != null);
      //   widget.onDismissed(direction);
      // }
    } else {
      _resizeController =
          AnimationController(duration: resizeDuration, vsync: this)
            ..addListener(_handleResizeProgressChanged)
            ..addStatusListener((AnimationStatus status) => updateKeepAlive());
      _resizeController.forward();
      setState(() {
        _sizePriorToCollapse = context.size;
        _resizeAnimation = _resizeController
            .drive(
              CurveTween(curve: _kResizeTimeCurve),
            )
            .drive(
              Tween<double>(
                begin: 1.0,
                end: 0.0,
              ),
            );
      });
    }
  }

  void _handleResizeProgressChanged() {
    if (_resizeController.isCompleted) {
      // if (widget.onDismissed != null) {
      //   final DismissDirection direction = _dismissDirection;
      //   assert(direction != null);
      //   widget.onDismissed(direction);
      // }
    } else {
      // if (widget.onResize != null) widget.onResize();
    }
  }

  _FlingGestureKind _describeFlingGesture(Velocity velocity) {
    if (_dragExtent == 0.0) {
      // If it was a fling, then it was a fling that was let loose at the exact
      // middle of the range (i.e. when there's no displacement). In that case,
      // we assume that the user meant to fling it back to the center, as
      // opposed to having wanted to drag it out one way, then fling it past the
      // center and into and out the other side.
      return _FlingGestureKind.none;
    }
    final double vx = velocity.pixelsPerSecond.dx;
    final double vy = velocity.pixelsPerSecond.dy;
    DismissDirection flingDirection;
    // Verify that the fling is in the generally right direction and fast enough.
    if (_directionIsXAxis) {
      if (vx.abs() - vy.abs() < _kMinFlingVelocityDelta ||
          vx.abs() < _kMinFlingVelocity) return _FlingGestureKind.none;
      assert(vx != 0.0);
      flingDirection = _extentToDirection(vx);
    } else {
      if (vy.abs() - vx.abs() < _kMinFlingVelocityDelta ||
          vy.abs() < _kMinFlingVelocity) return _FlingGestureKind.none;
      assert(vy != 0.0);
      flingDirection = _extentToDirection(vy);
    }
    // assert(_dismissDirection != null);
    if (flingDirection == _dismissDirection) return _FlingGestureKind.forward;
    return _FlingGestureKind.reverse;
  }

  Future<void> _handleDragEnd(DragEndDetails details) async {
    if (!_isActive || _moveController.isAnimating) return;
    _dragUnderway = false;
    if (_moveController.isCompleted &&
        await _confirmStartResizeAnimation() == true) {
      _startResizeAnimation();
      return;
    }
    Map<DismissDirection, double> dismissThresholds = {};

    final double flingVelocity = details.velocity.pixelsPerSecond.dx;
    switch (_describeFlingGesture(details.velocity)) {
      case _FlingGestureKind.forward:
        assert(_dragExtent != 0.0);
        assert(!_moveController.isDismissed);
        if ((dismissThresholds[_dismissDirection] ?? _kDismissThreshold) >=
            1.0) {
          _moveController.reverse();
          break;
        }
        _dragExtent = flingVelocity.sign;
        _moveController.fling(
            velocity: flingVelocity.abs() * _kFlingVelocityScale);
        break;
      case _FlingGestureKind.reverse:
        assert(_dragExtent != 0.0);
        assert(!_moveController.isDismissed);
        _dragExtent = flingVelocity.sign;
        _moveController.fling(
            velocity: -flingVelocity.abs() * _kFlingVelocityScale);
        break;
      case _FlingGestureKind.none:
        if (!_moveController.isDismissed) {
          // we already know it's not completed, we check that above
          if (_moveController.value >
              (dismissThresholds[_dismissDirection] ?? _kDismissThreshold)) {
            _moveController.forward();
          } else {
            _moveController.reverse();
          }
        }
        break;
    }
  }

  final direction = DismissDirection.horizontal;

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isActive || _moveController.isAnimating) return;

    final double delta = details.primaryDelta;
    final double oldDragExtent = _dragExtent;
    switch (direction) {
      case DismissDirection.horizontal:
      case DismissDirection.vertical:
        _dragExtent += delta;
        break;

      case DismissDirection.up:
        if (_dragExtent + delta < 0) _dragExtent += delta;
        break;

      case DismissDirection.down:
        if (_dragExtent + delta > 0) _dragExtent += delta;
        break;

      case DismissDirection.endToStart:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta > 0) _dragExtent += delta;
            break;
          case TextDirection.ltr:
            if (_dragExtent + delta < 0) _dragExtent += delta;
            break;
        }
        break;

      case DismissDirection.startToEnd:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta < 0) _dragExtent += delta;
            break;
          case TextDirection.ltr:
            if (_dragExtent + delta > 0) _dragExtent += delta;
            break;
        }
        break;
    }
    if (oldDragExtent.sign != _dragExtent.sign) {
      setState(() {
        _updateMoveAnimation();
      });
    }
    if (!_moveController.isAnimating) {
      _moveController.value = _dragExtent.abs() / _overallDragAxisExtent;
    }
  }

  @override
  bool get wantKeepAlive =>
      _moveController?.isAnimating == true ||
      _resizeController?.isAnimating == true;

  @override
  void dispose() {
    _moveController.dispose();
    _resizeController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _moveController =
        AnimationController(duration: movementDuration, vsync: this)
          ..addStatusListener(_handleDismissStatusChanged);
    _updateMoveAnimation();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget content = SlideTransition(
      position: _moveAnimation,
      child: widget.child ??
          Container(
            height: 74,
            color: Colors.orange,
          ),
    );

    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      behavior: HitTestBehavior.opaque,
      child: content,
      dragStartBehavior: DragStartBehavior.start,
    );
  }
}
