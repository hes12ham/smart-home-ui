import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarty/features/home/presentation/widgets/humidity.dart';
import 'package:smarty/features/home/presentation/widgets/tempreture.dart';
import '../../../../shared/res/res.dart';

class SummaryHeader extends StatelessWidget {
  const SummaryHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          decoration: BoxDecoration(
            color: SmartyColors.primary,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child:
              Row( children: [
            MaterialButton(
              onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>TemperaturePage()));
              },
              child: Column(
                children: [
                  Text(
                    'Temperature',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: SmartyColors.tertiary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.thermostat,
                        size: 24,
                        color: SmartyColors.tertiary,
                      ),
                      Text(
                        '25°C',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: SmartyColors.tertiary,
                      ),
                        ),],
                  )
                ],
              ),
            ),
            SizedBox(width: 110.h),
            MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HumidityPage()));
              },
              child: Column(
                children: [
                  Text(
                    'Humidity',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: SmartyColors.tertiary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        size: 24,
                        color: SmartyColors.tertiary,
                      ),
                      Text(
                        '80%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: SmartyColors.tertiary,
                      ),
                      ),],
                  ),
                ],
              ),
            ),

          ]),
        ),
      ),
    );
  }
}
