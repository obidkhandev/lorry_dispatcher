import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

import '../../../export.dart';

class DateRange {
  final DateTime? startDate;
  final DateTime? endDate;

  DateRange({this.startDate, this.endDate});

  bool get isComplete => startDate != null && endDate != null;
  bool get isEmpty => startDate == null && endDate == null;

  @override
  String toString() {
    if (isEmpty) return '';
    if (startDate != null && endDate == null) {
      return _formatDate(startDate!);
    }
    if (startDate != null && endDate != null) {
      return '${_formatDate(startDate!)} - ${_formatDate(endDate!)}';
    }
    return '';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Yanvar', 'Fevral', 'Mart', 'Aprel', 'May', 'Iyun',
      'Iyul', 'Avgust', 'Sentabr', 'Oktabr', 'Noyabr', 'Dekabr'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class CustomDropdownDateRangeWidget extends StatefulWidget {
  final DateRange? initialRange;
  final Function(DateRange) onRangeSelected;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Decoration? decoration;
  final String? label;

  const CustomDropdownDateRangeWidget({
    super.key,
    this.initialRange,
    required this.onRangeSelected,
    this.hintText = 'Select date range',
    this.textStyle,
    this.hintTextStyle,
    this.decoration,
    this.label,
  });

  @override
  State<CustomDropdownDateRangeWidget> createState() =>
      _CustomDropdownDateRangeWidgetState();
}

class _CustomDropdownDateRangeWidgetState
    extends State<CustomDropdownDateRangeWidget> {
  DateRange _selectedRange = DateRange();
  bool _isCalendarOpen = false;
  final GlobalKey _inputKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _selectedRange = widget.initialRange ?? DateRange();
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleCalendar() {
    if (_isCalendarOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      _isCalendarOpen = !_isCalendarOpen;
    });
  }

  void _showOverlay() {
    final RenderBox renderBox =
    _inputKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 8,
        width: size.width,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          color: context.theme.cardColor,
          child: _DateRangeCalendarDropdown(
            selectedRange: _selectedRange,
            onRangeSelected: (range) {
              setState(() {
                _selectedRange = range;
              });
              widget.onRangeSelected(range);
            },
            onClose: () {
              setState(() {
                _isCalendarOpen = false;
              });
              _removeOverlay();
            },
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!,
              style: context.theme.textTheme.titleMedium?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          key: _inputKey,
          onTap: _toggleCalendar,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: widget.decoration ??
                BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
            child: Row(
              children: [
                Icon(
                  Icons.date_range,
                  size: 20,
                  color: AppColors.hintColor,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                      !_selectedRange.isEmpty
                          ? _selectedRange.toString()
                          : widget.hintText!,
                      style: !_selectedRange.isEmpty
                          ? widget.textStyle
                          : widget.hintTextStyle ??
                          context.theme.textTheme.titleMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          )),
                ),
                if (!_selectedRange.isEmpty)
                  InkWell(
                    onTap: () {
                      _selectedRange = DateRange();
                      setState(() {});
                      widget.onRangeSelected(_selectedRange);
                    },
                    child: SvgPicture.asset(
                      AppIcons.cancel,
                      // colorFilter: AppColors.colorFilter(AppColors.red),
                      height: 20,
                      width: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DateRangeCalendarDropdown extends StatefulWidget {
  final DateRange selectedRange;
  final Function(DateRange) onRangeSelected;
  final VoidCallback onClose;

  const _DateRangeCalendarDropdown({
    required this.selectedRange,
    required this.onRangeSelected,
    required this.onClose,
  });

  @override
  State<_DateRangeCalendarDropdown> createState() =>
      _DateRangeCalendarDropdownState();
}

class _DateRangeCalendarDropdownState extends State<_DateRangeCalendarDropdown> {
  late DateTime _currentMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _hoverDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.selectedRange.startDate;
    _endDate = widget.selectedRange.endDate;
    _currentMonth = _startDate ?? DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _onDateTap(DateTime date) {
    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        // Start new selection
        _startDate = date;
        _endDate = null;
      } else if (_startDate != null && _endDate == null) {
        // Complete the range
        if (date.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = date;
        } else {
          _endDate = date;
        }
      }
    });

    // Update the parent widget immediately
    widget.onRangeSelected(DateRange(startDate: _startDate, endDate: _endDate));
  }

  void _onDateHover(DateTime date) {
    if (_startDate != null && _endDate == null) {
      setState(() {
        _hoverDate = date;
      });
    }
  }

  bool _isDateInRange(DateTime date) {
    if (_startDate == null) return false;

    if (_endDate != null) {
      return date.isAfter(_startDate!) && date.isBefore(_endDate!) ||
          date.isAtSameMomentAs(_startDate!) ||
          date.isAtSameMomentAs(_endDate!);
    }

    if (_hoverDate != null) {
      final start = _startDate!.isBefore(_hoverDate!) ? _startDate! : _hoverDate!;
      final end = _startDate!.isBefore(_hoverDate!) ? _hoverDate! : _startDate!;
      return date.isAfter(start) && date.isBefore(end) ||
          date.isAtSameMomentAs(start) ||
          date.isAtSameMomentAs(end);
    }

    return false;
  }

  bool _isStartDate(DateTime date) {
    return _startDate != null &&
        date.year == _startDate!.year &&
        date.month == _startDate!.month &&
        date.day == _startDate!.day;
  }

  bool _isEndDate(DateTime date) {
    return _endDate != null &&
        date.year == _endDate!.year &&
        date.month == _endDate!.month &&
        date.day == _endDate!.day;
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final days = <DateTime>[];

    // Add previous month's trailing days
    int firstWeekday = firstDay.weekday;
    if (firstWeekday != 1) {
      for (int i = firstWeekday - 1; i > 0; i--) {
        days.add(firstDay.subtract(Duration(days: i)));
      }
    }

    // Add current month's days
    for (int day = 1; day <= lastDay.day; day++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, day));
    }

    // Add next month's leading days to fill the grid
    int remainingDays = 42 - days.length;
    for (int day = 1; day <= remainingDays; day++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month + 1, day));
    }

    return days;
  }

  String _getMonthName(int month) {
    const months = [
      'Yanvar', 'Fevral', 'Mart', 'Aprel', 'May', 'Iyun',
      'Iyul', 'Avgust', 'Sentabr', 'Oktabr', 'Noyabr', 'Dekabr'
    ];
    return months[month - 1];
  }

  void _clearSelection() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _hoverDate = null;
    });
    widget.onRangeSelected(DateRange());
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with month/year and navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
                style: AppTextStyles().body18w5,
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Weekday headers
          Row(
            children: ['Du', 'Se', 'Cho', 'Pa', 'Ju', 'Sha', 'Ya'].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: AppTextStyles().body14w5,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Calendar grid
          ...List.generate(6, (weekIndex) {
            return Row(
              children: List.generate(7, (dayIndex) {
                final dayDate = days[weekIndex * 7 + dayIndex];
                final isCurrentMonth = dayDate.month == _currentMonth.month;
                final isStartDate = _isStartDate(dayDate);
                final isEndDate = _isEndDate(dayDate);
                final isInRange = _isDateInRange(dayDate);
                final isToday = DateTime.now().year == dayDate.year &&
                    DateTime.now().month == dayDate.month &&
                    DateTime.now().day == dayDate.day;

                Color backgroundColor = Colors.transparent;
                if (isStartDate || isEndDate) {
                  backgroundColor = AppColors.primaryColor;
                } else if (isInRange) {
                  backgroundColor = AppColors.primaryOpacity;
                } else if (isToday) {
                  backgroundColor = AppColors.primaryOpacity.withOpacity(0.3);
                }

                return Expanded(
                  child: MouseRegion(
                    onEnter: (_) => _onDateHover(dayDate),
                    child: GestureDetector(
                      onTap: () => _onDateTap(dayDate),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${dayDate.day}',
                            style: context.theme.textTheme.titleMedium?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: (isStartDate || isEndDate || isToday)
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: (isStartDate || isEndDate)
                                  ? AppColors.white
                                  : isCurrentMonth
                                  ? null
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),

          SizedBox(height: 16.h),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _clearSelection,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Tozalash',
                    style: AppTextStyles().body14w5.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Yopish',
                    style: AppTextStyles().body14w5.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}