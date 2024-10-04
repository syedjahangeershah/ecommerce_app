import 'package:assessment/app/components/custom_button.dart';
import 'package:assessment/app/constants/app_color.dart';
import 'package:assessment/app/constants/app_constants.dart';
import 'package:assessment/app/models/countries_model.dart';
import 'package:assessment/app/routes/routes.dart';
import 'package:assessment/app/service_repositories/storage_service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CountrySelection extends StatefulWidget {
  const CountrySelection({super.key, required this.countries});

  final CountriesModel countries;

  @override
  State<CountrySelection> createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection> {
  int? selectedCountry;

  @override
  Widget build(BuildContext context) {
    print("length: ${widget.countries.data?.length}");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Gap(100),
            const Text(
              'Select Country',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            const Text("Please select your shipping country"),
            const Gap(10),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: widget.countries.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 150,
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (ctx, index) {
                  final country = widget.countries.data![index];
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedCountry = index;
                    }),
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: selectedCountry == index
                            ? Border.all(width: 1, color: AppColors.black)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                              '${AppConstants.mediaUrl}${country.image}'),
                          Text(
                            '${country.title}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedCountry != null)
              CustomButton(
                text: 'Confirm',
                onTap: () {
                  StorageService().writeData(
                    AppConstants.country,
                    widget.countries.data![selectedCountry!].title,
                  );
                  Get.offAllNamed(Routes.home);
                },
              ),
          ],
        ),
      ),
    );
  }
}
