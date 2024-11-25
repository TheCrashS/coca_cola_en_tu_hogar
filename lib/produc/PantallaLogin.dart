import 'package:coca_cola_en_tu_hogar/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha
import 'package:provider/provider.dart';
import '../database_helper.dart'; // Importa tu helper para la base de datos
import '../pantallaProd.dart'; // Pantalla de productos
import '../pantallainicio.dart'; // Pantalla de registro

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  _PantallaLoginState createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String contrasena = '';
  DateTime? fecha;

  String _mensajeError =
      ''; // Para mostrar mensaje de error si no se encuentra el usuario

  // Función para crear los campos de texto
  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    bool obscureText = false, // Si es para contraseña
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor:
            Colors.white.withOpacity(0.8), // Fondo ligeramente transparente
        prefixIcon: Icon(label == 'Contraseña' ? Icons.lock : Icons.person),
      ),
      onSaved: onSaved,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        if (label == 'Contraseña' && value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
        return null; // Retorna null si es válido
      },
    );
  }

  // Función para iniciar sesión
  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Verificar si el usuario existe en la base de datos
      var user = await DatabaseHelper.instance
          .getUserByNameAndPassword(nombre, contrasena);

      if (user != null) {
        // Si el usuario existe, redirigir a PantallaProd
        setState(() {
          context.read<Usuario>().set(user['nombre']);
        });
        print('Usuario encontrado: $nombre');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PantallaProd(), // Pantalla de productos
          ),
        );
      } else {
        // Si no existe, mostrar mensaje de error
        setState(() {
          _mensajeError = 'Usuario o contraseña incorrectos';
        });
        // También podríamos limpiar el campo de contraseña para que el usuario vuelva a intentarlo
      }
    }
  }

  // Función para seleccionar fecha (opcional)
  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: fecha ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != fecha) {
      setState(() {
        fecha = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          // Fondo de pantalla que ocupa toda la pantalla (superior e inferior)
          Positioned.fill(
            child: Image.asset(
              'assets/img/iniicio.jpg', // Asegúrate de tener esta imagen en tu carpeta de assets
              fit: BoxFit.fill,
            ),
          ),
          // Formulario
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                          height: 150), // Ajuste para dar espacio desde el top
                      // Título
                      const Text(
                        'Bienvenido, Inicia Sesión',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
            
                      // Campo Nombre
                      _buildTextField(
                        label: 'Nombre',
                        onSaved: (value) => nombre = value!,
                      ),
                      const SizedBox(height: 16),
            
                      // Campo Contraseña
                      _buildTextField(
                        label: 'Contraseña',
                        obscureText: true,
                        onSaved: (value) => contrasena = value!,
                      ),
                      const SizedBox(height: 16),
            
                      // Selección de Fecha (opcional)
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200]!
                                .withOpacity(0.8), // Fondo más sutil
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                fecha == null
                                    ? 'Selecciona la fecha del Pedido'
                                    : 'Fecha: ${DateFormat('dd/MM/yyyy').format(fecha!)}', // Formato de fecha
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
            
                      // Botón de Iniciar Sesión
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation:
                              5, // Elevación para darle un toque más moderno
                        ),
                        child: const Text('Iniciar sesión'),
                      ),
                      const SizedBox(height: 20),
            
                      // Mostrar mensaje de error si el usuario no está registrado
                      if (_mensajeError.isNotEmpty)
                        Text(
                          _mensajeError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            
                      const SizedBox(height: 20),
            
                      // Opción de ir a la pantalla de Registro
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PantallaInicio(), // Pantalla de registro
                            ),
                          );
                        },
                        child: const Text(
                          '¿No tienes cuenta? Regístrate aquí',
                          style: TextStyle(
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
