# Sistema de Gestión de Ventas, Inventario y Analítica Avanzada (T-SQL)

## 📌 Descripción del Proyecto
Proyecto desarrollado en **Microsoft SQL Server (T-SQL)** que simula un sistema comercial transaccional con control de inventario en tiempo real. Diseñado para demostrar competencias en modelado relacional, automatización mediante triggers, transacciones ACID y generación de reportes analíticos para la toma de decisiones.

## 🗄️ Modelo Relacional
El sistema consta de 6 tablas interrelacionadas:
* **Categorias**: Clasificación de productos.
* **Productos**: Catálogo con control de stock y validación de precios.
* **Clientes**: Registro de compradores.
* **Pedidos**: Cabecera de transacciones comerciales.
* **DetallePedidos**: Relación de productos e importes por pedido.
* **AuditoriaPrecios**: Control histórico de modificaciones de tarifas.

## ⚙️ Características Técnicas Implementadas
* **Integridad Referencial:** Claves primarias, foráneas y restricciones `CHECK` / `DEFAULT`.
* **Lógica Transaccional (ACID):** Control estricto con `BEGIN TRANSACTION`, `COMMIT`, `ROLLBACK` y `TRY...CATCH` en el procedimiento `sp_RegistrarVenta` para prevenir inconsistencias de inventario.
* **Disparadores (Triggers):** Automatización con `trg_AuditoriaPrecios` para registrar variaciones de costos.
* **Analítica Avanzada:** Uso de Common Table Expressions (`CTEs`) y funciones de ventana (`DENSE_RANK() OVER (PARTITION BY ...)`) para análisis de ventas por categoría.

## 📂 Estructura del Repositorio
* `1. Base de datos y tablas.sql`: Esquema relacional DDL.
* `2. Insersion de datos en las tablas.sql`: Inserción de datos iniciales de prueba.
* `3. Logica de programacion.sql`: Procedimiento transaccional y trigger.
* `4. Consultas analiticas avanzadasA.sql`: Consultas analíticas y simulación de ventas.
