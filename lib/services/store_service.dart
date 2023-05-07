import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../config/helper/random_string_helper.dart';
import '../models/CartItemModel.dart';
import '../models/CategoryModel.dart';
import '../models/OrderModel.dart';
import '../models/Productmodel.dart';

class StoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    DocumentReference products =
        FirebaseFirestore.instance.collection('products').doc(product.id);
    return products
        .set({
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'categoryId': product.categoryId,
          'subCategoryId': product.subCategoryId,
          'created_at': product.created_at,
          'quantity': product.quantity,
          'rating': product.rating,
          'sales': product.sales,
          'images': product.images
        })
        .then((value) => print('Product added'))
        .catchError((error) => print('Failed to add product: $error'));
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
          cartItemData['quantity'] = (docSnapshot.data()!['quantity'] ?? 0) + 1;
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
      await _firestore
          .collection('shopping_cart')
          .doc(order.uid)
          .collection('products')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
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
}
