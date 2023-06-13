import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../config/helper/random_string_helper.dart';
import '../models/BannerModel.dart';
import '../models/CartItemModel.dart';
import '../models/CategoryModel.dart';
import '../models/OrderModel.dart';
import '../models/Productmodel.dart';
import '../models/StatisticalModel.dart';
import '../models/UserModel.dart';

class StoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) =>
            UserModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<BannerModel>> getBannersStream() {
    return _firestore.collection('banners').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => BannerModel.fromJson(doc.data() as Map<String, dynamic>),)
          .toList(),
    );
  }

  Stream<List<CategoryModel>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) =>
                CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<CategoryModel>> getSubCategories(String categoryId) {
    return _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('subCategories')
        .limit(6)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<ProductModel>> getPopularProducts() {
    return _firestore.collection('products').limit(6).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) =>
                ProductModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> updateOrderStatus(String orderId, String status,OrderModel order) async {
    try {
      if(order.cancelRequest == true && status=="Canceled"){
        await _firestore.collection('orders').doc(orderId).update({
          'status': "Canceled",
          'cancelRequest': false
        });
      }else if(status =="Completed"){
        var totalQuantity = order.items.fold(0, (sum, item) => sum + item.quantity);
        var profit = double.parse(order.total)*10/100;
        addOrUpdateStatisticalModel(totalQuantity,profit,double.parse(order.total));
        await _firestore.collection('orders').doc(orderId).update({
          'status': status,
          'cancelRequest': false
        });
      }else{
        await _firestore.collection('orders').doc(orderId).update({
          'status': status,
        });
      }
      print('Order status updated successfully!');
    } catch (error) {
      print('Error updating order status: $error');
    }
  }
  Future<void> addOrUpdateStatisticalModel(int ordersTotal,double profit,double sales) async {
    final dayNow = DateFormat('yyyy/MM/dd').format(DateTime.now());
    final querySnapshot = await _firestore
        .collection('statistical')
        .where('day', isEqualTo: dayNow)
        .limit(1)
        .get();

    if (querySnapshot.size > 0) {
      final docId = querySnapshot.docs[0].id;
      await _firestore
          .collection('statistical')
          .doc(docId)
          .update({
        'ordersTotal': FieldValue.increment(ordersTotal),
        'profit': FieldValue.increment(profit),
        'sales': FieldValue.increment(sales),
      });
    } else {
      final id = RandomStringHelper.generateRandomString(20);
      final StatisticalModel statisticalModel = StatisticalModel(id: id, day: dayNow, ordersTotal: ordersTotal, profit: profit, sales: sales);
      await _firestore.collection('statistical').doc(id).set(statisticalModel.toJson());
    }
  }

  Future<List<CategoryModel>> getAllSubCategories(String categoryId) async {
    final subCategories = <CategoryModel>[];
    try {
      final querySnapshot = await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('subCategories')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (final doc in querySnapshot.docs) {
          final subCategory = CategoryModel.fromJson(doc.data());
          subCategories.add(subCategory);
        }
      }
    } catch (e) {
      print('Error getting products for category: $e');
    }
    return subCategories;
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').doc(product.id).set(product.toJson());
      print('Product added successfully!');
    } catch (error) {
      print('Error adding product: $error');
    }
  }
  Future<void> updateProduct(ProductModel product) async {
    try {
      final productRef = _firestore.collection('products').doc(product.id);
      await productRef.update(product.toJson());
      print('Product updated successfully!');
    } catch (error) {
      print('Error updating product: $error');
    }
  }

  Future<void> removeProduct(String id) async {
    try {
      await _firestore.collection('products').doc(id).delete();
      print('Product removed successfully!');
    } catch (error) {
      print('Error removing product: $error');
    }
  }

  Future<void> removeOrder(String id) async {
    try {
      await _firestore.collection('orders').doc(id).delete();
      print('Order removed successfully!');
    } catch (error) {
      print('Error removing Order: $error');
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    final products = <ProductModel>[];
    try {
      final querySnapshot = await _firestore.collection('products').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (final doc in querySnapshot.docs) {
          final product = ProductModel.fromJson(doc.data());
          products.add(product);
        }
      }
    } catch (e) {
      print('Error getting products for category: $e');
    }
    return products;
  }

  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) =>
            ProductModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<OrderModel>> getOrders() {
    return _firestore.collection('orders').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) =>
                OrderModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<OrderModel>> getOrdersByStatus(String status) {
    return _firestore.collection('orders').where('status', isEqualTo: status).snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList()
    );
  }

  Stream<List<OrderModel>> getOrdersRequest() {
    return _firestore.collection('orders').where('cancelRequest', isEqualTo: true).snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList()
    );
  }

  Stream<List<ProductModel>> getOutOfStocksProducts() {
    return _firestore.collection('products').where('quantity',isEqualTo: 0).snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) =>
            ProductModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<List<ProductModel>> getProductsForCategory(String? categoryId) async {
    final products = <ProductModel>[];
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (final doc in querySnapshot.docs) {
          final product = ProductModel.fromJson(doc.data());
          products.add(product);
        }
      }
    } catch (e) {
      print('Error getting products for category: $e');
    }
    return products;
  }

  Stream<List<String>> getFavorites(String userId) {
    return _firestore
        .collection('favorites')
        .doc(userId)
        .snapshots()
        .map((snap) => List<String>.from(snap.data()!['productIds']));
  }

  Future<void> addFavorite(String userId, String productId) async {
    final DocumentReference docRef =
        _firestore.collection('favorites').doc(userId);
    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      await docRef.set({
        'productIds': [productId],
      });
    } else {
      await docRef.update({
        'productIds': FieldValue.arrayUnion([productId]),
      });
    }
  }

  Future<void> removeFavorite(String userId, String productId) {
    return _firestore.collection('favorites').doc(userId).update({
      'productIds': FieldValue.arrayRemove([productId]),
    });
  }

  Future<ProductModel> getProductById(String productId) async {
    try {
      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      if (productDoc.exists) {
        return ProductModel.fromJson(
            productDoc.data()! as Map<String, dynamic>);
      } else {
        throw Exception("Product not found!");
      }
    } catch (e) {
      throw Exception("Error getting product by id: $e");
    }
  }
  Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      DocumentSnapshot productDoc = await _firestore
          .collection('categories')
          .doc(categoryId)
          .get();
      if (productDoc.exists) {
        return CategoryModel.fromJson(
            productDoc.data()! as Map<String, dynamic>);
      } else {
        throw Exception("Category not found!");
      }
    } catch (e) {
      throw Exception("Error getting category by id: $e");
    }
  }
  Stream<List<CartItemModel>> getCartItems(String? uid) {
    if (uid == null) {
      return Stream.empty();
    }
    return _firestore
        .collection('shopping_cart')
        .doc(uid)
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CartItemModel.fromJson(doc.data()))
            .toList());
  }

  Future<bool> addCartItem(String uid, CartItemModel cartItem) async {
    try {
      final cartItemRef = _firestore
          .collection('shopping_cart')
          .doc(uid)
          .collection('products')
          .doc(cartItem.id);
      final cartItemData = cartItem.toJson();
      await cartItemRef.get().then((docSnapshot) async {
        if (docSnapshot.exists) {
          cartItemData['quantity'] = (docSnapshot.data()!['quantity'] ?? 0) + cartItem.quantity;
          await cartItemRef.update(cartItemData);
        } else {
          await cartItemRef.set(cartItemData);
        }
      });
      return true;
    } catch (e) {
      print('Error add product to cart: $e');
      return false;
    }
  }

  Future<bool> decrementQuantity(String uid, String itemId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('shopping_cart')
          .doc(uid)
          .collection('products')
          .doc(itemId);

      final snapshot = await docRef.get();
      if (!snapshot.exists) {
        return false;
      }

      final currentQuantity = snapshot.get('quantity');
      if (currentQuantity <= 1) {
        await docRef.delete();
        return true;
      }
      await docRef.update({'quantity': currentQuantity - 1});
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> incrementQuantity(String uid, String itemId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('shopping_cart')
          .doc(uid)
          .collection('products')
          .doc(itemId);

      final snapshot = await docRef.get();
      if (!snapshot.exists) {
        return false;
      }
      final currentQuantity = snapshot.get('quantity');
      await docRef.update({'quantity': currentQuantity + 1});
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> removeCartItem(String uid, String itemId) async {
    try {
      await _firestore
          .collection('shopping_cart')
          .doc(uid)
          .collection('products')
          .doc(itemId)
          .delete();
      return true; // Trả về true nếu xóa thành công
    } catch (e) {
      print('Error removing cart item: $e');
      return false; // Trả về false nếu xóa thất bại
    }
  }

  Future<void> addOrder(OrderModel order, String orderid) async {
    try {
      await _firestore.collection('orders').doc(orderid).set(order.toJson());
      // Lấy danh sách sản phẩm trong giỏ hàng
      final snapshot = await _firestore
          .collection('shopping_cart')
          .doc(order.uid)
          .collection('products')
          .get();
      // Duyệt qua từng sản phẩm và cập nhật quantity và sales
      for (final doc in snapshot.docs) {
        final productId = doc.id;
        await _firestore
            .collection('products')
            .doc(productId)
            .update({
          'quantity': FieldValue.increment(-1),
          'sales': FieldValue.increment(1),
        });
      }
      // Xóa danh sách sản phẩm trong giỏ hàng
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<OrderModel>> getOrdersByUid(String? uid) {
    if (uid == null) {
      return Stream.empty();
    }
    return _firestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }

  Future<OrderModel> getOrderById(String orderId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> orderDoc =
          await _firestore.collection('orders').doc(orderId).get();
      OrderModel order = OrderModel.fromJson(orderDoc.data()!);
      return order;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateOrderCancelRequest(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({'status': 'Request Cancel', 'cancelRequest': true});
    } catch (e) {
      print('Error updating order: $e');
    }
  }

  Stream<List<StatisticalModel>> getStatistical() {
    return _firestore
        .collection('statistical')
        .limit(7)
        .orderBy('day',descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => StatisticalModel.fromJson(doc.data())).toList());
  }
  Future<int> countProducts() async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot snapshot) {
      count = snapshot.size;
    });
    return count;
  }


  Future<int> countCategories() async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot snapshot) {
      count = snapshot.size;
    });
    return count;
  }
  Future<int> getTotalUsersInDay(String day) async {
    int count = 0;
    try{
      await _firestore
          .collection('users')
          .get().then((QuerySnapshot snapshot) {
        count = snapshot.size;
      });
    }catch(e){
      rethrow;
    }
    return count;
  }


}
