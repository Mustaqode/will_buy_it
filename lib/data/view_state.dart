abstract class ViewState {
  const ViewState();
}

class Loading extends ViewState {
  const Loading();
}

class Success<T> extends ViewState {
  final List<T> items;
  const Success(this.items);
}

class Error extends ViewState {
  final String reason;
  const Error(this.reason);
}
