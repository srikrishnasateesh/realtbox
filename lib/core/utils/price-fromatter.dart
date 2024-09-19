String formatPrice(double value) {
  if (value >= 10000000) {
    return '${(value / 10000000).toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")} Cr';
  } else if (value >= 100000) {
    return '${(value / 100000).toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")} L';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}k';
  } else if (value == 0 || value == 0.0) {
    return "0";
  } else {
    return value.toString();
  }
}

String formatStringPrice(String value) {
  try {
  final v = double.parse(value);
  return formatPrice(v);
  }catch(e){
    return value;
  }
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