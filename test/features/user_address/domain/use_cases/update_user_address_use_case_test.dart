import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:flower_app/features/user_address/domain/repositories/user_address_repo_contract.dart';
import 'package:flower_app/features/user_address/domain/use_cases/update_user_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_user_address_use_case_test.mocks.dart';

@GenerateMocks([UserAddressRepoContract])
void main() {
  late UpdateUserAddressUseCase useCase;
  late MockUserAddressRepoContract mockRepo;
  late Address addAddress;
  late List<Address> mockCurrentServerAddresses;
  String errorMessage = "error";
  setUpAll(() {
    provideDummy<Result<List<Address>>>(Success<List<Address>>(data: []));
    mockRepo = MockUserAddressRepoContract();
    useCase = UpdateUserAddressUseCase(mockRepo);
    mockCurrentServerAddresses = [
      Address(
        street: "initial 12 Nile Street",
        phone: "initial 01012345678",
        city: "initial Cairo",
        lat: "initial 30.0444",
        long: "initial 31.2357",
        username: "initial Mark Raouf",
        id: "000000000000000000000000",
      ),
    ];
    addAddress = Address(
      street: "add 12 Nile Street",
      phone: "add 01012345678",
      city: "add Cairo",
      lat: "add 30.0444",
      long: "add 31.2357",
      username: "add Mark Raouf",
    );
  });

  group("test repo on calling updateAddress", () {
    test(
      "case dataSource return Success<UserAddressResponseDto> list of update Addresses when updateAddress called",
      () async {
        //Arrange
        List<Address> processedAddresses = List.from(
          mockCurrentServerAddresses,
        );
        when(
          mockRepo.updateUserAddress(any, any),
        ).thenAnswer((_) async {
          return Success<List<Address>>(data: processedAddresses);
        });
        //Act
        var response = await useCase(addAddress, processedAddresses.last.id!);
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
          mockRepo.updateUserAddress(any, any),
        ).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressResponseDto> and return ",
      () async {
        //arrange
        when(
          mockRepo.updateUserAddress(
            any,
            any,
          ),
        ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
        //act
        var response = await useCase(
          addAddress,
          mockCurrentServerAddresses.last.id!,
        );
        //assert
        expect(response, isA<Failure<List<Address>>>());
        expect((response as Failure<List<Address>>).errorMessage, isNotNull);
        expect(response.errorMessage, isNotNull);
        verify(
          mockRepo.updateUserAddress(
            any,
            any,
          ),
        ).called(1);
      },
    );
  });
}
