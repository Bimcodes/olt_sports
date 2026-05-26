String formatNewsDateTime(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

  return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}, '
      '${hour.toString().padLeft(2, '0')}:$minute $amPm';
}
