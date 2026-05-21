String getPhoneWithoutCountryCode(String phone) {
  if (phone.startsWith('+20')) {
    return phone.substring(3);
  }

  return phone;
}
