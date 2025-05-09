import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:growhub/config/constants/colors.dart';
import 'package:growhub/features/api/cubit/config_data/config_data_cubit.dart';
import 'package:growhub/features/api/data/models/device_model.dart';
import 'package:growhub/features/bottom_app_bar/cubit/path_cubit.dart';

class DeviceCard extends StatelessWidget {
  final DeviceModel device;

  const DeviceCard({super.key, required this.device});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PathCubit>().onPathChange("/dashboard/sensor");
        context.read<ConfigDataCubit>().setCurrentDeviceId(device.id);

        context.push("/dashboard/sensor", extra: device.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: GHColors.primary,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: GHColors.black.withOpacity(0.13),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  device.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement logic for this button
                  },
                  icon: Icon(
                    Icons.help_outline,
                    color: GHColors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: device.sensors.map(
                    (sensor) {
                      return Text(
                        sensor.lastSensorReading?.value != null
                            ? "${sensor.lastSensorReading!.value} ${sensor.unit}"
                            : "No data",
                        style: const TextStyle(fontSize: 16),
                      );
                    },
                  ).toList(),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: SvgPicture.asset(
                      device.icon.path,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      colorFilter:
                          ColorFilter.mode(GHColors.black, BlendMode.srcIn),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
