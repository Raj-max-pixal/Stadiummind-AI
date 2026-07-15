class ApiConstants {
  // Base URLs
  static const String baseUrl = 'http://localhost:8000';
  static const String wsUrl = 'ws://localhost:8000';
  
  // API Endpoints
  static const String authPath = '/api/auth';
  static const String assistantPath = '/api/assistant';
  static const String crowdPath = '/api/crowd';
  static const String emergencyPath = '/api/emergency';
  static const String translationPath = '/api/translate';
  static const String adminPath = '/api/admin';
  
  // WebSocket Endpoints
  static const String crowdWs = '/ws/crowd';
  static const String emergencyWs = '/ws/emergency';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
