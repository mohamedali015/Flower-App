import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flower_app/features/user_address/data/models/address_dto.dart';
import 'package:flower_app/features/user_address/data/models/user_address_dto.dart';
import 'package:flower_app/features/user_address/data/repositories/user_address_repo_imp.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:flower_app/features/user_address/domain/repositories/user_address_repo_contract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_repo_imp_test.mocks.dart';

@GenerateMocks([UserAddressRemoteDataSourceContract])
void main() {
  late UserAddressRepoContract repository;
  late MockUserAddressRemoteDataSourceContract mockDataSource;
  late AddressDto addAddress;
  late List<AddressDto> mockCurrentServerAddresses;

  setUpAll(() {
    mockDataSource = MockUserAddressRemoteDataSourceContract();
    repository = UserAddressRepoImp(mockDataSource);
    provideDummy<Result<UserAddressResponseDto>>(
      Success<UserAddressResponseDto>(data: UserAddressResponseDto()),
    );
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

  group("test repository on calling addAddress", () {
    test(
      "case dataSource return Success<UserAddressResponseDto> list of addresses when addAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        processedAddresses.add(addAddress);
        when(mockDataSource.addUserAddress(addAddress)).thenAnswer(
          (_) async => Success<UserAddressResponseDto>(
            data: UserAddressResponseDto(
              message: "success",
              addresses: processedAddresses,
            ),
          ),
        );
        //Act
        var response = await repository.addUserAddress(addAddress);
        //Assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data.length,
          processedAddresses.length,
        );
        verify(mockDataSource.addUserAddress(addAddress)).called(1);
      },
    );

    test("case dataSource return Failure<UserAddressResponseDto> and return ", () async {
      //arrange
      when(mockDataSource.addUserAddress(addAddress)).thenAnswer(
        (_) async => Failure<UserAddressResponseDto>(errorMessage: "error"),
      );
      //act
      var response = await repository.addUserAddress(addAddress);
      //assert
      expect(response, isA<Failure<List<Address>>>());
      expect((response as Failure<List<Address>>).errorMessage, "error");
      verify(mockDataSource.addUserAddress(addAddress)).called(1);
    });
  });

  group("test repository on calling updateAddress", () {
    test(
      "case dataSource return Success<UserAddressResponseDto> list of update Addresses when updateAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        when(
          mockDataSource.updateUserAddress(
            addAddress,
            processedAddresses.last.id!,
          ),
        ).thenAnswer(
          (_) async => Success<UserAddressResponseDto>(
            data: UserAddressResponseDto(
              message: "success",
              addresses: processedAddresses,
            ),
          ),
        );
        //Act
        var response = await repository.updateUserAddress(
          addAddress,
          processedAddresses.last.id!,
        );
        //Assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data.length,
          processedAddresses.length,
        );
        verify(
          mockDataSource.updateUserAddress(
            addAddress,
            processedAddresses.last.id!,
          ),
        ).called(1);
      },
    );

    test("case dataSource return Failure<UserAddressResponseDto> and return ", () async {
      //arrange
      when(
        mockDataSource.updateUserAddress(
          addAddress,
          mockCurrentServerAddresses.last.id!,
        ),
      ).thenAnswer((_) async => Failure<UserAddressResponseDto>(errorMessage: "error"));
      //act
      var response = await repository.updateUserAddress(
        addAddress,
        mockCurrentServerAddresses.last.id!,
      );
      //assert
      expect(response, isA<Failure<List<Address>>>());
      expect((response as Failure<List<Address>>).errorMessage, "error");
      verify(
        mockDataSource.updateUserAddress(
          addAddress,
          mockCurrentServerAddresses.last.id!,
        ),
      ).called(1);
    });
  });

  group("test repository on calling getLoggedUserAddresses", () {
    test(
      "case dataSource return Success<UserAddressResponseDto> list of addresses when getLoggedUserAddresses is  called",
      () async {
        //arrange
        when(mockDataSource.getLoggedUserAddresses()).thenAnswer(
          (_) async => Success<UserAddressResponseDto>(
            data: UserAddressResponseDto(
              message: "success",
              addresses: mockCurrentServerAddresses,
            ),
          ),
        );
        //act
        var response = await repository.getLoggedUserAddresses();
        //assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data.length,
          mockCurrentServerAddresses.length,
        );
        verify(mockDataSource.getLoggedUserAddresses()).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressResponseDto> when Exception when getLoggedUserAddresses called",
      () async {
        //arrange
        when(mockDataSource.getLoggedUserAddresses()).thenAnswer(
          (_) async => Failure<UserAddressResponseDto>(errorMessage: "error"),
        );
        // act
        var response = await repository.getLoggedUserAddresses();
        //assert
        expect(response, isA<Failure<List<Address>>>());
        expect((response as Failure<List<Address>>).errorMessage, "error");
      },
    );
  });

  group("test repository on calling removeAddress", () {
    test(
      "case dataSource return Success<UserAddressResponseDto> list of remove Addresses when updateAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        when(
          mockDataSource.removeUserAddress(processedAddresses.last.id!),
        ).thenAnswer(
          (_) async => Success<UserAddressResponseDto>(
            data: UserAddressResponseDto(
              message: "success",
              addresses: processedAddresses,
            ),
          ),
        );
        //Act
        var response = await repository.removeUserAddress(
          processedAddresses.last.id!,
        );
        //Assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data.length,
          processedAddresses.length,
        );
        verify(
          mockDataSource.removeUserAddress(processedAddresses.last.id!),
        ).called(1);
      },
    );

    test("case dataSource return Failure<UserAddressResponseDto> and return ", () async {
      //arrange
      when(
        mockDataSource.removeUserAddress(mockCurrentServerAddresses.last.id!),
      ).thenAnswer((_) async => Failure<UserAddressResponseDto>(errorMessage: "error"));
      //act
      var response = await repository.removeUserAddress(
        mockCurrentServerAddresses.last.id!,
      );
      //assert
      expect(response, isA<Failure<List<Address>>>());
      expect((response as Failure<List<Address>>).errorMessage, "error");
      verify(
        mockDataSource.removeUserAddress(mockCurrentServerAddresses.last.id!),
      ).called(1);
    });
  });
}
