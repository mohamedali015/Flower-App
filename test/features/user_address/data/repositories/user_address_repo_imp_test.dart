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
main() {
  late UserAddressRepoContract repo;
  late MockUserAddressRemoteDataSourceContract mockRemoteDataSource;
  late AddressDto addAddressDto;
  late List<AddressDto> mockCurrentServerAddresses;
  String successMessage = "success";
  String errorMessage = "error";
  setUpAll(() {
    provideDummy<Result<UserAddressDto>>(
      Success<UserAddressDto>(data: UserAddressDto()),
    );
    mockRemoteDataSource = MockUserAddressRemoteDataSourceContract();
    repo = UserAddressRepoImp(mockRemoteDataSource);
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

    addAddressDto = AddressDto(
      street: "add 12 Nile Street",
      phone: "add 01012345678",
      city: "add Cairo",
      lat: "add 30.0444",
      long: "add 31.2357",
      username: "add Mark Raouf",
    );
  });

  group("test repo on calling addAddress", () {
    test(
      "case dataSource return Success<UserAddressDto> list of addresses when addAddress called",
      () async {
        //Arrange

        List<AddressDto> processedAddressesDto = List.from(
          mockCurrentServerAddresses,
        );
        List<Address> processedAddresses = await Future.wait(
          processedAddressesDto.map((e) => e.toEntity()),
        );

        when(mockRemoteDataSource.addUserAddress(addAddressDto)).thenAnswer((
          _,
        ) async {
          processedAddressesDto.add(addAddressDto);
          processedAddresses.add(await addAddressDto.toEntity());
          return Success<UserAddressDto>(
            data: UserAddressDto(
              message: successMessage,
              address: processedAddressesDto,
            ),
          );
        });
        //Act
        var response = await repo.addUserAddress(addAddressDto);

        //Assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data,
          equals(processedAddresses),
        );
        expect(response.data, isNotEmpty);
        expect(response.data, isNotNull);
        expect(response.data.length, mockCurrentServerAddresses.length + 1);
        verify(mockRemoteDataSource.addUserAddress(addAddressDto)).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressDto> and return ",
      () async {
        //arrange
        when(
          mockRemoteDataSource.addUserAddress(addAddressDto),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
        //act
        var response = await repo.addUserAddress(addAddressDto);
        //assert
        expect(response, isA<Failure<List<Address>>>());
        expect((response as Failure<List<Address>>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotNull);
        verify(mockRemoteDataSource.addUserAddress(addAddressDto)).called(1);
      },
    );
  });

  group("test repo on calling updateAddress", () {
    test(
      "case dataSource return Success<UserAddressDto> list of update Addresses when updateAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddressesDto = List.from(
          mockCurrentServerAddresses,
        );
        List<Address> processedAddresses = await Future.wait(
          processedAddressesDto.map((e) => e.toEntity()),
        );
        when(
          mockRemoteDataSource.updateUserAddress(
            addAddressDto,
            processedAddresses.last.id,
          ),
        ).thenAnswer((_) async {
          return Success<UserAddressDto>(
            data: UserAddressDto(
              message: successMessage,
              address: processedAddressesDto,
            ),
          );
        });
        //Act
        var response = await repo.updateUserAddress(
          addAddressDto,
          processedAddresses.last.id!,
        );
        //Assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data,
          equals(processedAddresses),
        );
        expect(response.data, isNotEmpty);
        expect(response.data, isNotNull);
        expect(response.data.length, mockCurrentServerAddresses.length);
        verify(
          mockRemoteDataSource.updateUserAddress(
            addAddressDto,
            processedAddresses.last.id!,
          ),
        ).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressDto> and return ",
      () async {
        //arrange
        when(
          mockRemoteDataSource.updateUserAddress(
            addAddressDto,
            mockCurrentServerAddresses.last.id,
          ),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
        //act
        var response = await repo.updateUserAddress(
          addAddressDto,
          mockCurrentServerAddresses.last.id!,
        );
        //assert
        expect(response, isA<Failure<List<Address>>>());
        expect((response as Failure<List<Address>>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotNull);
        verify(
          mockRemoteDataSource.updateUserAddress(
            addAddressDto,
            mockCurrentServerAddresses.last.id,
          ),
        ).called(1);
      },
    );
  });

  group("test repo on calling getLoggedUserAddress", () {
    test(
      "case dataSource return Success<UserAddressDto> list of addresses when getLoggedUserAddress is  called",
      () async {
        //arrange

        List<Address> processedAddresses = await Future.wait(
          mockCurrentServerAddresses.map((e) => e.toEntity()),
        );

        when(mockRemoteDataSource.getLoggedUserAddress()).thenAnswer(
          (_) async => Success<UserAddressDto>(
            data: UserAddressDto(
              message: successMessage,
              address: mockCurrentServerAddresses,
            ),
          ),
        );
        //act
        var response = await repo.getLoggedUserAddress();
        //assert
        expect(response, isA<Success<List<Address>>>());
        expect((response as Success<List<Address>>).data, isNotNull);
        expect(response.data, isNotEmpty);
        expect(response.data, equals(processedAddresses));
        verify(mockRemoteDataSource.getLoggedUserAddress()).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressDto> when Exception when getLoggedUserAddress called",
      () async {
        //arrange
        when(
          mockRemoteDataSource.getLoggedUserAddress(),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
        // act
        var response = await repo.getLoggedUserAddress();
        //assert
        expect(response, isA<Failure<List<Address>>>());
        expect((response as Failure<List<Address>>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotEmpty);
      },
    );
  });

  group("test repo on calling removeAddress", () {
    test(
      "case dataSource return Success<UserAddressDto> list of remove Addresses when updateAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddressesDto = List.from(
          mockCurrentServerAddresses,
        );

        List<Address> processedAddresses = await Future.wait(
          processedAddressesDto.map((e) => e.toEntity()),
        );

        when(
          mockRemoteDataSource.removeUserAddress(processedAddresses.last.id),
        ).thenAnswer((_) async {
          return Success<UserAddressDto>(
            data: UserAddressDto(
              message: successMessage,
              address: processedAddressesDto,
            ),
          );
        });
        //Act
        var response = await repo.removeUserAddress(
          processedAddresses.last.id!,
        );
        //Assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data,
          equals(processedAddresses),
        );
        expect(response.data, isNotEmpty);
        expect(response.data, isNotNull);
        expect(response.data.length, mockCurrentServerAddresses.length);
        verify(
          mockRemoteDataSource.removeUserAddress(processedAddresses.last.id!),
        ).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressDto> and return ",
      () async {
        //arrange
        when(
          mockRemoteDataSource.removeUserAddress(
            mockCurrentServerAddresses.last.id,
          ),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
        //act
        var response = await repo.removeUserAddress(
          mockCurrentServerAddresses.last.id!,
        );
        //assert
        expect(response, isA<Failure<List<Address>>>());
        expect((response as Failure<List<Address>>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotNull);
        verify(
          mockRemoteDataSource.removeUserAddress(
            mockCurrentServerAddresses.last.id,
          ),
        ).called(1);
      },
    );
  });
}
