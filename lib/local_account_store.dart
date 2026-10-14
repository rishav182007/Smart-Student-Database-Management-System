class LocalAccountStore {
  static final Map<String, Map<String, String>> _accounts = {
    'teachers': <String, String>{},
    'students': <String, String>{},
  };

  static bool accountExists({required String category, required String id}) {
    final accounts = _accounts[category];
    if (accounts == null) return false;
    return accounts.containsKey(id.trim().toLowerCase());
  }

  static void saveAccount({
    required String category,
    required String id,
    required String password,
  }) {
    final normalizedId = id.trim();
    _accounts.putIfAbsent(category, () => <String, String>{});
    _accounts[category]![normalizedId.toLowerCase()] = password;
  }

  static bool validateLogin({
    required String category,
    required String id,
    required String password,
  }) {
    final accounts = _accounts[category];
    if (accounts == null) return false;

    final savedPassword = accounts[id.trim().toLowerCase()];
    return savedPassword != null && savedPassword == password;
  }
}
