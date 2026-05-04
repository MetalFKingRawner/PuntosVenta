import tkinter as tk
from tkinter import ttk, messagebox, PhotoImage
from PIL import Image as ima, ImageTk
import database
import psycopg2
import sys
import os
from datetime import date, timedelta, datetime, time
from tkcalendar import Calendar, DateEntry
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from reportlab.lib.pagesizes import letter, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer, Image
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib import colors
from tkinter import filedialog
from reportlab.lib.units import inch 
import cv2
import pyzbar.pyzbar as pyzbar
import pygame
import threading
from pyzbar.pyzbar import decode
from pynput import keyboard
import serial
import win32print
import win32ui
import random
import string
import qrcode

# ========== SISTEMA DE AUTENTICACIÓN ==========
class SistemaAutenticacion:
    def __init__(self):
        self.usuario_actual = None
        self.rol_actual = None
    
    def verificar_credenciales(self, usuario, password):
        """Verifica las credenciales del usuario"""
        print(f"Intentando login: usuario='{usuario}', password='{password}'")
        
        usuarios = {
            "admin": {
                "password": "adminReBe25",
                "rol": "administrador"
            },
            "vendedor": {
                "password": "ventaR01", 
                "rol": "vendedor"
            }
        }
        
        if usuario in usuarios:
            if usuarios[usuario]["password"] == password:
                self.usuario_actual = usuario
                self.rol_actual = usuarios[usuario]["rol"]
                print(f"Login exitoso: {usuario} - {self.rol_actual}")
                return True
            else:
                print(f"Contraseña incorrecta para {usuario}")
        else:
            print(f"Usuario no encontrado: {usuario}")
            
        return False
    
    def obtener_rol(self):
        return self.rol_actual
    
    def cerrar_sesion(self):
        self.usuario_actual = None
        self.rol_actual = None

auth_system = SistemaAutenticacion()

# ========== VENTANA DE LOGIN ==========
def mostrar_login():
    login_window = tk.Toplevel(root)
    login_window.title("Iniciar Sesión - Paletería ReBe")
    login_window.geometry("400x500")
    login_window.resizable(False, False)
    login_window.transient(root)
    login_window.grab_set()
    login_window.focus_set()
    
    # Centrar la ventana
    login_window.update_idletasks()
    x = (root.winfo_screenwidth() // 2) - (login_window.winfo_width() // 2)
    y = (root.winfo_screenheight() // 2) - (login_window.winfo_height() // 2)
    login_window.geometry(f"+{x}+{y}")

    def on_closing():
        print("Ventana de login cerrada sin autenticación")
        if not auth_system.usuario_actual:
            print("Cerrando aplicación porque no hay usuario autenticado")
            root.quit()
            root.destroy()

    login_window.protocol("WM_DELETE_WINDOW", on_closing)
    
    canvas = tk.Canvas(login_window, width=400, height=500, highlightthickness=0)
    canvas.pack(fill="both", expand=True)
    
    try:
        bg_image = ima.open(resource_path("ondoagr.jpg"))
        bg_image = bg_image.resize((400, 500), ima.Resampling.LANCZOS)
        bg_photo = ImageTk.PhotoImage(bg_image)
        canvas.create_image(0, 0, anchor="nw", image=bg_photo)
        canvas.bg_photo = bg_photo  # Mantener referencia
    except:
        canvas.create_rectangle(0, 0, 400, 500, fill="#E8F5E9", outline="")
        for i in range(50):
            color_value = int(232 + (i * 0.5))
            color = f"#{color_value:02x}F5E9"
            canvas.create_rectangle(0, i*10, 400, (i+1)*10, fill=color, outline="")
    
    form_frame = tk.Frame(canvas, bg="#f8f9fa", relief="solid", bd=0)
    form_frame.place(relx=0.5, rely=0.5, anchor="center", width=320, height=400)
    
    titulo_frame = tk.Frame(form_frame, bg="#FF6B9D", height=70)
    titulo_frame.pack(fill="x", pady=(0, 15))
    titulo_frame.pack_propagate(False)
    
    tk.Label(titulo_frame, text="Paletería ReBe", font=("Arial", 20, "bold"), 
             bg="#FF6B9D", fg="white").pack(expand=True)
    
    tk.Label(form_frame, text="Iniciar Sesión", font=("Arial", 15, "bold"), 
             bg="#f8f9fa", fg="#2c3e50").pack(pady=(10, 25))
    
    campos_frame = tk.Frame(form_frame, bg="#f8f9fa")
    campos_frame.pack(padx=30, fill="x")
    
    usuario_frame = tk.Frame(campos_frame, bg="#f8f9fa")
    usuario_frame.pack(fill="x", pady=(0, 18))
    
    tk.Label(usuario_frame, text="Usuario", bg="#f8f9fa", fg="#34495e", 
             font=("Arial", 10, "bold")).pack(anchor="w", pady=(0, 6))
    
    entry_usuario = tk.Entry(usuario_frame, font=("Arial", 11), 
                            relief="solid", bd=1, highlightthickness=2,
                            highlightbackground="#bdc3c7", highlightcolor="#FF6B9D",
                            bg="white")
    entry_usuario.pack(fill="x", ipady=10)
    entry_usuario.focus()
    
    password_frame = tk.Frame(campos_frame, bg="#f8f9fa")
    password_frame.pack(fill="x", pady=(0, 12))
    
    tk.Label(password_frame, text="Contraseña", bg="#f8f9fa", fg="#34495e", 
             font=("Arial", 10, "bold")).pack(anchor="w", pady=(0, 6))
    
    entry_password = tk.Entry(password_frame, font=("Arial", 11), show="●",
                             relief="solid", bd=1, highlightthickness=2,
                             highlightbackground="#bdc3c7", highlightcolor="#FF6B9D",
                             bg="white")
    entry_password.pack(fill="x", ipady=10)
    
    mensaje_error = tk.Label(campos_frame, text="", bg="#f8f9fa", fg="#e74c3c", 
                            font=("Arial", 9, "bold"), wraplength=250)
    mensaje_error.pack(pady=(8, 12))
    
    def intentar_login():
        usuario = entry_usuario.get().strip()
        password = entry_password.get().strip()
        
        print(f"Login intentado: {usuario}")
        
        if not usuario or not password:
            mensaje_error.config(text="⚠️ Por favor complete todos los campos")
            return
        
        if auth_system.verificar_credenciales(usuario, password):
            print("Login exitoso, cerrando ventana...")
            login_window.destroy()
            actualizar_interfaz_segun_rol()
            root.title(f"Punto de Venta - Paletería Rebe - Usuario: {usuario} ({auth_system.rol_actual})")
        else:
            mensaje_error.config(text="❌ Usuario o contraseña incorrectos")
            entry_password.delete(0, tk.END)
            entry_usuario.focus()
            print("Login fallido")
    
    btn_login = tk.Button(campos_frame, text="INICIAR SESIÓN", command=intentar_login,
                         bg="#FF6B9D", fg="white", font=("Arial", 11, "bold"),
                         relief="flat", cursor="hand2", activebackground="#FF8AB3",
                         activeforeground="white", bd=0)
    btn_login.pack(fill="x", ipady=12, pady=(8, 0))
    
    def on_enter_btn(e):
        btn_login.config(bg="#FF8AB3")
    
    def on_leave_btn(e):
        btn_login.config(bg="#FF6B9D")
    
    btn_login.bind("<Enter>", on_enter_btn)
    btn_login.bind("<Leave>", on_leave_btn)
    
    def on_enter(event):
        intentar_login()
    
    entry_password.bind("<Return>", on_enter)
    entry_usuario.bind("<Return>", lambda e: entry_password.focus())
    
    separator = tk.Frame(form_frame, bg="#d5d8dc", height=1)
    separator.pack(fill="x", padx=30, pady=12)
    
    cred_frame = tk.Frame(form_frame, bg="#f8f9fa")
    cred_frame.pack(pady=(5, 10))
    
    tk.Label(cred_frame, text="Credenciales de prueba", bg="#f8f9fa", fg="#7f8c8d", 
             font=("Arial", 8, "bold")).pack()
    
    creds_info = tk.Frame(cred_frame, bg="#f8f9fa")
    creds_info.pack(pady=5)
    
    tk.Label(creds_info, text="Admin:", bg="#f8f9fa", fg="#FF6B9D", 
             font=("Arial", 8, "bold")).grid(row=0, column=0, sticky="w", padx=(0, 5))
    tk.Label(creds_info, text="admin / adminReBe25", bg="#f8f9fa", fg="#7f8c8d", 
             font=("Arial", 8)).grid(row=0, column=1, sticky="w")
    
    tk.Label(creds_info, text="Vendedor:", bg="#f8f9fa", fg="#FF6B9D", 
             font=("Arial", 8, "bold")).grid(row=1, column=0, sticky="w", padx=(0, 5))
    tk.Label(creds_info, text="vendedor / ventaR01", bg="#f8f9fa", fg="#7f8c8d", 
             font=("Arial", 8)).grid(row=1, column=1, sticky="w")

# ========== ACTUALIZAR INTERFAZ SEGÚN ROL ==========
def actualizar_interfaz_segun_rol():
    """Actualiza la interfaz según el rol del usuario"""
    rol = auth_system.obtener_rol()
    
    for widget in nav_frame.winfo_children():
        widget.destroy()
    
    usuario_label = tk.Label(nav_frame, text=f"Usuario: {auth_system.usuario_actual}", 
                            bg="#df487a", fg="white", font=("Arial", 10, "bold"), justify="left")
    usuario_label.pack(fill="x", pady=10, padx=10)
    
    # Definir opciones de menú según el rol
    if rol == "administrador":
        menu_options = [
            ("Productos", [
                ("Agregar Producto", agregar_producto, resource_path("gregar-producto.png")),
                ("Editar Producto", editar_producto, resource_path("editar.png")),
                ("Eliminar Producto", eliminar_producto, resource_path("eliminar.png")),
            ]),
            ("Ventas", [
                ("Abrir turno", boton_abrir_turno, resource_path("egistrar.png")),
                ("Cerrar turno", cerrar_turno, resource_path("justar.png")),
                ("Generar Venta", ver_ventas, resource_path("enta.png")),
                ("Ver Ventas", ver_reportes_ventas2, resource_path("er_venta.png"))
            ]),
            ("Reportes", [
                ("Ver Reportes de Ventas", ver_reportes_ventas, resource_path("eporte.png")),
                ("Gráficos y Visualizaciones", mostrar_bienvenida_graficos, resource_path("graficos.png"))
            ]),
            ("Inventario", [
                ("Ver Inventario", mostrar_pantalla_inventario, resource_path("inventario.png")),
                ("Reportes de Inventario", mostrar_pantalla_reportes_inventario, resource_path("eportes.png"))
            ])
        ]
    else:
        menu_options = [
            ("Ventas", [
                ("Abrir turno", boton_abrir_turno, resource_path("egistrar.png")),
                ("Generar Venta", ver_ventas, resource_path("enta.png")),
            ])
        ]
    
    for option, suboptions in menu_options:
        button = tk.Menubutton(nav_frame, text=option, bg="#df487a", fg=menu_fg, 
                              activebackground=button_bg, activeforeground=button_fg)
        button.pack(fill="x", pady=9, expand=True)
        submenu = create_submenu(button, suboptions)
        button.config(menu=submenu)
    
    logout_button = tk.Button(nav_frame, text="Cerrar Sesión", command=cerrar_sesion,
                             bg="#e74c3c", fg="white", font=("Arial", 10, "bold"))
    logout_button.pack(side="bottom", fill="x", pady=10, padx=10)
    
    actualizar_botones_bienvenida()

def actualizar_botones_bienvenida():
    rol = auth_system.obtener_rol()
    
    for widget in frame.winfo_children():
        widget.destroy()
    
    if rol == "administrador":
        botones_info = [
            {"texto": "Nuevo producto", "imagen": "imagen_0.jpg", "accion": agregar_producto},
            {"texto": "Abrir turno", "imagen": "imagen_1.jpg", "accion": boton_abrir_turno},
            {"texto": "Cerrar turno", "imagen": "imagen_2.jpg", "accion": cerrar_turno},
            {"texto": "Generar venta", "imagen": "imagen_3.jpg", "accion": mostrar_pantalla_ventas},
            {"texto": "Ver ventas", "imagen": "imagen_4.jpg", "accion": mostrar_pantalla_ver_ventas},
            {"texto": "Inventario", "imagen": "imagen_5.jpg", "accion": mostrar_pantalla_inventario},
        ]
    else:
        botones_info = [
            {"texto": "Abrir turno", "imagen": "imagen_1.jpg", "accion": boton_abrir_turno},
            {"texto": "Generar venta", "imagen": "imagen_3.jpg", "accion": mostrar_pantalla_ventas},
        ]
    
    boton_width = 90
    boton_height = 90
    
    for i, info in enumerate(botones_info):
        fila = i // 3
        columna = i % 3
        try:
            imagen_original = ima.open(resource_path("imagen_"+str(i)+".jpg"))
            imagen_redimensionada = imagen_original.resize((boton_width, boton_height), ima.Resampling.LANCZOS)
            boton_image = ImageTk.PhotoImage(imagen_redimensionada)
        except Exception as e:
            print(f"No se pudo cargar la imagen {info['imagen']}: {e}")
            boton_image = None
        
        boton = tk.Button(frame, image=boton_image, text="", command=info["accion"])
        boton.image = boton_image
        boton.grid(row=fila * 2, column=columna, padx=20, pady=10)
        
        label = tk.Label(frame, text=info["texto"], bg="#b793ad", fg="white", font=("Arial", 10, "bold"))
        label.grid(row=fila * 2 + 1, column=columna, padx=20, pady=5)

# ========== FUNCIÓN PARA CERRAR SESIÓN ==========
def cerrar_sesion():
    auth_system.cerrar_sesion()
    # Restablecer título de la ventana
    root.title("Punto de Venta - Paletería Rebe")
    # Mostrar login nuevamente
    mostrar_login()


#-------------CLASE TICKET--------------#

class Ticket:
    def __init__(self, items, total, payment_method):
        self.items = items
        self.total = total
        self.payment_method = payment_method

    #Nombre de la impresora
    def print_ticket_windows(self, printer_name="BIXOLON SRP-350plus"):
        try:
            hdc = win32ui.CreateDC()
            hdc.CreatePrinterDC(printer_name)

            hdc.StartDoc("Ticket de Compra")
            hdc.StartPage()

            font = win32ui.CreateFont({
                "name": "Arial",
                "height": 28,  # Tamaño de letra
                "weight": 700,  # Negrita
            })

            
            hdc.SelectObject(font)

            y = 10
            line_height = 40
            page_width = 500  

            fecha_actual = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            texto = "Paleteria ReBe"
            ancho_texto, _ = hdc.GetTextExtent(texto)

            hdc.TextOut((page_width // 2) - (ancho_texto // 2), y, texto)
            y += line_height
            texto2 = "RFC: LOAL9105313C3"
            ancho_texto, _ = hdc.GetTextExtent(texto2)
            hdc.TextOut((page_width // 2) - (ancho_texto // 2), y, texto2)
            y += line_height
            texto3 = "3 de Oct. #317, Col. Centro, Miahuatlan, Oax"
            ancho_texto, _ = hdc.GetTextExtent(texto3)
            hdc.TextOut((page_width // 2) - (ancho_texto // 2), y, texto3)
            y += line_height
            texto4 = "Tel: 951-314-4134"
            ancho_texto, _ = hdc.GetTextExtent(texto4)
            hdc.TextOut((page_width // 2) - (ancho_texto // 2), y, texto4)
            y += 40

            font2 = win32ui.CreateFont({
                "name": "Arial",
                "height": 22,  # Tamaño de letra
                "weight": 700,  # Negrita
            })
            hdc.SelectObject(font2)
            hdc.TextOut(10, y, f"Fecha: {fecha_actual}")
            y += 20
            hdc.TextOut(10, y, f"Metodo de Pago: {self.payment_method}")
            y += 40

            hdc.SelectObject(font)
            # Línea separadora
            hdc.TextOut(10, y, "=====================================")
            y += line_height

            column_widths = [200, 150, 150]  
            x_position = 10 

            hdc.TextOut(x_position, y, f"{'Producto':<20}")
            x_position += column_widths[0]
            hdc.TextOut(x_position, y, f"{'Cantidad':>10}")
            x_position += column_widths[1]
            hdc.TextOut(x_position, y, f"{'Precio':>10}")
            y += line_height

            hdc.MoveTo(10, y)
            hdc.LineTo(page_width - 10, y)
            y += line_height

            for item in self.items:
                x_position = 10 

                name = item["name"][:20] 
                hdc.TextOut(x_position, y, f"{name:<20}")
                x_position += column_widths[0]

                quantity = item["quantity"]
                hdc.TextOut(x_position, y, f"{quantity:>10}") 
                x_position += column_widths[1]

                price = item["price"]
                hdc.TextOut(x_position, y, f"{price:>10.2f}")
                y += line_height

            y += line_height
            hdc.TextOut(10, y, "=====================================")
            y += line_height

            total_x_position = page_width - 200 
            hdc.TextOut(total_x_position, y, f"Total: ${self.total:.2f}")
            y += line_height * 2

            hdc.TextOut((page_width // 2) - 130, y, "¡Gracias por su compra!")
            y += line_height * 2

            avance_papel = "-----------------------------------------------------------" 
            hdc.TextOut(10, y, avance_papel)

            hdc.EndPage()
            hdc.EndDoc()
            hdc.DeleteDC()

            print("Ticket impreso correctamente.")
        except Exception as e:
            print(f"Error al imprimir: {e}")


entry_codigo = None

def abrir_turno(total_inicio):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()

        try:
            # Verificar si hay un turno abierto
            cursor.execute("SELECT * FROM turnos WHERE estado = TRUE")
            turno_abierto = cursor.fetchone()
            if turno_abierto:
                messagebox.showinfo("Turno Abierto", "Ya existe un turno abierto.")
                conn.close()
                return

            cursor.execute("""
                INSERT INTO turnos (fecha_apertura, total_inicio, estado)
                VALUES (NOW(), %s, TRUE)
            """, (total_inicio,))
            conn.commit()
            messagebox.showinfo("Turno Abierto", "El turno se ha abierto correctamente.")
        except Exception as e:
            conn.rollback()
            messagebox.showerror("Error", f"No se pudo abrir el turno. Detalle: {str(e)}")
        finally:
            conn.close()

def boton_abrir_turno():
    ventana_abrir_turno = tk.Toplevel()
    ventana_abrir_turno.title("Abrir Turno")
    ventana_abrir_turno.geometry("300x150")
    ventana_abrir_turno.resizable(False, False)

    canvas = tk.Canvas(ventana_abrir_turno, width=800, height=900)
    canvas.pack(fill="both", expand=True)

    bg_image = ima.open(resource_path("ondoagr.jpg")) 
    bg_image = bg_image.resize((250,350), ima.Resampling.LANCZOS)
    bg_photo = ImageTk.PhotoImage(bg_image)

    canvas.create_image(0, 0, anchor="nw", image=bg_photo)

    def ajustar_fondo(event=None):
        nueva_imagen = bg_image.resize((ventana_abrir_turno.winfo_width(), ventana_abrir_turno.winfo_height()), ima.Resampling.LANCZOS)
        canvas.bg_photo = ImageTk.PhotoImage(nueva_imagen) 
        canvas.create_image(0, 0, anchor="nw", image=canvas.bg_photo)

    ajustar_fondo()

    ventana_abrir_turno.bind("<Configure>", ajustar_fondo)

    label_cantidad = tk.Label(canvas, text="Cantidad de inicio (Fondo):", font=("Arial", 12))
    label_cantidad.pack(pady=10)

    entry_cantidad = tk.Entry(canvas, font=("Arial", 12), justify="center")
    entry_cantidad.pack(pady=5)

    def confirmar_abrir_turno():
        try:
            cantidad = entry_cantidad.get()
            if cantidad == '':
                cantidad = 0

            cantidad = float(cantidad)

            if cantidad < 0:
                raise ValueError("La cantidad no puede ser negativa.")
            
            abrir_turno(cantidad) 
            ventana_abrir_turno.destroy()
        except ValueError as e:
            messagebox.showerror("Error", f"Entrada inválida: {str(e)}")

    boton_confirmar = tk.Button(canvas, text="Abrir Turno", font=("Arial", 12),
                                command=confirmar_abrir_turno)
    boton_confirmar.pack(pady=10)


def print_ticket_corte(printer_name="BIXOLON SRP-350plus", total_inicio=0.0, total_ventas=0.0, total_corte=0.0):
    try:
        hdc = win32ui.CreateDC()
        hdc.CreatePrinterDC(printer_name)

        hdc.StartDoc("Ticket de Corte")
        hdc.StartPage()

        font_title = win32ui.CreateFont({
            "name": "Arial",
            "height": 28,  # Tamaño de letra
            "weight": 700,  # Negrita
        })
        hdc.SelectObject(font_title)

        y = 10
        line_height = 40
        page_width = 500 

        encabezado = [
            "Paleteria ReBe",
            "RFC: LOAL9105313C3",
            "3 de Oct. #317, Col. Centro, Miahuatlan, Oax",
            "Tel: 951-314-4134"
        ]
        for linea in encabezado:
            ancho_texto, _ = hdc.GetTextExtent(linea)
            hdc.TextOut((page_width // 2) - (ancho_texto // 2), y, linea)
            y += line_height

        y += 20 

        fecha_actual = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        hdc.TextOut(10, y, f"Fecha de corte: {fecha_actual}")
        y += line_height

        hdc.TextOut(10, y, "=====================================")
        y += line_height

        font_body = win32ui.CreateFont({
            "name": "Arial",
            "height": 24,  # Tamaño de letra
            "weight": 400,  # Regular
        })
        hdc.SelectObject(font_body)

        datos_turno = [
            ("Fondo inicial", f"${total_inicio:.2f}"),
            ("Total ventas", f"${total_ventas:.2f}"),
            ("Total de corte", f"${total_corte:.2f}")
        ]

        for etiqueta, valor in datos_turno:
            hdc.TextOut(10, y, f"{etiqueta:<20}")
            hdc.TextOut(page_width - 150, y, f"{valor:>10}")
            y += line_height

        y += line_height
        hdc.TextOut(10, y, "=====================================")
        y += line_height

        mensaje_final = "¡Corte realizado exitosamente!"
        ancho_texto, _ = hdc.GetTextExtent(mensaje_final)
        hdc.TextOut((page_width // 2) - (ancho_texto // 2), y, mensaje_final)
        y += line_height * 2

        avance_papel = "-" * 40
        hdc.TextOut(10, y, avance_papel)

        hdc.EndPage()
        hdc.EndDoc()
        hdc.DeleteDC()

        print("Ticket de corte impreso correctamente.")
    except Exception as e:
        print(f"Error al imprimir el ticket de corte: {e}")

def cerrar_turno():
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()

        cursor.execute("SELECT id, total_inicio, fecha_apertura FROM turnos WHERE estado = TRUE")
        turno_abierto = cursor.fetchone()
        if not turno_abierto:
            messagebox.showwarning("Alerta", "No hay turnos abiertos para cerrar.")
            conn.close()
            return

        turno_id, total_inicio, fecha_apertura = turno_abierto

        confirmar = messagebox.askyesno("Confirmación", "¿Está seguro de que desea cerrar el turno?")
        if not confirmar:
            messagebox.showinfo("Turno no cerrado", "El turno sigue abierto.")
            conn.close()
            return

        cursor.execute("""
            SELECT COUNT(id) AS cantidad_ventas,
                   SUM(total) AS total_ventas
            FROM ventas 
            WHERE fecha BETWEEN %s AND NOW()
        """, (fecha_apertura,))
        resultado = cursor.fetchone()
        cantidad_ventas = resultado[0] or 0
        total_ventas = resultado[1] or 0.0

        total_corte = total_ventas + total_inicio

        fecha_cierre = datetime.now()
        cursor.execute("""
            UPDATE turnos
            SET fecha_cierre = %s, total_cierre = %s, estado = FALSE
            WHERE id = %s
        """, (fecha_cierre, total_ventas, turno_id))
        conn.commit()
        tot = str(total_ventas)
        messagebox.showinfo("Turno cerrado exitosamente", "Total de ventas: $"+tot)
        
        print_ticket_corte(
            total_inicio=total_inicio,
            total_ventas=total_ventas,
            total_corte=total_corte
        )
        
        conn.close()


def verificar_turno_abierto():
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM turnos WHERE estado = TRUE")
        turno_abierto = cursor.fetchone()
        conn.close()

        if turno_abierto:
            print("Hay un turno abierto.")
            return True
        else:
            print("No hay turnos abiertos.")
            return False


def generar_codigo_unico():
    global entry_codigo
 
    caracteres = string.ascii_letters + string.digits  # Letras y números
    random_part = ''.join(random.choices(caracteres, k=5))  # 5 caracteres aleatorios
    entry_codigo.delete(0, tk.END)  # Limpiar el texto actual
    entry_codigo.insert(0,random_part)


def generar_qr(codigo):

    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=10,
        border=2,
    )
    qr.add_data(codigo)
    qr.make(fit=True)
    imagen = qr.make_image(fill_color="black", back_color="white")
    
    filepath = filedialog.asksaveasfilename(
        defaultextension=".png",
        filetypes=[("Archivos PNG", "*.png"), ("Todos los archivos", "*.*")],
        title="Guardar código QR"
    )

    if not filepath:
        print("Operación cancelada por el usuario.")
        return

    imagen.save(filepath)
    print(f"Código QR generado y guardado en: {filepath}")

def agregar_producto():
    global entry_codigo
    ventana_agregar = tk.Toplevel(root)
    ventana_agregar.title("Agregar Producto")
    ventana_agregar.geometry("250x400")
    ventana_agregar.wm_attributes("-topmost", True)

    canvas = tk.Canvas(ventana_agregar, width=800, height=900)
    canvas.pack(fill="both", expand=True)

    bg_image = ima.open(resource_path("ondoagr.jpg")) 
    bg_image = bg_image.resize((250,350), ima.Resampling.LANCZOS)  
    bg_photo = ImageTk.PhotoImage(bg_image)

    canvas.create_image(0, 0, anchor="nw", image=bg_photo)

    def ajustar_fondo(event=None):
        nueva_imagen = bg_image.resize((ventana_agregar.winfo_width(), ventana_agregar.winfo_height()), ima.Resampling.LANCZOS)
        canvas.bg_photo = ImageTk.PhotoImage(nueva_imagen)
        canvas.create_image(0, 0, anchor="nw", image=canvas.bg_photo)

    ajustar_fondo()

    ventana_agregar.bind("<Configure>", ajustar_fondo)

    # Colores para el formulario
    label_bg = "#34495e"  # Azul oscuro para las etiquetas
    label_fg = "white"    # Texto blanco en las etiquetas
    entry_bg = "white"  # Gris claro para los campos de entrada

    # Posiciones iniciales y espaciado
    pos_x_label = 25
    pos_x_entry = 115
    pos_y_inicial = 30
    espaciado_y = 55
    cco = ''

    tk.Label(canvas, text="Producto:", bg=label_bg, fg=label_fg).place(x=pos_x_label, y=pos_y_inicial)
    entry_nombre = tk.Entry(canvas, bg=entry_bg)
    entry_nombre.place(x=pos_x_entry, y=pos_y_inicial, width=100)

    conn = database.conectar_db()
    if conn:
        categorias = database.ejecutar_consulta(conn, "SELECT id, nombre FROM categorias")
        conn.close()

        nombres_categorias = [categoria[1] for categoria in categorias]

        tk.Label(canvas, text="Categoría:", bg=label_bg, fg=label_fg).place(x=pos_x_label, y=pos_y_inicial + espaciado_y)
        combobox_categoria = ttk.Combobox(canvas, values=nombres_categorias)
        combobox_categoria.place(x=pos_x_entry, y=pos_y_inicial + espaciado_y, width=100)

    else:
        print("Error: No se pudo conectar a la base de datos")

    tk.Label(canvas, text="Precio:", bg=label_bg, fg=label_fg).place(x=pos_x_label, y=pos_y_inicial + 2 * espaciado_y)
    entry_precio_compra = tk.Entry(canvas, bg=entry_bg)
    entry_precio_compra.place(x=pos_x_entry, y=pos_y_inicial + 2 * espaciado_y, width=100)

    tk.Label(canvas, text="Stock:", bg=label_bg, fg=label_fg).place(x=pos_x_label, y=pos_y_inicial + 3 * espaciado_y)
    entry_stock = tk.Entry(canvas, bg=entry_bg)
    entry_stock.place(x=pos_x_entry, y=pos_y_inicial + 3 * espaciado_y, width=100)

    tk.Label(canvas, text="Código:", bg=label_bg, fg=label_fg).place(x=pos_x_label, y=pos_y_inicial + 4 * espaciado_y)
    entry_codigo = tk.Entry(canvas, bg=entry_bg)
    entry_codigo.place(x=pos_x_entry, y=pos_y_inicial + 4 * espaciado_y, width=100)

    tk.Button(canvas, text="Generar código", command= lambda: generar_codigo_unico(), bg=button_bg, fg=button_fg).place(x=85, y = pos_y_inicial + 5 * espaciado_y)

    def guardar_producto():

        if all([entry_nombre.get(), combobox_categoria.get(), entry_precio_compra.get(), entry_stock.get(), entry_codigo.get()]):

            try:
                nombre = entry_nombre.get()
                nombre_categoria = combobox_categoria.get()
                precio_compra = float(entry_precio_compra.get())
                stock = int(entry_stock.get())
                codigo_barras = entry_codigo.get()
                cco = codigo_barras

                precio_compra = float(precio_compra)
                stock = int(stock)
                if precio_compra <= 0 or stock < 0 :
                    raise ValueError("Los valores numéricos deben ser positivos")
            except ValueError:
                tk.messagebox.showerror("Error", "Los precios y el stock deben ser números positivos")
                return
            except TypeError:
                tk.messagebox.showerror("Error", "Los precios y el stock deben ser números")
                return

            conn = database.conectar_db()
            if conn:
                consulta_id_categoria = "SELECT id FROM categorias WHERE nombre = %s"
                parametros_id_categoria = (nombre_categoria,)
                resultado_id_categoria = database.ejecutar_consulta(conn, consulta_id_categoria, parametros_id_categoria)

                if resultado_id_categoria:
                    id_categoria = resultado_id_categoria[0][0]
                    print(id_categoria)
                else:
                    tk.messagebox.showerror("Error", "Categoría no encontrada")
                    conn.close()
                    return
                
                try:
                    cursor = conn.cursor()
                    consulta_producto = """
                        INSERT INTO productos (nombre, id_categoria, precio, stock, codigo)
                        VALUES (%s, %s, %s, %s, %s) RETURNING id
                    """
                    parametros_producto = (nombre, id_categoria, precio_compra, stock, codigo_barras)
                    cursor.execute(consulta_producto, parametros_producto)
                    id_producto = cursor.fetchone()[0]

                    consulta_movimiento = """
                        INSERT INTO movimientos_inventario (id_producto, cantidad, precio_unitario, tipo_movimiento, motivo)
                        VALUES (%s, %s, %s, 'entrada', 'Producto agregado')
                    """
                    parametros_movimiento = (id_producto, stock, precio_compra)
                    cursor.execute(consulta_movimiento, parametros_movimiento)

                    conn.commit()
                    generar_qr(cco)
                    messagebox.showinfo("Éxito", "Producto agregado correctamente")
                    ventana_agregar.destroy() 
                except Exception as e:
                    conn.rollback()
                    tk.messagebox.showerror("Error", f"No se pudo agregar el producto. Error: {e}")
                finally:
                    cursor.close()
                    conn.close()
            else:
                print("Error: No se pudo conectar a la base de datos")
        else:
            tk.messagebox.showerror("Error", "Todos los campos son obligatorios")

    tk.Button(canvas, text="Guardar", command=guardar_producto, bg=button_bg, fg=button_fg).place(x=100, y=pos_y_inicial + 6 * espaciado_y)
    
    canvas.bg_photo = bg_photo


# Función para escanear código de barras y actualizar la tabla de productos (ESTO SOLO ES PARA WEBCAM)
#def escanear_codigo(tabla_productos, ventana_editar):
    # Iniciar la cámara
#    cap = cv2.VideoCapture(3)
#    pygame.mixer.init()
#    
#    def play_beep():
#        pygame.mixer.music.load("Modificadobeep.mp3")
#        pygame.mixer.music.play()
    
#    while True:
#        ret, frame = cap.read()
#        if not ret:
#            break

        # Detectar códigos de barras
#        decoded_objects = pyzbar.decode(frame)
#        for obj in decoded_objects:
#            codigo = obj.data.decode('utf-8')
            # Reproducir sonido de "beep"
#            play_beep()
            
            # Obtener la fila seleccionada en la tabla de productos
#            selected_item = tabla_productos.selection()
#            if selected_item:
                # Rellenar la columna de "Código de Barras" en la fila seleccionada
#                tabla_productos.set(selected_item[0], column="Código de Barras", value=codigo)

            # Cerrar la cámara y ventana de visualización
#            cap.release()
#            cv2.destroyAllWindows()
#            ventana_editar.focus()  # Volver el enfoque a la ventana principal de edición
#            return
        
        # Mostrar la cámara
#        cv2.imshow("Escanear Código de Barras", frame)

        # Salir si se presiona la tecla 'q'
#        if cv2.waitKey(1) & 0xFF == ord('q'):
#            break

#    cap.release()
#    cv2.destroyAllWindows()


def editar_producto():
    global products_frame, tabla_productos  
    products_frame = tk.Frame(container, bg=frame_bg)
    products_frame.grid(row=0, column=1, sticky="nsew")

    canvas = tk.Canvas(products_frame, width=800, height=900)
    canvas.pack(fill="both", expand=True)

    bg_image = ima.open(resource_path("ondoedi.jpg"))  
    bg_image = bg_image.resize((250,350), ima.Resampling.LANCZOS)  
    bg_photo = ImageTk.PhotoImage(bg_image)

    canvas.create_image(0, 0, anchor="nw", image=bg_photo)

    def ajustar_fondo(event=None):
        nueva_imagen = bg_image.resize((products_frame.winfo_width(), products_frame.winfo_height()), ima.Resampling.LANCZOS)
        canvas.bg_photo = ImageTk.PhotoImage(nueva_imagen) 
        canvas.create_image(0, 0, anchor="nw", image=canvas.bg_photo)

    ajustar_fondo()

    products_frame.bind("<Configure>", ajustar_fondo)


    search_label = tk.Label(canvas, text="Buscar producto:", bg="#1D1454", fg="white", font=("Arial", 12))
    search_label.pack(pady=(10, 0))
    
    search_entry = tk.Entry(canvas, width=50, font=("Arial", 12))
    search_entry.pack(pady=(0, 10))

    estilo_tabla = ttk.Style()

    estilo_tabla.theme_use("clam")

    estilo_tabla.configure("Treeview",
                           background="white",
                           foreground="black",
                           rowheight=25,
                           fieldbackground="white",
                           bordercolor="#d9d9d9",
                           borderwidth=2,
                           font=('Arial', 9))

    estilo_tabla.configure("Treeview.Heading",
                           background="#00A3A3", 
                           foreground="white", 
                           font=('Arial', 9, 'bold'))

    estilo_tabla.map("Treeview",
                     background=[('selected', '#00A697')],
                     foreground=[('selected', 'white')])

    columnas = ("ID", "Producto", "Categoría", "Precio", "Stock", "Código")
    tabla_productos = ttk.Treeview(canvas, columns=columnas, show="headings", style="estilo_tabla.Treeview")
    tabla_productos.pack(expand=True, fill="both", pady=(20, 0)) 

    for col in columnas:
        tabla_productos.heading(col, text=col, anchor="center")
        tabla_productos.column(col, width=100, anchor="center")

    def cargar_productos(filtro=None):
        for item in tabla_productos.get_children():
            tabla_productos.delete(item)

        conn = database.conectar_db()
        if conn:
            consulta = """
                SELECT p.id, p.nombre, c.nombre AS categoria, p.precio, p.stock, p.codigo
                FROM productos p
                LEFT JOIN categorias c ON p.id_categoria = c.id
                ORDER BY p.id
            """
            productos = database.ejecutar_consulta(conn, consulta)
            conn.close()

            for producto in productos:
                if filtro and filtro.lower() not in producto[1].lower(): 
                    continue
                tabla_productos.insert("", "end", text=producto[0], values=producto)

        else:
            print("Error: No se pudo conectar a la base de datos")


    cargar_productos()

    def buscar_producto(event):
        filtro = search_entry.get()
        cargar_productos(filtro)

    search_entry.bind("<KeyRelease>", buscar_producto)
    # SOLO PARA WEBCAM
    #def abrir_escaneo_codigo_barras():
    #    codigo = escanear_codigo()  # Función que abre la cámara y devuelve el código escaneado
    #    row_id = tabla_productos.selection()[0]
    #    tabla_productos.set(row_id, column="Código de Barras", value=codigo)

    def guardar_cambios_tabla():
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            for row in tabla_productos.get_children():
                values = list(tabla_productos.item(row, "values"))
                id_producto = tabla_productos.item(row, "text")
                codigo_barras = values[5] 

                try:
                    precio_compra = float(values[3])
                    stock = int(values[4])
                    if precio_compra <= 0 or stock < 0:
                        raise ValueError("Los valores numéricos deben ser positivos")
                except ValueError:
                    messagebox.showerror("Error", f"Error en los valores numéricos del producto {id_producto}, deben ser positivos")
                    return  

                cursor.execute("SELECT id FROM categorias WHERE nombre = %s", (values[2],))
                id_categoria = cursor.fetchone()

                if id_categoria:
                    id_categoria = id_categoria[0]

                    cursor.execute("SELECT stock FROM productos WHERE id= %s", (id_producto,))
                    stock_actual = cursor.fetchone()[0]

                    consulta = """
                        UPDATE productos
                        SET nombre = %s, id_categoria = %s, precio = %s, 
                        stock = %s, codigo = %s
                        WHERE id = %s
                    """
                    parametros = (values[1], id_categoria, precio_compra, stock, codigo_barras, id_producto)
                    cursor.execute(consulta, parametros)

                    diferencia_stock = stock - stock_actual
                    if diferencia_stock != 0:
                        tipo_movimiento = 'entrada' if diferencia_stock > 0 else 'salida'
                        cantidad = abs(diferencia_stock)

                        consulta_movimiento = """
                            INSERT INTO movimientos_inventario (id_producto, cantidad, precio_unitario, tipo_movimiento, motivo)
                            VALUES (%s, %s, %s, %s, 'Edicion de producto')
                        """
                        parametros_movimiento = (id_producto, cantidad, precio_compra, tipo_movimiento)
                        cursor.execute(consulta_movimiento, parametros_movimiento)

                    conn.commit()

                else:
                    messagebox.showerror("Error", "Categoría o proveedor no encontrado")

            cursor.close()
            conn.close()
            messagebox.showinfo("Éxito", "Productos actualizados correctamente")
            cargar_productos()

    def make_cell_editable(event):
        row_id = tabla_productos.selection()[0]
        column = tabla_productos.identify_column(event.x)
        column_index = int(column[1:]) - 1

        if column_index == 0:
            return 

        x, y, width, height = tabla_productos.bbox(row_id, column)
        entry = ttk.Entry(tabla_productos, width=width)
        entry.place(x=x, y=y, width=width, height=height)
        entry.insert(0, tabla_productos.item(row_id, 'values')[column_index])
        entry.focus()

        def save_edit(event):
            tabla_productos.set(row_id, column=column, value=entry.get())
            entry.destroy()

        entry.bind("<Return>", save_edit)
        entry.bind("<FocusOut>", save_edit)

    def make_combobox_editable(event, options, column_index):
        row_id = tabla_productos.selection()[0]
        column = tabla_productos.identify_column(event.x)

        if int(column[1:]) - 1 != column_index:
            return

        x, y, width, height = tabla_productos.bbox(row_id, column)
        combobox = ttk.Combobox(tabla_productos, values=options, width=width)
        combobox.place(x=x, y=y, width=width, height=height)
        combobox.set(tabla_productos.item(row_id, 'values')[column_index])
        combobox.focus()

        def save_edit(event):
            tabla_productos.set(row_id, column=column, value=combobox.get())
            combobox.destroy()

        combobox.bind("<Return>", save_edit)
        combobox.bind("<FocusOut>", save_edit)

    def on_double_click(event):
        column = tabla_productos.identify_column(event.x)
        column_index = int(column[1:]) - 1

        if column_index == 3:  
            make_combobox_editable(event, categorias, 3)

        else:
            make_cell_editable(event)

    tabla_productos.bind("<Double-1>", on_double_click)

    conn = database.conectar_db()
    if conn:
        categorias = [nombre for id_categoria, nombre in database.ejecutar_consulta(conn, "SELECT id, nombre FROM categorias")]


    cerrar_button = tk.Button(canvas, text="Cerrar panel de edición", command=lambda: products_frame.destroy(), bg=button_bg, fg=button_fg)
    cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)

    actualizar_button = tk.Button(canvas, text="Actualizar Productos", command=guardar_cambios_tabla, bg="#1D1454", fg="white", font=("Arial", 12, "bold"), relief="flat")
    actualizar_button.pack(pady=10)  


def eliminar_producto():
    products_frame = tk.Frame(container, bg=frame_bg)
    products_frame.grid(row=0, column=1, sticky="nsew")

    canvas = tk.Canvas(products_frame, width=800, height=900)
    canvas.pack(fill="both", expand=True)

    bg_image = ima.open(resource_path("ondoeli.jpeg")) 
    bg_image = bg_image.resize((250,350), ima.Resampling.LANCZOS)  
    bg_photo = ImageTk.PhotoImage(bg_image)

    canvas.create_image(0, 0, anchor="nw", image=bg_photo)

    def ajustar_fondo(event=None):
        nueva_imagen = bg_image.resize((products_frame.winfo_width(), products_frame.winfo_height()), ima.Resampling.LANCZOS)
        canvas.bg_photo = ImageTk.PhotoImage(nueva_imagen) 
        canvas.create_image(0, 0, anchor="nw", image=canvas.bg_photo)

    ajustar_fondo()

    products_frame.bind("<Configure>", ajustar_fondo)

    search_label = tk.Label(canvas, text="Buscar producto:", bg=frame_bg, fg="black", font=("Arial", 12))
    search_label.pack(pady=(10, 0))
    
    search_entry = tk.Entry(canvas, width=50, font=("Arial", 12))
    search_entry.pack(pady=(0, 10))

    estilo_tabla = ttk.Style()

    estilo_tabla.theme_use("clam")

    estilo_tabla.configure("Treeview",
                    background="white",
                    foreground="black",
                    rowheight=25,
                    fieldbackground="white",
                    bordercolor="#d9d9d9",
                    borderwidth=2,
                    font=('Arial', 9))

    estilo_tabla.configure("Treeview.Heading",
                    background="#00A3A3",  
                    foreground="white",      
                    font=('Arial', 9, 'bold'))

    estilo_tabla.map("Treeview",
            background=[('selected', '#00A697')],
            foreground=[('selected', 'white')])

    tabla_productos = ttk.Treeview(canvas, columns=("ID", "Nombre", "Precio", "Stock"), show="headings", style="estilo_tabla.Treeview")
    tabla_productos.heading("ID", text="ID", anchor="center")
    tabla_productos.heading("Nombre", text="Nombre", anchor="center")
    tabla_productos.heading("Precio", text="Precio", anchor="center")
    tabla_productos.heading("Stock", text="Stock", anchor="center")
    tabla_productos.column("ID", anchor="center")
    tabla_productos.column("Nombre", anchor="center")
    tabla_productos.column("Precio", anchor="center")
    tabla_productos.column("Stock", anchor="center")
    tabla_productos.pack(expand=True, fill="both")

    def cargar_productos(filtro=None):
        for item in tabla_productos.get_children():
            tabla_productos.delete(item)

        conn = database.conectar_db()
        if conn:
            consulta = """
                SELECT p.id, p.nombre, p.precio, p.stock
                FROM productos p
                ORDER BY p.id
            """
            productos = database.ejecutar_consulta(conn, consulta)
            conn.close()

            for producto in productos:
                if filtro and filtro.lower() not in producto[1].lower():  
                    continue
                tabla_productos.insert("", "end", text=producto[0], values=producto)

        else:
            print("Error: No se pudo conectar a la base de datos")


    cargar_productos()

    def buscar_producto(event):
        filtro = search_entry.get()
        cargar_productos(filtro)

    search_entry.bind("<KeyRelease>", buscar_producto)

    def confirmar_eliminacion(event):
        seleccion = tabla_productos.selection()
        if seleccion:
            item = tabla_productos.item(seleccion[0])
            id_producto = item['text']
            nombre_producto = item['values'][1]

            respuesta = messagebox.askyesno("Confirmar Eliminación", f"¿Está seguro que desea eliminar el producto '{nombre_producto}'?")
            if respuesta:
                conn = database.conectar_db()
                if conn:
                    cursor = conn.cursor()

                    consulta_eliminar_movimientos = "DELETE FROM detalle_ventas WHERE id_producto = %s"
                    cursor.execute(consulta_eliminar_movimientos, (id_producto,))

                    consulta_eliminar_movimientos = "DELETE FROM movimientos_inventario WHERE id_producto = %s"
                    cursor.execute(consulta_eliminar_movimientos, (id_producto,))

                    consulta_eliminacion = "DELETE FROM productos WHERE id = %s"
                    parametros_eliminacion = (id_producto,)
                    cursor.execute(consulta_eliminacion, parametros_eliminacion)

                    conn.commit()

                    messagebox.showinfo("Éxito", "Producto eliminado correctamente")
                    cargar_productos()

                    cursor.close()
                    conn.close()
                else:
                    print("Error: No se pudo conectar a la base de datos")

    tabla_productos.bind("<Double-1>", confirmar_eliminacion)

    def cerrar_tabla_productos():
        products_frame.destroy()
        welcome_frame = tk.Frame(container, bg=frame_bg)

    btn_cerrar = tk.Button(canvas, text="Cerrar Tabla", command=cerrar_tabla_productos, bg=button_bg, fg=button_fg)
    btn_cerrar.pack(pady=10)

ventana_ventas = None


def mostrar_pantalla_ventas():
    global sales_frame  
    if sales_frame is not None: 
        sales_frame.destroy()  

    sales_frame = tk.Frame(container, bg=frame_bg) 
    sales_frame.grid(row=0, column=1, sticky='nsew')

    def resize_background(event):
        global background_image_ref
        width, height = event.width, event.height
        imagen_fondo = ima.open(resource_path("ondo.png")) 
        imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
        background_image_ref = ImageTk.PhotoImage(imagen_fondo)
        # Crear un Label con la imagen de fondo
        background_label.config(image=background_image_ref)
        background_label.image = background_image_ref 

    background_label = tk.Label(sales_frame)
    background_label.place(x=0, y=0, relwidth=1, relheight=1) 

    sales_frame.bind("<Configure>", resize_background)

    
    # Colores para la pantalla de ventas
    label_bg = "#2980b9"    # Azul oscuro para las etiquetas
    label_fg = "white"      # Texto blanco en las etiquetas
    entry_bg = "#ecf0f1"    # Gris claro para los campos de entrada
    table_bg = "white"      # Blanco para el fondo de las tablas
    table_fg = "black"      # Texto negro en las tablas
    button_bg = "#f39c12"   # Naranja para los botones
    button_fg = "white"     # Texto blanco en los botones

    busqueda_frame = tk.Frame(sales_frame, bg="black")
    busqueda_frame.pack(fill="x", padx=10, pady=10)

    tk.Label(busqueda_frame, text="Búsqueda:", bg=label_bg, fg=label_fg).pack(side="left", padx=5)
    entry_busqueda = tk.Entry(busqueda_frame, bg=None)
    entry_busqueda.pack(side="left", fill="x", expand=True, padx=5)

    def buscar_producto():
        termino_busqueda = entry_busqueda.get().lower() 

        conn = database.conectar_db()
        if conn:
            consulta = """
                SELECT id, nombre, precio, stock 
                FROM productos
                WHERE LOWER(nombre) LIKE %s
            """
            parametros = (f"%{termino_busqueda}%",) 
            productos = database.ejecutar_consulta(conn, consulta, parametros)
            conn.close()

            for item in tabla_productos_disponibles.get_children():
                tabla_productos_disponibles.delete(item)
            for producto in productos:
                tabla_productos_disponibles.insert("", tk.END, values=producto)

    def refrescar_tabla():
        cargar_productos_disponibles()  
        entry_busqueda.delete(0, tk.END) 


    tk.Button(busqueda_frame, text="Buscar", command=buscar_producto, bg=button_bg, fg=button_fg).pack(side="left", padx=5)
    tk.Button(busqueda_frame, text="Refresh", command=refrescar_tabla, bg=button_bg, fg=button_fg).pack(side="left", padx=5)
    cerrar_button = tk.Button(sales_frame, text="Cerrar panel de ventas", command=lambda: sales_frame.destroy(), bg=button_bg, fg=button_fg)
    cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)

    tabla_productos_disponibles = ttk.Treeview(sales_frame, columns=("ID", "Nombre", "Precio", "Stock"), show="headings")
    tabla_productos_disponibles.heading("ID", text="ID", anchor="center") 
    tabla_productos_disponibles.heading("Nombre", text="Nombre", anchor="center")
    tabla_productos_disponibles.heading("Precio", text="Precio", anchor="center")
    tabla_productos_disponibles.heading("Stock", text="Stock", anchor="center")
    tabla_productos_disponibles.pack(side="left", fill="both", expand=True, padx=10, pady=10)

    tabla_productos_disponibles.column("ID", width=50, anchor="center")
    tabla_productos_disponibles.column("Nombre", width=200, anchor="center")
    tabla_productos_disponibles.column("Precio", width=100, anchor="center")
    tabla_productos_disponibles.column("Stock", width=100, anchor="center")


    def cargar_productos_disponibles():
        for item in tabla_productos_disponibles.get_children(): 
            tabla_productos_disponibles.delete(item)

        conn = database.conectar_db()
        if conn:
            productos = database.ejecutar_consulta(conn, "SELECT id, nombre, precio, stock FROM productos ORDER BY id")
            conn.close()

            for producto in productos:
                tabla_productos_disponibles.insert("", tk.END, values=producto)

    cargar_productos_disponibles() 

    # --- Función para agregar producto al carrito al hacer doble clic ---
    def agregar_al_carrito(event):
        item = tabla_productos_disponibles.identify_row(event.y)
        if item:
            producto = tabla_productos_disponibles.item(item)
            nombre = producto['values'][1]
            precio_unitario = float(producto['values'][2])

            existe_en_carrito = False
            for row in tabla_reporte_producto.get_children():
                if tabla_reporte_producto.item(row)['values'][0] == nombre:
                    existe_en_carrito = True
                    break

            if existe_en_carrito:
                cantidad_actual = int(tabla_reporte_producto.item(row)['values'][1])
                nueva_cantidad = cantidad_actual + 1
                tabla_reporte_producto.item(row, values=(nombre, nueva_cantidad, precio_unitario, nueva_cantidad * precio_unitario))
            else:
                tabla_reporte_producto.insert("", tk.END, values=(nombre, 1, precio_unitario, precio_unitario))

            calcular_total()

    tabla_productos_disponibles.bind("<Double-Button-1>", agregar_al_carrito)

    # --- Carrito de Compras ---
    carrito_frame = tk.Frame(sales_frame, bg="black")
    carrito_frame.pack(side="right", fill="both", expand=True, padx=10, pady=10)
    def resize_background(event):
        global background_image_ref
        width, height = event.width, event.height
        imagen_fondo = ima.open(resource_path("ondo_c.jpg")) 
        imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
        background_image_ref = ImageTk.PhotoImage(imagen_fondo)
        background_label_ventas.config(image=background_image_ref)
        background_label_ventas.image = background_image_ref 

    background_label_ventas = tk.Label(carrito_frame)
    background_label_ventas.place(x=0, y=0, relwidth=1, relheight=1)

    carrito_frame.bind("<Configure>", resize_background)

    tk.Label(carrito_frame, text="Carrito de Compras", font=("Arial", 16, "bold"), bg="#3e0d3c", fg="#FFFFFF").pack(pady=10)

    estilo_tabla = ttk.Style()

    estilo_tabla.theme_use("clam")

    estilo_tabla.configure("Treeview",
                    background="white",
                    foreground="black",
                    rowheight=25,
                    fieldbackground="white",
                    bordercolor="#d9d9d9",
                    borderwidth=2,
                    font=('Arial', 9))

    estilo_tabla.configure("Treeview.Heading",
                    background="#00A3A3",  
                    foreground="white",     
                    font=('Arial', 9, 'bold'))

    estilo_tabla.map("Treeview",
            background=[('selected', '#00A697')],
            foreground=[('selected', 'white')])

    tabla_reporte_producto = ttk.Treeview(carrito_frame, columns=("Nombre", "Cantidad", "Precio Unitario", "Precio Total"), show="headings", style="estilo_tabla.Treeview")
    tabla_reporte_producto.heading("Nombre", text="Nombre", anchor="center")
    tabla_reporte_producto.heading("Cantidad", text="Cantidad", anchor="center")
    tabla_reporte_producto.heading("Precio Unitario", text="Precio Unitario", anchor="center")
    tabla_reporte_producto.heading("Precio Total", text="Precio Total", anchor="center")
    tabla_reporte_producto.pack(fill="both", expand=True)

    tabla_reporte_producto.column("Nombre", width=200, anchor="center")
    tabla_reporte_producto.column("Cantidad", width=100, anchor="center")
    tabla_reporte_producto.column("Precio Unitario", width=100, anchor="center")
    tabla_reporte_producto.column("Precio Total", width=100, anchor="center")

    total_frame = tk.Frame(carrito_frame, bg="#3e0d3c")
    total_frame.pack(fill="x")

    def eliminar_del_carrito():
        seleccion = tabla_reporte_producto.selection()
        if seleccion:
            item_id = seleccion[0]

            item = tabla_reporte_producto.item(item_id) 
            nombre = item['values'][0]
            cantidad = int(item['values'][1])

            if cantidad > 1:
                nueva_cantidad = cantidad - 1
                precio_unitario = float(item['values'][2])
                nuevo_precio_total = nueva_cantidad * precio_unitario
                tabla_reporte_producto.item(item_id, values=(nombre, nueva_cantidad, precio_unitario, nuevo_precio_total))
            else:
                tabla_reporte_producto.delete(item_id) 

            calcular_total()
        else:
            messagebox.showwarning("Advertencia", "Selecciona un producto para eliminar")


    def calcular_total():
        total = 0
        for row in tabla_reporte_producto.get_children():
            total += float(tabla_reporte_producto.item(row)['values'][3]) 
        label_total.config(text=f"${total:.2f}")

    tk.Label(total_frame, text="Total:", bg=label_bg, fg=label_fg).pack(side="left", padx=5, pady=5)
    label_total = tk.Label(total_frame, text="$0.00", bg="#3e0d3c", fg="#FFFFFF", font=("Arial", 14, "bold"))
    label_total.pack(side="left")

    payment_frame = tk.Frame(total_frame, bg="#3e0d3c")
    payment_frame.pack(side="right", fill="x", expand=True, padx=10, pady=5)

    def validar_pago(char):
        return char.isdigit() or char == "."  

    vcmd = (root.register(validar_pago), '%S')

    tk.Label(payment_frame, text="Pago:", font=("Arial", 12, "bold"), bg="#3e0d3c", fg="#FFFFFF").pack(side="left", padx=5)
    entry_pago = tk.Entry(payment_frame, bg=None, validate="key", validatecommand=vcmd)
    entry_pago.pack(side="left", padx=5)

    def obtener_float_de_label(label):
        texto = label.cget("text") 
        numero_str = ''.join(filter(lambda x: x.isdigit() or x == '.', texto)) 
        return float(numero_str) if numero_str else 0.0  

    def actualizar_cambio(event):
        try:
            pago = float(entry_pago.get())
            total_precio = obtener_float_de_label(label_total) 
            cambio = pago - total_precio
            label_cambio.config(text=f"Cambio: ${cambio:.2f}")
        except ValueError:
            label_cambio.config(text="Cambio: $0.00")

    entry_pago.bind("<KeyRelease>", actualizar_cambio)
    label_cambio = tk.Label(payment_frame, text="Cambio: $0.00", font=("Arial", 12, "bold"), bg="#3e0d3c", fg="#FFFFFF")
    label_cambio.pack(side="left", padx=5)

    button_frame = tk.Frame(payment_frame, bg="#3e0d3c")
    button_frame.pack(side="left", padx=10, pady=5)

    tk.Button(button_frame, text="Eliminar Producto", command=eliminar_del_carrito, bg=button_bg, fg=button_fg).pack(side="left", padx=5)


    def realizar_compra():
        conn = database.conectar_db()
        if conn:
            try:
                total_venta = float(label_total.cget("text").replace("$", ""))

                if not tabla_reporte_producto.get_children():
                    messagebox.showwarning("Advertencia", "No hay productos en el carrito")
                    return

                for row in tabla_reporte_producto.get_children():
                    item = tabla_reporte_producto.item(row)
                    nombre_producto = item['values'][0]
                    cantidad_a_comprar = int(item['values'][1])

                    consulta_stock = "SELECT stock FROM productos WHERE nombre = %s"
                    parametros_stock = (nombre_producto,)
                    resultado_stock = database.ejecutar_consulta(conn, consulta_stock, parametros_stock)

                    if resultado_stock:
                        stock_disponible = resultado_stock[0][0]
                        if stock_disponible < cantidad_a_comprar:
                            messagebox.showerror("Error", f"No hay suficiente stock de {nombre_producto}")
                            conn.rollback() 
                            return
                    else:
                        messagebox.showerror("Error", f"Producto {nombre_producto} no encontrado")
                        conn.rollback()
                        return

                consulta_venta = "INSERT INTO ventas (total) VALUES (%s) RETURNING id"
                parametros_venta = (total_venta,) 
                resultado_venta = database.ejecutar_consulta(conn, consulta_venta, parametros_venta)

                print(resultado_venta)
                if resultado_venta:
                    id_venta = resultado_venta[0][0]
                    items = []

                    for row in tabla_reporte_producto.get_children():
                        item = tabla_reporte_producto.item(row)
                        nombre_producto = item['values'][0]
                        cantidad = int(item['values'][1])
                        precio_unitario = float(item['values'][2])

                        consulta_producto = "SELECT id, stock FROM productos WHERE nombre = %s"
                        parametros_producto = (nombre_producto,)
                        resultado_producto = database.ejecutar_consulta(conn, consulta_producto, parametros_producto)

                        if resultado_producto:
                            id_producto, stock_actual = resultado_producto[0]

                            nuevo_stock = stock_actual - cantidad
                            consulta_actualizar_stock = "UPDATE productos SET stock = %s WHERE id = %s"
                            parametros_actualizar_stock = (nuevo_stock, id_producto)
                            database.ejecutar_consulta(conn, consulta_actualizar_stock, parametros_actualizar_stock)

                            consulta_detalle_venta = "INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, subtotal) VALUES (%s, %s, %s, %s)"
                            parametros_detalle_venta = (id_venta, id_producto, cantidad, precio_unitario)
                            database.ejecutar_consulta(conn, consulta_detalle_venta, parametros_detalle_venta)

                            consulta_movimiento = """
                                INSERT INTO movimientos_inventario (id_producto, cantidad, precio_unitario, tipo_movimiento, motivo)
                                VALUES (%s, %s, %s, 'salida', 'Venta de producto')
                            """
                            parametros_movimiento = (id_producto, cantidad, precio_unitario)
                            database.ejecutar_consulta(conn, consulta_movimiento, parametros_movimiento)
                            items.append({"name": nombre_producto, "quantity": cantidad, "price": (precio_unitario * cantidad)})


                    for item in tabla_reporte_producto.get_children():
                        tabla_reporte_producto.delete(item)
                    calcular_total()


                    # Preguntar si se desea imprimir el ticket
                    respuesta = messagebox.askyesno("Imprimir Ticket", "¿Desea imprimir el ticket?")
                    if respuesta:
                        payment_method = "Efectivo" 
                        ticket = Ticket(items, total_venta, payment_method)
                        ticket.print_ticket_windows()

                    messagebox.showinfo("Éxito", "Compra realizada correctamente")
                    cargar_productos_disponibles() 
                else:
                    messagebox.showerror("Error", "No se pudo registrar la venta")

            except Exception as e:
                messagebox.showerror("Error", f"Error al realizar la compra: {e}")
                conn.rollback()
            finally:
                if conn:
                    conn.close()

    escaneo_activo = False
    hilo_escaneo = None
    detener_hilo = threading.Event()
    codigo_buffer = ""  
    temporizador = None  
    TIEMPO_ESPERA = 0.1  
    
    # PYGAME SOLO PARA ESCANEOS CON WEBCAM/CAM CELULAR
    #pygame.mixer.init()

    def activar_desactivar_escaneo(event=None):
        nonlocal escaneo_activo, hilo_escaneo
        escaneo_activo = not escaneo_activo
        print(f"Escaneo activo: {escaneo_activo}")
        try:
            if escaneo_activo:
                hilo_escaneo = threading.Thread(target=escanear_codigo, daemon=True)
                hilo_escaneo.start()
            else:
                pass
        except Exception as e:
            messagebox.showerror("Error", f"Ocurrió un error: {str(e)}")

    #def play_beep():
        #"""Reproduce un sonido de confirmación."""
    #    pygame.mixer.music.load("beep.mp3")
    #    pygame.mixer.music.play()

    def escanear_codigo():
        nonlocal escaneo_activo, codigo_buffer, temporizador
        try:
            def procesar_codigo():
                nonlocal codigo_buffer
                if codigo_buffer:
                    #play_beep()
                    conn = database.conectar_db()
                    consulta = "SELECT id, nombre, precio FROM productos WHERE codigo = %s"
                    parametros = (codigo_buffer,)
                    producto = database.ejecutar_consulta(conn, consulta, parametros)
                    conn.close()
                    codigo_buffer = "" 

                    if producto:
                        nombre = producto[0][1]
                        precio_unitario = float(producto[0][2])

                        existe_en_carrito = False
                        for row in tabla_reporte_producto.get_children():
                            if tabla_reporte_producto.item(row)['values'][0] == nombre:
                                existe_en_carrito = True
                                break

                        if existe_en_carrito:
                            cantidad_actual = int(tabla_reporte_producto.item(row)['values'][1])
                            nueva_cantidad = cantidad_actual + 1
                            tabla_reporte_producto.item(row, values=(nombre, nueva_cantidad, precio_unitario, nueva_cantidad * precio_unitario))
                        else:
                            tabla_reporte_producto.insert("", tk.END, values=(nombre, 1, precio_unitario, precio_unitario))

                        calcular_total()
                    else:
                        messagebox.showwarning("No encontrado", "Producto no encontrado. Verifica su existencia porfavor")

            def on_press(key):
                """Callback para capturar teclas."""
                nonlocal codigo_buffer, temporizador

                if not escaneo_activo:
                    return False  

                try:
                    if hasattr(key, 'char') and key.char:  
                        codigo_buffer += key.char

                        if temporizador:
                            temporizador.cancel()
                        temporizador = threading.Timer(TIEMPO_ESPERA, procesar_codigo)
                        temporizador.start()
                except Exception as e:
                    print(f"Error en la captura de teclado: {e}")

            with keyboard.Listener(on_press=on_press) as listener:
                listener.join()
        except Exception as e:
            messagebox.showerror("Error", f"Ocurrió un error: {str(e)}")


    root.bind("<F1>", activar_desactivar_escaneo)
    

    tk.Button(button_frame, text="Realizar Compra", command=realizar_compra, bg=button_bg, fg=button_fg).pack(side="left", padx=5)



def ver_ventas():
    mostrar_pantalla_ventas()

def ver_reportes_ventas():
    mostrar_pantalla_ver_ventas(5)

def ver_reportes_ventas2():
    mostrar_pantalla_ver_ventas(0)

def obtener_ventas_dia(fecha):
    conn = database.conectar_db()
    if conn:
        consulta_ingresos = """
            SELECT SUM(total) 
            FROM ventas 
            WHERE DATE(fecha) = %s
        """
        resultado_ingresos = database.ejecutar_consulta(conn, consulta_ingresos, (fecha,))
        total_ingresos = resultado_ingresos[0][0] if resultado_ingresos and resultado_ingresos[0][0] is not None else 0


        consulta_cantidad_productos = """
            SELECT SUM(dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id
            WHERE DATE(v.fecha) = %s
        """
        resultado_cantidad_productos = database.ejecutar_consulta(conn, consulta_cantidad_productos, (fecha,))
        cantidad_productos = resultado_cantidad_productos[0][0] if resultado_cantidad_productos and resultado_cantidad_productos[0][0] is not None else 0

        consulta_cantidad_ventas = """
            SELECT COUNT(*)
            FROM ventas
            WHERE DATE(fecha) = %s
        """
        resultado_cantidad_ventas = database.ejecutar_consulta(conn, consulta_cantidad_ventas, (fecha,))
        cantidad_ventas = resultado_cantidad_ventas[0][0] if resultado_cantidad_ventas and resultado_cantidad_ventas[0][0] is not None else 0

        conn.close()

        return total_ingresos, cantidad_productos, cantidad_ventas

    else:
        print("Error: No se pudo conectar a la base de datos")
        return 0, 0, 0, 0

def actualizar_ventas_dia(fecha=None): 
    if fecha is None:
        fecha = date.today() 
    total_ingresos, cantidad_productos, cantidad_ventas = obtener_ventas_dia(fecha)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${total_ingresos:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cantidad_productos)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cantidad_ventas)


def obtener_ventas_semana(año, semana):
    conn = database.conectar_db()
    if conn:
        consulta_ingresos = """
            SELECT SUM(total) 
            FROM ventas 
            WHERE EXTRACT(YEAR FROM fecha) = %s AND EXTRACT(WEEK FROM fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_ingresos, (año, semana))
        total_ingresos = resultado[0][0] if resultado and resultado[0][0] else 0

        consulta_cantidad_productos = """
            SELECT SUM(dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            WHERE EXTRACT(YEAR FROM v.fecha) = %s AND EXTRACT(WEEK FROM v.fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_cantidad_productos, (año, semana))
        cantidad_productos = resultado[0][0] if resultado and resultado[0][0] else 0

        consulta_cantidad_ventas = """
            SELECT COUNT(*)
            FROM ventas
            WHERE EXTRACT(YEAR FROM fecha) = %s AND EXTRACT(WEEK FROM fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_cantidad_ventas, (año, semana))
        cantidad_ventas = resultado[0][0] if resultado and resultado[0][0] else 0

        conn.close()

        return total_ingresos, cantidad_productos, cantidad_ventas

    else:
        print("Error: No se pudo conectar a la base de datos")
        return 0, 0, 0
    
def actualizar_ventas_semana(año, semana):
    total_ingresos, cantidad_productos, cantidad_ventas = obtener_ventas_semana(año, semana)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${total_ingresos:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cantidad_productos)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cantidad_ventas)

def obtener_ventas_mes(año, mes):
    conn = database.conectar_db()
    if conn:
        consulta_ingresos = """
            SELECT SUM(total) 
            FROM ventas 
            WHERE EXTRACT(YEAR FROM fecha) = %s AND EXTRACT(MONTH FROM fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_ingresos, (año, mes))
        total_ingresos = resultado[0][0] if resultado and resultado[0][0] else 0

        consulta_cantidad_productos = """
            SELECT SUM(dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            WHERE EXTRACT(YEAR FROM v.fecha) = %s AND EXTRACT(MONTH FROM v.fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_cantidad_productos, (año, mes))
        cantidad_productos = resultado[0][0] if resultado and resultado[0][0] else 0

        consulta_cantidad_ventas = """
            SELECT COUNT(*)
            FROM ventas
            WHERE EXTRACT(YEAR FROM fecha) = %s AND EXTRACT(MONTH FROM fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_cantidad_ventas, (año, mes))
        cantidad_ventas = resultado[0][0] if resultado and resultado[0][0] else 0

        conn.close()

        return total_ingresos, cantidad_productos, cantidad_ventas

    else:
        print("Error: No se pudo conectar a la base de datos")
        return 0, 0, 0

def actualizar_ventas_mes(año, mes):
    total_ingresos, cantidad_productos, cantidad_ventas = obtener_ventas_mes(año, mes)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${total_ingresos:.2f}")
    #data_labels_ventas_dia["Total de ganancias:"].config(text=f"${total_ganancias:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cantidad_productos)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cantidad_ventas)

def obtener_ventas_año(año):
    conn = database.conectar_db()
    if conn:
        consulta_ingresos = """
            SELECT SUM(total) 
            FROM ventas 
            WHERE EXTRACT(YEAR FROM fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_ingresos, (año,))
        total_ingresos = resultado[0][0] if resultado and resultado[0][0] else 0

        consulta_cantidad_productos = """
            SELECT SUM(dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            WHERE EXTRACT(YEAR FROM v.fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_cantidad_productos, (año,))
        cantidad_productos = resultado[0][0] if resultado and resultado[0][0] else 0

        consulta_cantidad_ventas = """
            SELECT COUNT(*)
            FROM ventas
            WHERE EXTRACT(YEAR FROM fecha) = %s
        """
        resultado = database.ejecutar_consulta(conn, consulta_cantidad_ventas, (año,))
        cantidad_ventas = resultado[0][0] if resultado and resultado[0][0] else 0


        conn.close()

        return total_ingresos, cantidad_productos, cantidad_ventas

    else:
        print("Error: No se pudo conectar a la base de datos")
        return 0, 0, 0

def actualizar_ventas_año(año):
    total_ingresos, cantidad_productos, cantidad_ventas = obtener_ventas_año(año)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${total_ingresos:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cantidad_productos)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cantidad_ventas)

# --- Pantalla "Ver Ventas" ---
toolbar_frame = None
title_frame = None
data_frame = None
data_values_frame = None
image_frame = None
photo_ventas = None
data_labels = {}
btn_por_dia = None
btn_por_categoría = None
btn_por_producto = None
btn_por_hora = None
btn_dia = None
btn_semana = None
btn_mes = None
btn_año = None
data_labels_ventas_dia = {}


def mostrar_pantalla_ver_ventas(mostrar_botones=True):
    global toolbar_frame, title_frame, data_frame, data_values_frame, image_frame, photo_ventas, data_labels_ventas_dia, btn_por_dia, btn_por_categoría, btn_por_producto, btn_por_hora, btn_dia, btn_semana, btn_mes, btn_año
    show_frame(reports_frame)

    
    # Colores para la pantalla "Ver Ventas"
    label_bg = "#2980b9"      # Azul oscuro para las etiquetas
    label_fg = "white"        # Texto blanco en las etiquetas
    frame_bg = "#ecf0f1"      # Gris claro para el fondo
    button_bg = "#e67e22"     # Naranja llamativo para los botones
    button_fg = "white"       # Texto blanco en los botones
    highlight_bg = "#f0f0f0"  # Gris muy claro para resaltar
    button_bg_blue = "#1D1454" # Azul marino para los botones extra

    if toolbar_frame is None:
        toolbar_frame = tk.Frame(reports_frame, bg="#1A0038")
        toolbar_frame.pack(pady=(20, 10)) 

        btn_por_dia = tk.Button(toolbar_frame, text="Reporte por venta", command=ver_reportes_ventas, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_por_categoría = tk.Button(toolbar_frame, text="Reporte por categoría", command=mostrar_pantalla_reporte_categoria, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_por_producto = tk.Button(toolbar_frame, text="Reporte por producto", command=mostrar_pantalla_reporte_producto, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_por_hora = tk.Button(toolbar_frame, text="Reporte por hora", command=mostrar_pantalla_reporte_hora, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        
        title_frame = tk.Frame(reports_frame, bg=frame_bg)
        title_frame.pack(fill="none", padx=10, pady=(20, 0)) 

        tk.Label(title_frame, text="Ventas del día", font=("Arial", 24, "bold"), bg="#000000", fg="#FFFFFF").pack()

        data_frame = tk.Frame(reports_frame, bg="#b7fff0")
        data_frame.pack(fill="both", expand=True, padx=120, pady=40)

        
        data_values_frame = tk.Frame(data_frame, bg="#b7fff0")
        data_values_frame.place(relx=0.3, rely=0.45, anchor="center") 

        data_labels_text = ["Total de ingresos:", "Cantidad de productos vendidos:", "Cantidad de ventas realizadas:"]
        for i, label_text in enumerate(data_labels_text):
            frame_dato = tk.Frame(data_values_frame, bg="#b7fff0")
            frame_dato.pack(fill="x", pady=10) 

            label = tk.Label(frame_dato, text=label_text, bg=label_bg, fg=label_fg, font=("Arial", 14, "bold"), width=25, anchor="w")
            label.pack(side="left", padx=5)

            value_label = tk.Label(frame_dato, text="$0.00", bg="#b7fff0", font=("Arial", 14), width=15, anchor="e")
            value_label.pack(side="left", padx=(0, 5))

            data_labels_ventas_dia[label_text] = value_label 

        image_frame = tk.Frame(data_frame, bg="#b7fff0", width=250)
        image_frame.place(relx=0.7, rely=0.5, anchor="center") 

        img = ima.open(resource_path("sales.png"))
        img = img.resize((250, 250), ima.Resampling.LANCZOS)
        photo_ventas = ImageTk.PhotoImage(img)
        tk.Label(image_frame, image=photo_ventas, bg="#b7fff0").pack()

        def mostrar_calendario():
            def seleccionar_fecha():
                fecha_seleccionada = cal.selection_get()
                actualizar_ventas_dia(fecha_seleccionada)  
                top.destroy()

            top = tk.Toplevel(root)
            cal = Calendar(top, font="Arial 14", selectmode='day', year=date.today().year, month=date.today().month, day=date.today().day, headersbackground="lightblue",
               headersforeground="darkblue")
            cal.pack(fill="both", expand=True)
            tk.Button(top, text="Seleccionar Fecha", command=seleccionar_fecha, bg=button_bg, fg=button_fg).pack()

        def mostrar_calendario_semana():
            def seleccionar_semana():
                try:
                    fecha_seleccionada = cal.selection_get()
                    año, semana = fecha_seleccionada.isocalendar()[:2]
                    actualizar_ventas_semana(año, semana)
                    top.destroy()
                except Exception as e:
                    messagebox.showerror("Error", f"Ocurrió un error: {str(e)}")

            top = tk.Toplevel(root)
            cal = Calendar(top, font="Arial 14", selectmode='day', year=date.today().year, month=date.today().month, day=date.today().day, headersbackground="lightblue",
               headersforeground="darkblue")
            cal.pack(fill="both", expand=True)
            tk.Button(top, text="Seleccionar Semana", command=seleccionar_semana, bg=button_bg, fg=button_fg).pack()

        def mostrar_calendario_mes():
            def seleccionar_mes():
                fecha_seleccionada = cal.selection_get()
                año = fecha_seleccionada.year
                mes = fecha_seleccionada.month
                actualizar_ventas_mes(año, mes)
                top.destroy()

            top = tk.Toplevel(root)
            cal = Calendar(top, font="Arial 14", selectmode='day', year=date.today().year, month=date.today().month, day=date.today().day, headersbackground="lightblue",
               headersforeground="darkblue")
            cal.pack(fill="both", expand=True)
            tk.Button(top, text="Seleccionar Mes", command=seleccionar_mes, bg=button_bg, fg=button_fg).pack()

        def mostrar_calendario_año():
            def seleccionar_año():
                fecha_seleccionada = cal.selection_get()
                año = fecha_seleccionada.year
                actualizar_ventas_año(año)
                top.destroy()

            top = tk.Toplevel(root)
            cal = Calendar(top, font="Arial 14", selectmode='day', year=date.today().year, month=date.today().month, day=date.today().day, headersbackground="lightblue",
               headersforeground="darkblue")
            cal.pack(fill="both", expand=True)
            tk.Button(top, text="Seleccionar Año", command=seleccionar_año, bg=button_bg, fg=button_fg).pack()


        bottom_buttons_frame = tk.Frame(reports_frame, bg="#1A0038")
        bottom_buttons_frame.pack(pady=10)  

        btn_dia = tk.Button(bottom_buttons_frame, text="Ventas por día", command=mostrar_calendario, bg=button_bg_blue, fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_semana = tk.Button(bottom_buttons_frame, text="Ventas por semana", command=mostrar_calendario_semana, bg=button_bg_blue, fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_mes = tk.Button(bottom_buttons_frame, text="Ventas por mes", command=mostrar_calendario_mes, bg=button_bg_blue, fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_año = tk.Button(bottom_buttons_frame, text="Ventas por año", command=mostrar_calendario_año, bg=button_bg_blue, fg=button_fg, font=("Arial", 12, "bold"), relief="flat")

        cerrar_button = tk.Button(reports_frame, text="Cerrar panel de ventas", command=lambda: show_frame(welcome_frame), bg=button_bg, fg=button_fg)
        cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)

    if mostrar_botones:
        btn_por_dia.pack(side="left", padx=10)
        btn_por_categoría.pack(side="left", padx=10)
        btn_por_producto.pack(side="left", padx=10)
        btn_por_hora.pack(side="left", padx=10)
        btn_dia.pack(side="left", padx=10)
        btn_semana.pack(side="left", padx=10)
        btn_mes.pack(side="left", padx=10)
        btn_año.pack(side="left", padx=10)
    else:
        btn_por_dia.pack_forget()
        btn_por_categoría.pack_forget()
        btn_por_producto.pack_forget()
        btn_por_hora.pack_forget()
        btn_dia.pack_forget()
        btn_semana.pack_forget()
        btn_mes.pack_forget()
        btn_año.pack_forget()

   
    actualizar_ventas_dia() 

    style = ttk.Style()
    style.configure("TButton", background=button_bg, foreground=button_fg, font=("Arial", 12))

def actualizar_reporte_categoria():
    categoria_seleccionada = combobox_categoria.get()
    fecha_seleccionada = calendario.selection_get()
    periodo = periodo_seleccionado.get()

    if not categoria_seleccionada:
        messagebox.showerror("Error", "Seleccione una categoría.")
        return

    conn = database.conectar_db()
    if not conn:
        messagebox.showerror("Error", "No se pudo conectar a la base de datos.")
        return

    try:
        if periodo == "dia":
            query = """
                SELECT 
                    SUM(dv.cantidad * dv.subtotal) AS total_venta, 
                    SUM(dv.cantidad) AS cantidad_vendida,
                    p.nombre AS producto
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE c.nombre = %s AND DATE(v.fecha) = %s
                GROUP BY p.nombre
                ORDER BY cantidad_vendida DESC
                LIMIT 1;
            """
            params = (categoria_seleccionada, fecha_seleccionada)
        elif periodo == "semana":
            query = """
                SELECT 
                    SUM(dv.cantidad * dv.subtotal) AS total_venta, 
                    SUM(dv.cantidad) AS cantidad_vendida,
                    p.nombre AS producto
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE c.nombre = %s AND EXTRACT(WEEK FROM v.fecha) = EXTRACT(WEEK FROM %s)
                GROUP BY p.nombre
                ORDER BY cantidad_vendida DESC
                LIMIT 1;
            """
            params = (categoria_seleccionada, fecha_seleccionada)
        elif periodo == "mes":
            query = """
                SELECT 
                    SUM(dv.cantidad * dv.subtotal) AS total_venta, 
                    SUM(dv.cantidad) AS cantidad_vendida,
                    p.nombre AS producto
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE c.nombre = %s AND EXTRACT(MONTH FROM v.fecha) = EXTRACT(MONTH FROM %s)
                GROUP BY p.nombre
                ORDER BY cantidad_vendida DESC
                LIMIT 1;
            """
            params = (categoria_seleccionada, fecha_seleccionada)
        elif periodo == "año":
            query = """
                SELECT 
                    SUM(dv.cantidad * dv.subtotal) AS total_venta, 
                    SUM(dv.cantidad) AS cantidad_vendida,
                    p.nombre AS producto
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE c.nombre = %s AND EXTRACT(YEAR FROM v.fecha) = EXTRACT(YEAR FROM %s)
                GROUP BY p.nombre
                ORDER BY cantidad_vendida DESC
                LIMIT 1;
            """
            params = (categoria_seleccionada, fecha_seleccionada)

        cursor = conn.cursor()
        cursor.execute(query, params)
        resultado = cursor.fetchone()
        
        if resultado:
            total_venta, cantidad_vendida, producto_mas_vendido = resultado
            if not total_venta:
                total_venta, cantidad_vendida, producto_mas_vendido = 0, 0, "N/A"

            data_labels["Total de venta:"].config(text=f"${total_venta:,.2f}")
            data_labels["Cantidad de productos vendidos:"].config(text=f"{cantidad_vendida}")
            data_labels["Producto más vendido:"].config(text=f"{producto_mas_vendido}")  
        else:
            data_labels["Total de venta:"].config(text="$0.00")
            data_labels["Cantidad de productos vendidos:"].config(text="0")
            data_labels["Producto más vendido:"].config(text="N/A")

        cursor.close()
    except Exception as e:
        messagebox.showerror("Error", f"Error al obtener los datos: {e}")
    finally:
        conn.close()


# --- Colores para la pantalla "Reporte por Categoría" ---
label_bg2 = "#2980b9"      # Azul oscuro para las etiquetas
label_fg2 = "white"        # Texto blanco en las etiquetas
frame_bg2 = "#ecf0f1"      # Gris claro para el fondo
button_bg2 = "#e67e22"     # Naranja llamativo para los botones
button_fg2 = "white"       # Texto blanco en los botones
highlight_bg2 = "#f0f0f0"  # Gris muy claro para resaltar
button_bg_blue2 = "#1D1454" # Azul marino para los botones extra
combobox_categoria = None
calendario = None
btn_mostrar_resultados = None
right_section_frame = None
tabla_reporte_producto = None
tabla_reporte_hora = None


def mostrar_pantalla_reporte_categoria():
    global combobox_categoria, calendario, periodo_seleccionado, btn_mostrar_resultados, data_labels, data_values_frame, right_section_frame, title_frame, data_frame, toolbar_frame, reporte_categoria_frame

    if reporte_categoria_frame is not None:
        reporte_categoria_frame.destroy()  

    reporte_categoria_frame = tk.Frame(container, bg=frame_bg2)
    reporte_categoria_frame.grid(row=0, column=1, sticky="nsew")

    def resize_background(event):
        global background_image_ref
        width, height = event.width, event.height
        imagen_fondo = ima.open(resource_path("ondo.png")) 
        imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
        background_image_ref = ImageTk.PhotoImage(imagen_fondo)
        background_label_report.config(image=background_image_ref)
        background_label_report.image = background_image_ref  

    background_label_report = tk.Label(reporte_categoria_frame)
    background_label_report.place(x=0, y=0, relwidth=1, relheight=1) 

    reporte_categoria_frame.bind("<Configure>", resize_background)

    show_frame(reporte_categoria_frame)

    if toolbar_frame:
        toolbar_frame = tk.Frame(reporte_categoria_frame, bg="#1A0038")
        toolbar_frame.pack(pady=(20, 10))  

        style = ttk.Style()
        style.configure("TButton", background=button_bg_blue2, foreground=button_fg, font=("Arial", 12, "bold"), padding=10, relief="flat")
        style.map("TButton", background=[("active", "#d35400")])  

        tk.Button(toolbar_frame, text="Reporte por venta", command=ver_reportes_ventas, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por categoría", command=mostrar_pantalla_reporte_categoria, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por producto", command=mostrar_pantalla_reporte_producto, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por hora", command=mostrar_pantalla_reporte_hora, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)   

        
        title_frame = tk.Frame(reporte_categoria_frame, bg=frame_bg)
        title_frame.pack(fill="none", padx=10, pady=(20, 0))

        tk.Label(title_frame, text="Reporte por Categoría", font=("Arial", 24, "bold"), bg="#000000", fg="#FFFFFF").pack()
    
        data_frame = tk.Frame(reporte_categoria_frame, bg="#b7fff0")
        data_frame.pack(fill="both", expand=True, padx=20, pady=20)

        data_values_frame = tk.Frame(data_frame, bg="#b7fff0")
        data_values_frame.place(relx=0.3, rely=0.45, anchor="center")  

        data_labels_text = ["Total de venta:", "Cantidad de productos vendidos:", "Producto más vendido:"]
        
        for i, label_text in enumerate(data_labels_text):
            frame_dato = tk.Frame(data_values_frame, bg="#b7fff0")
            frame_dato.pack(fill="x", pady=10)  

            label = tk.Label(frame_dato, text=label_text, bg=label_bg2, fg=label_fg2, font=("Arial", 12, "bold"), width=25, anchor="w")
            label.pack(side="left", padx=5)

            value_label = tk.Label(frame_dato, text="$0.00", bg="#f9e3e6", font=("Arial", 12), width=25, anchor="e")
            value_label.pack(side="left", padx=(0, 5))

            data_labels[label_text] = value_label


        right_section_frame = tk.Frame(data_frame, bg="#b7fff0")
        right_section_frame.place(relx=0.7, rely=0.5, anchor="center")  

        tk.Label(right_section_frame, text="Categorías:", bg=label_bg2, fg=label_fg2).pack(pady=10)
        combobox_categoria = ttk.Combobox(right_section_frame, state="readonly")
        combobox_categoria.pack()

        tk.Label(right_section_frame, text="Calendario:", bg=label_bg2, fg=label_fg2).pack(pady=10)
        calendario = Calendar(right_section_frame, selectmode='day')
        calendario.pack()

        periodo_seleccionado = tk.StringVar(value="dia")

        period_frame = tk.Frame(right_section_frame, bg="#b7fff0") 
        period_frame.pack(pady=10)

        tk.Radiobutton(period_frame, text="Día", variable=periodo_seleccionado, value="dia", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Semana", variable=periodo_seleccionado, value="semana", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Mes", variable=periodo_seleccionado, value="mes", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Año", variable=periodo_seleccionado, value="año", bg="#b7fff0").pack(side="left", padx=5)

        btn_mostrar_resultados = tk.Button(right_section_frame, text="Mostrar resultados", command=actualizar_reporte_categoria, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_mostrar_resultados.pack(pady=10)

    
        data_values_frame.place(relx=0.3, rely=0.45, anchor="center") 
        right_section_frame.place(relx=0.7, rely=0.5, anchor="center") 

        conn = database.conectar_db()
        if conn:
            categorias = database.ejecutar_consulta(conn, "SELECT id, nombre FROM categorias")
            conn.close()
            nombres_categorias = [categoria[1] for categoria in categorias]
            combobox_categoria['values'] = nombres_categorias 

        cerrar_button = tk.Button(reporte_categoria_frame, text="Cerrar panel de reportes", command=lambda: show_frame(welcome_frame), bg=button_bg, fg=button_fg)
        cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)
    
    else:
        toolbar_frame.pack(pady=(20, 10))
        title_frame.pack(fill="x", padx=10, pady=(20, 0))
        data_frame.pack(fill="both", expand=True, padx=20, pady=20)
        data_values_frame.place(relx=0.3, rely=0.45, anchor="center")
        right_section_frame.place(relx=0.7, rely=0.5, anchor="center")

def actualizar_reporte_producto():
    fecha_seleccionada = calendario.selection_get()
    periodo = periodo_seleccionado.get()

    conn = database.conectar_db()
    if not conn:
        messagebox.showerror("Error", "No se pudo conectar a la base de datos.")
        return

    try:
        if periodo == "dia":
            query = """
                SELECT 
                    p.nombre AS producto,
                    SUM(dv.cantidad) AS cantidad_vendida,
                    SUM(dv.cantidad * dv.subtotal) AS venta_total
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                WHERE DATE(v.fecha) = %s
                GROUP BY p.nombre
            """
            params = (fecha_seleccionada,)
        elif periodo == "semana":
            query = """
                SELECT 
                    p.nombre AS producto,
                    SUM(dv.cantidad) AS cantidad_vendida,
                    SUM(dv.cantidad * dv.subtotal) AS venta_total
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                WHERE EXTRACT(WEEK FROM v.fecha) = EXTRACT(WEEK FROM %s)
                GROUP BY p.nombre
            """
            params = (fecha_seleccionada,)
        elif periodo == "mes":
            query = """
                SELECT 
                    p.nombre AS producto,
                    SUM(dv.cantidad) AS cantidad_vendida,
                    SUM(dv.cantidad * dv.subtotal) AS venta_total
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                WHERE EXTRACT(MONTH FROM v.fecha) = EXTRACT(MONTH FROM %s)
                GROUP BY p.nombre
            """
            params = (fecha_seleccionada,)
        elif periodo == "año":
            query = """
                SELECT 
                    p.nombre AS producto,
                    SUM(dv.cantidad) AS cantidad_vendida,
                    SUM(dv.cantidad * dv.subtotal) AS venta_total
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                JOIN productos p ON dv.id_producto = p.id
                WHERE EXTRACT(YEAR FROM v.fecha) = EXTRACT(YEAR FROM %s)
                GROUP BY p.nombre
            """
            params = (fecha_seleccionada,)

        cursor = conn.cursor()
        cursor.execute(query, params)
        resultados = cursor.fetchall()

        for row in tabla_reporte_producto.get_children():
            tabla_reporte_producto.delete(row)

        for resultado in resultados:
            tabla_reporte_producto.insert("", "end", values=resultado)

        cursor.close()
    except Exception as e:
        messagebox.showerror("Error", f"Error al obtener los datos: {e}")
    finally:
        conn.close()


def mostrar_pantalla_reporte_producto():
    global combobox_categoria, calendario, periodo_seleccionado, btn_mostrar_resultados, data_labels, data_values_frame, right_section_frame, title_frame, data_frame, toolbar_frame, reporte_categoria_frame

    if reporte_categoria_frame is not None:  
        reporte_categoria_frame.destroy() 

    reporte_categoria_frame = tk.Frame(container, bg="#b7fff0")
    reporte_categoria_frame.grid(row=0, column=1, sticky="nsew")

    def resize_background(event):
        global background_image_ref
        width, height = event.width, event.height
        imagen_fondo = ima.open(resource_path("ondo.png"))  
        imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
        background_image_ref = ImageTk.PhotoImage(imagen_fondo)
        background_label_ventas.config(image=background_image_ref)
        background_label_ventas.image = background_image_ref  

    background_label_ventas = tk.Label(reporte_categoria_frame)
    background_label_ventas.place(x=0, y=0, relwidth=1, relheight=1) 

    reporte_categoria_frame.bind("<Configure>", resize_background)

    show_frame(reporte_categoria_frame)

    if toolbar_frame:
        toolbar_frame = tk.Frame(reporte_categoria_frame, bg="#1A0038")
        toolbar_frame.pack(pady=(20, 10))  

        style = ttk.Style()
        style.configure("TButton", background=button_bg_blue2, foreground=button_fg, font=("Arial", 12, "bold"), padding=10, relief="flat")
        style.map("TButton", background=[("active", "#d35400")]) 

        tk.Button(toolbar_frame, text="Reporte por venta", command=ver_reportes_ventas, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por categoría", command=mostrar_pantalla_reporte_categoria, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por producto", command=mostrar_pantalla_reporte_producto, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por hora", command=mostrar_pantalla_reporte_hora, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)   

        
        title_frame = tk.Frame(reporte_categoria_frame, bg=frame_bg)
        title_frame.pack(fill="none", padx=10, pady=(20, 0))

        tk.Label(title_frame, text="Reporte por producto", font=("Arial", 24, "bold"), bg="#000000", fg="#FFFFFF").pack()

    
        data_frame = tk.Frame(reporte_categoria_frame, bg="#b7fff0")
        data_frame.pack(fill="both", expand=True, padx=20, pady=20)

        tabla_frame = tk.Frame(data_frame,bg="#b7fff0")
        tabla_frame.pack(side="left", fill="both", expand=True, padx=20, pady=20)

        style = ttk.Style()

        style.theme_use("clam")  

        style.configure("Treeview.Heading", 
                        background="#2099E7",  
                        foreground="white", 
                        font=("Arial", 14, "bold"),
                        borderwidth=2)

        style.configure("Treeview", 
                        background="#f9e3e6", 
                        foreground="#333333", 
                        fieldbackground="#ffe4b5",  
                        font=("Arial", 12))

        style.map("Treeview", 
                background=[("selected", "#f8546d")], 
                foreground=[("selected", "white")])

        style.layout("Treeview", 
                    [("Treeview.treearea", {"sticky": "nswe"})]) 


        global tabla_reporte_producto
        tabla_reporte_producto = ttk.Treeview(tabla_frame, columns=("Producto", "Cantidad Vendida", "Venta Total"), show="headings", height=15, style="Treeview")
        tabla_reporte_producto.heading("Producto", text="Producto", anchor="center")
        tabla_reporte_producto.heading("Cantidad Vendida", text="Cantidad Vendida", anchor="center")
        tabla_reporte_producto.heading("Venta Total", text="Venta Total", anchor="center")

        tabla_reporte_producto.grid(row=0, column=0, rowspan=2, sticky="nsew", padx=10, pady=10)  

        data_frame.grid_rowconfigure(0, weight=1)  
        data_frame.grid_columnconfigure(0, weight=1) 

        tabla_reporte_producto.column("Producto", width=200, anchor="center", stretch=True)
        tabla_reporte_producto.column("Cantidad Vendida", width=200, anchor="center", stretch=True)
        tabla_reporte_producto.column("Venta Total", width=200, anchor="center", stretch=True)
    
        right_section_frame = tk.Frame(data_frame, bg="#b7fff0")
        right_section_frame.place(relx=0.75, rely=0.5, anchor="center") 

        tk.Label(right_section_frame, text="Calendario:", bg=label_bg2, fg=label_fg2).pack(pady=10)
        calendario = Calendar(right_section_frame, selectmode='day', font=("Arial", 12))
        calendario.pack()

        periodo_seleccionado = tk.StringVar(value="dia")

        period_frame = tk.Frame(right_section_frame, bg="#b7fff0")
        period_frame.pack(pady=10)

        tk.Radiobutton(period_frame, text="Día", variable=periodo_seleccionado, value="dia", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Semana", variable=periodo_seleccionado, value="semana", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Mes", variable=periodo_seleccionado, value="mes", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Año", variable=periodo_seleccionado, value="año", bg="#b7fff0").pack(side="left", padx=5)

        btn_mostrar_resultados = tk.Button(right_section_frame, text="Mostrar resultados", command=actualizar_reporte_producto, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_mostrar_resultados.pack(pady=10)

    
        tabla_reporte_producto.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)
        right_section_frame.place(relx=0.75, rely=0.5, anchor="center") 

        cerrar_button = tk.Button(reporte_categoria_frame, text="Cerrar panel de reportes", command=lambda: show_frame(welcome_frame), bg=button_bg, fg=button_fg)
        cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)
    
    else:
        toolbar_frame.pack(pady=(20, 10))
        title_frame.pack(fill="x", padx=10, pady=(20, 0))
        data_frame.pack(fill="both", expand=True, padx=20, pady=20)
        data_values_frame.place(relx=0.3, rely=0.45, anchor="center")
        right_section_frame.place(relx=0.7, rely=0.5, anchor="center")


def obtener_ventas_por_hora(fecha):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        consulta = """
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id) AS cantidad_ventas, SUM(dv.cantidad) AS cantidad_vendida, 
                   SUM(dv.subtotal * dv.cantidad) AS venta_total
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id
            WHERE DATE(v.fecha) = %s
            GROUP BY hora
            ORDER BY hora
        """
        cursor.execute(consulta, (fecha,))
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    else:
        print("Error: No se pudo conectar a la base de datos")
        return []

def obtener_ventas_por_dia_semana(año, semana):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        consulta = """
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id) AS cantidad_ventas, SUM(dv.cantidad) AS cantidad_vendida, 
                   SUM(dv.subtotal * dv.cantidad) AS venta_total
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id
            WHERE EXTRACT(YEAR FROM v.fecha) = %s AND EXTRACT(WEEK FROM v.fecha) = %s
            GROUP BY hora
            ORDER BY hora
        """
        cursor.execute(consulta, (año, semana))
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    else:
        print("Error: No se pudo conectar a la base de datos")
        return []

def obtener_ventas_por_semana_mes(año, mes):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        consulta = """
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id) AS cantidad_ventas, SUM(dv.cantidad) AS cantidad_vendida, 
                   SUM(dv.subtotal * dv.cantidad) AS venta_total
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id
            WHERE EXTRACT(YEAR FROM v.fecha) = %s AND EXTRACT(MONTH FROM v.fecha) = %s
            GROUP BY hora
            ORDER BY hora
        """
        cursor.execute(consulta, (año, mes))
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    else:
        print("Error: No se pudo conectar a la base de datos")
        return []
    
def obtener_ventas_por_mes_año(año):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        consulta = """
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id) AS cantidad_ventas, SUM(dv.cantidad) AS cantidad_vendida, 
                   SUM(dv.subtotal * dv.cantidad) AS venta_total
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id
            WHERE EXTRACT(YEAR FROM v.fecha) = %s
            GROUP BY hora
            ORDER BY hora
        """
        cursor.execute(consulta, (año,))
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    else:
        print("Error: No se pudo conectar a la base de datos")
        return []

def mostrar_resultados_hora():
    periodo = periodo_seleccionado.get()
    fecha_seleccionada = calendario.selection_get()
    print(f"Fecha seleccionada: {fecha_seleccionada}") 

    if periodo == "dia":
        ventas = obtener_ventas_por_hora(fecha_seleccionada)
        print(f"Datos de ventas por hora: {ventas}")  
        rellenar_tabla(ventas, periodo)
    elif periodo == "semana":
        año, semana = fecha_seleccionada.isocalendar()[:2]
        ventas = obtener_ventas_por_dia_semana(año, semana)
        print(f"Datos de ventas por semana: {ventas}")  
        rellenar_tabla(ventas, periodo)
    elif periodo == "mes":
        año, mes = fecha_seleccionada.year, fecha_seleccionada.month
        ventas = obtener_ventas_por_semana_mes(año, mes)
        print(f"Datos de ventas por mes: {ventas}")  
        rellenar_tabla(ventas, periodo)
    elif periodo == "año":
        año = fecha_seleccionada.year
        ventas = obtener_ventas_por_mes_año(año)
        print(f"Datos de ventas por año: {ventas}")  
        rellenar_tabla(ventas, periodo)

def rellenar_tabla(datos, periodo):
    for item in tabla_reporte_hora.get_children():
        tabla_reporte_hora.delete(item)

    for dato in datos:
        hora = f"{int(dato[0]):02d}:00"
        cantidad_ventas = dato[1]
        cantidad_vendida = dato[2]
        venta_total = dato[3]
        ticket_promedio = venta_total / cantidad_ventas if cantidad_ventas else 0
        ticket_promedio = f"{ticket_promedio:.2f}"
        total_ventas = f"{cantidad_ventas}" 
        tabla_reporte_hora.insert("", "end", values=(hora, cantidad_vendida, venta_total, total_ventas, ticket_promedio))

def mostrar_pantalla_reporte_hora():
    global combobox_categoria, calendario, periodo_seleccionado, btn_mostrar_resultados, data_labels, data_values_frame, right_section_frame, title_frame, data_frame, toolbar_frame, reporte_categoria_frame
    frame_bg = "#ecf0f1"   
    if reporte_categoria_frame is not None: 
        reporte_categoria_frame.destroy()  

    reporte_categoria_frame = tk.Frame(container, bg=frame_bg)
    reporte_categoria_frame.grid(row=0, column=1, sticky="nsew")

    def resize_background(event):
        global background_image_ref
        width, height = event.width, event.height
        imagen_fondo = ima.open(resource_path("ondo.png"))
        imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
        background_image_ref = ImageTk.PhotoImage(imagen_fondo)
        background_label_ventas.config(image=background_image_ref)
        background_label_ventas.image = background_image_ref 

    background_label_ventas = tk.Label(reporte_categoria_frame)
    background_label_ventas.place(x=0, y=0, relwidth=1, relheight=1)

    reporte_categoria_frame.bind("<Configure>", resize_background)

    show_frame(reporte_categoria_frame)

    # Colores para la pantalla "Reporte por Hora"
    label_bg = "#2980b9"      # Azul oscuro para las etiquetas
    label_fg = "white"        # Texto blanco en las etiquetas
    
    button_bg = "#e67e22"     # Naranja llamativo para los botones
    button_fg = "white"       # Texto blanco en los botones
    highlight_bg = "#f0f0f0"  # Gris muy claro para resaltar
    button_bg_blue = "#1D1454" # Azul marino para los botones extra
    table_header_bg = "#34495e"  # Azul oscuro para el encabezado de la tabla
    table_header_fg = "white"    # Texto blanco en el encabezado de la tabla

    if toolbar_frame:
        toolbar_frame = tk.Frame(reporte_categoria_frame, bg="#1A0038")
        toolbar_frame.pack(pady=(20, 10))  

        style = ttk.Style()
        style.configure("TButton", background=button_bg_blue2, foreground=button_fg, font=("Arial", 12, "bold"), padding=10, relief="flat")
        style.map("TButton", background=[("active", "#d35400")])

        tk.Button(toolbar_frame, text="Reporte por venta", command=ver_reportes_ventas, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por categoría", command=mostrar_pantalla_reporte_categoria, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por producto", command=mostrar_pantalla_reporte_producto, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)
        tk.Button(toolbar_frame, text="Reporte por hora", command=mostrar_pantalla_reporte_hora, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(side="left", padx=10)   

        
        title_frame = tk.Frame(reporte_categoria_frame, bg="#b7fff0")
        title_frame.pack(fill="none", padx=10, pady=(20, 0))

        tk.Label(title_frame, text="Reporte por hora", font=("Arial", 24, "bold"), bg="#000000", fg="#FFFFFF").pack()

    
        data_frame = tk.Frame(reporte_categoria_frame, bg="#b7fff0")
        data_frame.pack(fill="both", expand=True, padx=20, pady=20)

        tabla_frame = tk.Frame(data_frame,bg="#b7fff0")
        tabla_frame.pack(side="left", fill="both", expand=True, padx=20, pady=20)

        global tabla_reporte_hora
        tabla_reporte_hora = ttk.Treeview(tabla_frame, columns=("Hora", "Cantidad Vendida", "Venta Total", "Total de ventas", "Ticket Promedio"), show="headings",height=15)
        tabla_reporte_hora.heading("Hora", text="Hora", anchor="center")
        tabla_reporte_hora.heading("Cantidad Vendida", text="Cantidad Vendida", anchor="center")
        tabla_reporte_hora.heading("Venta Total", text="Venta Total", anchor="center")
        tabla_reporte_hora.heading("Total de ventas", text="Total de ventas", anchor="center")
        tabla_reporte_hora.heading("Ticket Promedio", text="Ticket Promedio", anchor="center")

        tabla_reporte_hora.grid(row=0, column=0, rowspan=10, sticky="nsew", padx=10, pady=10)

        data_frame.grid_rowconfigure(0, weight=1)  
        data_frame.grid_columnconfigure(0, weight=1) 
        data_frame.grid_columnconfigure(1, weight=1)  

        tabla_reporte_hora.column("Hora", width=80, anchor="center", stretch=True)
        tabla_reporte_hora.column("Cantidad Vendida", width=150, anchor="center", stretch=True)
        tabla_reporte_hora.column("Venta Total", width=150, anchor="center", stretch=True)
        tabla_reporte_hora.column("Total de ventas", width=150, anchor="center", stretch=True)
        tabla_reporte_hora.column("Ticket Promedio", width=150, anchor="center", stretch=True)

        style = ttk.Style()
        style.theme_use("default")
        style.configure("Treeview.Heading", background=table_header_bg, foreground=table_header_fg, font=("Arial", 10, "bold"))


        right_section_frame = tk.Frame(data_frame, bg="#b7fff0")
        right_section_frame.place(relx=0.75, rely=0.5, anchor="center")  

        tk.Label(right_section_frame, text="Calendario:", bg=label_bg2, fg=label_fg2).pack(pady=10)
        calendario = Calendar(right_section_frame, selectmode='day', font=("Arial", 12))
        calendario.pack()

        periodo_seleccionado = tk.StringVar(value="dia")

        period_frame = tk.Frame(right_section_frame, bg="#b7fff0") 
        period_frame.pack(pady=10)

        tk.Radiobutton(period_frame, text="Día", variable=periodo_seleccionado, value="dia", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Semana", variable=periodo_seleccionado, value="semana", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Mes", variable=periodo_seleccionado, value="mes", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Año", variable=periodo_seleccionado, value="año", bg="#b7fff0").pack(side="left", padx=5)

        btn_mostrar_resultados = tk.Button(right_section_frame, text="Mostrar resultados", command=mostrar_resultados_hora, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat")
        btn_mostrar_resultados.pack(pady=10)

    
        tabla_reporte_hora.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)
        right_section_frame.place(relx=0.75, rely=0.5, anchor="center") 

        cerrar_button = tk.Button(reporte_categoria_frame, text="Cerrar panel de reportes", command=lambda: show_frame(welcome_frame), bg=button_bg, fg=button_fg)
        cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)

    else:
        toolbar_frame.pack(pady=(20, 10))
        title_frame.pack(fill="x", padx=10, pady=(20, 0))
        data_frame.pack(fill="both", expand=True, padx=20, pady=20)
        data_values_frame.place(relx=0.3, rely=0.45, anchor="center")
        right_section_frame.place(relx=0.7, rely=0.5, anchor="center")

#Gráfico de barras
def obtener_ventas_totales_por_hora(fecha):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            
            consulta = """
                SELECT EXTRACT(HOUR FROM fecha) AS hora, SUM(total) AS total_ventas
                FROM ventas
                WHERE DATE(fecha) = %s
                GROUP BY EXTRACT(HOUR FROM fecha)
                ORDER BY EXTRACT(HOUR FROM fecha)
            """
            cursor.execute(consulta, (fecha,))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []


def obtener_ventas_diarias_semana(año, semana):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT EXTRACT(DOW FROM fecha) AS dia_semana, SUM(total) AS total_ventas
                FROM ventas
                WHERE EXTRACT(YEAR FROM fecha) = %s AND EXTRACT(WEEK FROM fecha) = %s
                GROUP BY EXTRACT(DOW FROM fecha)
                ORDER BY EXTRACT(DOW FROM fecha)
            """
            cursor.execute(consulta, (año, semana))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []
    
def obtener_ventas_totales_semana_mes(año, mes):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT EXTRACT(WEEK FROM fecha) AS semana, SUM(total) AS total_ventas
                FROM ventas
                WHERE EXTRACT(YEAR FROM fecha) = %s AND EXTRACT(MONTH FROM fecha) = %s
                GROUP BY EXTRACT(WEEK FROM fecha)
                ORDER BY EXTRACT(WEEK FROM fecha)
            """
            cursor.execute(consulta, (año, mes))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []


def obtener_ventas_totales_mes_año(año):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT EXTRACT(MONTH FROM fecha) AS mes, SUM(total) AS total_ventas
                FROM ventas
                WHERE EXTRACT(YEAR FROM fecha) = %s
                GROUP BY EXTRACT(MONTH FROM fecha)
                ORDER BY EXTRACT(MONTH FROM fecha)
            """
            cursor.execute(consulta, (año,))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []

#Gráficos de pastel
def obtener_ventas_totales_por_hora_pastel(fecha):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            
            consulta = """
                SELECT c.nombre AS categoria, SUM(total) AS total_ventas
                FROM ventas v
                JOIN detalle_ventas dv ON v.id = dv.id_venta
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE DATE(v.fecha) = %s
                GROUP BY c.nombre
            """
            cursor.execute(consulta, (fecha,))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []


def obtener_ventas_diarias_semana_pastel(año, semana):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT c.nombre AS categoria, SUM(total) AS total_ventas
                FROM ventas v
                JOIN detalle_ventas dv ON v.id = dv.id_venta
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE EXTRACT(YEAR FROM v.fecha) = %s AND EXTRACT(WEEK FROM v.fecha) = %s
                GROUP BY c.nombre
            """
            cursor.execute(consulta, (año, semana))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []
    
def obtener_ventas_totales_semana_mes_pastel(año, mes):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT c.nombre AS categoria, SUM(total) AS total_ventas
                FROM ventas v
                JOIN detalle_ventas dv ON v.id = dv.id_venta
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE EXTRACT(YEAR FROM v.fecha) = %s AND EXTRACT(MONTH FROM v.fecha) = %s
                GROUP BY c.nombre
            """
            cursor.execute(consulta, (año, mes))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []


def obtener_ventas_totales_mes_año_pastel(año):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT c.nombre AS categoria, SUM(total) AS total_ventas
                FROM ventas v
                JOIN detalle_ventas dv ON v.id = dv.id_venta
                JOIN productos p ON dv.id_producto = p.id
                JOIN categorias c ON p.id_categoria = c.id
                WHERE EXTRACT(YEAR FROM v.fecha) = %s
                GROUP BY c.nombre
            """
            cursor.execute(consulta, (año,))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []

#Gráficos de líneas
def obtener_ventas_totales_por_hora_lineas(fecha):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            
            consulta = """
                SELECT EXTRACT(HOUR FROM v.fecha) AS hora, SUM(dv.cantidad * dv.subtotal) AS total_venta
                FROM detalle_ventas dv
                JOIN ventas v ON dv.id_venta = v.id
                WHERE DATE(v.fecha) = %s
                GROUP BY EXTRACT(HOUR FROM v.fecha)
                ORDER BY hora
            """
            cursor.execute(consulta, (fecha,))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []


def obtener_ventas_diarias_semana_lineas(año, semana):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT EXTRACT(DOW FROM fecha) AS dia_semana, SUM(total) AS total_ventas
                FROM ventas
                WHERE EXTRACT(YEAR FROM fecha) = %s AND EXTRACT(WEEK FROM fecha) = %s
                GROUP BY EXTRACT(DOW FROM fecha)
                ORDER BY EXTRACT(DOW FROM fecha)
            """
            cursor.execute(consulta, (año, semana))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []
    
def obtener_ventas_totales_semana_mes_lineas(año, mes):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT DATE_PART('day', v.fecha) AS dia_mes, SUM(v.total) AS total_ventas
                FROM ventas v
                WHERE EXTRACT(YEAR FROM v.fecha) = %s AND EXTRACT(MONTH FROM v.fecha) = %s
                GROUP BY DATE_PART('day', v.fecha)
                ORDER BY DATE_PART('day', v.fecha)
            """
            cursor.execute(consulta, (año, mes))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []


def obtener_ventas_totales_mes_año_lineas(año):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()

            consulta = """
                SELECT DATE_PART('month', v.fecha) AS mes, SUM(v.total) AS total_ventas
                FROM ventas v
                WHERE EXTRACT(YEAR FROM v.fecha) = %s
                GROUP BY DATE_PART('month', v.fecha)
                ORDER BY DATE_PART('month', v.fecha)
            """
            cursor.execute(consulta, (año,))
            resultados = cursor.fetchall()
            cursor.close()
            conn.close()
            return resultados
        else:
            print("Error: No se pudo conectar a la base de datos")
            return []
    except Exception as e:
        print(f"Error al ejecutar consulta: {e}")
        return []

graphs_frame = None
graph_area = None
def mostrar_bienvenida_graficos():
    global graphs_frame  
    global graph_area
    tipo_grafico_seleccionado = tk.StringVar(value="barras") 
    # Paleta de colores
    bg_color = "#f9e3e6"  # Azul oscuro de fondo
    title_color = "#FFFFFF"  # Blanco para el título
    label_bg = "#3498db"    # Azul claro para las etiquetas
    label_fg = "white"      # Texto blanco en las etiquetas
    button_bg = "#e67e22"   # Naranja para los botones
    button_fg = "white"     # Texto blanco en los botones
    frame_bg = "#f9e3e6"    # Gris claro para los frames
    
    if graphs_frame is None:  
        graphs_frame = tk.Frame(container, bg=frame_bg)
        graphs_frame.grid(row=0, column=1, sticky="nsew") 
        
        def resize_background(event):
            global background_image_ref
            width, height = event.width, event.height
            imagen_fondo = ima.open(resource_path("ondo.png"))  
            imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
            background_image_ref = ImageTk.PhotoImage(imagen_fondo)
            background_label_ventas.config(image=background_image_ref)
            background_label_ventas.image = background_image_ref 

        background_label_ventas = tk.Label(graphs_frame)
        background_label_ventas.place(x=0, y=0, relwidth=1, relheight=1) 

        graphs_frame.bind("<Configure>", resize_background)

        title_label = tk.Label(graphs_frame, text="Bienvenido a la sección de análisis de ventas", font=("Arial", 24, "bold"), bg="#3e0d3c", fg=title_color)
        title_label.pack(pady=(20, 10)) 

        description_label = tk.Label(graphs_frame, text="Explora tus datos de ventas en diferentes formatos y períodos de tiempo", font=("Arial", 14), bg="#3e0d3c", fg=title_color)
        description_label.pack()

        main_frame = tk.Frame(graphs_frame, bg=frame_bg)
        main_frame.pack(fill="both", expand=True)

        def resize_background(event):
            global background_image_ref
            width, height = event.width, event.height
            imagen_fondo = ima.open(resource_path("ondo_c.jpg")) 
            imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
            background_image_ref = ImageTk.PhotoImage(imagen_fondo)
            background_label_ventas5.config(image=background_image_ref)
            background_label_ventas5.image = background_image_ref  

        background_label_ventas5 = tk.Label(main_frame)
        background_label_ventas5.place(x=0, y=0, relwidth=1, relheight=1) 

        main_frame.bind("<Configure>", resize_background)

        left_frame = tk.Frame(main_frame, bg=bg_color)
        left_frame.pack(side="left", fill="both", expand=True, padx=20, pady=20)

        selection_frame = tk.Frame(left_frame, bg=bg_color)
        selection_frame.pack(pady=10)

        tk.Label(selection_frame, text="Selecciona el tipo de gráfico:", bg=label_bg, fg=label_fg).pack()

        button_frame = tk.Frame(selection_frame, bg="#f9e3e6")
        button_frame.pack()

        def mostrar_resultados():
            periodo = periodo_seleccionado.get()
            fecha_seleccionada = calendario.selection_get()
            print(f"Fecha seleccionada: {fecha_seleccionada}")  

            if tipo_grafico_seleccionado.get() == "barras":
                if periodo == "dia":
                    ventas = obtener_ventas_totales_por_hora(fecha_seleccionada)
                    print(f"Datos de ventas por hora: {ventas}")  
                    mostrar_grafico_barras_por_hora(ventas, "Ventas por Hora")
                elif periodo == "semana":
                    año, semana = fecha_seleccionada.isocalendar()[:2]
                    ventas = obtener_ventas_diarias_semana(año, semana)
                    print(f"Datos de ventas por semana: {ventas}")  
                    mostrar_grafico_barras_semana(ventas, "Ventas por Semana")
                elif periodo == "mes":
                    año, mes = fecha_seleccionada.year, fecha_seleccionada.month
                    ventas = obtener_ventas_totales_semana_mes(año, mes)
                    print(f"Datos de ventas por mes: {ventas}")  
                    mostrar_grafico_barras_semana_mes(ventas, "Ventas por Semana en el Mes")
                elif periodo == "año":
                    año = fecha_seleccionada.year
                    ventas = obtener_ventas_totales_mes_año(año)
                    print(f"Datos de ventas por año: {ventas}")  
                    mostrar_grafico_barras_mes_año(ventas, "Ventas por Mes en el Año")
            elif tipo_grafico_seleccionado.get() == "lineas":
                if periodo == "dia":
                    ventas = obtener_ventas_totales_por_hora_lineas(fecha_seleccionada)
                    print(f"Datos de ventas por hora: {ventas}")  
                    mostrar_grafico_lineas(ventas, "Ventas por día")
                elif periodo == "semana":
                    año, semana = fecha_seleccionada.isocalendar()[:2]
                    ventas = obtener_ventas_diarias_semana_lineas(año, semana)
                    print(f"Datos de ventas por semana: {ventas}")  
                    mostrar_grafico_lineas(ventas, "Ventas por semana")
                elif periodo == "mes":
                    año, mes = fecha_seleccionada.year, fecha_seleccionada.month
                    ventas = obtener_ventas_totales_semana_mes_lineas(año, mes)
                    print(f"Datos de ventas por mes: {ventas}")  
                    mostrar_grafico_lineas(ventas, "Ventas por mes")
                elif periodo == "año":
                    año = fecha_seleccionada.year
                    ventas = obtener_ventas_totales_mes_año_lineas(año)
                    print(f"Datos de ventas por año: {ventas}")  
                    mostrar_grafico_lineas(ventas, "Ventas por año")
            elif tipo_grafico_seleccionado.get() == "pastel":
                if periodo == "dia":
                    ventas = obtener_ventas_totales_por_hora_pastel(fecha_seleccionada)
                    print(f"Datos de ventas por hora: {ventas}")  
                    mostrar_grafico_pastel(ventas)
                elif periodo == "semana":
                    año, semana = fecha_seleccionada.isocalendar()[:2]
                    ventas = obtener_ventas_diarias_semana_pastel(año, semana)
                    print(f"Datos de ventas por semana: {ventas}")  
                    mostrar_grafico_pastel(ventas)
                elif periodo == "mes":
                    año, mes = fecha_seleccionada.year, fecha_seleccionada.month
                    ventas = obtener_ventas_totales_semana_mes_pastel(año, mes)
                    print(f"Datos de ventas por mes: {ventas}")  
                    mostrar_grafico_pastel(ventas)
                elif periodo == "año":
                    año = fecha_seleccionada.year
                    ventas = obtener_ventas_totales_mes_año_pastel(año)
                    print(f"Datos de ventas por año: {ventas}")  
                    mostrar_grafico_pastel(ventas)

        tk.Radiobutton(button_frame, text="Gráfico de barras", variable=tipo_grafico_seleccionado, value="barras", bg ="#f9e3e6").pack(side="left", padx=5)
        tk.Radiobutton(button_frame, text="Gráfico de líneas", variable=tipo_grafico_seleccionado, value="lineas", bg ="#f9e3e6").pack(side="left", padx=5)
        tk.Radiobutton(button_frame, text="Gráfico de pastel", variable=tipo_grafico_seleccionado, value="pastel", bg ="#f9e3e6").pack(side="left", padx=5)

        calendar_frame = tk.Frame(left_frame, bg=bg_color)
        calendar_frame.pack(pady=10)

        tk.Label(calendar_frame, text="Calendario:", bg=label_bg, fg=label_fg).pack()
        calendario = Calendar(calendar_frame, selectmode='day')
        calendario.pack()

        period_frame = tk.Frame(left_frame, bg=bg_color)
        period_frame.pack(pady=10)

        periodo_seleccionado = tk.StringVar(value="dia")

        tk.Radiobutton(period_frame, text="Día", variable=periodo_seleccionado, value="dia", bg=frame_bg, activebackground=button_bg, activeforeground=button_fg).pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Semana", variable=periodo_seleccionado, value="semana", bg=frame_bg, activebackground=button_bg, activeforeground=button_fg).pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Mes", variable=periodo_seleccionado, value="mes", bg=frame_bg, activebackground=button_bg, activeforeground=button_fg).pack(side="left", padx=5)
        tk.Radiobutton(period_frame, text="Año", variable=periodo_seleccionado, value="año", bg=frame_bg, activebackground=button_bg, activeforeground=button_fg).pack(side="left", padx=5)

        tk.Button(left_frame, text="Mostrar Resultados", command=mostrar_resultados, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(pady=10)

        graph_area = tk.Frame(main_frame, bg=frame_bg) 
        graph_area.pack(side="right", fill="both", expand=True, padx=20, pady=20)

        cerrar_button = tk.Button(graphs_frame, text="Cerrar panel de reportes", command=lambda: show_frame(welcome_frame), bg=button_bg, fg=button_fg)
        cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)  
        
    show_frame(graphs_frame) 

def mostrar_grafico_pastel(datos):
    for widget in graph_area.winfo_children():
        widget.destroy()

    if not datos:
        return

    categorias = [dato[0] for dato in datos]
    ventas = [dato[1] for dato in datos]

    fig, ax = plt.subplots(figsize=(8, 6))
    
    colores = ['#692395','#2DB89C','#2ED920','#EF4A11','#213EB2','#AF197D','#D60C0C','#D7DA10']
    
    explode = [0.1 if i == max(ventas) else 0 for i in ventas]
    
    wedges, texts, autotexts = ax.pie(
        ventas, 
        labels=categorias, 
        autopct='%1.1f%%', 
        startangle=140, 
        colors=colores, 
        shadow=True, 
        explode=explode
    )
    
    plt.setp(texts, size=8, weight='bold', color='black')
    plt.setp(autotexts, size=8, weight='bold', color='white')
    
    ax.axis('equal') 
    ax.set_title('Distribución de Ventas por Categoría', fontsize=14, weight='bold')
    
    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill=tk.BOTH, expand=True)

def mostrar_grafico_barras_por_hora(datos, titulo):
    for widget in graph_area.winfo_children():
        widget.destroy()

    horas = {hora: 0 for hora in range(6, 25)}

    for dato in datos:
        hora, total_ventas = dato
        if 6 <= hora < 24:
            horas[hora] = total_ventas

    periodos = [f"{hora}" for hora in horas.keys()]
    ventas = list(horas.values())

    fig, ax = plt.subplots(figsize=(8, 6)) 
    
    bars = ax.bar(periodos, ventas, color="#10AF7A")
    
    ax.set_xlabel("Hora", fontsize=12, weight='bold')
    ax.set_ylabel("Ventas Totales", fontsize=12, weight='bold')
    ax.set_title(titulo, fontsize=14, weight='bold')
    
    ax.grid(True, linestyle='--', alpha=0.7)

    for bar in bars:
        yval = bar.get_height()
        ax.text(bar.get_x() + bar.get_width()/2, yval + 1, int(yval), ha='center', va='bottom', fontsize=10, weight='bold')


    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)

def mostrar_grafico_barras_semana(datos, titulo):
    for widget in graph_area.winfo_children():
        widget.destroy()

    dias_semana = {i: 0 for i in range(7)}

    for dato in datos:
        dia_semana, total_ventas = dato
        dias_semana[dia_semana] = total_ventas

    periodos = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"]
    ventas = [dias_semana[i] for i in range(7)]

    fig, ax = plt.subplots(figsize=(8, 6)) 
    
    bars = ax.bar(periodos, ventas, color="#10AF7A")
    
    ax.set_xlabel("Hora", fontsize=12, weight='bold')
    ax.set_ylabel("Ventas Totales", fontsize=12, weight='bold')
    ax.set_title(titulo, fontsize=14, weight='bold')
    
    ax.grid(True, linestyle='--', alpha=0.7)
    
    for bar in bars:
        yval = bar.get_height()
        ax.text(bar.get_x() + bar.get_width()/2, yval + 1, int(yval), ha='center', va='bottom', fontsize=10, weight='bold')

    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)

def mostrar_grafico_barras_semana_mes(datos, titulo):
    for widget in graph_area.winfo_children():
        widget.destroy()

    semanas = [f"Semana {int(dato[0])}" for dato in datos]
    ventas = [dato[1] for dato in datos]

    fig, ax = plt.subplots(figsize=(8, 6)) 
    
    bars = ax.bar(semanas, ventas, color="#10AF7A")
    
    ax.set_xlabel("Hora", fontsize=12, weight='bold')
    ax.set_ylabel("Ventas Totales", fontsize=12, weight='bold')
    ax.set_title(titulo, fontsize=14, weight='bold')
    
    ax.grid(True, linestyle='--', alpha=0.7)
    
    for bar in bars:
        yval = bar.get_height()
        ax.text(bar.get_x() + bar.get_width()/2, yval + 1, int(yval), ha='center', va='bottom', fontsize=10, weight='bold')


    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)

def mostrar_grafico_barras_mes_año(datos, titulo):
    for widget in graph_area.winfo_children():
        widget.destroy()

    meses = [f"Mes {int(dato[0])}" for dato in datos]
    ventas = [dato[1] for dato in datos]

    fig, ax = plt.subplots(figsize=(8, 6)) 
    
    bars = ax.bar(meses, ventas, color="#10AF7A")
    
    ax.set_xlabel("Hora", fontsize=12, weight='bold')
    ax.set_ylabel("Ventas Totales", fontsize=12, weight='bold')
    ax.set_title(titulo, fontsize=14, weight='bold')
    
    ax.grid(True, linestyle='--', alpha=0.7)
    
    for bar in bars:
        yval = bar.get_height()
        ax.text(bar.get_x() + bar.get_width()/2, yval + 1, int(yval), ha='center', va='bottom', fontsize=10, weight='bold')



    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)

def mostrar_grafico_lineas(datos, titulo):
    for widget in graph_area.winfo_children():
        widget.destroy()

    periodos = [str(dato[0]) for dato in datos]
    ventas = [dato[1] for dato in datos]

    fig, ax = plt.subplots(figsize=(8, 6)) 
    
    ax.plot(periodos, ventas, marker='o', linestyle='-', color='#1f77b4', linewidth=2, markersize=6, markerfacecolor='red', markeredgewidth=2, markeredgecolor='black')
    
    ax.set_xlabel("Período", fontsize=12, weight='bold')
    ax.set_ylabel("Ventas Totales", fontsize=12, weight='bold')
    ax.set_title(titulo, fontsize=14, weight='bold')
    
    ax.grid(True, linestyle='--', alpha=0.7)
    
    for i, txt in enumerate(ventas):
        ax.annotate(txt, (periodos[i], ventas[i]), textcoords="offset points", xytext=(0,10), ha='center', fontsize=10, weight='bold')

    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)

inventario_frame = None
tabla_inventario = None
entry_busqueda_inventario = None
combobox_categoria_inventario = None
combobox_proveedor_inventario = None
check_stock_bajo = None
check_agotados = None
entry_editor = None  

def mostrar_pantalla_inventario():
    global inventario_frame, tabla_inventario, entry_busqueda_inventario, combobox_categoria_inventario, combobox_proveedor_inventario, check_stock_bajo, check_agotados
    
    # Paleta de colores
    bg_color = "#2980b9"  # Azul oscuro de fondo
    title_color = "#FFFFFF"  # Blanco para el título
    label_bg = "#3498db"    # Azul claro para las etiquetas
    label_fg = "white"      # Texto blanco en las etiquetas
    button_bg = "#e67e22"   # Naranja para los botones
    button_fg = "white"     # Texto blanco en los botones
    frame_bg = "#ecf0f1"    # Gris claro para los frames

    if inventario_frame is None:  
        inventario_frame = tk.Frame(container, bg=frame_bg)
        inventario_frame.grid(row=0, column=1, sticky="nsew")

        canvas = tk.Canvas(inventario_frame, width=800, height=900)
        canvas.pack(fill="both", expand=True)

        bg_image = ima.open(resource_path("ondo_c.jpg")) 
        bg_image = bg_image.resize((250,350), ima.Resampling.LANCZOS) 
        bg_photo = ImageTk.PhotoImage(bg_image)

        canvas.create_image(0, 0, anchor="nw", image=bg_photo)

        def ajustar_fondo(event=None):
            nueva_imagen = bg_image.resize((inventario_frame.winfo_width(), inventario_frame.winfo_height()), ima.Resampling.LANCZOS)
            canvas.bg_photo = ImageTk.PhotoImage(nueva_imagen) 
            canvas.create_image(0, 0, anchor="nw", image=canvas.bg_photo)

        ajustar_fondo()

        inventario_frame.bind("<Configure>", ajustar_fondo)

        toolbar_inventario = tk.Frame(canvas, bg="#3e0d3c")
        toolbar_inventario.pack(fill="x", padx=10, pady=10)

        tk.Label(toolbar_inventario, text="Buscar:", bg=label_bg, fg=label_fg).pack(side="left", padx=5)
        entry_busqueda_inventario = tk.Entry(toolbar_inventario)
        entry_busqueda_inventario.pack(side="left", fill="x", expand=True, padx=5)
        

        tk.Button(toolbar_inventario, text="Buscar", command=lambda: actualizar_tabla_inventariado(termino_busqueda='a'), bg=button_bg, fg=button_fg).pack(side="left", padx=5)
        tk.Button(toolbar_inventario, text="Refrescar", command=refrescar_tabla_inventario, bg=button_bg, fg=button_fg).pack(side="left", padx=5)

        filtro_frame = tk.Frame(canvas, bg="#3e0d3c")
        filtro_frame.pack(fill="x", padx=10, pady=(0, 10)) 

        tk.Label(filtro_frame, text="Categoría:", bg=label_bg, fg=label_fg).pack(side="left", padx=5)
        combobox_categoria_inventario = ttk.Combobox(filtro_frame, values=["Todas las categorías"], state="readonly")
        combobox_categoria_inventario.current(0)  
        combobox_categoria_inventario.pack(side="left", padx=5)

        def gestionar_checkboxes(*args):
            if check_stock_bajo.get() and check_agotados.get():
                if args[0] == str(check_stock_bajo):
                    check_agotados.set(False)
                elif args[0] == str(check_agotados):
                    check_stock_bajo.set(False)

        check_stock_bajo = tk.BooleanVar()
        check_agotados = tk.BooleanVar()

        check_stock_bajo.trace_add("write", gestionar_checkboxes)
        check_agotados.trace_add("write", gestionar_checkboxes)

        tk.Checkbutton(filtro_frame, text="Stock Bajo", variable=check_stock_bajo, bg=frame_bg).pack(side="left", padx=5)
        tk.Checkbutton(filtro_frame, text="Agotados", variable=check_agotados, bg=frame_bg).pack(side="left", padx=5)

        style = ttk.Style()

        style.theme_use("clam")

        style.configure("Treeview",
                        background="white",
                        foreground="black",
                        rowheight=25,
                        fieldbackground="white",
                        bordercolor="#d9d9d9",
                        borderwidth=2,
                        font=('Arial', 10))

        style.configure("Treeview.Heading",
                        background="#00A3A3",
                        foreground="white",
                        font=('Arial', 12, 'bold'))

        style.map("Treeview",
                background=[('selected', '#00A697')],
                foreground=[('selected', 'white')])


        tabla_inventario = ttk.Treeview(canvas, columns=("ID", "Nombre", "Categoría", "Precio", "Stock"), show="headings", style="Treeview")
        tabla_inventario.heading("ID", text="ID", anchor="center")
        tabla_inventario.heading("Nombre", text="Nombre", anchor="center")
        tabla_inventario.heading("Categoría", text="Categoría", anchor="center")
        tabla_inventario.heading("Precio", text="Precio Compra", anchor="center")
        tabla_inventario.heading("Stock", text="Stock", anchor="center")

        tabla_inventario.bind('<Double-1>', editar_celda)

        tabla_inventario.pack(fill="both", expand=True, padx=10, pady=10)

        for col in tabla_inventario["columns"]:
            tabla_inventario.column(col, anchor="center", width=150)

        actualizar_button = tk.Button(canvas, text="Actualizar inventario", command=actualizar_inventario, bg=button_bg, fg=button_fg)
        actualizar_button.pack(side="bottom", pady=10)

        cerrar_button = tk.Button(canvas, text="Cerrar panel de inventario", command=lambda: show_frame(welcome_frame), bg=button_bg, fg=button_fg)
        cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)

        cargar_productos_en_tabla()

    show_frame(inventario_frame)

def actualizar_inventario():
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        
        for item in tabla_inventario.get_children():
            valores = tabla_inventario.item(item, 'values')
            id_producto = valores[0]
            nuevo_stock = valores[4]

            cursor.execute("SELECT stock FROM productos WHERE id = %s", (id_producto,))
            stock_actual = cursor.fetchone()[0]

            if stock_actual != int(nuevo_stock):
                cursor.execute("UPDATE productos SET stock = %s WHERE id = %s", (nuevo_stock, id_producto))
        
        conn.commit()
        cursor.close()
        conn.close()
        tk.messagebox.showinfo("Actualización de Inventario", "El inventario ha sido actualizado exitosamente.")


def editar_celda(event):
    global entry_editor
    item = tabla_inventario.identify('item', event.x, event.y)
    column = tabla_inventario.identify('column', event.x, event.y)

    if column == '#5': 
        if entry_editor:
            entry_editor.destroy()

        entry_editor = tk.Entry(tabla_inventario)
        entry_editor.place(x=event.x, y=event.y, anchor="center")
        entry_editor.insert(0, tabla_inventario.item(item, 'values')[4])

        def on_return(event):
            new_value = entry_editor.get()
            tabla_inventario.item(item, values=(tabla_inventario.item(item, 'values')[:4] + (new_value,) + tabla_inventario.item(item, 'values')[5:]))
            entry_editor.destroy()

        entry_editor.bind('<Return>', on_return)

        def destroy_entry(event):
            if entry_editor:
                entry_editor.destroy()

        tabla_inventario.bind('<Button-1>', destroy_entry)


def actualizar_tabla_inventariado(termino_busqueda=None):

    global tabla_inventario, combobox_categoria_inventario, check_agotados, entry_busqueda_inventario, check_stock_bajo

    for item in tabla_inventario.get_children():
        tabla_inventario.delete(item)

    conn = database.conectar_db()
    if conn:
        consulta = """
            SELECT p.id, p.nombre, c.nombre, p.precio, p.stock
            FROM productos p
            JOIN categorias c ON p.id_categoria = c.id
        """

        parametros = []
        condiciones = []

        if termino_busqueda:
            termino = entry_busqueda_inventario.get()
            condiciones.append("LOWER(p.nombre) LIKE %s")
            parametros.append(f"%{termino.lower()}%")

        if combobox_categoria_inventario.get() != "Todas las categorías":
            condiciones.append("c.nombre = %s")
            parametros.append(combobox_categoria_inventario.get())

        if check_agotados.get():
            condiciones.append("p.stock = 0")
        
        if check_stock_bajo.get():
            condiciones.append("p.stock < 5")

        if condiciones:
            consulta += " WHERE " + " AND ".join(condiciones)

        consulta += " ORDER BY p.id"

        productos = database.ejecutar_consulta(conn, consulta, parametros)

        for producto in productos:
            tabla_inventario.insert("", tk.END, values=producto)

        conn.close()

def refrescar_tabla_inventario():

    global combobox_categoria_inventario, check_agotados, check_stock_bajo, entry_busqueda_inventario

    combobox_categoria_inventario.set("Todas las categorías")
    check_agotados.set(0)  
    check_stock_bajo.set(0)
    entry_busqueda_inventario.delete(0, tk.END)  

    actualizar_tabla_inventariado()


def buscar_producto_inventario():
    global tabla_inventario, entry_busqueda_inventario
    termino = entry_busqueda_inventario.get().lower() 

    conn = database.conectar_db()
    if conn:
        consulta = """
            SELECT p.id, p.nombre, c.nombre, p.precio, p.stock
            FROM productos p
            JOIN categorias c ON p.id_categoria = c.id
            WHERE LOWER(p.nombre) LIKE %s
            ORDER BY p.id
        """
        parametros = (f"%{termino}%",) 
        productos = database.ejecutar_consulta(conn, consulta, parametros)
        conn.close()

        for item in tabla_inventario.get_children():
            tabla_inventario.delete(item)
        for producto in productos:
            tabla_inventario.insert("", tk.END, values=producto)

def cargar_productos_en_tabla():
    global combobox_categoria_inventario, combobox_proveedor_inventario, tabla_inventario, check_stock_bajo, check_agotados

    for item in tabla_inventario.get_children():
        tabla_inventario.delete(item)

    conn = database.conectar_db()
    if conn:
        consulta = """
            SELECT p.id, p.nombre, c.nombre, p.precio, p.stock
            FROM productos p
            JOIN categorias c ON p.id_categoria = c.id
        """

        parametros = []
        condiciones = []

        if combobox_categoria_inventario.get() != "Todas las categorías":
            condiciones.append("c.nombre = %s")
            parametros.append(combobox_categoria_inventario.get())

        if check_agotados.get():
            condiciones.append("p.stock = 0")

        if condiciones:
            consulta += " WHERE " + " AND ".join(condiciones)

        consulta += " ORDER BY p.id"

        productos = database.ejecutar_consulta(conn, consulta, parametros)

        categorias = database.ejecutar_consulta(conn, "SELECT nombre FROM categorias")

        combobox_categoria_inventario['values'] = ["Todas las categorías"] + [c[0] for c in categorias]
        combobox_categoria_inventario.current(0)

        for producto in productos:
            tabla_inventario.insert("", tk.END, values=producto)
            
        conn.close()

def cargar_productos_en_tabla2():
    global combobox_categoria_inventario, combobox_proveedor_inventario  
    for item in tabla_inventario.get_children():
        tabla_inventario.delete(item)

    conn = database.conectar_db()
    if conn:
        consulta = """
            SELECT p.id_producto, p.nombre, c.nombre, pr.nombre, p.precio_compra, p.precio_venta, p.stock, p.stock_minimo
            FROM productos p
            JOIN categorias c ON p.id_categoria = c.id_categoria
            JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
        """

        if combobox_categoria_inventario.get() != "Todas las categorías":
            consulta += " WHERE c.nombre = %s"
            parametros = (combobox_categoria_inventario.get(),)
        else:
            parametros = None

        if combobox_proveedor_inventario.get() != "Todos los proveedores":
            consulta += " AND pr.nombre = %s"
            parametros = (combobox_proveedor_inventario.get(),)

        if check_stock_bajo.get():
            consulta += " AND p.stock <= p.stock_minimo"
        if check_agotados.get():
            consulta += " AND p.stock = 0"

        productos = database.ejecutar_consulta(conn, consulta, parametros)
        conn.close()

        for producto in productos:
            tabla_inventario.insert("", tk.END, values=producto)


# Variables globales para los widgets de la pantalla "Reportes de Inventario"
reporte_inventario_frame = None
tabla_inventario2 = None
entry_busqueda_inventario2 = None
combobox_categoria_inventario2 = None
combobox_proveedor_inventario2 = None
calendario_inventario = None  # Calendario para seleccionar fechas
active_button = None  # Variable para almacenar el botón activo
radio_seleccion = None
boton_stock_actual = None
boton_stock_bajo = None
boton_agotados = None
boton_movimientos_stock = None


def mostrar_pantalla_reportes_inventario():
    global reporte_inventario_frame, tabla_inventario2, entry_busqueda_inventario2, combobox_categoria_inventario2, combobox_proveedor_inventario2, calendario_inventario, active_button, boton_stock_actual, boton_stock_bajo, boton_agotados, boton_movimientos_stock, radio_seleccion

    # Colores para la pantalla "Reportes de Inventario"
    label_bg3 = "#2980b9"      # Azul oscuro para las etiquetas
    label_fg3 = "white"        # Texto blanco en las etiquetas
    frame_bg3 = "#ecf0f1"      # Gris claro para el fondo
    button_bg = "#e67e22"      # Naranja llamativo para los botones
    button_fg = "white"        # Texto blanco en los botones
    active_button_bg = "#d35400"  # Naranja oscuro para el botón activo
    highlight_bg = "#f0f0f0"   # Gris muy claro para resaltar

    def desactivar_radiobuttons():
        for widget in radiobuttons_frame.winfo_children():
            widget.config(state=tk.DISABLED)

    def activar_radiobuttons():
        for widget in radiobuttons_frame.winfo_children():
            widget.config(state=tk.NORMAL)

    def activar_boton(boton):
        global active_button 

        if active_button is not None:
            active_button.config(bg=button_bg)
        boton.config(bg=active_button_bg)
        active_button = boton

        if boton in [boton_stock_actual, boton_stock_bajo, boton_agotados]:
            for rb in radiobuttons_frame.winfo_children():
                rb.config(state=tk.DISABLED)

            for rb in radiobuttons_frame.winfo_children():
                if rb.cget("text") == "Día":
                    rb.config(state=tk.NORMAL)
                    break

        elif boton == boton_movimientos_stock:
            for rb in radiobuttons_frame.winfo_children():
                rb.config(state=tk.NORMAL)

    if reporte_inventario_frame is None:
        reporte_inventario_frame = tk.Frame(container, bg=frame_bg3)
        reporte_inventario_frame.grid(row=0, column=1, sticky="nsew")

        canvas = tk.Canvas(reporte_inventario_frame, width=800, height=900)
        canvas.pack(fill="both", expand=True)

        bg_image = ima.open(resource_path("ondo.png")) 
        bg_image = bg_image.resize((250,350), ima.Resampling.LANCZOS)
        bg_photo = ImageTk.PhotoImage(bg_image)

        canvas.create_image(0, 0, anchor="nw", image=bg_photo)

        def ajustar_fondo(event=None):
            nueva_imagen = bg_image.resize((reporte_inventario_frame.winfo_width(), reporte_inventario_frame.winfo_height()), ima.Resampling.LANCZOS)
            canvas.bg_photo = ImageTk.PhotoImage(nueva_imagen) 
            canvas.create_image(0, 0, anchor="nw", image=canvas.bg_photo)

        ajustar_fondo()

        reporte_inventario_frame.bind("<Configure>", ajustar_fondo)

        label_titulo = tk.Label(canvas, text="Tienda de abarrotes", font=("Helvetica", 24, "bold"), fg="white", bg="#3e0d3c")
        label_titulo.pack(pady=10)
        
        label_subtitulo = tk.Label(canvas, text="Observa y genera tus reportes de inventario en base a criterios", font=("Helvetica", 14), fg="white", bg="#3e0d3c")
        label_subtitulo.pack(pady=5)

        frame_botones = tk.Frame(canvas,bg="#3e0d3c", borderwidth=0, relief="solid")
        frame_botones.pack(fill="x", pady=3, side="bottom")

        pdf_button = tk.Button(
            frame_botones, 
            text="Generar PDF", 
            command=lambda: generar_pdf_inventario(
                1 if active_button == boton_stock_actual else 
                2 if active_button == boton_stock_bajo else 
                3 if active_button == boton_agotados else
                4 if active_button == boton_movimientos_stock and radio_seleccion.get() == "día" else
                5 if active_button == boton_movimientos_stock and radio_seleccion.get() == "semana" else
                6 if active_button == boton_movimientos_stock and radio_seleccion.get() == "mes" else  0 
            ),
            bg="#1D1454", 
            fg=button_fg, 
            font=("Arial", 12, "bold"), 
            relief="flat"
        )
        pdf_button.pack(side="top", padx=10)
        cerrar_button = tk.Button(frame_botones, text="Cerrar panel de inventario", command=lambda: show_frame(welcome_frame), bg=button_bg, fg=button_fg)
        cerrar_button.pack(side="bottom", anchor="se", padx=10, pady=10)

        frame_izquierdo = tk.Frame(canvas, bg="#b7fff0", borderwidth=0, relief="solid")
        frame_izquierdo.pack(side="left", fill="y", padx=10, pady=10, expand=True)

        frame_derecho = tk.Frame(canvas, bg="#b7fff0", borderwidth=0, relief="solid")
        frame_derecho.pack(side="right", fill="both", expand=True, padx=10, pady=10)

        toolbar_inventario = tk.Frame(frame_izquierdo, bg="#b7fff0")
        toolbar_inventario.pack(fill="x", pady=10)

        boton_stock_actual = tk.Button(toolbar_inventario, text="Stock Actual", command=lambda: activar_boton(boton_stock_actual), bg=button_bg, fg=button_fg, font=("Arial", 10, "bold"), relief="flat")
        boton_stock_actual.pack(side="left", padx=5)
        boton_movimientos_stock = tk.Button(toolbar_inventario, text="Movimientos de Stock", command=lambda: activar_boton(boton_movimientos_stock), bg=button_bg, fg=button_fg, font=("Arial", 10, "bold"), relief="flat")
        boton_movimientos_stock.pack(side="left", padx=5)
        boton_stock_bajo = tk.Button(toolbar_inventario, text="Stock Bajo", command=lambda: activar_boton(boton_stock_bajo), bg=button_bg, fg=button_fg, font=("Arial", 10, "bold"), relief="flat")
        boton_stock_bajo.pack(side="left", padx=5)
        boton_agotados = tk.Button(toolbar_inventario, text="Agotados", command=lambda: activar_boton(boton_agotados), bg=button_bg, fg=button_fg, font=("Arial", 10, "bold"), relief="flat")
        boton_agotados.pack(side="left", padx=5)

        filtro_frame = tk.Frame(frame_izquierdo, bg="#b7fff0")
        filtro_frame.pack(fill="x", pady=10)

        tk.Label(filtro_frame, text="Categoría:", bg=label_bg3, fg=label_fg3).pack(side="left", padx=100, pady=0)
        combobox_categoria_inventario2 = ttk.Combobox(filtro_frame, state="readonly")
        combobox_categoria_inventario2.pack(side="right", padx=0)

        tk.Label(frame_izquierdo, text="Fecha:", bg=label_bg3, fg=label_fg3).pack(pady=5)
        calendario_inventario = Calendar(frame_izquierdo, selectmode='day')
        calendario_inventario.pack(pady=5)

        radiobuttons_frame = tk.Frame(frame_izquierdo, bg="#b7fff0")
        radiobuttons_frame.pack(pady=5)

        tk.Radiobutton(radiobuttons_frame, text="Día", variable=radio_seleccion, value="día", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(radiobuttons_frame, text="Semana", variable=radio_seleccion, value="semana", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(radiobuttons_frame, text="Mes", variable=radio_seleccion, value="mes", bg="#b7fff0").pack(side="left", padx=5)
        tk.Radiobutton(radiobuttons_frame, text="Año", variable=radio_seleccion, value="año", bg="#b7fff0").pack(side="left", padx=5)

        boton_resultados = tk.Button(frame_izquierdo, text="Mostrar reporte", command=actualizar_tabla_stock_actual, bg="#1D1454", fg=button_fg, font=("Arial", 12, "bold"), relief="flat").pack(pady=10)

        estilo_tabla = ttk.Style()

        estilo_tabla.theme_use("clam")

        estilo_tabla.configure("Treeview",
                        background="white",
                        foreground="black",
                        rowheight=25,
                        fieldbackground="white",
                        bordercolor="#d9d9d9",
                        borderwidth=2,
                        font=('Arial', 9))

        estilo_tabla.configure("Treeview.Heading",
                        background="#00A3A3",
                        foreground="white",
                        font=('Arial', 9, 'bold'))

        estilo_tabla.map("Treeview",
                background=[('selected', '#00A697')],
                foreground=[('selected', 'white')])



        columnas = ("ID", "Nombre", "Categoría", "Precio", "Stock", "Valor Inventario")
        tabla_inventario2 = ttk.Treeview(frame_derecho, columns=columnas, show="headings", style="EstiloTabla.Treeview")
        tabla_inventario2.pack(fill="both", expand=True, padx=10, pady=10)

        for col in columnas:
            tabla_inventario2.heading(col, text=col)
            if col in ["ID"]:
                tabla_inventario2.column(col, width=30, anchor='center')
            elif col in ["Stock"]:
                tabla_inventario2.column(col, width=80, anchor='center')
            elif col in ["Precio", "Valor Inv"]:
                tabla_inventario2.column(col, width=100, anchor='center')
            else:
                tabla_inventario2.column(col, width=100, anchor="center")

        conn = database.conectar_db()
        if conn:
            categorias = database.ejecutar_consulta(conn, "SELECT nombre FROM categorias")
            conn.close()

            combobox_categoria_inventario2['values'] = ["Todas las categorías"] + [c[0] for c in categorias]
            combobox_categoria_inventario2.current(0)


    show_frame(reporte_inventario_frame)

def obtener_stock_actual(categoria=None, fecha=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()
        
        fecha_actual = date.today()

        if fecha is None or fecha == fecha_actual:
            tabla = "productos"
            filtro_fecha = ""
        else:
            tabla = "productos_respaldo"
            filtro_fecha = " AND DATE(p.fecha_respaldo) = %s"

        consulta = f"""
            SELECT p.id, p.nombre, c.nombre, p.precio, p.stock, (p.stock * p.precio) AS valor_inventario
            FROM {tabla} p
            JOIN categorias c ON p.id_categoria = c.id
            WHERE 1=1
        """

        parametros = []
        if categoria and categoria != "Todas las categorías":
            consulta += " AND c.nombre = %s"
            parametros.append(categoria)
        if filtro_fecha:
            consulta += filtro_fecha
            parametros.append(fecha)

        consulta += " ORDER BY p.id"

        cursor.execute(consulta, parametros)
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados

    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
        return []
    
def obtener_stock_bajo(categoria=None, fecha=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()
        
        fecha_actual = date.today()

        if fecha is None or fecha == fecha_actual:
            tabla = "productos"
            filtro_fecha = ""
        else:
            tabla = "productos_respaldo"
            filtro_fecha = " AND DATE(p.fecha_respaldo) = %s"

        consulta = f"""
            SELECT p.id, p.nombre, c.nombre, p.precio, p.stock, (p.stock * p.precio) AS valor_inventario
            FROM {tabla} p
            JOIN categorias c ON p.id_categoria = c.id
            WHERE p.stock <= 5
        """

        parametros = []
        if categoria and categoria != "Todas las categorías":
            consulta += " AND c.nombre = %s"
            parametros.append(categoria)
        if filtro_fecha:
            consulta += filtro_fecha
            parametros.append(fecha)

        consulta += " ORDER BY p.id"

        cursor.execute(consulta, parametros)
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados

    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
        return []

def obtener_productos_agotados(categoria=None, fecha=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()
        
        fecha_actual = date.today()

        if fecha is None or fecha == fecha_actual:
            tabla = "productos"
            filtro_fecha = ""
        else:
            tabla = "productos_respaldo"
            filtro_fecha = " AND DATE(p.fecha_respaldo) = %s"

        consulta = f"""
            SELECT p.id, p.nombre, c.nombre, p.precio, p.stock, (p.stock * p.precio) AS valor_inventario
            FROM {tabla} p
            JOIN categorias c ON p.id_categoria = c.id
            WHERE p.stock = 0
        """

        parametros = []
        if categoria and categoria != "Todas las categorías":
            consulta += " AND c.nombre = %s"
            parametros.append(categoria)
        if filtro_fecha:
            consulta += filtro_fecha
            parametros.append(fecha)

        cursor.execute(consulta, parametros)
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados

    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
        return []

def obtener_movimientos_inventario(fecha_inicio, fecha_fin, categoria=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()

        consulta = """
            SELECT mi.id, p.nombre, mi.fecha, mi.cantidad, mi.precio_unitario, mi.tipo_movimiento, mi.motivo
            FROM movimientos_inventario mi
            JOIN productos p ON mi.id_producto = p.id
            JOIN categorias c ON p.id_categoria = c.id
            WHERE mi.fecha BETWEEN %s AND %s
        """

        parametros = [fecha_inicio, fecha_fin]
        if categoria and categoria != "Todas las categorías":
            consulta += " AND c.nombre = %s"
            parametros.append(categoria)

        consulta += " ORDER BY mi.fecha"

        cursor.execute(consulta, parametros)
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
        return []

def obtener_movimientos_inventario_por_semana(año, semana, categoria=None):
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()

        consulta = """
            SELECT mi.id, p.nombre, mi.fecha, mi.cantidad, mi.precio_unitario, mi.tipo_movimiento, mi.motivo
            FROM movimientos_inventario mi
            JOIN productos p ON mi.id_producto = p.id
            JOIN categorias c ON p.id_categoria = c.id
            WHERE EXTRACT(YEAR FROM mi.fecha) = %s
            AND EXTRACT(WEEK FROM mi.fecha) = %s
        """

        parametros = [año, semana]
        if categoria and categoria != "Todas las categorías":
            consulta += " AND c.nombre = %s"
            parametros.append(categoria)

        consulta += " ORDER BY mi.fecha"

        cursor.execute(consulta, parametros)
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
        return []

def obtener_movimientos_inventario_por_mes(año, mes, categoria=None):
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()

        consulta = """
            SELECT mi.id, p.nombre, mi.fecha, mi.cantidad, mi.precio_unitario, mi.tipo_movimiento, mi.motivo
            FROM movimientos_inventario mi
            JOIN productos p ON mi.id_producto = p.id
            JOIN categorias c ON p.id_categoria = c.id
            WHERE EXTRACT(YEAR FROM mi.fecha) = %s
            AND EXTRACT(MONTH FROM mi.fecha) = %s
        """

        parametros = [año, mes]
        if categoria and categoria != "Todas las categorías":
            consulta += " AND c.nombre = %s"
            parametros.append(categoria)

        consulta += " ORDER BY mi.fecha"

        cursor.execute(consulta, parametros)
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
        return []

def obtener_movimientos_inventario_por_año(año, categoria=None):
    try:
        conn = database.conectar_db()
        cursor = conn.cursor()

        consulta = """
            SELECT mi.id, p.nombre, mi.fecha, mi.cantidad, mi.precio_unitario, mi.tipo_movimiento, mi.motivo
            FROM movimientos_inventario mi
            JOIN productos p ON mi.id_producto = p.id
            JOIN categorias c ON p.id_categoria = c.id
            WHERE EXTRACT(YEAR FROM mi.fecha) = %s
        """

        parametros = [año]
        if categoria and categoria != "Todas las categorías":
            consulta += " AND c.nombre = %s"
            parametros.append(categoria)

        consulta += " ORDER BY mi.fecha"

        cursor.execute(consulta, parametros)
        resultados = cursor.fetchall()
        cursor.close()
        conn.close()
        return resultados
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
        return []


def actualizar_tabla_stock_actual():
    global combobox_categoria_inventario2, combobox_proveedor_inventario2, calendario_inventario, radio_seleccion

    categoria = combobox_categoria_inventario2.get()
    fecha = calendario_inventario.selection_get()
    periodo = radio_seleccion.get()

    if active_button == boton_stock_actual or active_button == boton_stock_bajo or active_button == boton_agotados:
        columnas = ("ID", "Nombre", "Categoría", "Precio", "Stock", "Valor Inventario")
        tabla_inventario2["columns"] = columnas
        for col in columnas:
            tabla_inventario2.heading(col, text=col)
            if col in ["ID"]:
                tabla_inventario2.column(col, width=30, anchor='center')
            elif col in ["Stock"]:
                tabla_inventario2.column(col, width=80, anchor='center')
            elif col in ["Precio", "Valor Inv"]:
                tabla_inventario2.column(col, width=100, anchor='center')
            else:
                tabla_inventario2.column(col, width=100, anchor="center")

    if active_button == boton_stock_actual:
       stocking = obtener_stock_actual(categoria, fecha, periodo)
    elif active_button == boton_stock_bajo:
        stocking = obtener_stock_bajo(categoria, fecha, periodo)
    elif active_button == boton_agotados:
        stocking = obtener_productos_agotados(categoria, fecha, periodo)
    elif active_button == boton_movimientos_stock:
        columnas = ("ID Movimiento", "Nombre Producto", "Fecha", "Cantidad", "Precio Unitario", "Tipo Movimiento", "Motivo")
        tabla_inventario2["columns"] = columnas
        for col in columnas:
            tabla_inventario2.heading(col, text=col)
            if col == "ID Movimiento":
                tabla_inventario2.column(col, width=100, anchor='center')
            elif col in ["Cantidad", "Precio Unitario"]:
                tabla_inventario2.column(col, width=100, anchor='center')
            else:
                tabla_inventario2.column(col, width=150, anchor='center')

        fecha_inicio = fecha 
        fecha_fin = fecha + timedelta(days=1) 
        if periodo == "día":
            stocking = obtener_movimientos_inventario(fecha_inicio, fecha_fin, categoria, periodo)
        elif periodo == "semana":
            año, semana = fecha.isocalendar()[:2]
            stocking = obtener_movimientos_inventario_por_semana(año, semana, categoria)
        elif periodo == "mes":
            año, mes = fecha.year, fecha.month
            stocking = obtener_movimientos_inventario_por_mes(año, mes, categoria)
        else:
            año = fecha.year
            stocking = obtener_movimientos_inventario_por_año(año, categoria)

    for item in tabla_inventario2.get_children():
        tabla_inventario2.delete(item)

    for producto in stocking:
        tabla_inventario2.insert("", tk.END, values=producto)


def respaldar_productos_si_necesario():
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()

        ayer = date.today() - timedelta(days=1)

        consulta_verificar_respaldo = """
            SELECT COUNT(*)
            FROM productos_respaldo
            WHERE DATE(fecha_respaldo) = %s
        """
        cursor.execute(consulta_verificar_respaldo, (ayer,))
        respaldo_existente = cursor.fetchone()[0] > 0

        hora_actual = datetime.now().time()

        if hora_actual >= time(0, 0) and not respaldo_existente:
            consulta_respaldo = """
                INSERT INTO productos_respaldo (nombre, id_categoria, precio, stock, fecha_respaldo, codigo)
                SELECT nombre, id_categoria, precio, stock, %s, codigo
                FROM productos;
            """
            cursor.execute(consulta_respaldo, (ayer,))
            conn.commit()
            print("Respaldo de productos realizado correctamente")

        cursor.close()
        conn.close()

    else:
        print("Error: No se pudo conectar a la base de datos")

def ver_inventario():
    mostrar_pantalla_inventario()

def generar_pdf_inventario(numero):
    global combobox_categoria_inventario2, calendario_inventario, radio_seleccion

    try:
        categoria = combobox_categoria_inventario2.get()
        fecha = calendario_inventario.selection_get()
        periodo = radio_seleccion.get()

        print(numero)
        if numero == 1:
            stock_actual = obtener_stock_actual(categoria, fecha, periodo)
        elif numero == 2:
            stock_actual = obtener_stock_bajo(categoria, fecha, periodo)
        elif numero == 3:
            stock_actual = obtener_productos_agotados(categoria, fecha, periodo)
        elif numero == 4:
            fecha_inicio = fecha 
            fecha_fin = fecha + timedelta(days=1)
            stock_actual = obtener_movimientos_inventario(fecha_inicio, fecha_fin, categoria, periodo)
        elif numero == 5:
            año, semana = fecha.isocalendar()[:2]
            stock_actual = obtener_movimientos_inventario_por_semana(año, semana, categoria)
        elif numero == 6:
            año, mes = fecha.year, fecha.month
            stock_actual = obtener_movimientos_inventario_por_mes(año, mes, categoria)
        else:
            año= fecha.year
            stock_actual = obtener_movimientos_inventario_por_año(año, categoria)

        filepath = filedialog.asksaveasfilename(
            defaultextension=".pdf",
            filetypes=[("Archivos PDF", "*.pdf"), ("Todos los archivos", "*.*")]
        )
        if not filepath:
            return 

        doc = SimpleDocTemplate(filepath, pagesize=landscape(letter))
        story = []

        styles = getSampleStyleSheet()
        styleN = styles["Normal"]
        styleH = styles["Heading1"]
        styleH.alignment = 1  
        styleH.fontSize = 20 

        logo = Image(resource_path("ondda.jpg"), width=50, height=50)
        story.append(logo)
        story.append(Spacer(1, 12))
        story.append(Paragraph("Reporte de Inventario", styleH))
        story.append(Paragraph(f"Fecha de generación: {date.today()}", styleN))
        story.append(Paragraph(f"Categoría: {categoria if categoria != 'Todas las categorías' else 'Todas'}", styleN))
        if fecha:
            story.append(Paragraph(f"Fecha: {fecha.strftime('%Y-%m-%d')}", styleN))
            story.append(Paragraph(f"Periodo: {periodo}", styleN))
        story.append(Spacer(1, 24))

        if numero == 1 or numero == 2 or numero == 3:
            data = [
                ["ID", "Nombre", "Categoría", "Precio", "Stock", "Valor Inventario"],
            ] + stock_actual
            col_widths = [0.5*inch, 1.5*inch, 1.5*inch, 1.5*inch, 1.2*inch, 1.2*inch, 1*inch, 1*inch, 1.2*inch]
        else:
            data = [
                ["ID Movimiento", "Nombre Producto", "Fecha", "Cantidad", "Precio Unitario", "Tipo Movimiento", "Motivo"],
            ] + stock_actual
            col_widths = [1*inch, 1.5*inch, 1.5*inch, 1*inch, 1.2*inch, 1.5*inch, 1.5*inch] 

        table = Table(data, colWidths=col_widths)
        table.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#00A3A3")),  # Encabezado turquesa
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),  # Texto blanco en encabezado
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),  # Alineación al centro
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),  # Negrita en encabezado
            ('FONTSIZE', (0, 0), (-1, 0), 10),  # Tamaño de fuente del encabezado
            ('BOTTOMPADDING', (0, 0), (-1, 0), 8),  # Padding inferior en encabezado
            ('BACKGROUND', (0, 1), (-1, -1), colors.white),  # Fondo blanco en filas de datos
            ('GRID', (0, 0), (-1, -1), 1, colors.black),  # Líneas de la cuadrícula
            ('FONTSIZE', (0, 1), (-1, -1), 8),  # Tamaño de fuente de las filas de datos
        ]))
        story.append(table)

        story.append(Spacer(1, 12))
        story.append(Paragraph("--------------------------------------------------------------------------------", styleN))
        story.append(Paragraph(f"Página <pagenumber> de <totalpages> | Paletería ReBe | Tel: (951) 314-4134", styleN))

        doc.build(story)
        messagebox.showinfo("Éxito", f"Reporte generado y guardado en:\n{filepath}")
    except Exception as e:
        messagebox.showerror("Error", f"Entrada inválida: {str(e)}")

def show_frame(frame):
    rol = auth_system.obtener_rol()
    
    if rol != "administrador":
        frames_restringidos = [
            products_frame, reports_frame, inventario_frame, 
            reporte_inventario_frame, graphs_frame
        ]
        
        if frame in frames_restringidos:
            messagebox.showwarning("Acceso Denegado", 
                                "No tienes permisos para acceder a esta sección.\n"
                                "Solo los administradores pueden acceder a esta función.")
            return
    
    for f in [welcome_frame, sales_frame, products_frame, reports_frame, 
              inventario_frame, reporte_inventario_frame, graphs_frame]:
        if f and f.winfo_exists():
            f.grid_remove()
    
    if frame and frame.winfo_exists():
        frame.grid(row=0, column=1, sticky="nsew")

root = tk.Tk()
root.title("Punto de Venta - Paletería Rebe")
root.geometry("1200x600")
root.encoding = 'utf-8'

# --- Paleta de colores ---
root.configure(bg="#2980b9")  # Azul oscuro como fondo principal
menu_bg = "#3498db"         # Azul claro para el menú
menu_fg = "white"           # Texto blanco en el menú
frame_bg = "#ecf0f1"        # Gris claro para los frames de contenido
button_bg = "#b793ad"       # Verde para los botones
button_fg = "white"         # Texto blanco en los botones

container = tk.Frame(root, bg=frame_bg)
container.pack(side="top", fill="both", expand=True)
container.grid_rowconfigure(0, weight=1)
container.grid_columnconfigure(1, weight=1)

radio_seleccion = tk.StringVar(value="día")

reporte_categoria_frame = tk.Frame(container, bg=frame_bg2)

reporte_categoria_frame = tk.Frame(container, bg=frame_bg)
reporte_categoria_frame.grid(row=0, column=1, sticky="nsew")

welcome_frame = tk.Frame(container, bg=None)
products_frame = tk.Frame(container, bg=frame_bg)
sales_frame = tk.Frame(container, bg=frame_bg)
reports_frame = tk.Frame(container, bg=frame_bg)

for frame in (welcome_frame, products_frame, sales_frame, reports_frame, reporte_categoria_frame):
    frame.grid(row=0, column=1, sticky="nsew")

background_image_ref = None

def resize_background(event):
    global background_image_ref
    width, height = event.width, event.height
    imagen_fondo = ima.open(resource_path("ondo.png"))  
    imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
    background_image_ref = ImageTk.PhotoImage(imagen_fondo)
    background_label.config(image=background_image_ref)
    background_label.image = background_image_ref 

background_label = tk.Label(welcome_frame)
background_label.place(x=0, y=0, relwidth=1, relheight=1)

welcome_frame.bind("<Configure>", resize_background)

def resize_background(event):
    global background_image_ref
    width, height = event.width, event.height
    imagen_fondo = ima.open(resource_path("ondo.png"))
    imagen_fondo = imagen_fondo.resize((width, height), ima.Resampling.LANCZOS)
    background_image_ref = ImageTk.PhotoImage(imagen_fondo)
    background_label_ventas.config(image=background_image_ref)
    background_label_ventas.image = background_image_ref 

background_label_ventas = tk.Label(reports_frame)
background_label_ventas.place(x=0, y=0, relwidth=1, relheight=1) 

reports_frame.bind("<Configure>", resize_background)


def resource_path(relative_path):
    """ Get the absolute path to the resource, works for dev and for PyInstaller """
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")

    return os.path.join(base_path, relative_path)

frame = tk.Frame(welcome_frame, bg="#b793ad", highlightbackground="#3e0d3c", highlightthickness=2)
frame.place(x=200, y=300, width=415, height=300) 

botones_info = [
    {"texto": "Nuevo producto", "imagen": "imagen_0.jpg", "accion": agregar_producto},
    {"texto": "Abrir turno", "imagen": "imagen_1.jpg", "accion": boton_abrir_turno},
    {"texto": "Cerrar turno", "imagen": "imagen_2.jpg", "accion": cerrar_turno},
    {"texto": "Generar venta", "imagen": "imagen_3.jpg", "accion": mostrar_pantalla_ventas},
    {"texto": "Ver ventas", "imagen": "imagen_4.jpg", "accion": mostrar_pantalla_ver_ventas},
    {"texto": "Inventario", "imagen": "imagen_5.jpg", "accion": mostrar_pantalla_inventario},
]

boton_width = 90
boton_height = 90

for i, info in enumerate(botones_info):
    fila = i // 3 
    columna = i % 3 
    try:
        imagen_original = ima.open(resource_path("imagen_"+str(i)+".jpg")) 
        imagen_redimensionada = imagen_original.resize((boton_width, boton_height), ima.Resampling.LANCZOS)
        boton_image = ImageTk.PhotoImage(imagen_redimensionada)
    except Exception as e:
        print(f"No se pudo cargar la imagen {info['imagen']}: {e}")
        boton_image = None
    
    boton = tk.Button(frame, image=boton_image, text="", command=info["accion"])
    boton.image = boton_image  
    boton.grid(row=fila * 2, column=columna, padx=20, pady=10) 
    
    label = tk.Label(frame, text=info["texto"], bg="#b793ad", fg="white", font=("Arial", 10, "bold"))
    label.grid(row=fila * 2 + 1, column=columna, padx=20, pady=5)


nav_frame = tk.Frame(root, bg="#df487a", width=0)  
nav_frame.place(x=-200, y=0)  

is_nav_open = False  

def toggle_nav():
    global is_nav_open
    current_x = nav_frame.winfo_x()
    target_x = 0 if not is_nav_open else -200
    step = 5 if not is_nav_open else -5

    for x in range(current_x, target_x, step):
        nav_frame.place(x=x, y=0, relheight=1) 
        root.update()

    is_nav_open = not is_nav_open
    toggle_button.config(text="X" if is_nav_open else "☰")

toggle_button = tk.Button(root, text="☰", command=toggle_nav, bg="#df487a", fg=menu_fg, width=2, height=1)
toggle_button.place(x=0, y=0)

login_button_nav = tk.Button(nav_frame, text="Iniciar Sesión", command=mostrar_login,
                           bg="#27ae60", fg="white", font=("Arial", 10, "bold"))
login_button_nav.pack(fill="x", pady=10, padx=10)


def create_submenu(parent, options):
    submenu = tk.Menu(parent, tearoff=0, bg="#df487a", fg=menu_fg, activebackground=button_bg, activeforeground=button_fg)
    submenu.images = []  
    for option, command, image_path in options:
        img = ima.open(image_path).convert("RGBA")  
        img = img.resize((20, 20), ima.Resampling.LANCZOS)

        img_with_background = ima.new("RGBA", img.size, (255, 255, 255))  
        img_with_background.paste(img, (0, 0), img)  
        photo = ImageTk.PhotoImage(img_with_background)

        submenu.add_command(label=option, command=command, image=photo, compound="left")
        submenu.images.append(photo)  

    return submenu



menu_options = [
    ("Productos", [
        ("Agregar Producto", agregar_producto, resource_path("gregar-producto.png")),  
        ("Editar Producto", editar_producto, resource_path("editar.png")),
        ("Eliminar Producto", eliminar_producto, resource_path("eliminar.png")),
    ]),
    ("Ventas", [
        ("Abrir turno", boton_abrir_turno, resource_path("egistrar.png")),
        ("Cerrar turno", cerrar_turno, resource_path("justar.png")),
        ("Generar Venta", ver_ventas, resource_path("enta.png")),
        ("Ver Ventas", ver_reportes_ventas2, resource_path("er_venta.png"))
    ]),
    ("Reportes", [
        ("Ver Reportes de Ventas", ver_reportes_ventas, resource_path("eporte.png")),
        ("Gráficos y Visualizaciones", mostrar_bienvenida_graficos, resource_path("graficos.png"))
    ]),
    ("Inventario", [ 
        ("Ver Inventario", ver_inventario, resource_path("inventario.png")),
        ("Reportes de Inventario", mostrar_pantalla_reportes_inventario, resource_path("eportes.png")) 
    ])
]


for option, suboptions in menu_options:
    button = tk.Menubutton(nav_frame, text=option, bg="#df487a", fg=menu_fg, activebackground=button_bg, activeforeground=button_fg)
    button.pack(fill="x", pady=9, expand=True)  
    submenu = create_submenu(button, suboptions)
    button.config(menu=submenu)

show_frame(welcome_frame)
respaldar_productos_si_necesario()

root.after(100, mostrar_login)

conn = database.conectar_db()
root.mainloop()
conn.close()