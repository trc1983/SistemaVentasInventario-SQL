-- Prueba de transacciones y consultas analiticas (BI)
USE SistemaVentasInventario;
GO

-- Simulación de ventas usando el Stored Procedure
EXEC sp_RegistrarVenta @ClienteID = 1, @ProductoID = 1, @CantidadComprada = 2;
EXEC sp_RegistrarVenta @ClienteID = 2, @ProductoID = 3, @CantidadComprada = 1;
GO

-- Consulta Analítica Avanzada: Ranking de productos más vendidos por Categoría
WITH VentasPorCategoria AS (
    SELECT 
        c.NombreCategoria,
        p.NombreProducto,
        SUM(dp.Cantidad) AS TotalUnidadesVendidas,
        SUM(dp.Cantidad * dp.PrecioUnitario) AS IngresoTotal,
        DENSE_RANK() OVER (PARTITION BY c.CategoriaID ORDER BY SUM(dp.Cantidad) DESC) AS Ranking
    FROM Categorias c
    INNER JOIN Productos p ON c.CategoriaID = p.CategoriaID
    INNER JOIN DetallePedidos dp ON p.ProductoID = dp.ProductoID
    GROUP BY c.CategoriaID, c.NombreCategoria, p.NombreProducto
)
SELECT NombreCategoria, NombreProducto, TotalUnidadesVendidas, IngresoTotal, Ranking
FROM VentasPorCategoria
WHERE Ranking <= 3;
GO