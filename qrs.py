import os
import qrcode
import tkinter as tk
from tkinter import filedialog
import database

def obtener_productos():
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()
        # Consulta para obtener productos
        consulta = "SELECT codigo, nombre FROM productos"
        cursor.execute(consulta)
        productos = cursor.fetchall()

        conn.close()
        return productos
    except Exception as e:
        print(f"Error al conectar con la base de datos: {e}")
        return []

def generar_qr(codigo, nombre, ruta_guardado):
    """
    Genera un código QR basado en un código y lo guarda en una ruta específica.
    """
    try:
        # Crear el código QR
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_H,
            box_size=10,
            border=2,
        )
        qr.add_data(codigo)
        qr.make(fit=True)
        imagen = qr.make_image(fill_color="black", back_color="white")

        # Crear el nombre del archivo
        nombre_archivo = f"{nombre}_{codigo}.png".replace(" ", "_")

        # Guardar la imagen en la ruta seleccionada
        filepath = os.path.join(ruta_guardado, nombre_archivo)
        imagen.save(filepath)
        print(f"Código QR guardado en: {filepath}")
    except Exception as e:
        print(f"Error al generar QR: {e}")

def seleccionar_ruta_guardado():
    """
    Muestra un diálogo para seleccionar la carpeta donde guardar los códigos QR.
    """
    root = tk.Tk()
    root.withdraw()  # Ocultar la ventana principal
    ruta = filedialog.askdirectory(title="Seleccionar carpeta para guardar los códigos QR")
    return ruta

def main():
    """
    Función principal para generar los códigos QR.
    """
    print("Obteniendo productos de la base de datos...")
    productos = obtener_productos()

    if not productos:
        print("No se encontraron productos en la base de datos o ocurrió un error.")
        return

    print(f"Se encontraron {len(productos)} productos.")

    # Seleccionar la ruta de guardado
    print("Selecciona la carpeta donde deseas guardar los códigos QR.")
    ruta_guardado = seleccionar_ruta_guardado()

    if not ruta_guardado:
        print("Operación cancelada. No se seleccionó ninguna carpeta.")
        return

    print("Generando códigos QR...")
    for producto in productos:
        id_producto, nombre_producto = producto
        generar_qr(codigo=id_producto, nombre=nombre_producto, ruta_guardado=ruta_guardado)

    print("¡Códigos QR generados con éxito!")

if __name__ == "__main__":
    main()
