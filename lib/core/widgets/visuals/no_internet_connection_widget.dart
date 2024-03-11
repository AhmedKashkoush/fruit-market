import 'package:flutter/cupertino.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:fruit_market/core/constants/lotties.dart';
import 'package:fruit_market/core/widgets/buttons/custom_outlined_button.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  final void Function()? onRefresh;
  const NoInternetConnectionWidget({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          noInternetLottie,
          height: 100,
        ),
        const Gap(10),
        LabelWidget(
          label: 'No Internet Connection',
          color: lighterGrey.withOpacity(0.5),
          size: 24,
        ),
        const Gap(5),
        CustomOutlinedButton(
          text: 'Refresh',
          icon: CupertinoIcons.refresh,
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
