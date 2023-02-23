class LawyerModel {
  final int id;
  final int typeId;
  final int ethnicityId;
  final dynamic visaTypeId;
  final String firstName;
  final String lastName;
  final String gender;
  final String experience;
  final String hourlyRate;
  final String description;
  final Map<String, dynamic> fields;
  final String website;
  final String phoneNo;
  final String email;
  final String password;
  final String sraAuthorized;
  final String sraNumber;
  final String qualification;
  final dynamic membership;
  final String startTime;
  final String endTime;
  final String location;
  final String area;
  final String lat;
  final String lng;
  final dynamic streetNumber;
  final dynamic route;
  final dynamic locality;
  final dynamic administrativeAreaLevel1;
  final dynamic postalCode;
  final dynamic country;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String lawyerType;
  final String ethnicityType;

  LawyerModel({
    required this.id,
    required this.typeId,
    required this.ethnicityId,
    this.visaTypeId,
    required this.firstName,
    required this.lastName,
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
    this.membership,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.area,
    required this.lat,
    required this.lng,
    this.streetNumber,
    this.route,
    this.locality,
    this.administrativeAreaLevel1,
    this.postalCode,
    this.country,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.lawyerType,
    required this.ethnicityType,
  });

  factory LawyerModel.fromJson(Map<String, dynamic> json) {
    return LawyerModel(
      id: json['id'],
      typeId: json['type_id'],
      ethnicityId: json['ethnicity_id'],
      visaTypeId: json['visatype_id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
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
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      lawyerType: json['lawyer_type'],
      ethnicityType: json['ethnicity_type'],
    );
  }
}
