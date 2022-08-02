import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AppDismissible extends StatelessWidget {
  final Key slidableKey;
  final Widget listItem;
  final bool dragToRemove;
  final ActionConfiguration removeAction;
  final ActionConfiguration? editAction;
  final ConfirmationDialogConfiguration? confirmationRemoveDialog;
  final SnackbarConfiguration? onDismissedSnackbar;
  final FutureOr<bool> Function()? willDismissCondition;
  final bool showActionIcon;

  AppDismissible({
    Key? key,
    required this.slidableKey,
    required this.listItem,
    required this.removeAction,
    this.dragToRemove = true,
    this.editAction,
    this.confirmationRemoveDialog,
    this.onDismissedSnackbar,
    this.willDismissCondition,
    this.showActionIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Slidable.builder(
    //   key: slidableKey,
    //   controller: slidableController,
    //   dismissal: SlidableDismissal(
    //       child: SlidableDrawerDismissal(),
    //       dragDismissible: dragToRemove,
    //       onWillDismiss: (_) async {
    //         var result = true;
    //         if (willDismissCondition != null) {
    //           result = await willDismissCondition?.call() ?? false;
    //         }
    //         return result;
    //       },
    //       onDismissed: (_) {
    //         removeAction.performAction();
    //       }),
    //   actionPane: SlidableDrawerActionPane(),
    //   actionExtentRatio: 0.208,
    //   child: listItem,
    //   secondaryActionDelegate: SlideActionBuilderDelegate(
    //     actionCount: editAction != null ? 2 : 1,
    //     builder: (context, index, animation, renderingMode) => _buildSlidableAction(
    //       context,
    //       index,
    //       showIcon: showActionIcon,
    //     ),
    //   ),
    // );
  }

  Widget _buildSlidableAction(
    BuildContext context,
    int index, {
    bool showIcon = false,
  }) {
    SlidableAction(
      onPressed: (context) {},
      backgroundColor: editAction?.backgroundColor ?? Colors.red,
    );
    final isEditAction = index == 0 && editAction != null;
    if (isEditAction) {
      // return SlidableAction(
      //   color: editAction?.backgroundColor ?? Colors.red,
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(
      //       horizontal: 8,
      //     ),
      //     child: (showIcon && editAction?.icon != null)
      //         ? Icon(editAction?.icon, color: Colors.orange)
      //         : Text(
      //             editAction?.label ?? '',
      //             maxLines: 1,
      //           ),
      //   ),
      //   closeOnTap: editAction?.closeOnTap ?? false,
      //   onTap: editAction?.performAction,
      // );
    } else {
      // return SlideAction(
      //   color: removeAction.backgroundColor ?? Colors.red,
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(
      //       horizontal: 8,
      //     ),
      //     child: (showIcon && removeAction.icon != null)
      //         ? Icon(removeAction.icon, color: Colors.red)
      //         : Text(
      //             removeAction.label,
      //             maxLines: 1,
      //           ),
      //   ),
      //   closeOnTap: removeAction.closeOnTap,
      //   onTap: () async {
      //     if (confirmationRemoveDialog != null) {
      //     } else {
      //       Slidable.of(context)!.dismiss();
      //     }
      //   },
      // );
    }
    return Container();
  }
}

class ActionConfiguration {
  final String label;
  final VoidCallback performAction;
  final IconData? icon;
  final bool closeOnTap;
  final Color? backgroundColor;
  const ActionConfiguration({
    required this.label,
    required this.performAction,
    this.icon,
    this.closeOnTap = false,
    this.backgroundColor,
  });
}

class ConfirmationDialogConfiguration {
  final String dialogTitle;
  final String dialogDescription;
  final String confirmLabel;
  final String cancelLabel;

  const ConfirmationDialogConfiguration({
    required this.dialogTitle,
    required this.dialogDescription,
    required this.confirmLabel,
    required this.cancelLabel,
  });
}

class SnackbarConfiguration {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final VoidCallback? onSnackbarClosed;

  const SnackbarConfiguration({
    required this.title,
    this.onSnackbarClosed,
    this.actionLabel,
    this.onActionTap,
  });
}
