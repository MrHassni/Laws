class LawyerModel {
  int id;
  int typeId;
  int ethnicityId;
  dynamic visaTypeId;
  String firstName;
  String lastName;
  String gender;
  String experience;
  dynamic hourlyRate;
  dynamic description;
  String fields;
  List fieldsName;
  dynamic website;
  dynamic phoneNo;
  String email;
  dynamic password;
  dynamic sraAuthorized;
  dynamic sraNumber;
  dynamic qualification;
  dynamic membership;
  dynamic startTime;
  String endTime;
  String location;
  dynamic area;
  dynamic lat;
  dynamic lng;
  dynamic streetNumber;
  dynamic route;
  dynamic locality;
  dynamic administrativeAreaLevel1;
  dynamic postalCode;
  dynamic country;
  dynamic status;
  String createdAt;
  String updatedAt;
  String ethnicityName;
  String lawyersType;

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
    required this.fieldsName,
    required this.website,
    required this.phoneNo,
    required this.email,
    required this.ethnicityName,
    required this.lawyersType,
    this.password,
    required this.fields,
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
    fieldsName: json["fields_name"],
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
    lawyersType: json['lawyers_type'],
    ethnicityName: json['ethnicity_name']
  );

}