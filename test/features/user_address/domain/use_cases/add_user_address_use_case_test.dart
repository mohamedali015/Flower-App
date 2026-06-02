import 'package:flower_app/config/error_handling/result.dart';

import 'package:flower_app/features/user_address/data/models/address_dto.dart';
import 'package:flower_app/features/user_address/data/models/user_address_dto.dart';
import 'package:flower_app/features/user_address/domain/repositories/user_address_repo_contract.dart';
import 'package:flower_app/features/user_address/domain/use_cases/add_user_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_user_address_use_case_test.mocks.dart';

@GenerateMocks([UserAddressRepoContract])
main() {
  late AddUserAddressUseCase useCase;
  late MockUserAddressRepoContract mockRepo;
  late AddressDto addAddress;
  late List<AddressDto> mockCurrentServerAddresses;
  String successMessage = "success";
  String errorMessage = "error";
  setUpAll(() {
    provideDummy<Result<UserAddressDto>>(
      Success<UserAddressDto>(data: UserAddressDto()),
    );
    mockRepo = MockUserAddressRepoContract();
    useCase = AddUserAddressUseCase(mockRepo);
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

  group("test repo on calling addAddress", () {
    test(
      "case dataSource return Success<UserAddressDto> list of addresses when addAddress called",
      () async {
        //Arrange
        List<AddressDto> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        when(mockRepo.addUserAddress(addAddress)).thenAnswer((_) async {
          processedAddresses.add(addAddress);
          return Success<UserAddressDto>(
            data: UserAddressDto(
              message: successMessage,
              address: processedAddresses,
            ),
          );
        });
        //Act
        var response = await useCase(addAddress);
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
        verify(mockRepo.addUserAddress(addAddress)).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressDto> and return ",
      () async {
        //arrange
        when(
          mockRepo.addUserAddress(addAddress),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
        //act
        var response = await useCase(addAddress);
        //assert
        expect(response, isA<Failure<UserAddressDto>>());
        expect((response as Failure<UserAddressDto>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotNull);
        verify(mockRepo.addUserAddress(addAddress)).called(1);
      },
    );
  });
}
