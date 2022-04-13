import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'enums.dart';

abstract class ToastFactory {
  // ignore: constant_identifier_names
  static const int _animation_duration_in_ms = 5;
  // ignore: constant_identifier_names
  static const int _toast_duration_in_s = 2;
  static void makeToast(BuildContext context, TOAST_TYPE toastType,
      String title, String description, bool fromTop, Function? onClose) {
    switch (toastType) {
      case TOAST_TYPE.success:
        {
          MotionToast.success(
            description: Text(description),
            iconType: Platform.isAndroid
                ? ICON_TYPE.materialDesign
                : ICON_TYPE.cupertino,
            title: Text(title),
            iconSize: 25,
            animationType:
                fromTop == true ? ANIMATION.fromTop : ANIMATION.fromBottom,
            animationDuration:
                const Duration(milliseconds: _animation_duration_in_ms),
            toastDuration: const Duration(seconds: _toast_duration_in_s),
            position: fromTop == true
                ? MOTION_TOAST_POSITION.top
                : MOTION_TOAST_POSITION.bottom,
            onClose: onClose,
            layoutOrientation: ORIENTATION.ltr,
          ).show(context);

          break;
        }
      case TOAST_TYPE.delete:
        {
          MotionToast.delete(
            description: Text(description),
            iconType: Platform.isAndroid
                ? ICON_TYPE.materialDesign
                : ICON_TYPE.cupertino,
            title: Text(title),
            iconSize: 25,
            animationType:
                fromTop == true ? ANIMATION.fromTop : ANIMATION.fromBottom,
            animationDuration:
                const Duration(milliseconds: _animation_duration_in_ms),
            toastDuration: const Duration(seconds: _toast_duration_in_s),
            position: fromTop == true
                ? MOTION_TOAST_POSITION.top
                : MOTION_TOAST_POSITION.bottom,
            onClose: onClose,
            layoutOrientation: ORIENTATION.ltr,
          ).show(context);
          break;
        }
      case TOAST_TYPE.error:
        {
          MotionToast.error(
            description: Text(description),
            iconType: Platform.isAndroid
                ? ICON_TYPE.materialDesign
                : ICON_TYPE.cupertino,
            title: Text(title),
            iconSize: 25,
            animationType:
                fromTop == true ? ANIMATION.fromTop : ANIMATION.fromBottom,
            animationDuration:
                const Duration(milliseconds: _animation_duration_in_ms),
            toastDuration: const Duration(seconds: _toast_duration_in_s),
            position: fromTop == true
                ? MOTION_TOAST_POSITION.top
                : MOTION_TOAST_POSITION.bottom,
            onClose: onClose,
            layoutOrientation: ORIENTATION.ltr,
          ).show(context);
          break;
        }
      case TOAST_TYPE.warning:
        {
          MotionToast.warning(
            description: Text(description),
            iconType: Platform.isAndroid
                ? ICON_TYPE.materialDesign
                : ICON_TYPE.cupertino,
            title: Text(title),
            iconSize: 25,
            animationType:
                fromTop == true ? ANIMATION.fromTop : ANIMATION.fromBottom,
            animationDuration:
                const Duration(milliseconds: _animation_duration_in_ms),
            toastDuration: const Duration(seconds: _toast_duration_in_s),
            position: fromTop == true
                ? MOTION_TOAST_POSITION.top
                : MOTION_TOAST_POSITION.bottom,
            onClose: onClose,
            layoutOrientation: ORIENTATION.ltr,
          ).show(context);
          break;
        }

      case TOAST_TYPE.info:
        {
          MotionToast.info(
            description: Text(description),
            iconType: Platform.isAndroid
                ? ICON_TYPE.materialDesign
                : ICON_TYPE.cupertino,
            title: Text(title),
            iconSize: 25,
            animationType:
                fromTop == true ? ANIMATION.fromTop : ANIMATION.fromBottom,
            animationDuration:
                const Duration(milliseconds: _animation_duration_in_ms),
            toastDuration: const Duration(seconds: _toast_duration_in_s),
            position: fromTop == true
                ? MOTION_TOAST_POSITION.top
                : MOTION_TOAST_POSITION.bottom,
            onClose: onClose,
            layoutOrientation: ORIENTATION.ltr,
          ).show(context);
          break;
        }
    }
  }
}
