import 'package:flutter/material.dart';

import 'package:flutter_application_1/app_constants/widget_extension.dart';
import 'package:flutter_application_1/app_constants/ticket_clipper.dart';

class TicketWidget extends StatelessWidget {
  final double notch;
  final double notchChange;
  final double radius;
  final double radiusRatio;
  final double minHeight;
  final Color? color;
  final double? width;
  final Widget? child;

  const TicketWidget({
    Key? key,
    this.notch = 1.0,
    this.notchChange = 0.06,
    this.radius = 25.0,
    this.radiusRatio = 0.3,
    this.minHeight = 100.0,
    this.child,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(
        notch: notch,
        notchChange: notchChange,
        radius: radius,
        radiusRatio: radiusRatio,
        width: width,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
          constraints: BoxConstraints(
            minHeight: minHeight,
            minWidth: double.infinity,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF282a36),
                  Color(0xFF292b37),
                  Color(0xFF20222d),
                  Color(0xFF191a25),
                ]),
            color: color ?? Theme.of(context).primaryColor,
          ),
          child: (child as Flex).separated(
            const SizedBox(
              width: 15,
            ),
          ),
        ),
      ),
    );
  }
}
// Row(
//             children: [
//               Flexible(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: AspectRatio(
//                     aspectRatio: 10 / 16,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: ImageEnums.sampleimage2.toImagewithBoxFit),
//                   ),
//                 ),
//               ),
//               Flexible(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 35.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pasific Rim The Black',
//                         style: TextStyles.robotoRegularBold28Style,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           SizedBox.square(
//                               dimension: 25, child: IconEnums.fullstar.toImage),
//                           Text(
//                             '8.9',
//                             style: TextStyles.robotoHeadlineStyle
//                                 .copyWith(color: Colors.amber),
//                           )
//                         ],
//                       ).separated(const SizedBox(
//                         width: 5,
//                       )),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8),
//                         child: Text('Guillermo del Toro'),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           )