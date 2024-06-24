String formatPrice(double value) {

  if (value >= 10000000) {
    return '${(value / 10000000).toStringAsFixed((value % 10000000 == 0) ? 0 : (value % 1000000 == 0) ? 1 : 3).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")} Cr';
  } else if (value >= 100000) {
    return '${(value / 100000).toStringAsFixed((value % 100000 == 0) ? 0 : 1).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")} L';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed((value % 1000 == 0) ? 0 : 1).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}k';
  } else {
    return value.toString();
  }
  
}

String formatStringPrice(String value) {
  final v = double.parse(value);
  return formatPrice(v);
}

/* old

/* if (value >= 10000000) {
    return '${(value / 10000000).toStringAsFixed(value % 10000000 == 0 ? 0 : 3)} Cr';
  } else if (value >= 100000) {
    return '${(value / 100000).toStringAsFixed(value % 100000 == 0 ? 0 : 1)} L';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1)}k';
  } else if(value == 0 || value == 0.0){
    return "0";
  } 
  else {
    return value.toString();
  } */
 */