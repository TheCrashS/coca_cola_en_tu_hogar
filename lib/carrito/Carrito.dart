import 'package:flutter/material.dart';
import 'package:coca_cola_en_tu_hogar/produc/item.dart';

 class Carrito extends ChangeNotifier {
   Map<String, Item> _items = {};

   Map<String, Item> get items {
     return {..._items};
   }

   int get numeroItems {
     return _items.length;
   }

   double get subTotal {
     var total = 0.0;
     items.forEach((key, elementos) =>
     total += (elementos.precio * elementos.cantidad) as double);
     return total;
   }

   double get impuesto {
     var total = 0.0;
     total = this.montoTotal * 0.18;
     return total;
   }

   double get total {
     var total = 0.0;
     total = this.subTotal * 1.18;
     return total;
   }

   get montoTotal => null;

   void agregarItem(String producto_id,
       String nombre,
       String precio,
       String unidad,
       String imagen,
       int cantidad,) {
     if (_items.containsKey(producto_id)) {
       _items.update(
           producto_id,
               (old) =>
               Item(
                   id: old.id,
                   nombre: old.nombre,
                   precio: old.precio,
                   unidad: old.unidad,
                   imagen: old.imagen,
                   cantidad: old.cantidad + 1
               )
       );
     } else {
       _items.putIfAbsent(
           producto_id,
               () =>
               Item(
                   id: producto_id,
                   nombre: nombre,
                   precio: precio,
                   unidad: unidad,
                   imagen: imagen,
                   cantidad: 1
               )
       );
     }
   }

   void removerItem(String producto_id) {
     _items.remove(producto_id);
   }

   void incrementarCantidadItem(String producto_id) {
     if (_items.containsKey(producto_id)) {
       _items.update(
           producto_id,
               (old) =>
               Item(
                   id: old.id,
                   nombre: old.nombre,
                   precio: old.precio,
                   unidad: old.unidad,
                   imagen: old.imagen,
                   cantidad: old.cantidad + 1
               )
       );
     }
   }

   void decrementarCantidadItem(String producto_id) {
     if (!_items.containsKey(producto_id)) return;
     if (_items[producto_id]!.cantidad > 1) {
       _items.update(
           producto_id,
               (old) =>
               Item(
                   id: old.id,
                   nombre: old.nombre,
                   precio: old.precio,
                   unidad: old.unidad,
                   imagen: old.imagen,
                   cantidad: old.cantidad - 1
               )
       );
     } else {
       _items.remove(producto_id);
     }
   }

   void removeCarrito() {
     _items = {};
   }
 }
