import 'package:accurate_task/features/shimmer.dart';
import 'package:accurate_task/features/update_request/presentation/converter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:accurate_task/core/Di/di.dart';
import 'package:accurate_task/core/common_widget/separator.dart';
import 'package:accurate_task/core/helpers/date_model.dart';
import 'package:accurate_task/core/routing/routes_manager.dart';
import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:accurate_task/features/lobby/presentation/lobby_controller.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<LobbyController>(
      create: (_) {
        LobbyController contrller =
            LobbyController(requestsRepo: getIt(), context: context);
        return contrller..paymentFilter();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Lobby",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: ColorManager.primaryColor),
          )),
        ),
        body: Container(
          child: Column(
            children: [
              SmallFormSeparator(screenHeight: screenHeight),
              Consumer(builder: (context, LobbyController controller, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    outLineButton(
                      label: "Payment",
                      isSelected: controller.payment,
                      onPressed: () {
                        controller.paymentFilter();
                      },
                    ),
                    outLineButton(
                      label: "Returns",
                      isSelected: controller.returns,
                      onPressed: () {
                        controller.returnsFilter();
                      },
                    ),
                    outLineButton(
                      label: "Materials",
                      isSelected: controller.materials,
                      onPressed: () {
                        controller.matrialFilter();
                      },
                    )
                  ],
                );
              }),
              SmallFormSeparator(screenHeight: screenHeight),
              Container(
                height: screenHeight * 0.6,
                width: screenWidth * 0.8,
                child: Consumer(
                    builder: (context, LobbyController controller, child) {
                  return controller.isLoading
                      ? ShimmerLoadingList(
                          itemCount: 5,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight)
                      : SingleChildScrollView(
                          child: Column(
                            children:
                                controller.filteredRequests.map((request) {
                              return Column(
                                children: [
                                  Container(
                                    color: ColorManager.backGroundInput,
                                    child: InkWell(
                                      onTap: () async {
                                        var model = controller.goToUpdateScree(
                                            context,
                                            int.parse(request.id),
                                            request.deliveryType,
                                            request.typeCode,
                                            fromString(request.dateTime),
                                            request.payeeName,
                                            request.notes);
                                        Navigator.of(context)
                                            .pushNamed(Routes.updateRequest,
                                                arguments: model)
                                            .then((re) {
                                          context.read<LobbyController>()
                                            ..paymentFilter();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "id: ${request.id}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white),
                                            ),
                                            Text(
                                              "date: ${request.dateTime}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white),
                                            ),
                                            Text(
                                              "payee: ${request.payeeName}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white),
                                            ),
                                            Text(
                                              "Delivery type: ${deliveryConveterStringString(request.deliveryType)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white),
                                            ),
                                            Text(
                                              "typeCode: ${typeConverterStringString(request.typeCode)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white),
                                            ),
                                            Text(
                                              "notes: ${request.notes}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SmallFormSeparator(
                                    screenHeight: screenHeight,
                                  )
                                ],
                              );
                            }).toList(),
                          ),
                        );
                }),
              ),
              Divider(),
              Container(
                width: screenWidth * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Consumer(builder: (context, controller, child) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.createRequest)
                                .then((value) {
                              context.read<LobbyController>().paymentFilter();
                            });
                          },
                          child: Text("create Request"));
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class outLineButton extends StatelessWidget {
  outLineButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });
  String label;
  bool isSelected;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(
            color: isSelected
                ? ColorManager.primaryColor
                : ColorManager.labelTextColor)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isSelected
                ? ColorManager.primaryColor
                : ColorManager.labelTextColor),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const ShimmerList({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5, // Adjust the count based on your needs
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Container(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.85,
                  color: Colors.white,
                ),
              ),
              SmallFormSeparator(screenHeight: screenHeight)
            ],
          );
        },
      ),
    );
  }
}
