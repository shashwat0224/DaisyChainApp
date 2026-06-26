import 'package:daisy_chain/models/search_models.dart';
import 'package:daisy_chain/screens/home/widgets/station_screen_sheet.dart';
import 'package:flutter/material.dart';

import 'package:daisy_chain/core/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StationInput extends StatefulWidget {
  const StationInput({super.key});

  @override
  State<StationInput> createState() => _StationInputState();
}

class _StationInputState extends State<StationInput> {
  Station _source = Station(code: 'JP', name: 'Jaipur', isMajor: true);
  Station _destination = Station(code: 'INDB', name: 'Indore', isMajor: true);
  final DateTime _today = DateTime.now();
  final DateTime _tomorrow = DateTime.now().add(Duration(days: 1));
  final DateTime _dayAfterTomorrow = DateTime.now().add(Duration(days: 2));
  final DateTime _threshold = DateTime.now().add(Duration(days: 63));
  DateTime _pickedDate = DateTime.now();
  static const Map<int, String> _weekday = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };

  @override
  void initState() {
    super.initState();
    _pickedDate = _today;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: Colors.black12, width: 4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final Station? selected =
                            await showModalBottomSheet<Station>(
                              useSafeArea: true,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              sheetAnimationStyle: AnimationStyle(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                              ),
                              context: context,
                              builder: (ctx) => StationScreenSheet(),
                            );

                        if (selected != null) {
                          setState(() {
                            _source = selected;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(Icons.train, size: 36, color: AppColors.primary),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'FROM',
                                  style: AppTextStyles.trainName.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${_source.code}-${_source.name}',
                                  style: AppTextStyles.stationName.copyWith(
                                    fontSize: 24,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 50),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Divider(
                      color: Colors.black45,
                      height: 10,
                      thickness: 5,
                      indent: 40,
                      endIndent: 60,
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final Station? selected =
                            await showModalBottomSheet<Station>(
                              useSafeArea: true,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              sheetAnimationStyle: AnimationStyle(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                              ),
                              context: context,
                              builder: (ctx) => StationScreenSheet(),
                            );

                        if (selected != null) {
                          setState(() {
                            _destination = selected;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(
                            Icons.directions_train,
                            size: 36,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'TO',
                                  style: AppTextStyles.trainName.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${_destination.code}-${_destination.name}',
                                  style: AppTextStyles.stationName.copyWith(
                                    fontSize: 24,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 50),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _pickedDate,
                          firstDate: _today,
                          lastDate: _threshold,
                          helpText: 'Departure date',
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );
                        if (date != null) {
                          setState(() {
                            _pickedDate = date;
                          });
                        }
                      },
                      onDoubleTap: () {
                        setState(() {
                          _pickedDate = _today;
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          _pickedDate = _threshold;
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.calendar_month,
                            size: 32,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 8.0),
                          Column(
                            children: [
                              Text(
                                '${_pickedDate.month}/${_pickedDate.day}',
                                style: AppTextStyles.stationName.copyWith(
                                  fontSize: 28,
                                ),
                              ),
                              Text(
                                _weekday[_pickedDate.weekday]!,
                                style: AppTextStyles.stationName.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 160,
                  left: 180,
                  child: Row(
                    spacing: 10.0,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pickedDate = _tomorrow;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              '${_tomorrow.month}/${_tomorrow.day}',
                              style: AppTextStyles.stationName.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              _weekday[_tomorrow.weekday]!,
                              style: AppTextStyles.stationName.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pickedDate = _dayAfterTomorrow;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              '${_dayAfterTomorrow.month}/${_dayAfterTomorrow.day}',
                              style: AppTextStyles.stationName.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              _weekday[_dayAfterTomorrow.weekday]!,
                              style: AppTextStyles.stationName.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 2,
                  left: 260,
                  child: Container(
                    height: 54,
                    width: 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                      border: BoxBorder.all(color: Colors.black45, width: 6),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          final temp = _source;
                          _source = _destination;
                          _destination = temp;
                        });
                      },
                      icon: Icon(
                        Icons.swap_vert,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppColors.primary,
              border: Border.all(color: Colors.black12, width: 4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextButton.icon(
              onPressed: () {
                if (_source.code == _destination.code) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Source and destination cannot be same',
                        style: AppTextStyles.stationInput.copyWith(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  );
                  return;
                }
                final qParams = {
                  'source': _source.code,
                  'destination': _destination.code,
                  'date': DateFormat('yyyy-MM-dd').format(_pickedDate),
                };
                context.pushNamed('results', queryParameters: qParams);
              },
              icon: Icon(Icons.search, size: 32, color: AppColors.textPrimary),
              label: Text(
                'Search',
                style: AppTextStyles.stationName.copyWith(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
