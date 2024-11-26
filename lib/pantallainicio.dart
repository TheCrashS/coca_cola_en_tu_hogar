import 'package:coca_cola_en_tu_hogar/main.dart';
import 'package:coca_cola_en_tu_hogar/pantallaProd.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha
import 'package:coca_cola_en_tu_hogar/database_helper.dart'; // Importa el helper de la base de datos
import 'package:provider/provider.dart';
import 'produc/PantallaLogin.dart';  // Asegúrate de importar la pantalla de login

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<PantallaInicio> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String direccion = '';
  String celular = '';
  String contrasena = '';
  DateTime? fecha;
  final bool _isObscure = true; // Para ocultar la contraseña

  // Función para crear los campos de texto
  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    TextInputType? keyboardType,
    bool obscureText = false, // Si es para contraseña
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(label == 'Celular' ? Icons.phone : Icons.person),
      ),
      onSaved: onSaved,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        if (label == 'Nombre' && !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
          return 'Solo se permiten letras';
        }
        if (label == 'Celular') {
          if (!RegExp(r'^\d+$').hasMatch(value)) {
            return 'Solo se permiten números';
          }
          if (value.length != 8) {
            return 'El número debe tener exactamente 8 dígitos';
          }
        }
        if (label == 'Contraseña' && value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
        return null; // Retorna null si es válido
      },
    );
  }

  // Función para seleccionar la fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Solo permite fechas a partir de hoy
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != fecha) {
      setState(() {
        fecha = picked;
      });
    }
  }

  // Función para guardar los datos en la base de datos
  Future<void> _saveData() async {
    final dbHelper = DatabaseHelper.instance;

    // Creamos un mapa con los datos que vamos a insertar en la base de datos
    Map<String, dynamic> row = {
      'nombre': nombre,
      'direccion': direccion,
      'celular': celular,
      'contrasena': contrasena,
      'fecha': fecha != null ? DateFormat('MM/dd/yyyy').format(fecha!) : '',
    };

    // Insertamos los datos en la base de datos
    int id = await dbHelper.insertUsuario(row);

    // Verificación: Imprime el ID de la fila insertada
    if (kDebugMode) {
      print('Usuario registrado con id: $id');
    }

    // Verificación: Consultamos los datos insertados
    var insertedUser = await dbHelper.getUserByNameAndPassword(nombre, contrasena);
    if (insertedUser != null) {
      if (kDebugMode) {
        print('Usuario insertado correctamente: $insertedUser');
      }
      // Navegar a otra pantalla si es necesario
      setState(() {
          context.read<Usuario>().set(nombre);
        });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PantallaProd(), // Asegúrate de tener esta clase definida
        ),
      );
      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Usuario registrado con éxito!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      if (kDebugMode) {
        print('Error al insertar usuario');
      }
      // Mostrar mensaje de error si el registro falla
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al registrar el usuario'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Función para enviar el formulario
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Verificar los valores antes de guardarlos
      if (kDebugMode) {
        print('Dirección: $direccion');
      }
      if (kDebugMode) {
        print('Celular: $celular');
      }
      if (kDebugMode) {
        print('Contraseña: $contrasena');
      }
      if (kDebugMode) {
        print('Fecha: ${fecha?.toLocal()}');
      }

      // Guardamos los datos en la base de datos
      _saveData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PEDIDOS COCA-COLA'),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const PantallaLogin(), // Regresa a la pantalla de login
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo de pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/img/fondo.jpg',  // LOGO   
              fit: BoxFit.cover,
            ),
          ),
          // Formulario
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    // Título
                    const Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Campo Nombre
                    _buildTextField(
                      label: 'Nombre',
                      onSaved: (value) => nombre = value!,
                    ),
                    const SizedBox(height: 16),

                    // Campo Dirección
                    _buildTextField(
                      label: 'Dirección',
                      onSaved: (value) => direccion = value!,
                    ),
                    const SizedBox(height: 16),

                    // Campo Celular
                    _buildTextField(
                      label: 'Celular',
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => celular = value!,
                    ),
                    const SizedBox(height: 16),

                    // Campo Contraseña
                    _buildTextField(
                      label: 'Contraseña',
                      obscureText: _isObscure,
                      onSaved: (value) => contrasena = value!,
                    ),
                    const SizedBox(height: 16),

                    // Selección de Fecha
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              fecha == null
                                  ? 'Selecciona la fecha'
                                  : 'Fecha: ${DateFormat('MM/dd/yyyy').format(fecha!)}', // Formato de fecha en inglés
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botón de Registro
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Registrarse'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}