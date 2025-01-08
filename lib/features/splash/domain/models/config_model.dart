import 'package:user_app/data/model/image_full_url.dart';

class ConfigModel {
  String? brandSetting;
  String? digitalProductSetting;
  int? systemDefaultCurrency;
  bool? digitalPayment;
  bool? cashOnDelivery;
  String? sellerRegistration;
  String? posActive;
  String? companyPhone;
  String? companyEmail;
  ImageFullUrl? companyFavIcon;

  int? deliveryCountryRestriction;
  int? deliveryZipCodeAreaRestriction;
  BaseUrls? baseUrls;
  StaticUrls? staticUrls;
  String? aboutUs;
  String? privacyPolicy;
  List<Faq>? faq;
  String? termsConditions;

  RefundPolicy? refundPolicy;
  RefundPolicy? returnPolicy;
  RefundPolicy? cancellationPolicy;
  List<CurrencyList>? currencyList;
  String? currencySymbolPosition;
  String? businessMode;
  bool? maintenanceMode;
  List<Language>? language;

  List<ColorsModel>? colors;
  List<String>? unit;
  String? shippingMethod;
  bool? emailVerification;
  bool? phoneVerification;
  String? countryCode;
  List<SocialLogin>? socialLogin;
  String? currencyModel;
  String? forgotPasswordVerification;
  Announcement? announcement;
  String? pixelanalytics;
  String? softwareVersion;
  int? decimalPointSettings;
  String? inhouseSelectedShippingType;
  int? billingInputByCustomer;
  int? minimumOrderLimit;
  int? walletStatus;
  int? loyaltyPointStatus;
  double? loyaltyPointExchangeRate;
  int? loyaltyPointMinimumPoint;
  List<PaymentMethods>? paymentMethods;
  OfflinePayment? offlinePayment;
  String? paymentMethodImagePath;
  String? refEarningStatus;
  String? activeTheme;
  List<PopularTags>? popularTags;
  int? guestCheckOut;
  String? uploadpictureondelivery;
  CustomerLogin? customerLogin;

  UserAppVersionControl? userAppVersionControl;
  SellerAppVersion? sellerAppVersion;
  DeliveryMapApp? deliveryMapApp;
  String? refSignup;
  int? addFundsToWallet;
  double? minimumAddFundAmount;
  double? maximumAddFundAmount;
  InhouseTemporaryClose? inhouseTemporaryClose;
  InhouseVacationAdd? inhouseVacationAdd;

  int? freedeliverystate;
  int? freedeliveryoveramount;
  String? freedeliveryresponsiblity;
  int? freedeliveryover;
  int? minimumOrderAmountState;
  int? minimumOrderAmount;
  int? minimumOrderAmountSeller;
  int? orderVerification;
  String? referralCustomerSignup;
  String? systemTimezone;

  ConfigModel({
    this.brandSetting,
    this.digitalProductSetting,
    this.systemDefaultCurrency,
    this.digitalPayment,
    this.cashOnDelivery,
    this.sellerRegistration,
    this.posActive,
    this.companyPhone,
    this.companyEmail,
    this.companyFavIcon,
    this.deliveryCountryRestriction,
    this.deliveryZipCodeAreaRestriction,
    this.baseUrls,
    this.staticUrls,
    this.aboutUs,
    this.privacyPolicy,
    this.faq,
    this.termsConditions,
    this.refundPolicy,
    this.returnPolicy,
    this.cancellationPolicy,
    this.currencyList,
    this.currencySymbolPosition,
    this.businessMode,
    this.maintenanceMode,
    this.language,
    this.colors,
    this.unit,
    this.shippingMethod,
    this.emailVerification,
    this.phoneVerification,
    this.refSignup,
    this.countryCode,
    this.socialLogin,
    this.currencyModel,
    this.forgotPasswordVerification,
    this.announcement,
    this.pixelanalytics,
    this.softwareVersion,
    this.decimalPointSettings,
    this.inhouseSelectedShippingType,
    this.billingInputByCustomer,
    this.minimumOrderLimit,
    this.walletStatus,
    this.loyaltyPointStatus,
    this.loyaltyPointExchangeRate,
    this.loyaltyPointMinimumPoint,
    this.paymentMethods,
    this.offlinePayment,
    this.paymentMethodImagePath,
    this.refEarningStatus,
    this.activeTheme,
    this.popularTags,
    this.guestCheckOut,
    this.addFundsToWallet,
    this.minimumAddFundAmount,
    this.maximumAddFundAmount,
    this.orderVerification,
    this.inhouseTemporaryClose,
    this.inhouseVacationAdd,
    this.userAppVersionControl,
    this.systemTimezone,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    brandSetting = json['brand_setting'] ?? 'default_brand_setting';
    digitalProductSetting = json['digital_product_setting'] ?? false;
    systemDefaultCurrency = json['system_default_currency'] ?? 'USD';
    digitalPayment = json['digital_payment'] ?? false;
    cashOnDelivery = json['cash_on_delivery'] ?? false;
    sellerRegistration = json['seller_registration'] ?? false;
    posActive = json['pos_active'] ?? false;
    companyPhone = json['company_phone']?.toString() ?? '0000000000';
    companyEmail = json['company_email'] ?? 'default@company.com';
companyFavIcon = json['company_logo'] != null
    ? (json['company_logo'] is Map<String, dynamic>
        ? ImageFullUrl.fromJson(json['company_logo'])
        : ImageFullUrl.fromString(json['company_logo'])) // استخدم دالة لمعالجة النصوص
    : null;

    deliveryCountryRestriction = json['delivery_country_restriction'] ?? 0;
    refSignup = json['referral_customer_signup_url'] ?? '';
    deliveryZipCodeAreaRestriction =
        json['delivery_zip_code_area_restriction'] ?? 0;

    baseUrls =
        json['base_urls'] != null ? BaseUrls.fromJson(json['base_urls']) : null;
    staticUrls = json['static_urls'] != null
        ? StaticUrls.fromJson(json['static_urls'])
        : null;
    aboutUs = json['about_us'] ?? '';
    privacyPolicy = json['privacy_policy'] ?? '';

    faq = json['faq'] != null
        ? (json['faq'] as List).map((v) => Faq.fromJson(v)).toList()
        : [];

    customerLogin = json['customer_login'] != null
        ? CustomerLogin.fromJson(json['customer_login'])
        : null;
    termsConditions = json['terms_&_conditions'] ?? '';
    refundPolicy = json['refund_policy'] != null
        ? RefundPolicy.fromJson(json['refund_policy'])
        : null;
    returnPolicy = json['return_policy'] != null
        ? RefundPolicy.fromJson(json['return_policy'])
        : null;
    cancellationPolicy = json['cancellation_policy'] != null
        ? RefundPolicy.fromJson(json['cancellation_policy'])
        : null;

    currencyList = json['currency_list'] != null
        ? (json['currency_list'] as List)
            .map((v) => CurrencyList.fromJson(v))
            .toList()
        : [];
    currencySymbolPosition = json['currency_symbol_position'] ?? '';
    businessMode = json['business_mode'] ?? '';

    language = json['language'] != null
        ? (json['language'] as List).map((v) => Language.fromJson(v)).toList()
        : [];
    colors = json['colors'] != null
        ? (json['colors'] as List).map((v) => ColorsModel.fromJson(v)).toList()
        : [];
    unit = json['unit']?.cast<String>() ?? [];
    shippingMethod = json['shipping_method'] ?? '';
    emailVerification = json['email_verification'] ?? false;
    phoneVerification = json['phone_verification'] ?? false;

    countryCode = json['country_code'] ?? '';
    socialLogin = json['social_login'] != null
        ? (json['social_login'] as List)
            .map((v) => SocialLogin.fromJson(v))
            .toList()
        : [];
    currencyModel = json['currency_model'] ?? '';
    forgotPasswordVerification = json['forgot_password_verification'] ?? false;
    announcement = json['announcement'] != null
        ? Announcement.fromJson(json['announcement'])
        : null;
    softwareVersion = json['software_version'] ?? '1.0.0';

    decimalPointSettings =
        int.tryParse(json['decimal_point_settings']?.toString() ?? '1') ?? 1;

    inhouseSelectedShippingType = json['inhouse_selected_shipping_type'] ?? '';
    billingInputByCustomer = json['billing_input_by_customer'] ?? false;
    minimumOrderLimit = json['minimum_order_limit'] ?? 0;
    walletStatus = json['wallet_status'] ?? false;
    loyaltyPointStatus = json['loyalty_point_status'] ?? false;

    loyaltyPointExchangeRate = double.tryParse(
            json['loyalty_point_exchange_rate']?.toString() ?? '1.0') ??
        1.0;

    loyaltyPointMinimumPoint = json['loyalty_point_minimum_point'] ?? 0;
    paymentMethods = json['payment_methods'] != null
        ? (json['payment_methods'] as List)
            .map((v) => PaymentMethods.fromJson(v))
            .toList()
        : [];
    offlinePayment = json['offline_payment'] != null
        ? OfflinePayment.fromJson(json['offline_payment'])
        : null;
    paymentMethodImagePath = json['payment_method_image_path'] ?? '';
    refEarningStatus = json['ref_earning_status']?.toString() ?? '';
    activeTheme = json['active_theme'] ?? '';

    popularTags = json['popular_tags'] != null
        ? (json['popular_tags'] as List)
            .map((v) => PopularTags.fromJson(v))
            .toList()
        : [];
    guestCheckOut =
        int.tryParse(json['guest_checkout']?.toString() ?? '0') ?? 0;
    addFundsToWallet =
        int.tryParse(json['add_funds_to_wallet']?.toString() ?? '0') ?? 0;

    minimumAddFundAmount =
        double.tryParse(json['minimum_add_fund_amount']?.toString() ?? '0.0') ??
            0.0;
    maximumAddFundAmount =
        double.tryParse(json['maximum_add_fund_amount']?.toString() ?? '0.0') ??
            0.0;

    orderVerification = json['order_verification'] ?? false;

    inhouseTemporaryClose = json['inhouse_temporary_close'] != null
        ? InhouseTemporaryClose.fromJson(json['inhouse_temporary_close'])
        : null;
    inhouseVacationAdd = json['inhouse_vacation_add'] != null
        ? InhouseVacationAdd.fromJson(json['inhouse_vacation_add'])
        : null;

    userAppVersionControl = json['user_app_version_control'] != null
        ? UserAppVersionControl.fromJson(json['user_app_version_control'])
        : null;
  }
}

class BaseUrls {
  String? productImageUrl;
  String? productThumbnailUrl;
  String? digitalProductUrl;
  String? brandImageUrl;
  String? bannerImageUrl;
  String? customerImageUrl;
  String? categoryImageUrl;
  String? reviewImageUrl;
  String? sellerImageUrl;
  String? shopImageUrl;
  String? notificationImageUrl;
  String? deliveryManImageUrl;
  String? supportTicketImageUrl;
  String? chattingImageUrl;

  BaseUrls(
      {this.productImageUrl,
      this.productThumbnailUrl,
      this.digitalProductUrl,
      this.brandImageUrl,
      this.customerImageUrl,
      this.bannerImageUrl,
      this.categoryImageUrl,
      this.reviewImageUrl,
      this.sellerImageUrl,
      this.shopImageUrl,
      this.notificationImageUrl,
      this.deliveryManImageUrl,
      this.supportTicketImageUrl,
      this.chattingImageUrl});

  BaseUrls.fromJson(Map<String, dynamic> json) {
    productImageUrl = json['product_image_url'];
    productThumbnailUrl = json['product_thumbnail_url'];
    digitalProductUrl = json['digital_product_url'];
    brandImageUrl = json['brand_image_url'];
    customerImageUrl = json['customer_image_url'];
    bannerImageUrl = json['banner_image_url'];
    categoryImageUrl = json['category_image_url'];
    reviewImageUrl = json['review_image_url'];
    sellerImageUrl = json['seller_image_url'];
    shopImageUrl = json['shop_image_url'];
    notificationImageUrl = json['notification_image_url'];
    deliveryManImageUrl = json['delivery_man_image_url'];
    supportTicketImageUrl = json['support_ticket_image_url'];
    chattingImageUrl = json['chatting_image_url'];
  }
}

class StaticUrls {
  String? contactUs;
  String? brands;
  String? categories;
  String? customerAccount;

  StaticUrls(
      {this.contactUs, this.brands, this.categories, this.customerAccount});

  StaticUrls.fromJson(Map<String, dynamic> json) {
    contactUs = json['contact_us'];
    brands = json['brands'];
    categories = json['categories'];
    customerAccount = json['customer_account'];
  }
}

class Faq {
  int? id;
  String? question;
  String? answer;
  int? ranking;
  int? status;
  String? createdAt;
  String? updatedAt;

  Faq(
      {this.id,
      this.question,
      this.answer,
      this.ranking,
      this.status,
      this.createdAt,
      this.updatedAt});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    ranking = json['ranking'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class RefundPolicy {
  int? status;
  String? content;

  RefundPolicy({this.status, this.content});

  RefundPolicy.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      try {
        status = json['status'];
      } catch (e) {
        status = int.parse(json['status'].toString());
      }
    }

    content = json['content'];
  }
}

class CurrencyList {
  int? id;
  String? name;
  String? symbol;
  String? code;
  bool? status;
  double? exchangeRate;
  String? createdAt;
  String? updatedAt;

  CurrencyList(
      {this.id,
      this.name,
      this.symbol,
      this.code,
      this.status,
      this.exchangeRate,
      this.createdAt,
      this.updatedAt});

  CurrencyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    code = json['code'];
    status = json['status'];
    if (json['exchange_rate'] != null) {
      try {
       exchangeRate = json['exchange_rate'] != null
    ? double.tryParse(json['exchange_rate'].toString()) ?? 0.0
    : 0.0;

      } catch (e) {
        exchangeRate = double.parse(json['exchange_rate'].toString());
      }
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Language {
  String? code;
  String? name;

  Language({this.code, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }
}

class ColorsModel {
  int? id;
  String? name;
  String? code;
  String? createdAt;
  String? updatedAt;

  ColorsModel({this.id, this.name, this.code, this.createdAt, this.updatedAt});

  ColorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class SocialLogin {
  String? loginMedium;
  bool? status;

  SocialLogin({this.loginMedium, this.status});

  SocialLogin.fromJson(Map<String, dynamic> json) {
    loginMedium = json['login_medium'];
    status = json['status'];
  }
}

class Announcement {
  String? status;
  String? color;
  String? textColor;
  String? announcement;

  Announcement({this.status, this.color, this.textColor, this.announcement});

  Announcement.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    color = json['color'];
    textColor = json['text_color'];
    announcement = json['announcement'];
  }
}

class PaymentMethods {
  String? keyName;
  String? isshow;
  AdditionalDatas? additionalDatas;

  PaymentMethods({this.isshow, this.keyName, this.additionalDatas});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    keyName = json['key_name'];
    isshow = json['is_show'];
    additionalDatas = json['additional_datas'] != null
        ? AdditionalDatas.fromJson(json['additional_datas'])
        : null;
  }
}

class AdditionalDatas {
  String? gatewayTitle;
  String? gatewayImage;

  AdditionalDatas({this.gatewayTitle, this.gatewayImage});

  AdditionalDatas.fromJson(Map<String, dynamic> json) {
    gatewayTitle = json['gateway_title'];
    gatewayImage = json['gateway_image'];
  }
}

class OfflinePayment {
  String? name;
  String? image;

  OfflinePayment({this.name, this.image});

  OfflinePayment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}

class PopularTags {
  int? id;
  String? tag;
  String? createdAt;
  String? updatedAt;

  PopularTags({this.id, this.tag, this.createdAt, this.updatedAt});

  PopularTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class InhouseTemporaryClose {
  int? status;
  InhouseTemporaryClose({this.status});

  InhouseTemporaryClose.fromJson(Map<String, dynamic> json) {
    status = int.tryParse(json['status'].toString()) ?? 0;
  }
}

class InhouseVacationAdd {
  int? status;
  String? vacationStartDate;
  String? vacationEndDate;
  String? vacationNote;

  InhouseVacationAdd(
      {this.status,
      this.vacationStartDate,
      this.vacationEndDate,
      this.vacationNote});

  InhouseVacationAdd.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    vacationStartDate = json['vacation_start_date'];
    vacationEndDate = json['vacation_end_date'];
    vacationNote = json['vacation_note'];
  }
}

class DefaultLocation {
  String? lat;
  String? lng;

  DefaultLocation({this.lat, this.lng});

  DefaultLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class UserAppVersionControl {
  ForAndroid? forAndroid;
  ForAndroid? forIos;

  UserAppVersionControl({this.forAndroid, this.forIos});

  UserAppVersionControl.fromJson(Map<String, dynamic> json) {
    forAndroid = json['for_android'] != null
        ? ForAndroid.fromJson(json['for_android'])
        : null;
    forIos =
        json['for_ios'] != null ? ForAndroid.fromJson(json['for_ios']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forAndroid != null) {
      data['for_android'] = forAndroid!.toJson();
    }
    if (forIos != null) {
      data['for_ios'] = forIos!.toJson();
    }
    return data;
  }
}

class SellerAppVersion {
  ForAndroid? forAndroid;
  ForAndroid? forIos;

  SellerAppVersion({this.forAndroid, this.forIos});

  SellerAppVersion.fromJson(Map<String, dynamic> json) {
    forAndroid = json['for_android'] != null
        ? ForAndroid.fromJson(json['for_android'])
        : null;
    forIos =
        json['for_ios'] != null ? ForAndroid.fromJson(json['for_ios']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forAndroid != null) {
      data['for_android'] = forAndroid!.toJson();
    }
    if (forIos != null) {
      data['for_ios'] = forIos!.toJson();
    }
    return data;
  }
}

class DeliveryMapApp {
  ForAndroid? forAndroid;
  ForAndroid? forIos;

  DeliveryMapApp({this.forAndroid, this.forIos});

  DeliveryMapApp.fromJson(Map<String, dynamic> json) {
    forAndroid = json['for_android'] != null
        ? ForAndroid.fromJson(json['for_android'])
        : null;
    forIos =
        json['for_ios'] != null ? ForAndroid.fromJson(json['for_ios']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forAndroid != null) {
      data['for_android'] = forAndroid!.toJson();
    }
    if (forIos != null) {
      data['for_ios'] = forIos!.toJson();
    }
    return data;
  }
}

class ForAndroid {
  int? status;
  String? version;
  String? link;

  ForAndroid({this.status, this.version, this.link});

  ForAndroid.fromJson(Map<String, dynamic> json) {
    status = int.parse(json['status'].toString());
    version = json['version'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['version'] = version;
    data['link'] = link;
    return data;
  }
}

class MaintenanceMode {
  int? maintenanceStatus;
  SelectedMaintenanceSystem? selectedMaintenanceSystem;
  MaintenanceMessages? maintenanceMessages;
  MaintenanceTypeAndDuration? maintenanceTypeAndDuration;

  MaintenanceMode(
      {this.maintenanceStatus,
      this.selectedMaintenanceSystem,
      this.maintenanceMessages,
      this.maintenanceTypeAndDuration});

  MaintenanceMode.fromJson(Map<String, dynamic> json) {
    maintenanceStatus = int.tryParse(json['maintenance_status'].toString());
    selectedMaintenanceSystem = json['selected_maintenance_system'] != null
        ? new SelectedMaintenanceSystem.fromJson(
            json['selected_maintenance_system'])
        : null;
    maintenanceMessages = json['maintenance_messages'] != null
        ? new MaintenanceMessages.fromJson(json['maintenance_messages'])
        : null;

    maintenanceTypeAndDuration = json['maintenance_type_and_duration'] != null
        ? new MaintenanceTypeAndDuration.fromJson(
            json['maintenance_type_and_duration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenance_status'] = maintenanceStatus;
    if (selectedMaintenanceSystem != null) {
      data['selected_maintenance_system'] = selectedMaintenanceSystem!.toJson();
    }
    if (maintenanceMessages != null) {
      data['maintenance_messages'] = maintenanceMessages!.toJson();
    }
    if (maintenanceTypeAndDuration != null) {
      data['maintenance_type_and_duration'] =
          maintenanceTypeAndDuration!.toJson();
    }
    return data;
  }
}

class SelectedMaintenanceSystem {
  int? branchPanel;
  int? customerApp;
  int? webApp;
  int? deliverymanApp;

  SelectedMaintenanceSystem(
      {this.branchPanel, this.customerApp, this.webApp, this.deliverymanApp});

  SelectedMaintenanceSystem.fromJson(Map<String, dynamic> json) {
    customerApp = int.tryParse(json['user_app'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_panel'] = branchPanel;
    data['customer_app'] = customerApp;
    data['web_app'] = webApp;
    data['deliveryman_app'] = deliverymanApp;
    return data;
  }
}

class MaintenanceMessages {
  int? businessNumber;
  int? businessEmail;
  String? maintenanceMessage;
  String? messageBody;

  MaintenanceMessages(
      {this.businessNumber,
      this.businessEmail,
      this.maintenanceMessage,
      this.messageBody});

  MaintenanceMessages.fromJson(Map<String, dynamic> json) {
    businessNumber = json['business_number'];
    businessEmail = json['business_email'];
    maintenanceMessage = json['maintenance_message'];
    messageBody = json['message_body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_number'] = businessNumber;
    data['business_email'] = businessEmail;
    data['maintenance_message'] = maintenanceMessage;
    data['message_body'] = messageBody;
    return data;
  }
}

class MaintenanceTypeAndDuration {
  String? _maintenanceDuration;
  String? _startDate;
  String? _endDate;

  MaintenanceTypeAndDuration(
      {String? maintenanceDuration, String? startDate, String? endDate}) {
    if (maintenanceDuration != null) {
      _maintenanceDuration = maintenanceDuration;
    }
    if (startDate != null) {
      _startDate = startDate;
    }
    if (endDate != null) {
      _endDate = endDate;
    }
  }

  String? get maintenanceDuration => _maintenanceDuration;
  set maintenanceDuration(String? maintenanceDuration) =>
      _maintenanceDuration = maintenanceDuration;
  String? get startDate => _startDate;
  set startDate(String? startDate) => _startDate = startDate;
  String? get endDate => _endDate;
  set endDate(String? endDate) => _endDate = endDate;

  MaintenanceTypeAndDuration.fromJson(Map<String, dynamic> json) {
    _maintenanceDuration = json['maintenance_duration'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenance_duration'] = _maintenanceDuration;
    data['start_date'] = _startDate;
    data['end_date'] = _endDate;
    return data;
  }
}

class CustomerLogin {
  LoginOption? loginOption;
  SocialMediaLoginOptions? socialMediaLoginOptions;

  CustomerLogin({this.loginOption, this.socialMediaLoginOptions});

  CustomerLogin.fromJson(Map<String, dynamic> json) {
    loginOption = json['login_option'] != null
        ? LoginOption.fromJson(json['login_option'])
        : null;
    socialMediaLoginOptions = json['social_media_login_options'] != null
        ? SocialMediaLoginOptions.fromJson(json['social_media_login_options'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (loginOption != null) {
      data['login_option'] = loginOption!.toJson();
    }
    if (socialMediaLoginOptions != null) {
      data['social_media_login_options'] = socialMediaLoginOptions!.toJson();
    }
    return data;
  }
}

class LoginOption {
  int? manualLogin;
  int? otpLogin;
  int? socialMediaLogin;

  LoginOption({this.manualLogin, this.otpLogin, this.socialMediaLogin});

  LoginOption.fromJson(Map<String, dynamic> json) {
    manualLogin = int.tryParse(json['manual_login'].toString());
    otpLogin = int.tryParse(json['otp_login'].toString());
    socialMediaLogin = int.tryParse(json['social_login'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['manual_login'] = manualLogin;
    data['otp_login'] = otpLogin;
    data['social_media_login'] = socialMediaLogin;
    return data;
  }
}

class SocialMediaLoginOptions {
  int? google;
  int? facebook;
  int? apple;

  SocialMediaLoginOptions({this.google, this.facebook, this.apple});

  SocialMediaLoginOptions.fromJson(Map<String, dynamic> json) {
    google = int.tryParse(json['google'].toString());
    facebook = int.tryParse(json['facebook'].toString());
    apple = int.tryParse(json['apple'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['google'] = google;
    data['facebook'] = facebook;
    data['apple'] = apple;
    return data;
  }
}

class CustomerVerification {
  int? status;
  int? phone;
  int? email;
  int? firebase;

  CustomerVerification({this.status, this.phone, this.email, this.firebase});

  CustomerVerification.fromJson(Map<String, dynamic> json) {
    status = int.tryParse(json['status'].toString()) ?? 1;
    phone = int.tryParse(json['phone'].toString());
    email = int.tryParse(json['email'].toString());
    firebase = int.tryParse(json['firebase'].toString());

    // status = 1;
    // firebase = 1;
    // email = 0;
    // phone =  0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['firebase'] = this.firebase;
    return data;
  }
}
