import 'package:flutter/material.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/base/size.dart';
import 'package:ncckios/base/style.dart';
import 'package:ncckios/base/tool.dart';
import 'package:ncckios/model/entity.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget(
      {this.filmName,
      @required this.ticket,
      @required this.name,
      @required this.seat,
      @required this.version,
      @required this.languageCode,
      @required this.projectDate,
      @required this.projectTime,
      @required this.cinemaId});

  final String filmName;
  final String version;
  final String languageCode;
  final Ticket ticket;
  final String name;
  final String seat;
  final String projectDate;
  final String projectTime;
  final String cinemaId;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          height: screenHeight / 667 * 320,
          width: screenWidth / 360 * 328,
          color: AppColor.primaryColor,
        ),
        Positioned(
          top: 0,
          left: screenWidth / 360 * 8,
          child: Container(
            height: screenHeight / 667 * 320,
            width: screenWidth / 360 * 312,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenHeight / 667 * 24,
                      vertical: screenWidth / 360 * 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        filmName,
                        style: textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.backGround, fontSize: screenHeight/667*16),
                      ),
                      Container(
                        height: screenHeight / 667 * 8,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSize.getHeight(context, 3),
                                horizontal: AppSize.getWidth(context, 4)),
                            child: Text(
                              version,
                              style: textTheme.bodyText2
                                  .copyWith(color: AppColor.red, fontSize: screenHeight/667*14),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1,
                                  color: AppColor.red,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          Container(
                            width: 4,
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSize.getHeight(context, 3),
                                  horizontal: screenWidth / 360 * 4),
                              child: Text(
                                convertLanguageCode(languageCode),
                                style: textTheme.bodyText2
                                    .copyWith(color: AppColor.red, fontSize: screenHeight/667*14),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1,
                                  color: AppColor.red,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: AppColor.border,
                  width: screenWidth / 360 * 264,
                  height: screenHeight / 667 * 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenHeight / 667 * 24.0,
                      vertical: screenWidth / 360 * 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Người đặt',
                            style: textTheme.subtitle2.copyWith(
                                color: AppColor.title,
                                fontSize: screenHeight / 667 * 14),
                          ),
                          Text(
                            name,
                            style: textTheme.subtitle1.copyWith(
                                fontSize: screenHeight / 667 * 16,
                                color: AppColor.backGround,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: screenHeight / 667 * 16,
                          ),
                          Text(
                            'Ca chiếu',
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.title, fontSize: screenHeight/667*14),
                          ),
                          Text(
                            projectTime,
                            style: textTheme.subtitle1.copyWith(
                                color: AppColor.backGround,
                                fontWeight: FontWeight.bold, fontSize: screenHeight/667*16),
                          ),
                          Container(
                            height: screenHeight / 667 * 16,
                          ),
                          Text(
                            'Phòng chiếu',
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.title, fontSize: screenHeight/667*14),
                          ),
                          Text(
                            cinemaId,
                            style: textTheme.subtitle1.copyWith(
                                color: AppColor.backGround,
                                fontWeight: FontWeight.bold, fontSize: screenHeight/667*16),
                          ),
                          Container(
                            height: screenHeight / 667 * 16,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mã vé',
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.title, fontSize: screenHeight/667*14),
                          ),
                          Text(
                            ticket != null ? ticket.ticketNo : '',
                            style: textTheme.subtitle1.copyWith(
                                color: AppColor.backGround,
                                fontWeight: FontWeight.bold, fontSize: screenHeight/667*16),
                          ),
                          Container(
                            height: screenHeight / 667 * 16,
                          ),
                          Text(
                            'Ngày chiếu',
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.title, fontSize: screenHeight/667*14),
                          ),
                          Text(
                            projectDate,
                            style: textTheme.subtitle1.copyWith(
                                color: AppColor.backGround,
                                fontWeight: FontWeight.bold, fontSize: screenHeight/667*16),
                          ),
                          Container(
                            height: screenHeight / 667 * 16,
                          ),
                          Text(
                            'Ghế',
                            style: textTheme.subtitle2
                                .copyWith(color: AppColor.title, fontSize: screenHeight/667*14),
                          ),
                          Text(
                            seat,
                            style: textTheme.subtitle1.copyWith(
                                color: AppColor.backGround,
                                fontWeight: FontWeight.bold, fontSize: screenHeight/667*16),
                          ),
                          Container(
                            height: screenHeight / 667 * 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const MySeparator(
                  color: AppColor.backGround,
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: screenHeight / 667 * 40,
            left: 0,
            child: Container(
              height: screenHeight / 667 * 16,
              width: screenWidth / 360 * 16,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.primaryColor),
            )),
        Positioned(
          bottom: screenHeight / 667 * 41,
          right: 0,
          child: Container(
            height: screenHeight / 667 * 16,
            width: screenWidth / 360 * 16,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.primaryColor),
          ),
        )
      ],
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({this.height = 1, this.color = Colors.black});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: 1,
        width: screenWidth / 360 * 296,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Container(
                  height: 1,
                  width: screenWidth/360*4,
                  color: color,
                ),
            separatorBuilder: (BuildContext context, int index) => Container(
                  height: 1,
                  width: screenWidth/360*2,
                ),
            itemCount: (screenWidth / 6).floor()),
      ),
    );
  }
}
