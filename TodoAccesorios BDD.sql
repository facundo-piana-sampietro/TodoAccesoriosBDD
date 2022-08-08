CREATE DATABASE TodoAccesoriosBD
GO


USE TodoAccesoriosBD
GO


CREATE TABLE Categorias
(
Id_Cat char(8) NOT NULL,
Descripcion_Cat varchar(30) NOT NULL,
CONSTRAINT PK_CATEGORIAS PRIMARY KEY (Id_Cat)
)
GO

CREATE TABLE Materiales
(
Id_Mat char(8) NOT NULL,
Descripcion_Mat  varchar(30) NOT NULL,
CONSTRAINT PK_MATERIALES PRIMARY KEY (Id_Mat)
)
GO

CREATE TABLE Provincias
(
Id_Prov char(8) NOT NULL,
Nombre_Prov varchar(30) NOT NULL,
CONSTRAINT PK_PROVINCIAS PRIMARY KEY (Id_Prov)
)
GO

CREATE TABLE Localidades
(
IdProv_Loc char(8) NOT NULL,
Id_Loc char(8) NOT NULL,
Nombre_Loc  varchar(30) NOT NULL,
CONSTRAINT PK_LOCALIDADES PRIMARY KEY (Id_Loc, IdProv_Loc),
CONSTRAINT FK_lOCALIDADES_PROVINCIAS FOREIGN KEY (IdProv_Loc) 
REFERENCES Provincias (Id_Prov)
)
GO

CREATE TABLE TipoEnvio
(
Id_TEnvio char(8) NOT NULL,
Descripcion_TEnvio char(30) NOT NULL,
CONSTRAINT PK_TIPOENVIO PRIMARY KEY (Id_TEnvio)
)
GO

CREATE TABLE TipoPago
(
Id_TPago char(8) NOT NULL,
Descripcion_TPago char(30) NOT NULL,
CONSTRAINT PK_TIPOPAGO PRIMARY KEY (Id_TPago)
)
GO

CREATE TABLE Usuarios
(
DNI_Us char(8) NOT NULL,
Usuario_Us varchar(30) NOT NULL,
Email_Us varchar(60) NOT NULL,
IdProv_Us char(8) NOT NULL,
IdLoc_Us char(8) NOT NULL,
Domicilio_Us varchar(40) NOT NULL,
Departamento_Us varchar(10) NOT NULL DEFAULT 'NO',
Contraseña_Us varchar(30) NOT NULL,
Telefono_Us char(10) NOT NULL,
Nombre_Us char(30) NOT NULL,
Apellido_Us char(30) NOT NULL,
UrlImagen_Us varchar(60) NOT NULL DEFAULT N'Imagenes/Usuarios/user-default',
FechaNac_Us date NOT NULL,
Tipo_Us Int NOT NULL default 1,
Estado bit NOT NULL default 1,
Barrio_Us varchar(40) NOT NULL DEFAULT '----',
CodPostal_Us int NOT NULL, 
CONSTRAINT PK_USUARIOS PRIMARY KEY (DNI_Us),
CONSTRAINT UK_USUARIOS UNIQUE (Usuario_Us,Email_Us),
CONSTRAINT FK_USUARIOS_LOCALIDADES FOREIGN KEY (IdLoc_Us, IdProv_Us) 
REFERENCES LOCALIDADES (Id_Loc, IdProv_Loc)
)
GO

CREATE TABLE Articulos
(
Id_Art char(8) NOT NULL,
IdCat_Art char(8) NOT NULL,
IdMat_Art char(8) NOT NULL,
Nombre_Art varchar(20) NOT NULL,
Descripcion_Art varchar(100) NOT NULL,
UrlImagen_Art varchar(60) NOT NULL,
Stock_Art int NOT NULL DEFAULT 0,
FechaIngreso_Art date NOT NULL,
PrecioUnitario_Art decimal(10,2) NOT NULL DEFAULT 0.00,
Estado_Art bit NOT NULL,
CONSTRAINT PK_ARTICULOS PRIMARY KEY (Id_Art),
CONSTRAINT FK_ARTICULOS_CATEGORIAS FOREIGN KEY (IdCat_Art) 
REFERENCES Categorias (Id_Cat),
CONSTRAINT FK_ARTICULOS_MATERIALES FOREIGN KEY (IdMat_Art) 
REFERENCES Materiales (Id_Mat)
)
GO

CREATE TABLE Ventas
(
Nro_Vent int NOT NULL IDENTITY (1,1),
DniUsuario_Vent char(8) NOT NULL,
IdTipoEnvio_Vent char(8) NOT NULL,
IdLoc_Vent char(8) NOT NULL,
IdProvLoc_Vent char(8) NOT NULL,
IdTipoPago_Vent char(8) NOT NULL,
Usuario_Vent varchar(30) NOT NULL,
EmailUsuario_Vent varchar(60) NOT NULL,
DireccionUs_Vent varchar(40) NOT NULL,
TelefonoUsuario_Vent char(10) NOT NULL,
Total_Vent decimal(8,2) NOT NULL,
Fecha_Vent date NOT NULL,
Nombre_Vent varchar(60) NOT NULL,
Apellido_Vent varchar(60) NOT NULL,
Departamento_Vent varchar(40) NOT NULL DEFAULT 'Sin departamento',
Barrio_Vent varchar(40) NOT NULL DEFAULT 'Sin barrio',
CodPostal_Vent int NOT NULL, 

CONSTRAINT PK_VENTAS PRIMARY KEY (Nro_Vent),
CONSTRAINT FK_VENTAS_USUARIOS FOREIGN KEY (DniUsuario_Vent)
REFERENCES Usuarios (DNI_Us),
CONSTRAINT FK_VENTAS_TIPOENVIO FOREIGN KEY (IdTipoEnvio_Vent)
REFERENCES TipoEnvio (Id_TEnvio),
CONSTRAINT FK_VENTAS_LOCALIDADES FOREIGN KEY (IdLoc_Vent, IdProvLoc_Vent) 
REFERENCES LOCALIDADES (Id_Loc, IdProv_Loc),
CONSTRAINT FK_VENTAS_TIPOPAGO FOREIGN KEY (IdTipoPago_Vent)
REFERENCES TipoPago (Id_TPago)
)
GO

CREATE TABLE Detalle_Ventas
(
NroVent_Detalle int NOT NULL,
IdArt_Detalle char(8) NOT NULL,
Cantidad_Detalle  int NOT NULL,
PrecioArt_Detalle  decimal(8,2) NOT NULL,
CONSTRAINT PK_DETALLEVENTAS PRIMARY KEY (NroVent_Detalle, IdArt_Detalle),
CONSTRAINT FK_DETALLEVENTAS_VENTAS FOREIGN KEY (NroVent_Detalle) 
REFERENCES Ventas (Nro_Vent),
CONSTRAINT FK_DETALLEVENTAS_ARTICULOS FOREIGN KEY (IdArt_Detalle) 
REFERENCES Articulos (Id_Art)
)
GO

CREATE TABLE Historial_Estado_Articulos
(
Id_Elim_HE INT IDENTITY (1,1)NOT NULL,
Id_Art_HE char(8) NOT NULL, 
Fecha_HE datetime NOT NULL,
Estado_HE bit NOT NULL,
CONSTRAINT PK_Estado PRIMARY KEY (Id_Elim_HE)
)
GO


CREATE TABLE Log_Articulos
(
Id_LogArticulo_LA INT IDENTITY (1,1)NOT NULL,
Id_Art_LA char(8) NOT NULL, 
Fecha_LA datetime NOT NULL,
Motivo_LA char(30) NOT NULL,
CONSTRAINT PK_LogArticulo PRIMARY KEY (Id_LogArticulo_LA)
)
GO

CREATE TABLE Log_Ventas
(
Id_LogVenta_LV INT IDENTITY (1,1)NOT NULL,
Nro_Vent_LV char(8) NOT NULL, 
Fecha_LV datetime NOT NULL,
Motivo_LV char(30) NOT NULL,
CONSTRAINT PK_Id_LogVenta PRIMARY KEY (Id_LogVenta_LV)
)
GO


CREATE TABLE Log_Usuarios
(
Id_LogUsuario_LU INT IDENTITY (1,1)NOT NULL,
DNI_LU char(8) NOT NULL, 
Fecha_LU datetime NOT NULL,
Motivo_LU char(30) NOT NULL,
CONSTRAINT PK_Id_LogUsuario PRIMARY KEY (Id_LogUsuario_LU)
)
GO










--Carga de Datos

INSERT INTO Provincias (Id_Prov,Nombre_Prov)
SELECT '1','Buenos Aires' UNION
SELECT '2','Entre Rios' UNION
SELECT '3','Santa Fe' UNION
SELECT '4','Cordoba' 
GO

INSERT INTO Localidades (IdProv_Loc,Id_Loc,Nombre_Loc)
SELECT '1','1','Tigre' UNION
SELECT '1','2','San Fernando' UNION
SELECT '1','3','General Pacheco' UNION
SELECT '2','1','Colon' UNION
SELECT '2','2','Paraná' UNION
SELECT '3','1','Reconquista' UNION
SELECT '3','2','San Justo' UNION
SELECT '4','1','Carlos Paz' UNION
SELECT '4','2','Cosquin' 
GO


INSERT INTO Usuarios (DNI_Us, Usuario_Us, Email_Us, IdProv_Us, IdLoc_Us, Domicilio_Us, 
Contraseña_Us, Telefono_Us, Nombre_Us, Apellido_Us, UrlImagen_Us, FechaNac_Us, Tipo_Us, Estado,CodPostal_Us)
SELECT 'adminDNI','admin','TodoAccesorios@gmail.com','1','1','adminDOM','adminPass','123','Admin','Adminaso',
N'Forms/Imagenes/Usuarios/user-default','1666-6-6',2,1, 1640 UNION
SELECT '22392235','Maria1','Marisita@gmail.com','1','2','peuje 99','MariaPass','4749-1238','Maria','Mendez',
N'Forms/Imagenes/Usuarios/user-22392235','1957-1-16',1,1, 1620 UNION
SELECT '29483923','Pepaso2','pepito@gmail.com','2','1','santa 233','pepePass','3832-0952','Pepe','Rodrigez',
N'Forms/Imagenes/Usuarios/user-29483923','1940-9-28',1,1, 1612 UNION
SELECT '40483923','L-Gante3','cumbia@gmail.com','3','1','Calle','L-GantePass','420','L-Gante','Keloke',
N'Forms/Imagenes/Usuarios/user-40483923','1997-3-20',1,1, 1655 UNION
SELECT '25483923','Biden4','Biden@gmail.com','4','1','Pennsylvania 1600','BidenPass','9648-2783','Joe','Biden',
N'Forms/Imagenes/Usuarios/user-25483923','1942-11-20',1,1, 1660
GO


INSERT INTO TipoEnvio (Id_TEnvio, Descripcion_TEnvio)
SELECT '1','A domicilio' UNION
SELECT '2','Retiro en sucursal' UNION
SELECT '3','Retiro en sede mas cercano'
GO

INSERT INTO TipoPago (Id_TPago, Descripcion_TPago)
SELECT '1','Efectivo' UNION
SELECT '2','Tarjeta' UNION
SELECT '3','Transferencia'
GO

INSERT INTO Categorias (Id_Cat, Descripcion_Cat)
SELECT '1','Cadena' UNION
SELECT '2','Aro' UNION
SELECT '3','Pulsera' UNION
SELECT '4','Anillo' UNION
SELECT '5','Dije' UNION
SELECT '6','Tobillera'
GO

INSERT INTO Materiales (Id_Mat, Descripcion_Mat)
SELECT '1','Oro 18k' UNION
SELECT '2','Plata 925' UNION
SELECT '3','Vermeil' UNION
SELECT '4','Bronce enchapado de Oro' UNION
SELECT '5','Acero Inoxidable' UNION
SELECT '6','Diamante'
GO


INSERT INTO Articulos (Id_Art, IdCat_Art, IdMat_Art, Nombre_Art, Descripcion_Art, UrlImagen_Art, Stock_Art,FechaIngreso_Art, PrecioUnitario_Art, Estado_Art)
SELECT '1','1','1','Forcet','Largo 70cm',N'~/Forms/Imagenes/Articulos/1.jpg',20,'2022-6-6',15300,1 UNION
SELECT '2','2','4','Corona','',N'~/Forms/Imagenes/Articulos/2.jpg',30,'2022-6-10',2900,1 UNION
SELECT '3','3','3','Juliana Vermeil','Largo 19cm',N'~/Forms/Imagenes/Articulos/3.jpg',50,'2022-6-6',11500,1 UNION
SELECT '4','5','2','Cruz CZ','',N'~/Forms/Imagenes/Articulos/4.jpg',45,'2022-6-12',4400,1 UNION
SELECT '5','6','1','Groumet 5mm','Largo 22cm',N'~/Forms/Imagenes/Articulos/5.jpg',35,'2022-6-29',5100,1 UNION
SELECT '6','1','2','Cubana','Plana 3mm',N'~/Forms/Imagenes/Articulos/6.jpg',18,'2022-3-6',6900,1 UNION
SELECT '7','3','1','Panther','19cm',N'~/Forms/Imagenes/Articulos/7.jpg',70,'2022-3-15',9800,1 UNION
SELECT '8','3','4','Paris','Marinero 18cm X 5mm',N'~/Forms/Imagenes/Articulos/8.jpg',53,'2022-2-16',4300,1 UNION
SELECT '9','2','6','Solitarios','10mm',N'~/Forms/Imagenes/Articulos/9.jpg',15,'2022-5-15',20000,1 UNION
SELECT '10','4','1','Sello','Cuadrado',N'~/Forms/Imagenes/Articulos/10.jpg',55,'2022-4-26',9600,1 UNION
SELECT '11','5','4','Medusa','Circular 9mm',N'~/Forms/Imagenes/Articulos/11.jpg',17,'2022-5-8',3900,1 UNION
SELECT '12','5','2','Iced','GL',N'~/Forms/Imagenes/Articulos/12.jpg',44,'2022-1-10',8600,1 UNION
SELECT '13','4','4','Eslabón','Groumet',N'~/Forms/Imagenes/Articulos/13.jpg',8,'2022-2-2',4850,1 UNION
SELECT '14','2','1','Rayo','9mm',N'~/Forms/Imagenes/Articulos/14.jpg',10,'2022-5-12',12000,1 UNION
SELECT '15','5','4','Reloj','15mm',N'~/Forms/Imagenes/Articulos/15.jpg',5,'2022-4-29',4500,1
GO


INSERT INTO Ventas (DniUsuario_Vent, IdTipoEnvio_Vent, IdLoc_Vent, IdProvLoc_Vent, IdTipoPago_Vent, Usuario_Vent, 
EmailUsuario_Vent, DireccionUs_Vent, TelefonoUsuario_Vent, Total_Vent, Fecha_Vent, Nombre_Vent, Apellido_Vent, Departamento_Vent, Barrio_Vent, CodPostal_Vent)
SELECT '40483923','1','1','1','3','L-Gante','cumbia@gmail.com','Calle','420',7000,'2022-6-20', 'L-Gante','Keloke', '2B','Martínez',1640 UNION
SELECT '22392235','2','1','3','3','Maria','Marisita@msn.com','peuje 99','4749-1238',4400,'2022-6-19','Maria','Mendez', '3A','Olivos',1620 UNION
SELECT '25483923','2','1','2','3','Biden','Biden@gmail.com','Pennsylvania 1600','9648-2783',564929.02,'2022-6-29','Joe','Biden', '5C','Acassuso',1612 UNION
SELECT '29483923','3','2','1','3','Pepaso','pepito@gmail.com','santa 233','3832-0952',5100,'2022-6-29','Pepe','Rodriguez', '7D','La lucila',1655 UNION
SELECT '40483923','1','1','1','3','L-Gante','cumbia@gmail.com','Calle','420',564929.02,'2022-6-20','L-Gante','Keloke', '6C','Rivadavia',1660
GO


INSERT INTO Detalle_Ventas (NroVent_Detalle,IdArt_Detalle,Cantidad_Detalle,PrecioArt_Detalle)
SELECT 1,'4',1,4400 UNION
SELECT 2,'1',1,564929.02 UNION
SELECT 3,'5',1,5100 UNION
SELECT 4,'2',1,2900 UNION
SELECT 5,'5',1,5100 UNION
SELECT 3,'1',1,564929.02
GO












--Consultas

--Cantidad de artículos con el stock por debajo de una cantidad específica
SELECT COUNT(Id_Art) AS 'Cantidad de artículos'
FROM Articulos
WHERE Stock_Art < 2
GO

--El nombre y apellido de los usuarios de determinada provincia que hayan comprado determinado artículo
SELECT Nombre_Us, Apellido_Us
FROM Usuarios INNER JOIN Ventas ON DNI_Us=DniUsuario_Vent
	INNER JOIN Detalle_Ventas ON Nro_Vent = NroVent_Detalle
		INNER JOIN Articulos ON Id_Art = IdArt_Detalle
		WHERE IdProv_Us = '1' AND IdCat_Art = '5'





--La categoría de artículos mas vendida en una determinada localidad

SELECT TOP(1) Descripcion_Cat, COUNT (IdArt_Detalle) AS [Articulos vendidos]
FROM Detalle_Ventas INNER JOIN  Articulos ON Id_Art=IdArt_Detalle
		INNER JOIN Categorias ON Id_Cat = IdCat_Art
			INNER JOIN Ventas ON  Nro_Vent = NroVent_Detalle
			WHERE IdLoc_Vent = 2
			GROUP BY Descripcion_Cat
			ORDER BY [Articulos vendidos] DESC

-- LOCALIDADES DE "X" PROVINCIA

SELECT Localidades.Nombre_Loc AS Localidad FROM Localidades
INNER JOIN Provincias ON Localidades.IdProv_Loc = Provincias.Id_Prov
WHERE Provincias.Nombre_Prov = 'Buenos Aires'
GO

-- OBTENER VENTAS DE USUARIO POR NOMBRE DEL USUARIO

SELECT UPPER(Nombre_Art) AS Articulo, Cantidad_Detalle AS Cantidad, Fecha_Vent AS Fecha ,PrecioArt_Detalle AS Precio
FROM Ventas INNER JOIN Detalle_Ventas ON Ventas.Nro_Vent = Detalle_Ventas.NroVent_Detalle
INNER JOIN Articulos ON Detalle_Ventas.IdArt_Detalle = Articulos.Id_Art
WHERE Ventas.Nombre_Vent = 'Maria'
GO

-- FILTRAR ARTICULOS POR PRECIO MAYOR O IGUAL A

SELECT Id_Art AS ID, Nombre_Art AS Nombre, Descripcion_Cat AS Categoria, Descripcion_Mat AS Material, 
Descripcion_Art AS Descripcion, UrlImagen_Art AS Url, Stock_Art AS Stock, FechaIngreso_Art AS FechaDeIngreso, 
PrecioUnitario_Art AS PrecioUnitario, 
Estado_Art AS Estado
FROM Articulos
INNER JOIN Materiales ON IdMat_Art = Id_Mat
INNER JOIN Categorias ON IdCat_Art = Id_Cat
WHERE PrecioUnitario_Art >= 10000
GO



-- OBTENER EL DNI DEL USUARIO Y CANTIDAD DE ARTICULOS DEL USUARIO QUE COMPRO MAS ARTICULOS

SELECT TOP(1)Ventas.DniUsuario_Vent, 
COUNT(Detalle_Ventas.IdArt_Detalle) AS Articulos
FROM Ventas 
INNER JOIN Detalle_Ventas ON Ventas.Nro_Vent = Detalle_Ventas.NroVent_Detalle
GROUP BY Ventas.DniUsuario_Vent
ORDER BY Articulos DESC
GO







--Procedimientos Almacenados

CREATE PROCEDURE SPEliminarArticulo
(
	@ID char(8)  
)

AS
UPDATE Articulos SET Estado_Art = 0 WHERE Id_Art = @ID
GO

CREATE PROCEDURE SPEliminarUsuario
(
	@DNI char(8) 	
)

AS
UPDATE Usuarios SET Estado = 0 WHERE DNI_Us = @DNI
GO

CREATE PROCEDURE SPActualizarArticulo
(
	@ID char(8),
	@IDCAT char(8),
	@IDMAT char(8),
	@NOMBRE varchar(20),
	@DESCRIPCION varchar(100),
	@URL varchar(60),
	@STOCK int,
        @FECHA date,
	@PRECIO decimal,
        @ESTADO bit
	)

AS
	UPDATE Articulos
	SET
        Id_Art=@ID,
	IdCat_Art=@IDCAT,
	IdMat_Art=@IDMAT,
	Nombre_Art=@NOMBRE,
	Descripcion_Art=@DESCRIPCION,
	UrlImagen_Art=@URL,
	Stock_Art=@STOCK,
        FechaIngreso_Art=@FECHA,
	PrecioUnitario_Art=@PRECIO,
        Estado_Art=@ESTADO
	WHERE Id_Art=@ID
GO

CREATE PROCEDURE SPActualizarUsuario
(
	@DNI char(8),
	@USUARIO varchar(30),
	@EMAIL varchar(60),
	@PROV char(8),
	@LOC char(8),
	@DOMICILIO varchar(40),
	@DEPTO varchar(10),
	@CONTRASEÑA varchar(30),
	@TELEFONO char(10),
	@NOMBRE char(30),
	@APELLIDO char(30),
	@URL varchar(60),
	@FECHANAC date,
    @TIPO int,
    @ESTADO bit,
	@DEPARTAMENTO varchar(10),
	@BARRIO varchar(40),
	@CODIGOPOSTAL int
	)

AS
	UPDATE Usuarios
	SET
	DNI_Us=@DNI,
	Usuario_Us=@USUARIO,
	Email_Us=@EMAIL,
	IdProv_Us=@PROV,
	IdLoc_Us=@LOC,
	Domicilio_Us=@DOMICILIO,
	Departamento_Us=@DEPTO,
	Contraseña_Us=@CONTRASEÑA,
	Telefono_Us=@TELEFONO,
	Nombre_Us=@NOMBRE,
	Apellido_Us=@APELLIDO,
	UrlImagen_Us=@URL,
	FechaNac_Us=@FECHANAC,
    Tipo_Us=@TIPO,
    Estado=@ESTADO,
	Barrio_Us=@BARRIO, 
	CodPostal_Us=@CODIGOPOSTAL
	WHERE DNI_Us=@DNI
GO

CREATE PROCEDURE SPAgregarArticulo
(
	@ID char(8),
	@IDCAT char(8),
	@IDMAT char(8),
	@NOMBRE varchar(20),
	@DESCRIPCION varchar(100),
	@URL varchar(60),
	@STOCK int,
	@FECHA date,
	@PRECIO decimal,
	@ESTADO bit = 1
	)
AS
    INSERT INTO Articulos(Id_Art,IdCat_Art,IdMat_Art,Nombre_Art, Descripcion_Art,UrlImagen_Art,Stock_Art,FechaIngreso_Art,PrecioUnitario_Art,Estado_Art) VALUES(@ID,@IDCAT,@IDMAT,@NOMBRE,@DESCRIPCION,@URL,@STOCK,@FECHA,@PRECIO,@ESTADO)
    GO

CREATE PROCEDURE SPAgregarUsuario
(
	@DNI char(8),
	@USUARIO varchar(30),
	@EMAIL varchar(60),
	@PROV char(8),
	@LOC char(8),
	@DOMICILIO varchar(40),
	@CONTRASEÑA varchar(30),
	@TELEFONO char(10),
	@NOMBRE char(30),
	@APELLIDO char(30),
	@FECHANAC date,
	@DEPARTAMENTO varchar(10),
	@BARRIO varchar(40),
	@CODIGOPOSTAL int
	)
AS
    INSERT INTO Usuarios(DNI_Us,Usuario_Us,Email_Us,IdProv_Us,IdLoc_Us,Domicilio_Us,Contraseña_Us,Telefono_Us,Nombre_Us,Apellido_Us,FechaNac_Us, Departamento_Us, Barrio_Us, CodPostal_Us) 
	VALUES(@DNI,@USUARIO,@EMAIL,@PROV,@LOC,@DOMICILIO,@CONTRASEÑA,@TELEFONO,@NOMBRE,@APELLIDO,@FECHANAC,@DEPARTAMENTO,@BARRIO,@CODIGOPOSTAL)
    GO

CREATE PROCEDURE SPAgregarVenta
(
		@DniUsuario char(8),
        @IdTipoEnvio char(8),
        @IdLoc char(8),
        @IdProvLoc char(8),
        @IdTipoPago char(8),
        @Usuario varchar(30),
        @EmailUsuario varchar(40),
        @DireccionUs varchar(60),
        @TelefonoUsuario char(10),
        @Total decimal,
        @Fecha date,
        @Nombre varchar (60),
        @Apellido varchar (60),
        @Departamento varchar (60),
        @Barrio varchar (60),
        @CodPostal int
)
AS
INSERT INTO Ventas (DniUsuario_Vent ,IdTipoEnvio_Vent,IdLoc_Vent,IdProvLoc_Vent ,IdTipoPago_Vent ,Usuario_Vent ,EmailUsuario_Vent ,DireccionUs_Vent ,
TelefonoUsuario_Vent,Total_Vent ,Fecha_Vent ,Nombre_Vent ,Apellido_Vent ,Departamento_Vent ,Barrio_Vent ,CodPostal_Vent)

VALUES(@DniUsuario ,@IdTipoEnvio, @IdLoc, @IdProvLoc, @IdTipoPago, @Usuario, @EmailUsuario, @DireccionUs,
@TelefonoUsuario, @Total, @Fecha, @Nombre, @Apellido, @Departamento, @Barrio,@CodPostal)
GO

CREATE PROCEDURE SPAgregarDetalleVenta
(
	@NroVent int,
	@IdArt char(8),
	@Cantidad  int,
	@PrecioArt decimal
)
AS
INSERT INTO Detalle_Ventas (NroVent_Detalle, IdArt_Detalle, Cantidad_Detalle, PrecioArt_Detalle)

VALUES (@NroVent,@IdArt,@Cantidad,@PrecioArt)
GO







--Triggers

CREATE TRIGGER BajaStock
ON Detalle_Ventas
AFTER INSERT
AS

BEGIN
	DECLARE @IdArt char(8), @Stock int
	SET @IdArt = (SELECT IdArt_Detalle FROM inserted)
	SET @Stock = (SELECT Cantidad_Detalle FROM inserted)

	UPDATE Articulos
	SET Stock_Art = Stock_Art - @Stock
	WHERE Id_Art = @IdArt
END
GO

--//////////////////////////////////////////////////////////////

CREATE TRIGGER AumentarTotalVenta
ON Detalle_Ventas
AFTER INSERT
AS

BEGIN
	DECLARE @Precio decimal, @Cantidad int, @NroVenta int
	SET @Precio = (SELECT PrecioArt_Detalle FROM inserted)
	SET @Cantidad = (SELECT Cantidad_Detalle FROM inserted)
	SET @NroVenta = (SELECT NroVent_Detalle FROM INSERTED)

	UPDATE Ventas
	SET Total_Vent += @Precio * @Cantidad
	WHERE Nro_Vent = @NroVenta
END
GO

--//////////////////////////////////////////////////////////////

Create Trigger Tr_Estado_Art
on Articulos
AFTER UPDATE
AS
IF UPDATE(Estado_Art)
BEGIN
INSERT INTO Historial_Estado_Articulos(Id_Art_HE,Fecha_HE,Estado_HE)
SELECT Id_Art,GETDATE(),Estado_Art
FROM INSERTED
END
 GO

--//////////////////////////////////////////////////////////////

Create Trigger [dbo].[Tr_Log_Venta]
on [dbo].[Ventas]
AFTER UPDATE
AS
IF UPDATE(Nro_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Nro de Venta'
			FROM INSERTED
	END
IF UPDATE(DniUsuario_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod DNI'
			FROM INSERTED
	END
IF UPDATE(IdTipoEnvio_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Tipo de envio'
			FROM INSERTED
	END
IF UPDATE(IdLoc_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod de Local de venta'
			FROM INSERTED
	END
IF UPDATE(IdTipoPago_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod tipo de pago'
			FROM INSERTED
	END
IF UPDATE(Usuario_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod usuario'
			FROM INSERTED
	END
IF UPDATE(EmailUsuario_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Email'
			FROM INSERTED
	END
IF UPDATE(DireccionUs_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Direccion'
			FROM INSERTED
	END
IF UPDATE(TelefonoUsuario_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Telefono'
			FROM INSERTED
	END
IF UPDATE(Total_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Total'
			FROM INSERTED
	END
IF UPDATE(Fecha_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Fecha'
			FROM INSERTED
	END
IF UPDATE(Nombre_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Nombre'
			FROM INSERTED
	END
IF UPDATE(Apellido_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Apellido'
			FROM INSERTED
	END
IF UPDATE(Departamento_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Departamento'
			FROM INSERTED
	END
IF UPDATE(Barrio_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Barrio'
			FROM INSERTED
	END
IF UPDATE(CodPostal_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Cod Postal'
			FROM INSERTED
	END
	GO

--//////////////////////////////////////////////////////////////

create trigger [dbo].[Tr_Insert_Venta]
  on [dbo].[Ventas]
  for insert
  as
 IF UPDATE(Nro_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Alta de Venta'
		FROM INSERTED
	end
  GO

--////////////////////////////////////////////////////////////

Create Trigger [dbo].[Tr_Log_Art]
on [dbo].[Articulos]
AFTER UPDATE
AS
IF UPDATE(Estado_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod Estado'
			FROM INSERTED
	END
IF UPDATE(Nombre_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod Nombre'
			FROM INSERTED
	END
IF UPDATE(Descripcion_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod Desc'
			FROM INSERTED
	END
IF UPDATE(IdCat_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod IdCat'
			FROM INSERTED
	END
IF UPDATE(IdMat_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod IdMat'
			FROM INSERTED
	END
IF UPDATE(UrlImagen_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod URL'
			FROM INSERTED
	END
IF UPDATE(PrecioUnitario_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod Precio'
			FROM INSERTED
	END
IF UPDATE(FechaIngreso_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod Fecha Ingreso'
			FROM INSERTED
	END
IF UPDATE(Stock_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Stock_Art,GETDATE(),'Mod Stock'
			FROM INSERTED
	END
IF UPDATE(Id_Art)
	BEGIN
			INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
			SELECT Id_Art,GETDATE(),'Mod Stock'
			FROM INSERTED
	END
GO

--/////////////////////////////////////////////////////////////

create trigger [dbo].[Tr_Insert_Art]
  on [dbo].[Articulos]
  for insert
  as
 IF UPDATE(Estado_Art)
	BEGIN
	INSERT INTO Log_Articulos(Id_Art_LA,Fecha_LA,Motivo_LA)
	SELECT Id_Art,GETDATE(),'Alta Articulo'
		FROM INSERTED
	end
  GO

--/////////////////////////////////////////////////////////////

Create Trigger [dbo].[Tr_Mod_Venta]
on [dbo].[Ventas]
AFTER UPDATE
AS
IF UPDATE(DniUsuario_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod DNI'
			FROM INSERTED
	END
IF UPDATE(IdTipoEnvio_Vent)
	BEGIN
			INSERT INTO Log_Ventas(Nro_Vent_LV,Fecha_LV,Motivo_LV)
			SELECT Nro_Vent,GETDATE(),'Mod Tipo Envio'
			FROM INSERTED
	END
GO

--//////////////////////////////////////////////////////////////

create trigger [dbo].[Tr_Insert_User]
  on [dbo].[Usuarios]
  for insert
  as
 IF UPDATE(DNI_Us)
	BEGIN
	INSERT INTO Log_Usuarios(DNI_LU,Fecha_LU,Motivo_LU)
	SELECT DNI_Us,GETDATE(),'Alta Usuario'
		FROM INSERTED
	end
  GO

