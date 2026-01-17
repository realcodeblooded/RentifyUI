class AppState {
  final bool isAuthenticated;
  final bool isLoading;

  const AppState({
    this.isAuthenticated = false,
    this.isLoading = false,
  });

  AppState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
  }) {
    return AppState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
