import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:flower_app/features/user_address/domain/repositories/user_address_repo_contract.dart';
import 'package:flower_app/features/user_address/domain/use_cases/get_logged_user_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_logged_user_address_use_case_test.mocks.dart';

@GenerateMocks([UserAddressRepoContract])
void main() {
  late GetLoggedUserAddressesUseCase useCase;
  late MockUserAddressRepoContract mockRepo;
  late List<Address> mockCurrentServerAddresses;

  setUpAll(() {
    mockRepo = MockUserAddressRepoContract();
    useCase = GetLoggedUserAddressesUseCase(mockRepo);

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
  });

  group("test usecase on calling getLoggedUserAddresses", () {
    test(
      "case dataSource return Success<UserAddressResponseDto> list of addresses when getLoggedUserAddresses is  called",
      () async {
        //arrange
        when(mockRepo.getLoggedUserAddresses()).thenAnswer(
          (_) async => Success<List<Address>>(
            data: mockCurrentServerAddresses,
          ),
        );
        //act
        var response = await useCase();
        //assert
        expect(response, isA<Success<List<Address>>>());
        expect(
          (response as Success<List<Address>>).data.length,
          mockCurrentServerAddresses.length,
        );
        verify(mockRepo.getLoggedUserAddresses()).called(1);
      },
    );

    test(
      "case dataSource return Failure<UserAddressResponseDto> when Exception when getLoggedUserAddresses called",
      () async {
        //arrange
        when(mockRepo.getLoggedUserAddresses()).thenAnswer(
          (_) async => Failure<List<Address>>(errorMessage: "error"),
        );
        // act
        var response = await useCase();
        //assert
        expect(response, isA<Failure<List<Address>>>());
        expect((response as Failure<List<Address>>).errorMessage, "error");
      },
    );
  });
}
