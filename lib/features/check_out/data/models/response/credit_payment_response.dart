import 'package:flower_app/features/check_out/domain/Entities/credit_payment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_payment_response.g.dart';

@JsonSerializable()
class CreditPaymentResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "session")
  final Session? session;

  CreditPaymentResponse({this.message, this.session});

  CreditPaymentResponse copyWith({String? message, Session? session}) =>
      CreditPaymentResponse(
        message: message ?? this.message,
        session: session ?? this.session,
      );

  factory CreditPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreditPaymentResponseToJson(this);

  CreditPaymentEntity toEntity() {
    return const CreditPaymentEntity();
  }
}

@JsonSerializable()
class Session {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "object")
  final String? object;
  @JsonKey(name: "adaptive_pricing")
  final AdaptivePricing? adaptivePricing;
  @JsonKey(name: "after_expiration")
  final dynamic afterExpiration;
  @JsonKey(name: "allow_promotion_codes")
  final dynamic allowPromotionCodes;
  @JsonKey(name: "amount_subtotal")
  final int? amountSubtotal;
  @JsonKey(name: "amount_total")
  final int? amountTotal;
  @JsonKey(name: "automatic_tax")
  final AutomaticTax? automaticTax;
  @JsonKey(name: "billing_address_collection")
  final dynamic billingAddressCollection;
  @JsonKey(name: "branding_settings")
  final BrandingSettings? brandingSettings;
  @JsonKey(name: "cancel_url")
  final String? cancelUrl;
  @JsonKey(name: "client_reference_id")
  final String? clientReferenceId;
  @JsonKey(name: "client_secret")
  final dynamic clientSecret;
  @JsonKey(name: "collected_information")
  final CollectedInformation? collectedInformation;
  @JsonKey(name: "consent")
  final dynamic consent;
  @JsonKey(name: "consent_collection")
  final dynamic consentCollection;
  @JsonKey(name: "created")
  final int? created;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "currency_conversion")
  final dynamic currencyConversion;
  @JsonKey(name: "custom_fields")
  final List<dynamic>? customFields;
  @JsonKey(name: "custom_text")
  final CustomText? customText;
  @JsonKey(name: "customer")
  final dynamic customer;
  @JsonKey(name: "customer_account")
  final dynamic customerAccount;
  @JsonKey(name: "customer_creation")
  final String? customerCreation;
  @JsonKey(name: "customer_details")
  final CustomerDetails? customerDetails;
  @JsonKey(name: "customer_email")
  final String? customerEmail;
  @JsonKey(name: "discounts")
  final List<dynamic>? discounts;
  @JsonKey(name: "expires_at")
  final int? expiresAt;
  @JsonKey(name: "integration_identifier")
  final dynamic integrationIdentifier;
  @JsonKey(name: "invoice")
  final dynamic invoice;
  @JsonKey(name: "invoice_creation")
  final InvoiceCreation? invoiceCreation;
  @JsonKey(name: "livemode")
  final bool? livemode;
  @JsonKey(name: "locale")
  final dynamic locale;
  @JsonKey(name: "managed_payments")
  final AdaptivePricing? managedPayments;
  @JsonKey(name: "metadata")
  final SessionMetadata? metadata;
  @JsonKey(name: "mode")
  final String? mode;
  @JsonKey(name: "origin_context")
  final dynamic originContext;
  @JsonKey(name: "payment_intent")
  final dynamic paymentIntent;
  @JsonKey(name: "payment_link")
  final dynamic paymentLink;
  @JsonKey(name: "payment_method_collection")
  final String? paymentMethodCollection;
  @JsonKey(name: "payment_method_configuration_details")
  final PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  @JsonKey(name: "payment_method_options")
  final PaymentMethodOptions? paymentMethodOptions;
  @JsonKey(name: "payment_method_types")
  final List<String>? paymentMethodTypes;
  @JsonKey(name: "payment_status")
  final String? paymentStatus;
  @JsonKey(name: "permissions")
  final dynamic permissions;
  @JsonKey(name: "phone_number_collection")
  final AdaptivePricing? phoneNumberCollection;
  @JsonKey(name: "recovered_from")
  final dynamic recoveredFrom;
  @JsonKey(name: "saved_payment_method_options")
  final dynamic savedPaymentMethodOptions;
  @JsonKey(name: "setup_intent")
  final dynamic setupIntent;
  @JsonKey(name: "shipping_address_collection")
  final dynamic shippingAddressCollection;
  @JsonKey(name: "shipping_cost")
  final dynamic shippingCost;
  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;
  @JsonKey(name: "shipping_options")
  final List<dynamic>? shippingOptions;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "submit_type")
  final dynamic submitType;
  @JsonKey(name: "subscription")
  final dynamic subscription;
  @JsonKey(name: "success_url")
  final String? successUrl;
  @JsonKey(name: "total_details")
  final TotalDetails? totalDetails;
  @JsonKey(name: "ui_mode")
  final String? uiMode;
  @JsonKey(name: "url")
  final String? url;
  @JsonKey(name: "wallet_options")
  final dynamic walletOptions;

  Session({
    this.id,
    this.object,
    this.adaptivePricing,
    this.afterExpiration,
    this.allowPromotionCodes,
    this.amountSubtotal,
    this.amountTotal,
    this.automaticTax,
    this.billingAddressCollection,
    this.brandingSettings,
    this.cancelUrl,
    this.clientReferenceId,
    this.clientSecret,
    this.collectedInformation,
    this.consent,
    this.consentCollection,
    this.created,
    this.currency,
    this.currencyConversion,
    this.customFields,
    this.customText,
    this.customer,
    this.customerAccount,
    this.customerCreation,
    this.customerDetails,
    this.customerEmail,
    this.discounts,
    this.expiresAt,
    this.integrationIdentifier,
    this.invoice,
    this.invoiceCreation,
    this.livemode,
    this.locale,
    this.managedPayments,
    this.metadata,
    this.mode,
    this.originContext,
    this.paymentIntent,
    this.paymentLink,
    this.paymentMethodCollection,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.permissions,
    this.phoneNumberCollection,
    this.recoveredFrom,
    this.savedPaymentMethodOptions,
    this.setupIntent,
    this.shippingAddressCollection,
    this.shippingCost,
    this.shippingDetails,
    this.shippingOptions,
    this.status,
    this.submitType,
    this.subscription,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
    this.walletOptions,
  });

  Session copyWith({
    String? id,
    String? object,
    AdaptivePricing? adaptivePricing,
    dynamic afterExpiration,
    dynamic allowPromotionCodes,
    int? amountSubtotal,
    int? amountTotal,
    AutomaticTax? automaticTax,
    dynamic billingAddressCollection,
    BrandingSettings? brandingSettings,
    String? cancelUrl,
    String? clientReferenceId,
    dynamic clientSecret,
    CollectedInformation? collectedInformation,
    dynamic consent,
    dynamic consentCollection,
    int? created,
    String? currency,
    dynamic currencyConversion,
    List<dynamic>? customFields,
    CustomText? customText,
    dynamic customer,
    dynamic customerAccount,
    String? customerCreation,
    CustomerDetails? customerDetails,
    String? customerEmail,
    List<dynamic>? discounts,
    int? expiresAt,
    dynamic integrationIdentifier,
    dynamic invoice,
    InvoiceCreation? invoiceCreation,
    bool? livemode,
    dynamic locale,
    AdaptivePricing? managedPayments,
    SessionMetadata? metadata,
    String? mode,
    dynamic originContext,
    dynamic paymentIntent,
    dynamic paymentLink,
    String? paymentMethodCollection,
    PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails,
    PaymentMethodOptions? paymentMethodOptions,
    List<String>? paymentMethodTypes,
    String? paymentStatus,
    dynamic permissions,
    AdaptivePricing? phoneNumberCollection,
    dynamic recoveredFrom,
    dynamic savedPaymentMethodOptions,
    dynamic setupIntent,
    dynamic shippingAddressCollection,
    dynamic shippingCost,
    dynamic shippingDetails,
    List<dynamic>? shippingOptions,
    String? status,
    dynamic submitType,
    dynamic subscription,
    String? successUrl,
    TotalDetails? totalDetails,
    String? uiMode,
    String? url,
    dynamic walletOptions,
  }) => Session(
    id: id ?? this.id,
    object: object ?? this.object,
    adaptivePricing: adaptivePricing ?? this.adaptivePricing,
    afterExpiration: afterExpiration ?? this.afterExpiration,
    allowPromotionCodes: allowPromotionCodes ?? this.allowPromotionCodes,
    amountSubtotal: amountSubtotal ?? this.amountSubtotal,
    amountTotal: amountTotal ?? this.amountTotal,
    automaticTax: automaticTax ?? this.automaticTax,
    billingAddressCollection:
        billingAddressCollection ?? this.billingAddressCollection,
    brandingSettings: brandingSettings ?? this.brandingSettings,
    cancelUrl: cancelUrl ?? this.cancelUrl,
    clientReferenceId: clientReferenceId ?? this.clientReferenceId,
    clientSecret: clientSecret ?? this.clientSecret,
    collectedInformation: collectedInformation ?? this.collectedInformation,
    consent: consent ?? this.consent,
    consentCollection: consentCollection ?? this.consentCollection,
    created: created ?? this.created,
    currency: currency ?? this.currency,
    currencyConversion: currencyConversion ?? this.currencyConversion,
    customFields: customFields ?? this.customFields,
    customText: customText ?? this.customText,
    customer: customer ?? this.customer,
    customerAccount: customerAccount ?? this.customerAccount,
    customerCreation: customerCreation ?? this.customerCreation,
    customerDetails: customerDetails ?? this.customerDetails,
    customerEmail: customerEmail ?? this.customerEmail,
    discounts: discounts ?? this.discounts,
    expiresAt: expiresAt ?? this.expiresAt,
    integrationIdentifier: integrationIdentifier ?? this.integrationIdentifier,
    invoice: invoice ?? this.invoice,
    invoiceCreation: invoiceCreation ?? this.invoiceCreation,
    livemode: livemode ?? this.livemode,
    locale: locale ?? this.locale,
    managedPayments: managedPayments ?? this.managedPayments,
    metadata: metadata ?? this.metadata,
    mode: mode ?? this.mode,
    originContext: originContext ?? this.originContext,
    paymentIntent: paymentIntent ?? this.paymentIntent,
    paymentLink: paymentLink ?? this.paymentLink,
    paymentMethodCollection:
        paymentMethodCollection ?? this.paymentMethodCollection,
    paymentMethodConfigurationDetails:
        paymentMethodConfigurationDetails ??
        this.paymentMethodConfigurationDetails,
    paymentMethodOptions: paymentMethodOptions ?? this.paymentMethodOptions,
    paymentMethodTypes: paymentMethodTypes ?? this.paymentMethodTypes,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    permissions: permissions ?? this.permissions,
    phoneNumberCollection: phoneNumberCollection ?? this.phoneNumberCollection,
    recoveredFrom: recoveredFrom ?? this.recoveredFrom,
    savedPaymentMethodOptions:
        savedPaymentMethodOptions ?? this.savedPaymentMethodOptions,
    setupIntent: setupIntent ?? this.setupIntent,
    shippingAddressCollection:
        shippingAddressCollection ?? this.shippingAddressCollection,
    shippingCost: shippingCost ?? this.shippingCost,
    shippingDetails: shippingDetails ?? this.shippingDetails,
    shippingOptions: shippingOptions ?? this.shippingOptions,
    status: status ?? this.status,
    submitType: submitType ?? this.submitType,
    subscription: subscription ?? this.subscription,
    successUrl: successUrl ?? this.successUrl,
    totalDetails: totalDetails ?? this.totalDetails,
    uiMode: uiMode ?? this.uiMode,
    url: url ?? this.url,
    walletOptions: walletOptions ?? this.walletOptions,
  );

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable()
class AdaptivePricing {
  @JsonKey(name: "enabled")
  final bool? enabled;

  AdaptivePricing({this.enabled});

  AdaptivePricing copyWith({bool? enabled}) =>
      AdaptivePricing(enabled: enabled ?? this.enabled);

  factory AdaptivePricing.fromJson(Map<String, dynamic> json) =>
      _$AdaptivePricingFromJson(json);

  Map<String, dynamic> toJson() => _$AdaptivePricingToJson(this);
}

@JsonSerializable()
class AutomaticTax {
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "liability")
  final dynamic liability;
  @JsonKey(name: "provider")
  final dynamic provider;
  @JsonKey(name: "status")
  final dynamic status;

  AutomaticTax({this.enabled, this.liability, this.provider, this.status});

  AutomaticTax copyWith({
    bool? enabled,
    dynamic liability,
    dynamic provider,
    dynamic status,
  }) => AutomaticTax(
    enabled: enabled ?? this.enabled,
    liability: liability ?? this.liability,
    provider: provider ?? this.provider,
    status: status ?? this.status,
  );

  factory AutomaticTax.fromJson(Map<String, dynamic> json) =>
      _$AutomaticTaxFromJson(json);

  Map<String, dynamic> toJson() => _$AutomaticTaxToJson(this);
}

@JsonSerializable()
class BrandingSettings {
  @JsonKey(name: "background_color")
  final String? backgroundColor;
  @JsonKey(name: "border_style")
  final String? borderStyle;
  @JsonKey(name: "button_color")
  final String? buttonColor;
  @JsonKey(name: "display_name")
  final String? displayName;
  @JsonKey(name: "font_family")
  final String? fontFamily;
  @JsonKey(name: "icon")
  final Icon? icon;
  @JsonKey(name: "logo")
  final Icon? logo;

  BrandingSettings({
    this.backgroundColor,
    this.borderStyle,
    this.buttonColor,
    this.displayName,
    this.fontFamily,
    this.icon,
    this.logo,
  });

  BrandingSettings copyWith({
    String? backgroundColor,
    String? borderStyle,
    String? buttonColor,
    String? displayName,
    String? fontFamily,
    Icon? icon,
    Icon? logo,
  }) => BrandingSettings(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    borderStyle: borderStyle ?? this.borderStyle,
    buttonColor: buttonColor ?? this.buttonColor,
    displayName: displayName ?? this.displayName,
    fontFamily: fontFamily ?? this.fontFamily,
    icon: icon ?? this.icon,
    logo: logo ?? this.logo,
  );

  factory BrandingSettings.fromJson(Map<String, dynamic> json) =>
      _$BrandingSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$BrandingSettingsToJson(this);
}

@JsonSerializable()
class Icon {
  @JsonKey(name: "file")
  final String? file;
  @JsonKey(name: "type")
  final String? type;

  Icon({this.file, this.type});

  Icon copyWith({String? file, String? type}) =>
      Icon(file: file ?? this.file, type: type ?? this.type);

  factory Icon.fromJson(Map<String, dynamic> json) => _$IconFromJson(json);

  Map<String, dynamic> toJson() => _$IconToJson(this);
}

@JsonSerializable()
class CollectedInformation {
  @JsonKey(name: "business_name")
  final dynamic businessName;
  @JsonKey(name: "individual_name")
  final dynamic individualName;
  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;

  CollectedInformation({
    this.businessName,
    this.individualName,
    this.shippingDetails,
  });

  CollectedInformation copyWith({
    dynamic businessName,
    dynamic individualName,
    dynamic shippingDetails,
  }) => CollectedInformation(
    businessName: businessName ?? this.businessName,
    individualName: individualName ?? this.individualName,
    shippingDetails: shippingDetails ?? this.shippingDetails,
  );

  factory CollectedInformation.fromJson(Map<String, dynamic> json) =>
      _$CollectedInformationFromJson(json);

  Map<String, dynamic> toJson() => _$CollectedInformationToJson(this);
}

@JsonSerializable()
class CustomText {
  @JsonKey(name: "after_submit")
  final dynamic afterSubmit;
  @JsonKey(name: "shipping_address")
  final dynamic shippingAddress;
  @JsonKey(name: "submit")
  final dynamic submit;
  @JsonKey(name: "terms_of_service_acceptance")
  final dynamic termsOfServiceAcceptance;

  CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  CustomText copyWith({
    dynamic afterSubmit,
    dynamic shippingAddress,
    dynamic submit,
    dynamic termsOfServiceAcceptance,
  }) => CustomText(
    afterSubmit: afterSubmit ?? this.afterSubmit,
    shippingAddress: shippingAddress ?? this.shippingAddress,
    submit: submit ?? this.submit,
    termsOfServiceAcceptance:
        termsOfServiceAcceptance ?? this.termsOfServiceAcceptance,
  );

  factory CustomText.fromJson(Map<String, dynamic> json) =>
      _$CustomTextFromJson(json);

  Map<String, dynamic> toJson() => _$CustomTextToJson(this);
}

@JsonSerializable()
class CustomerDetails {
  @JsonKey(name: "address")
  final dynamic address;
  @JsonKey(name: "business_name")
  final dynamic businessName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "individual_name")
  final dynamic individualName;
  @JsonKey(name: "name")
  final dynamic name;
  @JsonKey(name: "phone")
  final dynamic phone;
  @JsonKey(name: "tax_exempt")
  final String? taxExempt;
  @JsonKey(name: "tax_ids")
  final dynamic taxIds;

  CustomerDetails({
    this.address,
    this.businessName,
    this.email,
    this.individualName,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  CustomerDetails copyWith({
    dynamic address,
    dynamic businessName,
    String? email,
    dynamic individualName,
    dynamic name,
    dynamic phone,
    String? taxExempt,
    dynamic taxIds,
  }) => CustomerDetails(
    address: address ?? this.address,
    businessName: businessName ?? this.businessName,
    email: email ?? this.email,
    individualName: individualName ?? this.individualName,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    taxExempt: taxExempt ?? this.taxExempt,
    taxIds: taxIds ?? this.taxIds,
  );

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

@JsonSerializable()
class InvoiceCreation {
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "invoice_data")
  final InvoiceData? invoiceData;

  InvoiceCreation({this.enabled, this.invoiceData});

  InvoiceCreation copyWith({bool? enabled, InvoiceData? invoiceData}) =>
      InvoiceCreation(
        enabled: enabled ?? this.enabled,
        invoiceData: invoiceData ?? this.invoiceData,
      );

  factory InvoiceCreation.fromJson(Map<String, dynamic> json) =>
      _$InvoiceCreationFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceCreationToJson(this);
}

@JsonSerializable()
class InvoiceData {
  @JsonKey(name: "account_tax_ids")
  final dynamic accountTaxIds;
  @JsonKey(name: "custom_fields")
  final dynamic customFields;
  @JsonKey(name: "description")
  final dynamic description;
  @JsonKey(name: "footer")
  final dynamic footer;
  @JsonKey(name: "issuer")
  final dynamic issuer;
  @JsonKey(name: "metadata")
  final InvoiceDataMetadata? metadata;
  @JsonKey(name: "rendering_options")
  final dynamic renderingOptions;

  InvoiceData({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  InvoiceData copyWith({
    dynamic accountTaxIds,
    dynamic customFields,
    dynamic description,
    dynamic footer,
    dynamic issuer,
    InvoiceDataMetadata? metadata,
    dynamic renderingOptions,
  }) => InvoiceData(
    accountTaxIds: accountTaxIds ?? this.accountTaxIds,
    customFields: customFields ?? this.customFields,
    description: description ?? this.description,
    footer: footer ?? this.footer,
    issuer: issuer ?? this.issuer,
    metadata: metadata ?? this.metadata,
    renderingOptions: renderingOptions ?? this.renderingOptions,
  );

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}

@JsonSerializable()
class InvoiceDataMetadata {
  InvoiceDataMetadata();

  factory InvoiceDataMetadata.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataMetadataToJson(this);
}

@JsonSerializable()
class SessionMetadata {
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "street")
  final String? street;

  SessionMetadata({this.city, this.lat, this.long, this.phone, this.street});

  SessionMetadata copyWith({
    String? city,
    String? lat,
    String? long,
    String? phone,
    String? street,
  }) => SessionMetadata(
    city: city ?? this.city,
    lat: lat ?? this.lat,
    long: long ?? this.long,
    phone: phone ?? this.phone,
    street: street ?? this.street,
  );

  factory SessionMetadata.fromJson(Map<String, dynamic> json) =>
      _$SessionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionMetadataToJson(this);
}

@JsonSerializable()
class PaymentMethodConfigurationDetails {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "parent")
  final dynamic parent;

  PaymentMethodConfigurationDetails({this.id, this.parent});

  PaymentMethodConfigurationDetails copyWith({String? id, dynamic parent}) =>
      PaymentMethodConfigurationDetails(
        id: id ?? this.id,
        parent: parent ?? this.parent,
      );

  factory PaymentMethodConfigurationDetails.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentMethodConfigurationDetailsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentMethodConfigurationDetailsToJson(this);
}

@JsonSerializable()
class PaymentMethodOptions {
  @JsonKey(name: "card")
  final Card? card;

  PaymentMethodOptions({this.card});

  PaymentMethodOptions copyWith({Card? card}) =>
      PaymentMethodOptions(card: card ?? this.card);

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodOptionsToJson(this);
}

@JsonSerializable()
class Card {
  @JsonKey(name: "request_three_d_secure")
  final String? requestThreeDSecure;

  Card({this.requestThreeDSecure});

  Card copyWith({String? requestThreeDSecure}) => Card(
    requestThreeDSecure: requestThreeDSecure ?? this.requestThreeDSecure,
  );

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable()
class TotalDetails {
  @JsonKey(name: "amount_discount")
  final int? amountDiscount;
  @JsonKey(name: "amount_shipping")
  final int? amountShipping;
  @JsonKey(name: "amount_tax")
  final int? amountTax;

  TotalDetails({this.amountDiscount, this.amountShipping, this.amountTax});

  TotalDetails copyWith({
    int? amountDiscount,
    int? amountShipping,
    int? amountTax,
  }) => TotalDetails(
    amountDiscount: amountDiscount ?? this.amountDiscount,
    amountShipping: amountShipping ?? this.amountShipping,
    amountTax: amountTax ?? this.amountTax,
  );

  factory TotalDetails.fromJson(Map<String, dynamic> json) =>
      _$TotalDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalDetailsToJson(this);
}
