import 'dart:math';
import 'package:coca_cola_en_tu_hogar/carrito/Carrito.dart';
import 'package:coca_cola_en_tu_hogar/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart'; // Importamos para dar formato a la fecha
import 'package:coca_cola_en_tu_hogar/database_helper.dart'; // Importa el helper de la base de datos

class Pantallacarrito extends StatefulWidget {
  const Pantallacarrito({super.key});

  @override
  State<Pantallacarrito> createState() => _PantallacarritoState();
}



class _PantallacarritoState extends State<Pantallacarrito> {

  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      // Calcular el total de todos los productos
      double totalCarrito = 0.0;
      int totalCantidadProductos = 0; // Variable para el total de productos

      carrito.items.forEach((key, value) {
        totalCarrito += (_getValidPrice(value.precio) * (value.cantidad ?? 0));
        totalCantidadProductos +=
            value.cantidad ?? 0; // Sumar la cantidad de productos
      });

      // Suponiendo que tienes datos del cliente, puedes obtenerlos de alguna manera
      // Si ya tienes una clase de cliente o los datos están en un Provider, usa eso.
      String nombreCliente = "";
      String direccionCliente =
          " "; 
      String telefonoCliente =
          " "; 

      // Formato de la fecha
      String fechaPedido =
          DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

      return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text("PEDIDOS"),
          elevation: 0,
          backgroundColor: Colors.amberAccent,
        ),
        body: Container(
          child: carrito.items.isEmpty
              ? const Center(
                  child: Text("Carrito Vacio"),
                )
              : SingleChildScrollView(
                  // Aquí hemos envuelto la lista de productos
                  child: Column(
                    children: <Widget>[
                      // Lista de productos en el carrito
                      for (var item in carrito.items.values)
                        Card(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              // Imagen del producto
                              Image.asset(
                                "assets/img/${item.imagen}",
                                width: 100,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(item.nombre),
                                      // Asegúrate de que el precio es un número
                                      Text(
                                          "Bs/.${_getValidPrice(item.precio)}"),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Botón de decremento
                                          Container(
                                            width: 50,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  carrito
                                                      .decrementarCantidadItem(
                                                          item.id);
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                            child: Center(
                                              child: Text(
                                                  item.cantidad.toString()),
                                            ),
                                          ),
                                          // Botón de incremento
                                          Container(
                                            width: 50,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.add,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  carrito
                                                      .incrementarCantidadItem(
                                                          item.id);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Monto total por producto
                              Container(
                                height: 100,
                                width: 70,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Center(
                                  child: Text(
                                    "Bs/.${(_getValidPrice(item.precio) * (item.cantidad ?? 0)).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Agregar la cantidad total de productos
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("CANTIDAD DE PRODUCTOS"),
                            Text(
                              totalCantidadProductos
                                  .toString(), // Mostrar la cantidad total
                            ),
                          ],
                        ),
                      ),
                      // Sección para mostrar el total de todo el carrito
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("TOTAL"),
                            Text(
                              totalCarrito
                                  .toStringAsFixed(2), // Mostrar el total final
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        // Botón de envío centrado con el texto "Enviar"
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: ElevatedButton(
            onPressed: () async {
              String pedido = "";
              carrito.items.forEach((key, value) {
                // Asegúrate de que 'precio' y 'cantidad' no sean nulos antes de hacer el cálculo
                double precioProducto = _getValidPrice(value.precio);
                int cantidadProducto = value.cantidad ?? 0;
                double totalProducto = precioProducto * cantidadProducto;

                pedido =
                    "$pedido${value.nombre} CANTIDAD :. $precioProducto PRECIO TOTAL : ${totalProducto.toStringAsFixed(2)}, ****************************, ";
              });
              /* pedido =
                  "${pedido}SUBTOTAL: ${carrito.subTotal.toStringAsFixed(2)}, ";
              pedido =
                  "${pedido}IMPUESTO: ${carrito.impuesto.toStringAsFixed(2)}, "; */
              pedido = "${pedido}TOTAL: ${totalCarrito.toStringAsFixed(2)}, ";

              //carlos
              //123456


              String user = context.read<Usuario>().user;
              var userData = await DatabaseHelper.instance.getDataUser(user);
              String nombreData = userData?["nombre"].toString() ?? '';
              String direccionData = userData?["direccion"].toString() ?? '';
              String celularData = userData?["celular"].toString() ?? '';
              // Agregar datos del cliente
              pedido = "$pedido, Cliente: $nombreData, ";
              pedido = "${pedido}Dirección: $direccionData, ";
              pedido = "${pedido}Teléfono: $celularData, ";
              pedido = "${pedido}Fecha del Pedido: $fechaPedido, ";

              // Vínculo para enviar el mensaje por WhatsApp
              String celular = "59167924911";
              String mensaje = pedido;
              String url = "https://wa.me/$celularData?text=$mensaje";
              //String url = "https://wa.me/$celular";
              Uri urlSend = Uri.parse(url);
              if (!(await launchUrl(urlSend))) {
                throw ("No se pudo enviar mensaje por WhatsApp");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amberAccent, // Color de fondo del botón
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Bordes redondeados
              ),
            ),
            child: const Text(
              'Enviar', // Texto del botón
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    });
  }

  // Función para asegurarse de que el precio es un valor numérico válido
  double _getValidPrice(dynamic price) {
    if (price is double) {
      return price;
    } else if (price is String) {
      // Intentamos convertir el precio si es un String
      return double.tryParse(price) ?? 0.0;
    }
    return 0.0;
  }
}
