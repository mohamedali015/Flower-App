import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/user_address/api/data_source/user_address_remote_data_source_imp.dart';
import 'package:flower_app/features/user_address/api/user_address_api_client/user_address_api_client.dart';
import 'package:flower_app/features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flower_app/features/user_address/data/models/address_dto.dart';
import 'package:flower_app/features/user_address/data/models/user_address_dto.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_remote_data_source_imp_test.mocks.dart';



@GenerateMocks([UserAddressApiClient])
main() {
  late UserAddressRemoteDataSourceContract dataSource;
  late MockUserAddressApiClient mockApiClient;
  late AddressDto addAddress;
  late List<AddressDto> mockCurrentServerAddresses;
  String successMessage = "success";
  setUpAll(() {
    mockApiClient = MockUserAddressApiClient();
    dataSource = UserAddressRemoteDataSourceImp(mockApiClient);
    mockCurrentServerAddresses = [
      AddressDto(
        street: "initial 12 Nile Street",
        phone: "initial 01012345678",
        city: "initial Cairo",
        lat: "initial 30.0444",
        long: "initial 31.2357",
        username: "initial Mark Raouf",
        id: "000000000000000000000000",
      ),
    ];
    addAddress = AddressDto(
      street: "add 12 Nile Street",
      phone: "add 01012345678",
      city: "add Cairo",
      lat: "add 30.0444",
      long: "add 31.2357",
      username: "add Mark Raouf",
    );
  });

  group("test datasource on calling addAddress", () {
    test(
      "case Client return UserAddressDto list of addresses when addAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        when(mockApiClient.addUserAddress(addAddress)).thenAnswer((_) async {
          processedAddresses.add(addAddress);
          return UserAddressDto(
            message: successMessage,
            address: processedAddresses,
          );
        });
        //Act
        var response = await dataSource.addUserAddress(addAddress);
        //Assert
        expect(response, isA<Success<UserAddressDto>>());
        expect(
          (response as Success<UserAddressDto>).data.address,
          equals(processedAddresses),
        );
        expect(response.data.message, successMessage);
        expect(response.data.address, isNotEmpty);
        expect(response.data.address, isNotNull);
        expect(
          response.data.address!.length,
          mockCurrentServerAddresses.length + 1,
        );
        verify(mockApiClient.addUserAddress(addAddress)).called(1);
      },
    );

    test("case Client throw Exception and return ", () async {
      //arrange
      when(mockApiClient.addUserAddress(addAddress)).thenThrow(Exception());
      //act
      var response = await dataSource.addUserAddress(addAddress);
      //assert
      expect(response, isA<Failure<UserAddressDto>>());
      expect((response as Failure<UserAddressDto>).errorMessage, isNotNull);
      expect(response.errorMessage, isNotNull);
      verify(mockApiClient.addUserAddress(addAddress)).called(1);
    });
  });

  group("test datasource on calling updateAddress", () {
    test(
      "case Client return UserAddressDto list of update Addresses when updateAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        when(
          mockApiClient.updateUserAddress(
            addAddress,
            processedAddresses.last.id,
          ),
        ).thenAnswer((_) async {
          return UserAddressDto(
            message: successMessage,
            address: processedAddresses,
          );
        });
        //Act
        var response = await dataSource.updateUserAddress(
          addAddress,
          processedAddresses.last.id!,
        );
        //Assert
        expect(response, isA<Success<UserAddressDto>>());
        expect(
          (response as Success<UserAddressDto>).data.address,
          equals(processedAddresses),
        );
        expect(response.data.message, successMessage);
        expect(response.data.address, isNotEmpty);
        expect(response.data.address, isNotNull);
        expect(
          response.data.address!.length,
          mockCurrentServerAddresses.length,
        );
        verify(
          mockApiClient.updateUserAddress(
            addAddress,
            processedAddresses.last.id!,
          ),
        ).called(1);
      },
    );

    test("case Client throw Exception and return ", () async {
      //arrange
      when(
        mockApiClient.updateUserAddress(
          addAddress,
          mockCurrentServerAddresses.last.id,
        ),
      ).thenThrow(Exception());
      //act
      var response = await dataSource.updateUserAddress(
        addAddress,
        mockCurrentServerAddresses.last.id!,
      );
      //assert
      expect(response, isA<Failure<UserAddressDto>>());
      expect((response as Failure<UserAddressDto>).errorMessage, isNotNull);
      expect(response.errorMessage, isNotNull);
      verify(
        mockApiClient.updateUserAddress(
          addAddress,
          mockCurrentServerAddresses.last.id,
        ),
      ).called(1);
    });
  });

  group("test dataSource on calling getLoggedUserAddress", () {
    test(
      "case Client return UserAddressDto list of addresses when getLoggedUserAddress is  called",
      () async {
        //arrange
        when(mockApiClient.getLoggedUserAddress()).thenAnswer(
          (_) async => UserAddressDto(
            message: successMessage,
            address: mockCurrentServerAddresses,
          ),
        );
        //act
        var response = await dataSource.getLoggedUserAddress();
        //assert
        expect(response, isA<Success<UserAddressDto>>());
        expect(
          (response as Success<UserAddressDto>).data.message,
          successMessage,
        );
        expect(response.data.address, isNotNull);
        expect(response.data.address, isNotEmpty);
        expect(response.data.address, equals(mockCurrentServerAddresses));
        verify(mockApiClient.getLoggedUserAddress()).called(1);
      },
    );

    test(
      "case Client throw Exception when getLoggedUserAddress called",
      () async {
        //arrange
        when(mockApiClient.getLoggedUserAddress()).thenThrow(Exception());
        // act
        var response = await dataSource.getLoggedUserAddress();
        //assert
        expect(response, isA<Failure<UserAddressDto>>());
        expect((response as Failure<UserAddressDto>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotEmpty);
      },
    );
  });

  group("test datasource on calling removeAddress", () {
    test(
      "case Client return UserAddressDto list of remove Addresses when updateAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        when(
          mockApiClient.removeUserAddress(processedAddresses.last.id),
        ).thenAnswer((_) async {
          return UserAddressDto(
            message: successMessage,
            address: processedAddresses,
          );
        });
        //Act
        var response = await dataSource.removeUserAddress(
          processedAddresses.last.id!,
        );
        //Assert
        expect(response, isA<Success<UserAddressDto>>());
        expect(
          (response as Success<UserAddressDto>).data.address,
          equals(processedAddresses),
        );
        expect(response.data.message, successMessage);
        expect(response.data.address, isNotEmpty);
        expect(response.data.address, isNotNull);
        expect(
          response.data.address!.length,
          mockCurrentServerAddresses.length,
        );
        verify(
          mockApiClient.removeUserAddress(processedAddresses.last.id!),
        ).called(1);
      },
    );

    test("case Client throw Exception and return ", () async {
      //arrange
      when(
        mockApiClient.removeUserAddress(mockCurrentServerAddresses.last.id),
      ).thenThrow(Exception());
      //act
      var response = await dataSource.removeUserAddress(
        mockCurrentServerAddresses.last.id!,
      );
      //assert
      expect(response, isA<Failure<UserAddressDto>>());
      expect((response as Failure<UserAddressDto>).errorMessage, isNotNull);
      expect(response.errorMessage, isNotNull);
      verify(
        mockApiClient.removeUserAddress(mockCurrentServerAddresses.last.id),
      ).called(1);
    });
  });
}
