import 'dart:convert';
import 'package:bloc/bloc.dart';
import '../../../../../core/utilities/api_constants.dart';
import '../../../data/models/order_requested_model.dart';
import '../../../data/models/order_socket_response.dart';
import '../../../data/repos/home_repo.dart';
import 'orders_states.dart';
import 'dart:async';

class OrdersCubit extends Cubit<OrdersState> {
  final HomeRepo homeRepo;
  StreamSubscription? _ordersSubscription;

  OrdersCubit(this.homeRepo) : super(OrdersInitial());

  List<OrderRequestedModel> incomingOrders = [];
  List<OrderRequestedModel> preparingOrders = [];

  void initSocket(String token) {
    _ordersSubscription?.cancel();
    homeRepo.initOrdersSocket(token: token);

    _ordersSubscription = homeRepo.listenToOrders().listen((event) {
      if (!isClosed) {
        try {
          final Map<String, dynamic> responseMap =
          event is String ? jsonDecode(event) : event;
          final socketResponse = OrderSocketResponse.fromJson(responseMap);

          if (socketResponse.type == 'new_order') {
            emit(NewIncomingOrderSuccess(socketResponse.data));
          } else if (socketResponse.type == 'order_canceled') {
            emit(OrderCanceledSuccess(socketResponse.data));
          }
        } catch (e) {
          print("An Error has occurred");
        }
      }
    });
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    homeRepo.closeSocket();
    return super.close();
  }

  Future<void> getOrders({
    required String token,
    required String status,
  }) async {
    // عدلنا الشرط هنا عشان يقبل 'accepted' اللي مبعوتة من الشاشة
    if (status == 'pending') {
      emit(GetIncomingOrdersLoadingState());
    } else if (status == 'accepted') {
      emit(GetPreparingOrdersLoadingState());
    }

    var result = await homeRepo.getOrders(token: token, status: status);

    result.fold(
          (failure) {
        if (status == 'pending') {
          emit(GetIncomingOrdersErrorState(failure.errorMessage));
        } else if (status == 'accepted') { // عدلنا هنا كمان
          emit(GetPreparingOrdersErrorState(failure.errorMessage));
        }
      },
          (ordersResponse) {
        if (status == 'pending') {
          incomingOrders = ordersResponse;
          emit(GetIncomingOrdersSuccessState(incomingOrders));
        } else if (status == 'accepted') { // عدلنا هنا لتخزين الـ accepted جوه لستة الـ preparing
          preparingOrders = ordersResponse;
          emit(GetPreparingOrdersSuccessState(preparingOrders));
        }
      },
    );
  }

  void refreshOrders() {
    getOrders(
      token: ApiConstants.token!,
      status: 'pending',
    );
    getOrders(
      token: ApiConstants.token!,
      status: 'accepted', // عدلنا دي من preparing لـ accepted عشان الـ token يروح للـ API الصح
    );
  }

  Future<void> updateOrderStatus({
    required String token,
    required String orderId,
    required String status,
  }) async {
    emit(UpdateOrderStatusLoadingState());

    var result = await homeRepo.updateOrderStatus(
      token: token,
      orderId: orderId,
      status: status,
    );

    result.fold(
          (failure) => emit(UpdateOrderStatusErrorState(failure.errorMessage)),
          (updatedStatusModel) {
        emit(UpdateOrderStatusSuccessState(updatedStatusModel));
        refreshOrders();
      },
    );
  }
}