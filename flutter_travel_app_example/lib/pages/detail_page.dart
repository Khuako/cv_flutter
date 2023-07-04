import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_app_example/cubit/app_cubit_states.dart';
import 'package:flutter_travel_app_example/cubit/app_cubits.dart';
import 'package:flutter_travel_app_example/misc/colors.dart';
import 'package:flutter_travel_app_example/widgets/app_buttons.dart';
import 'package:flutter_travel_app_example/widgets/app_large_text.dart';
import 'package:flutter_travel_app_example/widgets/app_text.dart';
import 'package:flutter_travel_app_example/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is DetailState) {
            var info = state.place;
            int curSelectedIndex = info.selectedPeople! - 1;
            return SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: double.maxFinite,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'http://mark.bslmeiyu.com/uploads/${info.img}'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 70,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AppCubits>(context).goHome();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 320,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(
                                text: info.name!,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              AppLargeText(
                                text: '\$ ${info.price}',
                                color: AppColors.mainColor,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.mainColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              AppText(
                                text: info.location!,
                                color: AppColors.textColor1,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(5, (index) {
                                  int gottenStars = info.stars!;
                                  return Icon(
                                    index >= gottenStars
                                        ? Icons.star_border_outlined
                                        : Icons.star,
                                    color: index >= gottenStars
                                        ? Colors.grey
                                        : AppColors.starColor,
                                  );
                                }),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              AppText(
                                text: '(${double.tryParse(
                                  info.stars.toString(),
                                )})',
                                color: AppColors.textColor2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          AppLargeText(
                            text: 'People',
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                            text: 'Number of people in your group',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 30),
                            width: double.maxFinite,
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        curSelectedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: AppButtons(
                                        size: 55,
                                        color: curSelectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        backgroundColor:
                                            curSelectedIndex == index
                                                ? Colors.black
                                                : AppColors.buttonBackground,
                                        borderColor: curSelectedIndex == index
                                            ? Colors.black
                                            : AppColors.buttonBackground,
                                        text: (index + 1).toString(),
                                      ),
                                    ));
                              },
                              itemCount: 5,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppLargeText(
                            text: 'Description',
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                            text: info.description!,
                            color: AppColors.mainTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        AppButtons(
                          size: 60,
                          color: AppColors.textColor1,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.textColor1,
                          isIcon: true,
                          icon: Icons.favorite_border_outlined,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ResponsiveButton(
                          isResponsive: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
