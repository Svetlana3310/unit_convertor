double convertUnits(String fromUnit, String toUnit, double value) {
  if (fromUnit == 'Inches' && toUnit == 'Centimeters') {
    return value * 2.54;
  } else if (fromUnit == 'Centimeters' && toUnit == 'Inches') {
    return value / 2.54;
  } else if (fromUnit == 'Acres' && toUnit == 'Hectares') {
    return value * 0.404686;
  } else if (fromUnit == 'Hectares' && toUnit == 'Acres') {
    return value / 0.404686;
  } else if (fromUnit == 'Kilograms' && toUnit == 'Pounds') {
    return value * 2.20462;
  } else if (fromUnit == 'Pounds' && toUnit == 'Kilograms') {
    return value / 2.20462;
  } else if (fromUnit == 'Liters' && toUnit == 'Gallons') {
    return value * 0.264172;
  } else if (fromUnit == 'Gallons' && toUnit == 'Liters') {
    return value / 0.264172;
  } else if (fromUnit == 'Kilometers' && toUnit == 'Miles') {
    return value * 0.621371;
  } else if (fromUnit == 'Miles' && toUnit == 'Kilometers') {
    return value / 0.621371;
  }
  return value;
}
