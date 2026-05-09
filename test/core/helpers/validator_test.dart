import 'package:flower_app/core/helpers/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test Validator Name", () {
    test("When name is null", () {
      final actual = Validator.name(null);
      expect(actual, "This field cannot be empty");
    });

    test("When name is Empty", () {
      final actual = Validator.name("");
      expect(actual, "This field cannot be empty");
    });

    test("When name is Success", () {
      final actual = Validator.name("Mohamed");
      expect(actual, isNull);
    });
  });

  group("Test Validator Email", () {
    test("When Email is null", () {
      final actual = Validator.email(null);
      expect(actual, "Email is required");
    });

    test("When Email is Empty", () {
      final actual = Validator.email("");
      expect(actual, "Email is required");
    });

    test("When Email is not Valid", () {
      final actual = Validator.email("mohamed");
      expect(actual, "Please enter a valid email address");
    });

    test("When Email is Valid", () {
      final actual = Validator.email("mohamedmousa@gmail.com");
      expect(actual, isNull);
    });
  });

  group("Test Validator Password", () {
    test("When Password is null", () {
      expect(Validator.password(null), "Password is required");
    });

    test("When Password is Empty", () {
      expect(Validator.password(""), "Password is required");
    });

    test("When Password is less than 6 characters", () {
      expect(
        Validator.password("Mo@1"),
        "Password must be at least 6 characters",
      );
    });

    test("When Password is missing uppercase", () {
      expect(
        Validator.password("mohamed123@mousa"),
        "Password must contain uppercase, lowercase, number, and special character",
      );
    });

    test("When Password is missing lowercase", () {
      expect(
        Validator.password("MOHAMED123@MOUSA"),
        "Password must contain uppercase, lowercase, number, and special character",
      );
    });

    test("When Password is missing digit", () {
      expect(
        Validator.password("Mohamed@"),
        "Password must contain uppercase, lowercase, number, and special character",
      );
    });

    test("When Password is missing special character", () {
      expect(
        Validator.password("Mohamed12"),
        "Password must contain uppercase, lowercase, number, and special character",
      );
    });

    test("When Password is valid", () {
      expect(Validator.password("Mohamed@123"), null);
    });
  });

  group("Test Validator Confirm Password", () {
    test('When Confirm Password is null', () {
      expect(
        Validator.confirmPassword(null, 'Mohamed@123'),
        "Please confirm your password",
      );
    });
    test('returns error when does not match', () {
      expect(
        Validator.confirmPassword('Mohamed@123', 'Mohamed@456'),
        "Passwords do not match",
      );
    });
    test('returns null when matches and valid', () {
      expect(Validator.confirmPassword('Mohamed@123', 'Mohamed@123'), isNull);
    });
  });
}
