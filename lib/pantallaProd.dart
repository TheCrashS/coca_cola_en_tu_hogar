import 'package:coca_cola_en_tu_hogar/carrito/Carrito.dart' show Carrito;
import 'package:coca_cola_en_tu_hogar/pantallaCarrito.dart';
import 'package:coca_cola_en_tu_hogar/produc/PantallaLogin.dart';
import 'package:coca_cola_en_tu_hogar/produc/Productos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaProd extends StatefulWidget {
  const PantallaProd({super.key});
  @override
  State<PantallaProd> createState() => _PantallaProdState();
}

class _PantallaProdState extends State<PantallaProd> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _globalKey,
          backgroundColor: Colors.amberAccent,
          appBar: AppBar(
            title: const Text("PRODUCTOS"),
            backgroundColor: Colors.red,
            elevation: 0,
            bottom: const TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Gaseosas"),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Jugos"),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Energizantes"),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Agua"),
                    ),
                  )
                ]),
            actions: <Widget>[
              IconButton(
                  //boton carrito de compras
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    carrito.numeroItems != 0
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext) => const Pantallacarrito()))
                        : ScaffoldMessenger.of(_globalKey.currentContext!)
                            .showSnackBar(const SnackBar(
                            content: Text(
                              "Agraga un Producto",
                              textAlign: TextAlign.center,
                            ),
                          ));
                  }),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  constraints:
                      const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: Text(
                    carrito.numeroItems.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          drawer: const menuLateral(),
          body: TabBarView(
            children: <Widget>[
              // GASEOSAS
              Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: GASEOSAS.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.2),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x000005cc),
                            blurRadius: 30,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          // Ajustar imagen
                          Image.asset(
                            "assets/img/${GASEOSAS[index].imagen}",
                            fit: BoxFit
                                .contain, // Ajusta la imagen sin recortarla
                            height:
                                120, // Puedes ajustar la altura si es necesario
                            width: double
                                .infinity, // Se ajusta al ancho del contenedor
                          ),
                          Text(
                            GASEOSAS[index].nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Bs/.${GASEOSAS[index].precio}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                carrito.agregarItem(
                                  GASEOSAS[index].id.toString(),
                                  GASEOSAS[index].nombre,
                                  GASEOSAS[index].precio.toString(),
                                  "1",
                                  GASEOSAS[index].imagen,
                                  1,
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.redAccent,
                            ),
                            label: const Text(
                              "Agregar",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .yellow, // Cambia el color de fondo a amarillo
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // JUGOS
              Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: JUGOS.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.2),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x000005cc),
                            blurRadius: 30,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          // Ajustar imagen
                          Image.asset(
                            "assets/img/${JUGOS[index].imagen}",
                            fit: BoxFit
                                .contain, // Ajusta la imagen sin recortarla
                            height:
                                120, // Puedes ajustar la altura si es necesario
                            width: double
                                .infinity, // Se ajusta al ancho del contenedor
                          ),
                          Text(
                            JUGOS[index].nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Bs/.${JUGOS[index].precio}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                carrito.agregarItem(
                                  JUGOS[index].id.toString(),
                                  JUGOS[index].nombre,
                                  JUGOS[index].precio.toString(),
                                  "1",
                                  JUGOS[index].imagen,
                                  1,
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.redAccent,
                            ),
                            label: const Text(
                              "Agregar",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .yellow, // Cambia el color de fondo a amarillo
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // ENERGIZANTES
              Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: ENERGIZANTES.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.2),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x000005cc),
                            blurRadius: 30,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          // Ajustar imagen
                          Image.asset(
                            "assets/img/${ENERGIZANTES[index].imagen}",
                            fit: BoxFit
                                .contain, // Ajusta la imagen sin recortarla
                            height:
                                120, // Puedes ajustar la altura si es necesario
                            width: double
                                .infinity, // Se ajusta al ancho del contenedor
                          ),
                          Text(
                            ENERGIZANTES[index].nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Bs/.${ENERGIZANTES[index].precio}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                carrito.agregarItem(
                                  ENERGIZANTES[index].id.toString(),
                                  ENERGIZANTES[index].nombre,
                                  ENERGIZANTES[index].precio.toString(),
                                  "1",
                                  ENERGIZANTES[index].imagen,
                                  1,
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.redAccent,
                            ),
                            label: const Text(
                              "Agregar",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .yellow, // Cambia el color de fondo a amarillo
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // AGUA
              Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: AGUA.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.2),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x000005cc),
                            blurRadius: 30,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          // Ajustar imagen
                          Image.asset(
                            "assets/img/${AGUA[index].imagen}",
                            fit: BoxFit
                                .contain, // Ajusta la imagen sin recortarla
                            height:
                                120, // Puedes ajustar la altura si es necesario
                            width: double
                                .infinity, // Se ajusta al ancho del contenedor
                          ),
                          Text(
                            AGUA[index].nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Bs/.${AGUA[index].precio}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                carrito.agregarItem(
                                  AGUA[index].id.toString(),
                                  AGUA[index].nombre,
                                  AGUA[index].precio.toString(),
                                  "1",
                                  AGUA[index].imagen,
                                  1,
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.redAccent,
                            ),
                            label: const Text(
                              "Agregar",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .yellow, // Cambia el color de fondo a amarillo
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// Menú lateral
class menuLateral extends StatelessWidget {
  const menuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("PEDIDOS COCA COLA"),
            accountEmail: null,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/FONDO1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            child: const ListTile(
              title: Text("INICIO"),
              leading: Icon(
                Icons.home,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const PantallaLogin()));
            },
          ),
          InkWell(
            child: const ListTile(
              title: Text("CARRITO"),
              leading: Icon(
                Icons.add_shopping_cart,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Pantallacarrito()));
            },
          ),
          InkWell(
            child: const ListTile(
              title: Text("COCA-COLA"),
              leading: Icon(
                Icons.account_balance,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PantallaCocaCola()));
            },
          ),
          InkWell(
            child: const ListTile(
              title: Text("PRODUCTOS"),
              leading: Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PantallaProductos()));
            },
          ),
          InkWell(
            child: const ListTile(
              title: Text("REPORTES DE CLIENTES"),
              leading: Icon(
                Icons.add_chart_outlined,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PantallaReportesClientes(
                        pedidos: [],
                      )));
            },
          ),
          InkWell(
            child: const ListTile(
              title: Text("USUARIO"),
              leading: Icon(
                Icons.account_circle_rounded,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PantallaUsuario(
                        nombre: '',
                        direccion: '',
                        celular: '',
                        contrasena: '',
                      )));
            },
          ),
          // Nuevo ítem para confirmar pedido
          InkWell(
            child: const ListTile(
              title: Text("CONFIRMAR PEDIDO"),
              leading: Icon(
                Icons.check_circle,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PantallaConfirmarPedido()));
            },
          ),
        ],
      ),
    );
  }
}

// Pantalla Coca-Cola
class PantallaCocaCola extends StatelessWidget {
  const PantallaCocaCola({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COCA-COLA"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/img/AGENCIA.jpg',
                height: 200,
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "INFORMACION DE LA AGENCIA",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "CALLE: Firulla Esquina Copacabana, CIUDAD: Villazón, TELEFONO: 73331232.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "HISTORIA DE COCA-COLA",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "Coca-Cola fue inventada en 1886 por John S. Pemberton. "
              "Originalmente un jarabe para curar diversas dolencias, "
              "se convirtió en una de las bebidas más populares del mundo.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Volver"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla Productos
class PantallaProductos extends StatelessWidget {
  const PantallaProductos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRODUCTOS"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/img/PRODUCTOS1.jpg',
                height: 250,
                width: 550,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "INFORMACION DE LOS PRODUCTOS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "Coca-Cola ofrece una variedad de productos en VILLAZÓN que se adaptan a diferentes gustos y necesidades, incluyendo opciones con azúcar y sin azúcar, jugos naturales, agua, energizantes y bebidas deportivas. Además, la marca está comprometida con la sostenibilidad y la responsabilidad social en la región, apoyando tanto a la comunidad como al medio ambiente.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Volver"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Pantala Reportes Clientes 
class PantallaReportesClientes extends StatelessWidget {
  final List<Map<String, dynamic>> pedidos;

  const PantallaReportesClientes({super.key, required this.pedidos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reporte de Pedidos"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: pedidos.length,
          itemBuilder: (context, index) {
            final pedido = pedidos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text("Pedido #${pedido['idPedido']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cliente: ${pedido['cliente']}"),
                    Text("Productos: ${pedido['productos']}"),
                    Text("Cantidad: ${pedido['cantidad']}"),
                    Text("Total: ${pedido['total']} Bs"),
                    Text("Fecha: ${pedido['fecha']}"),
                    Text("Estado: ${pedido['estado']}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Eliminar pedido (simulado)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Pedido #${pedido['idPedido']} eliminado')),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Pantalla Usuario (Edición de usuario)
class PantallaUsuario extends StatefulWidget {
  final String nombre;
  final String direccion;
  final String celular;
  final String contrasena;

  const PantallaUsuario({
    super.key,
    required this.nombre,
    required this.direccion,
    required this.celular,
    required this.contrasena,
  });

  @override
  _PantallaUsuarioState createState() => _PantallaUsuarioState();
}

class _PantallaUsuarioState extends State<PantallaUsuario> {
  late TextEditingController _nombreController;
  late TextEditingController _direccionController;
  late TextEditingController _celularController;
  late TextEditingController _contrasenaController;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los datos recibidos de PantallaInicio
    //consultar los datos del cliente logeado desde la base de datos
    //query a usuarios
    //resulta datos

    //_nombreController = TextEditingController(text: resulta.nombre);
    _nombreController = TextEditingController(text: 'javier');
    _direccionController = TextEditingController(text: widget.direccion);
    _celularController = TextEditingController(text: widget.celular);
    _contrasenaController = TextEditingController(text: widget.contrasena);
  }

  // Función para guardar los datos modificados
  void _guardarDatos() {
    // Aquí puedes actualizar los datos en la base de datos
    String nuevoNombre = _nombreController.text;
    String nuevaDireccion = _direccionController.text;
    String nuevoCelular = _celularController.text;
    String nuevaContrasena = _contrasenaController.text;

    // Simulando la actualización de los datos en la base de datos o en algún servicio
    // Aquí puedes llamar a tu servicio para actualizar los datos

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos guardados')),
    );

    // Mostrar los datos actualizados en la consola
    if (kDebugMode) {
      print('Datos actualizados:');
    }
    if (kDebugMode) {
      print('Nombre: $nuevoNombre');
    }
    if (kDebugMode) {
      print('Dirección: $nuevaDireccion');
    }
    if (kDebugMode) {
      print('Celular: $nuevoCelular');
    }
    if (kDebugMode) {
      print('Contraseña: $nuevaContrasena');
    }
    //query update tabla usuarios
  }

  // Función para eliminar la cuenta
  void _eliminarCuenta() {
    // Lógica para eliminar la cuenta del usuario (eliminar de la base de datos)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cuenta eliminada')),
    );
    //navegar a la ruta remplazada login
    Navigator.of(context).pop(); // Volver a la pantalla anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos de Usuario"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Imagen de perfil arriba de los datos
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/img/logo3.jpg'), // Imagen de perfil
              ),
            ),
            const SizedBox(height: 20),

            // Campos de texto para editar los datos
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _direccionController,
              decoration: const InputDecoration(labelText: "Dirección"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _celularController,
              decoration: const InputDecoration(labelText: "Celular"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contrasenaController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true, // Para ocultar la contraseña
            ),
            const SizedBox(height: 20),

            // Botón para guardar cambios
            ElevatedButton(
              onPressed: _guardarDatos,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Guardar Cambios"),
            ),
            const SizedBox(height: 20),

            // Botón para eliminar cuenta
            ElevatedButton(
              onPressed: _eliminarCuenta,
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text("Eliminar Cuenta"),
            ),

            const Spacer(), // Espaciador para empujar el botón de Volver hacia abajo

            // Botón "Volver" en la parte inferior
          ],
        ),
      ),
    );
  }
}

class PantallaConfirmarPedido extends StatelessWidget {
  const PantallaConfirmarPedido({super.key});

  // Función para enviar el mensaje por WhatsApp
  void _enviarMensajeWhatsApp(String mensaje) async {
    final urlSend = Uri.parse(
        "https://wa.me/59167924911?text=$mensaje"); // Reemplaza con el número de WhatsApp real
    if (!(await launchUrl(urlSend))) {
      throw ("No se pudo enviar mensaje por WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmar Pedido"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen en la parte superior
            Center(
              child: Image.asset(
                'assets/img/camion.jpg', // Asegúrate de tener esta imagen en tu carpeta assets
                height: 200,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20), // Espacio entre la imagen y la pregunta
            const Text(
              "¿Te ha llegado el pedido?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black87,
              ),
            ),
            const SizedBox(
                height: 30), // Espacio entre la pregunta y los botones

            // Botón "Sí, llegó"
            ElevatedButton(
              onPressed: () {
                // Enviar mensaje confirmando que el pedido llegó
                _enviarMensajeWhatsApp(
                    "Hola, me ha llegado el pedido correctamente.");
                Navigator.of(context).pop(); // Volver a la pantalla anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Sí, llegó"),
            ),

            const SizedBox(height: 20), // Espacio entre los botones

            // Botón "No, no llegó"
            ElevatedButton(
              onPressed: () {
                // Enviar mensaje informando que el pedido no llegó
                _enviarMensajeWhatsApp("Hola, no me ha llegado el pedido.");
                Navigator.of(context).pop(); // Volver a la pantalla anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("No, no llegó"),
            ),
          ],
        ),
      ),
    );
  }
}
