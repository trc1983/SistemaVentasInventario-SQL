--- Creación de Base de datos SistemaVentasInventario y las tablas correspondientes Categorias, Productos, Clientes, Pedidos, DetallePedidos,AuditoriaPrecios 

CREATE DATABASE SistemaVentasInventario;
GO

USE SistemaVentasInventario;
GO

CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCategoria VARCHAR(100) NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL
);
GO

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(150) NOT NULL,
    CategoriaID INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK (PrecioUnitario > 0),
    StockActual INT NOT NULL CHECK (StockActual >= 0),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Productos_Categorias FOREIGN KEY (CategoriaID) 
        REFERENCES Categorias(CategoriaID)
);
GO

CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Pedidos (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    FechaPedido DATETIME DEFAULT GETDATE(),
    EstadoPedido VARCHAR(30) DEFAULT 'Completado' CHECK (EstadoPedido IN ('Pendiente', 'Completado', 'Cancelado')),
    TotalPedido DECIMAL(12,2) NOT NULL DEFAULT 0,
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (ClienteID) 
        REFERENCES Clientes(ClienteID)
);
GO

CREATE TABLE DetallePedidos (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Detalle_Pedidos FOREIGN KEY (PedidoID) 
        REFERENCES Pedidos(PedidoID) ON DELETE CASCADE,
    CONSTRAINT FK_Detalle_Productos FOREIGN KEY (ProductoID) 
        REFERENCES Productos(ProductoID)
);
GO

CREATE TABLE AuditoriaPrecios (
    AuditoriaID INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT NOT NULL,
    PrecioAnterior DECIMAL(10,2),
    PrecioNuevo DECIMAL(10,2),
    FechaCambio DATETIME DEFAULT GETDATE(),
    UsuarioModificacion VARCHAR(100) DEFAULT SYSTEM_USER
);
GO