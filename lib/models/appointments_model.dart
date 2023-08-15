class AppointmentModel {
  final int appId;
  final String appCode;
  final int customerId;
  final int lawyerId;
  final String appFirstname;
  final String appLastname;
  final String appEmail;
  final String appContact;
  final String appLocation;
  final dynamic appBudget;
  final dynamic appRange;
  final int appEthnicityId;
  final dynamic appImmigInformation;
  final String appVisaTypeId;
  final int appTypeId;
  final String status;
  final String appStartTime;
  final String appEndTime;
  final String appDate;
  final dynamic appDetail;
  final String createdAt;
  final String updatedAt;
  final int id;
  final int typeId;
  final int ethnicityId;
  final int visaTypeId;
  final String firstname;
  final String lastname;
  final String gender;
  final String experience;
  final dynamic hourlyRate;
  final String description;
  final String fields;
  final String website;
  final String phoneNo;
  final String email;
  final dynamic password;
  final dynamic sraAuthorized;
  final dynamic sraNumber;
  final dynamic qualification;
  final dynamic membership;
  final String startTime;
  final String endTime;
  final String location;
  final dynamic area;
  final String lat;
  final String lng;
  final dynamic streetNumber;
  final dynamic route;
  final dynamic locality;
  final dynamic administrativeAreaLevel1;
  final dynamic postalCode;
  final String country;
  final String ethnicityName;
  final String lawyersType;
  final String visaTypeName;

  AppointmentModel({
    required this.appId,
    required this.appCode,
    required this.customerId,
    required this.lawyerId,
    required this.appFirstname,
    required this.appLastname,
    required this.appEmail,
    required this.appContact,
    required this.appLocation,
    required this.appBudget,
    required this.appRange,
    required this.appEthnicityId,
    required this.appImmigInformation,
    required this.appVisaTypeId,
    required this.appTypeId,
    required this.status,
    required this.appStartTime,
    required this.appEndTime,
    required this.appDate,
    required this.appDetail,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.typeId,
    required this.ethnicityId,
    required this.visaTypeId,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.experience,
    required this.hourlyRate,
    required this.description,
    required this.fields,
    required this.website,
    required this.phoneNo,
    required this.email,
    required this.password,
    required this.sraAuthorized,
    required this.sraNumber,
    required this.qualification,
    required this.membership,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.area,
    required this.lat,
    required this.lng,
    required this.streetNumber,
    required this.route,
    required this.locality,
    required this.administrativeAreaLevel1,
    required this.postalCode,
    required this.country,
    required this.ethnicityName,
    required this.lawyersType,
    required this.visaTypeName,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appId: json['app_id'],
      appCode: json['app_code'],
      customerId: json['customer_id'],
      lawyerId: json['lawyer_id'],
      appFirstname: json['app_firstname'],
      appLastname: json['app_lastname'],
      appEmail: json['app_email'],
      appContact: json['app_contact'],
      appLocation: json['app_location'],
      appBudget: json['app_budget'],
      appRange: json['app_range'],
      appEthnicityId: json['app_ethnicity_id'],
      appImmigInformation: json['app_immig_information'],
      appVisaTypeId: json['app_visatype_id'],
      appTypeId: json['app_type_id'],
      status: json['status'],
      appStartTime: json['app_start_time'],
      appEndTime: json['app_end_time'],
      appDate: json['app_date'],
      appDetail: json['app_detail'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id: json['id'],
      typeId: json['type_id'],
      ethnicityId: json['ethnicity_id'],
      visaTypeId: json['visatype_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      gender: json['gender'],
      experience: json['experience'],
      hourlyRate: json['hourly_rate'],
      description: json['description'],
      fields: json['fields'],
      website: json['website'],
      phoneNo: json['phone_no'],
      email: json['email'],
      password: json['password'],
      sraAuthorized: json['sra_authorized'],
      sraNumber: json['sra_number'],
      qualification: json['qualification'],
      membership: json['membership'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      location: json['location'],
      area: json['area'],
      lat: json['lat'],
      lng: json['lng'],
      streetNumber: json['street_number'],
      route: json['route'],
      locality: json['locality'],
      administrativeAreaLevel1: json['administrative_area_level_1'],
      postalCode: json['postal_code'],
      country: json['country'],
      ethnicityName: json['ethnicity_name'],
      lawyersType: json['lawyers_type'],
      visaTypeName: json['visa_type_name'],
    );
  }
}
