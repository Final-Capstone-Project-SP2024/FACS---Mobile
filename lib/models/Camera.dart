class Camera {
  String cameraName;
  String cameraDestination;
  String status;

  Camera({
    required this.cameraName,
    required this.cameraDestination,
    required this.status,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      cameraName: json['cameraName'],
      cameraDestination: json['cameraDestination'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cameraName'] = this.cameraName;
    data['cameraDestination'] = this.cameraDestination;
    data['status'] = this.status;
    return data;
  }
}
