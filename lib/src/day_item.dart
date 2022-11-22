import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

/// Creates a Widget representing the day.
class DayItem extends StatelessWidget {
  final int dayNumber;
  final String shortName;
  final bool isSelected;
  final Function onTap;
  final Color? dayColor;
  final Color? activeDayColor;
  final Color? activeDayBackgroundColor;
  final bool available;
  final Color? dotsColor;
  final Color? dayNameColor;
  final bool shrink;
  final bool showNameOnAllDays;
  final bool Function(int dayNumber)? showBadge;
  final String Function(int dayNumber)? badgeText;

  DayItem(
      {Key? key,
      required this.dayNumber,
      required this.shortName,
      required this.onTap,
      this.isSelected = false,
      this.dayColor,
      this.activeDayColor,
      this.activeDayBackgroundColor,
      this.available = true,
      this.dotsColor,
      this.dayNameColor,
      this.shrink = false,
      this.showNameOnAllDays = false,
      this.showBadge,
      this.badgeText})
      : super(key: key);

  _buildDay(BuildContext context) {
    final textStyle = TextStyle(
        color: available
            ? dayColor ?? Theme.of(context).colorScheme.secondary
            : dayColor?.withOpacity(0.5) ??
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        fontSize: shrink
            ? 14
            : showNameOnAllDays
                ? 28
                : 32,
        fontWeight: FontWeight.normal);
    final dayNameTextStyle = TextStyle(
        color: available
            ? dayColor ?? Theme.of(context).colorScheme.secondary
            : dayColor?.withOpacity(0.5) ??
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        fontWeight: FontWeight.normal);

    final selectedStyle = TextStyle(
      color: activeDayColor ?? Colors.white,
      fontSize: shrink ? 14 : 32,
      fontWeight: FontWeight.bold,
      height: 0.8,
    );

    return GestureDetector(
      onTap: available ? onTap as void Function()? : null,
      child: Badge(
        showBadge: !isSelected && (showBadge?.call(dayNumber) ?? false),
        badgeContent: badgeText != null
            ? Text(
                badgeText?.call(dayNumber) ?? '',
                style: const TextStyle(color: Colors.white),
              )
            : null,
        position: BadgePosition.topEnd(top: -4, end: 1),
        badgeColor: Colors.red,
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  color: activeDayBackgroundColor ??
                      Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12.0),
                )
              : BoxDecoration(color: Colors.transparent),
          height: shrink ? 40 : 70,
          width: shrink ? 33 : 60,
          child: Column(
            children: <Widget>[
              if (isSelected) ...[
                SizedBox(height: shrink ? 6 : 7),
                if (!shrink) _buildDots(),
                SizedBox(height: shrink ? 9 : 12),
              ] else
                SizedBox(height: shrink ? 10 : 14),
              Text(
                dayNumber.toString(),
                style: isSelected ? selectedStyle : textStyle,
              ),
              if (isSelected)
                Text(
                  shortName,
                  style: TextStyle(
                    color: dayNameColor ?? activeDayColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: shrink ? 9 : 14,
                  ),
                ),
              if (!isSelected && showNameOnAllDays)
                Text(
                  shortName,
                  style: dayNameTextStyle,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    final dot = Container(
      height: 5,
      width: 5,
      decoration: new BoxDecoration(
        color: this.dotsColor ?? this.activeDayColor ?? Colors.white,
        shape: BoxShape.circle,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [dot, dot],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDay(context);
  }
}
