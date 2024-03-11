import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/location.dart';
import 'package:fruit_market/core/widgets/buttons/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/headers/transparent_app_bar.dart';
import 'package:fruit_market/core/widgets/loading/default_loading_widget.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/core/widgets/visuals/no_internet_connection_widget.dart';
import 'package:fruit_market/features/auth/presentation/screens/choose%20location%20manually/widgets/find_location_button.dart';
import 'package:fruit_market/features/auth/presentation/screens/choose%20location%20manually/widgets/lat_lng_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/choose%20location%20manually/widgets/map_view_widget.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

class ChooseLocationManuallyScreen extends StatefulWidget {
  final Connectivity connectivity;
  const ChooseLocationManuallyScreen({super.key, required this.connectivity});

  @override
  State<ChooseLocationManuallyScreen> createState() =>
      _ChooseLocationManuallyScreenState();
}

class _ChooseLocationManuallyScreenState
    extends State<ChooseLocationManuallyScreen> {
  final TextEditingController _latController = TextEditingController(),
      _lngController = TextEditingController();
  final ValueNotifier<String> _coordinates = ValueNotifier<String>('');
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: StatefulBuilder(builder: (context, setState) {
        return FutureBuilder<ConnectivityResult>(
            future: widget.connectivity.checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const DefaultLoadingWidget();
              }
              if (snapshot.data! == ConnectivityResult.none) {
                return Center(
                  child: NoInternetConnectionWidget(
                    onRefresh: () => _refresh(setState),
                  ),
                );
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                reverse: true,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LabelWidget(label: 'Enter your coordinates'),
                      const Gap(20),
                      LatLngFormField(
                        latController: _latController,
                        lngController: _lngController,
                      ),
                      const Divider(),
                      const Gap(4),
                      MapViewWidget(
                        coordinates: _coordinates,
                        latController: _latController,
                        lngController: _lngController,
                      ),
                      const Divider(),
                      const Gap(4),
                      FindLocationButton(
                        formKey: _formKey,
                        latController: _latController,
                        lngController: _lngController,
                        coordinates: _coordinates,
                      ),
                      const Gap(4),
                      const Divider(),
                      const Gap(4),
                      CustomElevatedButton(
                        text: 'Generate address',
                        onPressed: _generateAddress,
                        isLoading: _isLoading.value,
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }

  void _refresh(void Function(void Function()) setState) {
    setState(() {});
  }

  void _generateAddress() async {
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _isLoading.value = true;
    try {
      final Placemark address = await getAddressFromLocation(
        double.parse(_latController.text),
        double.parse(_lngController.text),
      );
      debugPrint(address.toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    _isLoading.value = false;
  }
}
