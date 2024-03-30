import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:gap/gap.dart';

void showSuccessSnackBar(
  BuildContext context,
  String message, {
  SuccessType successType = SuccessType.normal,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: success,
      content: Row(
        children: [
          if (successType == SuccessType.auth)
            const Icon(
              CupertinoIcons.person_solid,
              color: Colors.white,
            )
          else if (successType == SuccessType.network)
            const Icon(
              CupertinoIcons.wifi,
              color: Colors.white,
            )
          else
            const Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: Colors.white,
            ),
          const Gap(5),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

void showErrorSnackBar(
  BuildContext context,
  String message, {
  ErrorType errorType = ErrorType.normal,
  void Function()? onActionTap,
  String actionLabel = 'Verify',
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: error,
      action: errorType != ErrorType.verification
          ? null
          : SnackBarAction(
              label: actionLabel,
              onPressed: onActionTap!,
              textColor: Colors.white,
            ),
      content: Row(
        children: [
          if (errorType == ErrorType.auth)
            const Icon(
              CupertinoIcons.person_solid,
              color: Colors.white,
            )
          else if (errorType == ErrorType.network)
            const Icon(
              CupertinoIcons.wifi_exclamationmark,
              color: Colors.white,
            )
          else if (errorType == ErrorType.location)
            const Icon(
              CupertinoIcons.location_slash_fill,
              color: Colors.white,
            )
          else if (errorType == ErrorType.verification)
            const Icon(
              Icons.person_off_rounded,
              color: Colors.white,
            )
          else
            const Icon(
              CupertinoIcons.clear_circled_solid,
              color: Colors.white,
            ),
          const Gap(5),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
