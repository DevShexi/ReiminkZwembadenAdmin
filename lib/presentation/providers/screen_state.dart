enum StateType { initial, loading, error, success }

class ScreenState<T> {
  final StateType stateType;
  T? data;
  String? errorMessage;

  ScreenState(this.stateType);

  ScreenState.initial() : stateType = StateType.initial;
  ScreenState.loading() : stateType = StateType.loading;
  ScreenState.success(this.data) : stateType = StateType.success;
  ScreenState.error(this.errorMessage) : stateType = StateType.error;
}
