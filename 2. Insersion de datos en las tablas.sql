--- Datos iniciales de prueba

USE SistemaVentasInventario;
GO

INSERT INTO Categorias (NombreCategoria, Descripcion) VALUES 
('Electrónica', 'Dispositivos y accesorios tecnológicos'),
('Hogar', 'Muebles y utensilios de cocina'),
('Ropa', 'Indumentaria y calzado');
GO

INSERT INTO Productos (NombreProducto, CategoriaID, PrecioUnitario, StockActual) VALUES 
('Teclado Mecánico RGB', 1, 75.50, 50),
('Mouse Inalámbrico Ergonómico', 1, 25.00, 120),
('Monitor Curvo 27 pulgadas', 1, 280.00, 15),
('Cafetera Automática', 2, 120.00, 30),
('Set de Sartenes Antiadherentes', 2, 45.99, 40),
('Campera Impermeable', 3, 90.00, 25);
GO

INSERT INTO Clientes (Nombre, Apellido, Email) VALUES 
('Carlos', 'Gómez', 'carlos.gomez@email.com'),
('María', 'Rodríguez', 'maria.rodriguez@email.com'),
('Alejandro', 'Pérez', 'alejandro.perez@email.com');
GO