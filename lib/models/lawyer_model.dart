class LawyerModel {
  int id;
  int typeId;
  int ethnicityId;
  int visaTypeId;
  String firstName;
  String lastName;
  String gender;
  String experience;
  String hourlyRate;
  String description;
  String fields;
  String website;
  String phoneNo;
  String email;
  dynamic password;
  dynamic sraAuthorized;
  dynamic sraNumber;
  dynamic qualification;
  dynamic membership;
  String startTime;
  String endTime;
  String location;
  dynamic area;
  String lat;
  String lng;
  dynamic streetNumber;
  dynamic route;
  dynamic locality;
  String administrativeAreaLevel1;
  dynamic postalCode;
  String country;
  String status;
  String createdAt;
  String updatedAt;

  LawyerModel({
    required this.id,
    required this.typeId,
    required this.ethnicityId,
    required this.visaTypeId,
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
    this.password,
    this.sraAuthorized,
    this.sraNumber,
    this.qualification,
    this.membership,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.area,
    required this.lat,
    required this.lng,
    this.streetNumber,
    this.route,
    this.locality,
    required this.administrativeAreaLevel1,
    this.postalCode,
    required this.country,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LawyerModel.fromJson(Map<String, dynamic> json) => LawyerModel(
    id: json["id"],
    typeId: json["type_id"],
    ethnicityId: json["ethnicity_id"],
    visaTypeId: json["visatype_id"],
    firstName: json["firstname"],
    lastName: json["lastname"],
    gender: json["gender"],
    experience: json["experience"],
    hourlyRate: json["hourly_rate"],
    description: json["description"],
    fields: json["fields"],
    website: json["website"],
    phoneNo: json["phone_no"],
    email: json["email"],
    password: json["password"],
    sraAuthorized: json["sra_authorized"],
    sraNumber: json["sra_number"],
    qualification: json["qualification"],
    membership: json["membership"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    location: json["location"],
    area: json["area"],
    lat: json["lat"],
    lng: json["lng"],
    streetNumber: json["street_number"],
    route: json["route"],
    locality: json["locality"],
    administrativeAreaLevel1: json["administrative_area_level_1"],
    postalCode: json["postal_code"],
    country: json["country"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

}