class NetworkResponse {
  NetworkResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.data,
  });

  final bool error;
  final String message;
  final int count;
  final int founded;
  final Map<String, dynamic>? data;

  NetworkResponse.fromJson(Map<String, dynamic>? json, String dataKey)
      : error = json?["error"] ?? true,
        message = json?["message"] ?? "Error Fetching Network Data!",
        count = json?["count"] ?? 0,
        founded = json?["founded"] ?? 0,
        data = (json?[dataKey] != null)
            ? {
                "data": json?["dataKey"],
              }
            : null;
}
