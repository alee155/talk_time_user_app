class Availability {
  final String day; // Day of the week
  final String startTime; // Start time for the availability
  final String endTime; // End time for the availability

  Availability({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  // Factory method to create an Availability object from a map
  factory Availability.fromMap(Map<String, dynamic> data) {
    return Availability(
      day: data['day'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
    );
  }
}

class ProviderModel {
  String id; // Unique identifier for the provider
  String fullName; // Provider's full name
  String description; // Description of the provider
  String email; // Provider's email
  String contactNumber; // Provider's contact number
  String experience; // Years of experience
  String experienceDescription; // Description of experience
  bool formFilled; // Whether the form is filled
  String imageUrl; // URL of the provider's image
  String location; // Provider's location
  double pricePerHour; // Price per hour for service
  String service; // Type of service provided
  String status; // Status of the provider (active/inactive)
  String uid; // User ID of the provider
  List<Availability> availability; // List of availability objects

  ProviderModel({
    required this.id,
    required this.fullName,
    required this.description,
    required this.email,
    required this.contactNumber,
    required this.experience,
    required this.experienceDescription,
    required this.formFilled,
    required this.imageUrl,
    required this.location,
    required this.pricePerHour,
    required this.service,
    required this.status,
    required this.uid,
    required this.availability,
  });

  // Factory method to create a ProviderModel object from a map
  factory ProviderModel.fromMap(Map<String, dynamic> data, String documentId) {
    print('Mapping data for document: $documentId');
    print('Raw data: $data');

    // Map the availability list
    List<Availability> availabilityList =
        (data['availability'] as List<dynamic>? ?? [])
            .map((item) => Availability.fromMap(item))
            .toList();

    return ProviderModel(
      id: documentId,
      fullName: data['fullName'] ?? 'Unknown Provider', // Default value
      description: data['description'] ?? 'No description available.',
      email: data['email'] ?? 'No email provided',
      contactNumber: data['contactNumber'] ?? 'No contact number provided',
      experience: data['experience'] ?? 'Not specified',
      experienceDescription: data['experienceDescription'] ?? 'No description.',
      formFilled: data['formFilled'] ?? false,
      imageUrl: data['imageUrl'] ?? '',
      location: data['location'] ?? 'Unknown Location',
      pricePerHour: (data['pricePerHour'] != null)
          ? double.tryParse(data['pricePerHour'].toString()) ?? 0.0
          : 0.0,
      service: data['service'] ?? 'Not specified',
      status: data['status'] ?? 'Inactive',
      uid: data['uid'] ?? '',
      availability: availabilityList, // Set the availability list
    );
  }
}
