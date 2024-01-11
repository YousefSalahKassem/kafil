import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafil/core/components/stepper/constants.dart';
import 'package:kafil/core/utilities/extensions.dart';
import 'node.dart';

class FullLinearStepIndicator extends StatefulWidget {
  ///Controller for tracking page changes.
  ///
  final int currentIndex;

  ///Number of nodes to paint on screen
  final int steps;

  ///[completedIcon] size
  final double iconSize;

  ///Size of each node
  final double nodeSize;

  ///Height of separating line
  final double lineHeight;

  ///Icon showed when a step is completed
  final IconData completedIcon;

  ///Color of each completed node border
  final Color activeBorderColor;

  ///Color of each uncompleted node border
  final Color inActiveBorderColor;

  ///Color of each separating line after a completed node
  final Color activeLineColor;

  ///Color of each separating line after an uncompleted node
  final Color inActiveLineColor;

  ///Background color of a completed node
  final Color activeNodeColor;

  ///Background color of an uncompleted node
  final Color inActiveNodeColor;

  ///Thickness of node's borders
  final double nodeThickness;

  ///Node's shape
  final BoxShape shape;

  ///[completedIcon] color
  final Color iconColor;

  ///Step indicator's background color
  final Color backgroundColor;

  ///Boolean function that returns [true] when last node should be completed

  ///Step indicator's vertical padding
  final double verticalPadding;

  ///Labels for individual nodes
  final List<String> labels;

  ///Textstyle for an active label
  final TextStyle? activeLabelStyle;

  ///Textstyle for an inactive label
  final TextStyle? inActiveLabelStyle;

  const FullLinearStepIndicator({
    Key? key,
    required this.steps,
    required this.currentIndex,
    this.activeBorderColor = kActiveColor,
    this.inActiveBorderColor = kInActiveColor,
    this.activeLineColor = kActiveLineColor,
    this.inActiveLineColor = kInActiveLineColor,
    this.activeNodeColor = kActiveColor,
    this.inActiveNodeColor = kInActiveNodeColor,
    this.iconSize = kIconSize,
    this.completedIcon = kCompletedIcon,
    this.nodeThickness = kDefaultThickness,
    this.nodeSize = kDefaultSize,
    this.verticalPadding = kDefaultSize,
    this.lineHeight = kDefaultLineHeight,
    this.shape = BoxShape.circle,
    this.iconColor = kIconColor,
    this.backgroundColor = kIconColor,
    this.labels = const <String>[],
    this.activeLabelStyle,
    this.inActiveLabelStyle,
  })  : assert(steps > 0, "steps value must be a non-zero positive integer"),
        assert(labels.length == steps || labels.length == 0,
            "Provide exactly $steps strings for labels"),
        super(key: key);

  @override
  _FullLinearStepIndicatorState createState() =>
      _FullLinearStepIndicatorState();
}

class _FullLinearStepIndicatorState extends State<FullLinearStepIndicator> {
  late List<Node> nodes;

  @override
  void initState() {
    super.initState();
    _updateNodes();
  }

  @override
  void didUpdateWidget(FullLinearStepIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _updateNodes();
    }
  }

  void _updateNodes() {
    setState(() {
      nodes = List<Node>.generate(widget.steps, (index) => Node(step: index));
      for (int i = 0; i <= widget.currentIndex; i++) {
        nodes[i].completed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentIndex);
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
        color: widget.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.labels.isNotEmpty) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < widget.labels.length; i++) ...[
                    SizedBox(
                      width: 30.w,
                    ),
                    Text(
                      widget.labels[i],
                      style: nodes[i].completed
                          ? widget.activeLabelStyle
                          : widget.inActiveLabelStyle,
                    ),
                    if (widget.labels[i] !=
                        widget.labels[widget.steps - 1]) ...[
                      SizedBox(
                        width: 80.w,
                      ),
                    ],
                  ],
                ],
              ),
            ],
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var node in nodes) ...[
                  if (nodes.indexOf(node) == 0) ...{
                    Container(
                      color: node.completed
                          ? widget.activeLineColor
                          : widget.inActiveLineColor,
                      height: widget.lineHeight,
                      width: context.screenWidth(1 / widget.steps) * .25,
                    ),
                  },
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: node.completed
                          ? Colors.white
                          : widget.inActiveNodeColor,
                      border: Border.all(
                          color: node.completed
                              ? context.appTheme.primary
                              : Colors.transparent,
                          width: 2),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: .5,
                          blurRadius: .5,
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(.4),
                        ),
                      ],
                    ),
                    child: Text(
                      "${nodes.indexOf(node) + 1}",
                      style: context.appTextStyles.labelLarge.copyWith(
                        color: node.completed
                            ? widget.activeLineColor
                            : widget.inActiveLineColor,
                      ),
                    ),
                  ),
                  if (node.step != widget.steps - 1)
                    Container(
                      color: nodes.last.completed
                          ? widget.activeBorderColor
                          : widget.inActiveLineColor,
                      height: widget.lineHeight,
                      width: widget.steps > 3
                          ? context.screenWidth(1 / widget.steps) - 40
                          : context.screenWidth(1 / widget.steps) - 28,
                    ),
                  if (nodes.indexOf(node) == widget.steps - 1) ...{
                    Container(
                      color: node.completed
                          ? widget.activeLineColor
                          : widget.inActiveLineColor,
                      height: widget.lineHeight,
                      width: context.screenWidth(1 / widget.steps) * .25,
                    ),
                  },
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
