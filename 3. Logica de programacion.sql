USE SistemaVentasInventario;
GO

-- 1. Trigger de Auditoría de Precios
CREATE TRIGGER trg_AuditoriaPrecios
ON Productos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(PrecioUnitario)
    BEGIN
        INSERT INTO AuditoriaPrecios (ProductoID, PrecioAnterior, PrecioNuevo)
        SELECT 
            i.ProductoID, 
            d.PrecioUnitario, 
            i.PrecioUnitario
        FROM inserted i
        INNER JOIN deleted d ON i.ProductoID = d.ProductoID;
    END
END;
GO

-- 2. Procedimiento Almacenado Transaccional (ACID)
CREATE PROCEDURE sp_RegistrarVenta
    @ClienteID INT,
    @ProductoID INT,
    @CantidadComprada INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Validar existencia del cliente
        IF NOT EXISTS (SELECT 1 FROM Clientes WHERE ClienteID = @ClienteID)
        BEGIN
            RAISERROR('El cliente especificado no existe.', 16, 1);
        END

        -- Verificar stock y precio
        DECLARE @StockActual INT;
        DECLARE @PrecioUnitario DECIMAL(10,2);

        SELECT @StockActual = StockActual, @PrecioUnitario = PrecioUnitario
        FROM Productos
        WHERE ProductoID = @ProductoID;

        IF @StockActual IS NULL
        BEGIN
            RAISERROR('El producto especificado no existe.', 16, 1);
        END

        IF @StockActual < @CantidadComprada
        BEGIN
            RAISERROR('Stock insuficiente para completar la venta.', 16, 1);
        END

        -- Insertar el pedido principal
        DECLARE @PedidoID INT;
        INSERT INTO Pedidos (ClienteID, EstadoPedido, TotalPedido)
        VALUES (@ClienteID, 'Completado', @PrecioUnitario * @CantidadComprada);

        SET @PedidoID = SCOPE_IDENTITY();

        -- Insertar el detalle del pedido
        INSERT INTO DetallePedidos (PedidoID, ProductoID, Cantidad, PrecioUnitario)
        VALUES (@PedidoID, @ProductoID, @CantidadComprada, @PrecioUnitario);

        -- Descontar el stock actual
        UPDATE Productos
        SET StockActual = StockActual - @CantidadComprada
        WHERE ProductoID = @ProductoID;

        COMMIT TRANSACTION;
        SELECT 'Venta registrada con éxito. Nro de Pedido: ' + CAST(@PedidoID AS VARCHAR(10)) AS Resultado;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO