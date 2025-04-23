import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BaseDatosV extends StatefulWidget {
  const BaseDatosV({Key? key}) : super(key: key);

  @override
  State<BaseDatosV> createState() => _BaseDatosVState();
}

class _BaseDatosVState extends State<BaseDatosV> {
  List<Map<String, dynamic>> ventas = [];

  @override
  void initState() {
    super.initState();
    _cargarVentasGuardadas();
  }

  Future<void> _cargarVentasGuardadas() async {
    final prefs = await SharedPreferences.getInstance();
    final ventasJson = prefs.getString('ventas_guardadas');
    if (ventasJson != null) {
      final List<dynamic> listaDecodificada = jsonDecode(ventasJson);
      setState(() {
        ventas =
            listaDecodificada
                .map<Map<String, dynamic>>(
                  (item) => Map<String, dynamic>.from(item),
                )
                .toList();
      });
    }
  }

  Future<void> _guardarVentasActualizadas() async {
    final prefs = await SharedPreferences.getInstance();
    final ventasJson = jsonEncode(ventas);
    await prefs.setString('ventas_guardadas', ventasJson);
  }

  void _eliminarVenta(Map<String, dynamic> venta) {
    setState(() {
      ventas.remove(venta);
    });
    _guardarVentasActualizadas();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🗑️ Venta eliminada"),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Diario de Ventas'),
        backgroundColor: Colors.brown[400],
      ),
      body:
          ventas.isEmpty
              ? const Center(
                child: Text(
                  'No hay ventas registradas aún.',
                  style: TextStyle(fontSize: 16),
                ),
              )
              : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Producto')),
                    DataColumn(label: Text('Cantidad')),
                    DataColumn(label: Text('Total')),
                    DataColumn(label: Text('Origen')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  rows:
                      ventas.map((venta) {
                        return DataRow(
                          cells: [
                            DataCell(Text(venta['producto'].toString())),
                            DataCell(Text(venta['cantidad'].toString())),
                            DataCell(Text('\$${venta['total'].toString()}')),
                            DataCell(Text(venta['origen'].toString())),
                            DataCell(
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _eliminarVenta(venta),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
    );
  }
}
