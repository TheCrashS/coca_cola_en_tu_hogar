class Item {
  String id;
  String nombre;
  String precio;
  String unidad;
  String imagen;
  int cantidad;

  Item({required this.id, required this.nombre, required this.precio, required this.unidad, required this.imagen,
      required this.cantidad});

  Itemmap(dynamic o){
    id= o["id"];
    nombre= o["nombre"];
    precio= o["precio"];
    unidad= o["unidad"];
    imagen= o["imagen"];
    cantidad= o["cantidadd"];
  }
  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map["id"] =id;
    map["nombre"] =nombre;
    map["precio"] =precio;
    map["unidad"] =unidad;
    map["imagen"] =imagen;
    map["cantidad"] =cantidad;
    return map;
  }
  Map<String, dynamic> tolMap(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] =id;
    data["nombre"] =nombre;
    data["precio"] =precio;
    data["unidad"] =unidad;
    data["imagen"] =imagen;
    data["cantidad"] =cantidad;
    return data;
  }
}