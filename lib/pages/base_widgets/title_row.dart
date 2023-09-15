import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/color_resources.dart';
import '../../utils/custom_themes.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';

class TitleRow extends StatelessWidget {
  final String? title;
  final Function? icon;
  final Function? onTap;
  final Duration? eventDuration;
  final bool? isDetailsPage;
  final bool isFlash;
  const TitleRow(
      {Key? key,
      required this.title,
      this.icon,
      this.onTap,
      this.eventDuration,
      this.isDetailsPage,
      this.isFlash = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? days, hours, minutes, seconds;
    if (eventDuration != null) {
      days = eventDuration!.inDays;
      hours = eventDuration!.inHours - days * 24;
      minutes = eventDuration!.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = eventDuration!.inSeconds -
          (24 * days * 60 * 60) -
          (hours * 60 * 60) -
          (minutes * 60);
    }
    

    return Container(
      decoration: isFlash
          ? BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.paddingSizeExtraSmall)),
              color: Theme.of(context).primaryColor.withOpacity(.05),
            )
          : null,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        isFlash
            ? Padding(
                padding: isFlash
                    ? const EdgeInsets.only(
                        left: Dimensions.paddingSizeExtraSmall)
                    : const EdgeInsets.all(0),
                child: Image.asset(
                  Images.flashDeal,
                  scale: 4,
                ),
              )
            : const SizedBox(),
        Text(title!, style: titleHeader),
        const Spacer(),
        eventDuration == null
            ? const Expanded(child: SizedBox.shrink())
            : Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeSmall),
                child: Row(children: [
                  const SizedBox(width: 5),
                  TimerBox(
                    time: days,
                    day: 'Day',
                  ),
                  Text(':',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  TimerBox(time: hours, day: 'Hrs'),
                  Text(':',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  TimerBox(time: minutes, day: 'Min'),
                  Text(':',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  TimerBox(time: seconds, day: 'Sec'),
                  const SizedBox(width: 5),
                ]),
              ),
        const Spacer(),
        icon != null
            ? InkWell(
                onTap: icon as void Function()?,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SvgPicture.asset(
                    Images.filterImage,
                    height: Dimensions.iconSizeDefault,
                    width: Dimensions.iconSizeDefault,
                    // color: ColorResources.getPrimary(context),
                  ),
                ))
            : const SizedBox.shrink(),
        onTap != null && isFlash
            ? InkWell(
                onTap: onTap as void Function()?,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).size.width / 6.5,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(
                                  Dimensions.paddingSizeExtraSmall),
                              bottomRight: Radius.circular(
                                  Dimensions.paddingSizeExtraSmall)),
                          color:
                              Theme.of(context).primaryColor.withOpacity(.3)),
                    ),
                    Positioned(
                      left: 12,
                      right: 12,
                      top: 18,
                      bottom: 18,
                      child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).primaryColor),
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 15,
                            color: Theme.of(context).cardColor,
                          )),
                    ),
                  ],
                ),
              )
            : onTap != null && !isFlash
                ? InkWell(
                    onTap: onTap as void Function()?,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isDetailsPage == null
                              ? Text('View All',
                                  style: titilliumRegular.copyWith(
                                    color: ColorResources.getArrowButtonColor(
                                        context),
                                    fontSize: Dimensions.fontSizeDefault,
                                  ))
                              : const SizedBox.shrink(),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: isDetailsPage == null
                                ? ColorResources.getArrowButtonColor(context)
                                : Theme.of(context).hintColor,
                            size: Dimensions.fontSizeDefault,
                          ),
                        ]),
                  )
                : const SizedBox.shrink(),
      ]),
    );
  }
}

class TimerBox extends StatelessWidget {
  final int? time;
  final bool isBorder;
  final String? day;

  const TimerBox(
      {Key? key, required this.time, this.isBorder = false, this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 9.5,
      height: MediaQuery.of(context).size.width / 9.5,
      decoration: BoxDecoration(
        color: isBorder ? null : ColorResources.getPrimary(context),
        border: isBorder
            ? Border.all(width: 2, color: ColorResources.getPrimary(context))
            : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              time! < 10 ? '0$time' : time.toString(),
              style: robotoRegular.copyWith(
                color: isBorder
                    ? ColorResources.getPrimary(context)
                    : Theme.of(context).highlightColor,
                fontSize: Dimensions.fontSizeSmall,
              ),
            ),
            Text(day!,
                style: titilliumRegular.copyWith(
                  color: isBorder
                      ? ColorResources.getPrimary(context)
                      : Theme.of(context).highlightColor,
                  fontSize: Dimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
    );
  }
}
