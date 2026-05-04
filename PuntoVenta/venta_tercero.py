import tkinter as tk
from tkinter import ttk, messagebox
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

# 1. PALETA DE COLORES
menu_bg     = "#2C3E50"   # Azul grisáceo oscuro para el menú
menu_fg     = "#ECF0F1"   # Blanco roto
frame_bg    = "#F5F7FA"   # Gris muy claro para fondos
button_bg   = "#3498DB"   # Azul principal para botones
button_fg   = "white"
accent_bg   = "#E67E22"   # Naranja para acentos
success_bg  = "#27AE60"   # Verde para éxito
danger_bg   = "#E74C3C"   # Rojo para eliminar
label_bg    = "#34495E"   # Azul oscuro para etiquetas
label_fg    = "white"
entry_bg    = "#FFFFFF"
highlight_bg = "#F0F3F5"

# Fuentes
default_font = ('Segoe UI', 10)
bold_font    = ('Segoe UI', 10, 'bold')
title_font   = ('Segoe UI', 18, 'bold')
heading_font = ('Segoe UI', 14, 'bold')


# 2. ESTILOS PARA TABLAS 
def setup_styles():
    style = ttk.Style()
    style.theme_use("clam")
    style.configure("Modern.Treeview",
        background="white",
        foreground="black",
        rowheight=28,
        fieldbackground="white",
        font=default_font)
    style.configure("Modern.Treeview.Heading",
        background=label_bg,
        foreground="white",
        font=bold_font,
        relief="flat")
    style.map("Modern.Treeview",
        background=[('selected', button_bg)],
        foreground=[('selected', 'white')])
    style.configure("Accent.TButton",
        background=accent_bg,
        foreground="white",
        font=bold_font,
        padding=(12, 6),
        relief="flat")
    style.map("Accent.TButton",
        background=[('active', '#D35400'), ('pressed', '#A04000')])

# 3. CLASE TOOLTIP
class ToolTip:
    def __init__(self, widget, text):
        self.widget = widget
        self.text = text
        self.tip_window = None
        widget.bind('<Enter>', self.show_tip)
        widget.bind('<Leave>', self.hide_tip)

    def show_tip(self, event=None):
        if self.tip_window or not self.text:
            return
        try:
            x, y, _, _ = self.widget.bbox("insert")
        except Exception:
            x, y = 0, 0
        x += self.widget.winfo_rootx() + 25
        y += self.widget.winfo_rooty() + 25
        self.tip_window = tw = tk.Toplevel(self.widget)
        tw.wm_overrideredirect(True)
        tw.wm_geometry(f"+{x}+{y}")
        label = tk.Label(tw, text=self.text, justify=tk.LEFT,
                         background="#FFFFE0", relief=tk.SOLID, borderwidth=1,
                         font=('Segoe UI', 9))
        label.pack()

    def hide_tip(self, event=None):
        if self.tip_window:
            self.tip_window.destroy()
            self.tip_window = None


# 4. FUNCIÓN PARA CENTRAR VENTANAS EMERGENTES
def configurar_ventana_emergente(ventana, titulo, ancho=500, alto=400):
    ventana.title(titulo)
    ventana.config(bg=frame_bg)
    ventana.resizable(False, False)
    x = (ventana.winfo_screenwidth() // 2) - (ancho // 2)
    y = (ventana.winfo_screenheight() // 2) - (alto // 2)
    ventana.geometry(f'{ancho}x{alto}+{x}+{y}')

# 5. RESOURCE PATH
def resource_path(relative_path):
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(base_path, relative_path)

# 6. FUNCIONES DE PRODUCTOS
def agregar_producto():
    ventana_agregar = tk.Toplevel(root)
    configurar_ventana_emergente(ventana_agregar, "Agregar Producto", 620, 560)

    header = tk.Frame(ventana_agregar, bg=label_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="➕  Agregar Nuevo Producto",
             font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

    body = tk.Frame(ventana_agregar, bg=frame_bg)
    body.pack(fill="both", expand=True, padx=20, pady=15)

    sec1 = ttk.LabelFrame(body, text=" 📋 Información General ", padding=12)
    sec1.pack(fill="x", pady=(0, 10))
    sec1.columnconfigure(1, weight=1)
    sec1.columnconfigure(3, weight=1)

    ttk.Label(sec1, text="📦 Nombre:", font=bold_font).grid(row=0, column=0, sticky="e", padx=5, pady=7)
    entry_nombre = ttk.Entry(sec1, font=default_font, width=28)
    entry_nombre.grid(row=0, column=1, columnspan=3, sticky="ew", padx=5, pady=7)

    ttk.Label(sec1, text="📝 Descripción:", font=bold_font).grid(row=1, column=0, sticky="e", padx=5, pady=7)
    entry_descripcion = ttk.Entry(sec1, font=default_font)
    entry_descripcion.grid(row=1, column=1, columnspan=3, sticky="ew", padx=5, pady=7)

    conn = database.conectar_db()
    if conn:
        categorias = database.ejecutar_consulta(conn, "SELECT id_categoria, nombre FROM categorias")
        conn.close()
        nombres_categorias = [c[1] for c in categorias]
        ttk.Label(sec1, text="🏷️ Categoría:", font=bold_font).grid(row=2, column=0, sticky="e", padx=5, pady=7)
        combobox_categoria = ttk.Combobox(sec1, values=nombres_categorias, state="readonly", width=18)
        combobox_categoria.grid(row=2, column=1, sticky="w", padx=5, pady=7)
    else:
        print("Error: No se pudo conectar a la base de datos")

    conn = database.conectar_db()
    if conn:
        proveedores = database.ejecutar_consulta(conn, "SELECT id_proveedor, nombre FROM proveedores")
        conn.close()
        nombres_proveedores = [p[1] for p in proveedores]
        ttk.Label(sec1, text="🚚 Proveedor:", font=bold_font).grid(row=2, column=2, sticky="e", padx=5, pady=7)
        combobox_proveedor = ttk.Combobox(sec1, values=nombres_proveedores, state="readonly", width=18)
        combobox_proveedor.grid(row=2, column=3, sticky="w", padx=5, pady=7)
    else:
        print("Error: No se pudo conectar a la base de datos")

    sec2 = ttk.LabelFrame(body, text=" 💰 Precios y Stock ", padding=12)
    sec2.pack(fill="x", pady=(0, 10))
    sec2.columnconfigure(1, weight=1)
    sec2.columnconfigure(3, weight=1)

    ttk.Label(sec2, text="💵 Precio Compra:", font=bold_font).grid(row=0, column=0, sticky="e", padx=5, pady=7)
    entry_precio_compra = ttk.Entry(sec2, font=default_font, width=14)
    entry_precio_compra.grid(row=0, column=1, sticky="w", padx=5, pady=7)

    ttk.Label(sec2, text="🏷️ Precio Venta:", font=bold_font).grid(row=0, column=2, sticky="e", padx=5, pady=7)
    entry_precio_venta = ttk.Entry(sec2, font=default_font, width=14)
    entry_precio_venta.grid(row=0, column=3, sticky="w", padx=5, pady=7)

    ttk.Label(sec2, text="📊 Stock:", font=bold_font).grid(row=1, column=0, sticky="e", padx=5, pady=7)
    entry_stock = ttk.Entry(sec2, font=default_font, width=14)
    entry_stock.grid(row=1, column=1, sticky="w", padx=5, pady=7)

    ttk.Label(sec2, text="⚠️ Stock Mínimo:", font=bold_font).grid(row=1, column=2, sticky="e", padx=5, pady=7)
    entry_stock_minimo = ttk.Entry(sec2, font=default_font, width=14)
    entry_stock_minimo.grid(row=1, column=3, sticky="w", padx=5, pady=7)

    def guardar_producto():
        nombre = entry_nombre.get()
        descripcion = entry_descripcion.get()
        nombre_categoria = combobox_categoria.get()
        nombre_proveedor = combobox_proveedor.get()

        if not nombre:
            messagebox.showerror("Error", "El nombre del producto es obligatorio")
            return
        try:
            precio_compra = float(entry_precio_compra.get())
            precio_venta  = float(entry_precio_venta.get())
            stock         = int(entry_stock.get())
            stock_minimo  = int(entry_stock_minimo.get())
            if precio_compra <= 0 or precio_venta <= 0 or stock < 0 or stock_minimo < 0:
                raise ValueError("Los valores numéricos deben ser positivos")
        except ValueError:
            messagebox.showerror("Error", "Los precios y el stock deben ser números positivos")
            return

        conn = database.conectar_db()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("SELECT id_proveedor FROM proveedores WHERE nombre = %s", (nombre_proveedor,))
                res_prov = cursor.fetchone()
                if not res_prov:
                    messagebox.showerror("Error", "Proveedor no encontrado")
                    conn.close()
                    return
                id_proveedor = res_prov[0]

                cursor.execute("SELECT id_categoria FROM categorias WHERE nombre = %s", (nombre_categoria,))
                res_cat = cursor.fetchone()
                if not res_cat:
                    messagebox.showerror("Error", "Categoría no encontrada")
                    conn.close()
                    return
                id_categoria = res_cat[0]

                consulta_producto = """
                    INSERT INTO productos (nombre, descripcion, id_categoria, id_proveedor, precio_compra, precio_venta, stock, stock_minimo)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING id_producto
                """
                cursor.execute(consulta_producto, (nombre, descripcion, id_categoria, id_proveedor,
                                                   precio_compra, precio_venta, stock, stock_minimo))
                id_producto = cursor.fetchone()[0]

                cursor.execute("""
                    INSERT INTO movimientos_inventario (id_producto, cantidad, precio_unitario, tipo_movimiento, motivo)
                    VALUES (%s, %s, %s, 'entrada', 'Producto agregado')
                """, (id_producto, stock, precio_compra))

                conn.commit()
                messagebox.showinfo("Éxito", "Producto agregado correctamente")
                ventana_agregar.destroy()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", f"No se pudo agregar el producto. Error: {e}")
            finally:
                cursor.close()
                conn.close()
        else:
            messagebox.showerror("Error", "No se pudo conectar a la base de datos")

    btn_frame = tk.Frame(ventana_agregar, bg=frame_bg)
    btn_frame.pack(pady=10)
    btn_guardar = ttk.Button(btn_frame, text="✔  Guardar Producto",
                             command=guardar_producto, style="Accent.TButton")
    btn_guardar.pack(ipadx=20, ipady=6)
    ToolTip(btn_guardar, "Guarda el producto en la base de datos")


def agregar_producto_por_gramaje():
    ventana_agregar = tk.Toplevel(root)
    configurar_ventana_emergente(ventana_agregar, "Agregar Producto por Gramaje", 600, 580)

    frame_datos = ttk.LabelFrame(ventana_agregar, text="Información del producto (por peso)", padding=15)
    frame_datos.pack(fill="both", expand=True, padx=15, pady=15)
    frame_datos.columnconfigure(1, weight=1)

    row = 0
    ttk.Label(frame_datos, text="Nombre:", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
    entry_nombre = ttk.Entry(frame_datos, font=default_font, width=35)
    entry_nombre.grid(row=row, column=1, sticky="w", padx=5, pady=8)

    row += 1
    ttk.Label(frame_datos, text="Descripción:", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
    entry_descripcion = ttk.Entry(frame_datos, font=default_font)
    entry_descripcion.grid(row=row, column=1, sticky="ew", padx=5, pady=8)

    conn = database.conectar_db()
    if conn:
        categorias = database.ejecutar_consulta(conn, "SELECT id_categoria, nombre FROM categorias")
        conn.close()
        nombres_categorias = [c[1] for c in categorias]
        row += 1
        ttk.Label(frame_datos, text="Categoría:", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
        combobox_categoria = ttk.Combobox(frame_datos, values=nombres_categorias, state="readonly")
        combobox_categoria.grid(row=row, column=1, sticky="w", padx=5, pady=8)
    else:
        print("Error: No se pudo conectar a la base de datos")

    conn = database.conectar_db()
    if conn:
        proveedores = database.ejecutar_consulta(conn, "SELECT id_proveedor, nombre FROM proveedores")
        conn.close()
        nombres_proveedores = [p[1] for p in proveedores]
        row += 1
        ttk.Label(frame_datos, text="Proveedor:", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
        combobox_proveedor = ttk.Combobox(frame_datos, values=nombres_proveedores, state="readonly")
        combobox_proveedor.grid(row=row, column=1, sticky="w", padx=5, pady=8)
    else:
        print("Error: No se pudo conectar a la base de datos")

    row += 1
    ttk.Label(frame_datos, text="Precio Compra:", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
    entry_precio_compra = ttk.Entry(frame_datos, font=default_font)
    entry_precio_compra.grid(row=row, column=1, sticky="w", padx=5, pady=8)

    row += 1
    ttk.Label(frame_datos, text="Precio Venta:", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
    entry_precio_venta = ttk.Entry(frame_datos, font=default_font)
    entry_precio_venta.grid(row=row, column=1, sticky="w", padx=5, pady=8)

    row += 1
    ttk.Label(frame_datos, text="Stock (gr/kg):", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
    entry_stock = ttk.Entry(frame_datos, font=default_font)
    entry_stock.grid(row=row, column=1, sticky="w", padx=5, pady=8)

    row += 1
    ttk.Label(frame_datos, text="Stock Mínimo (gr/kg):", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
    entry_stock_minimo = ttk.Entry(frame_datos, font=default_font)
    entry_stock_minimo.grid(row=row, column=1, sticky="w", padx=5, pady=8)

    row += 1
    ttk.Label(frame_datos, text="Unidad de Medida (gr/kg):", font=bold_font).grid(row=row, column=0, sticky="e", padx=5, pady=8)
    entry_unidad_medida = ttk.Entry(frame_datos, font=default_font)
    entry_unidad_medida.grid(row=row, column=1, sticky="w", padx=5, pady=8)

    def guardar_producto():
        nombre         = entry_nombre.get()
        descripcion    = entry_descripcion.get()
        nombre_categoria = combobox_categoria.get()
        nombre_proveedor = combobox_proveedor.get()
        unidad_medida  = entry_unidad_medida.get()

        if not nombre:
            messagebox.showerror("Error", "El nombre del producto es obligatorio")
            return
        try:
            precio_compra = float(entry_precio_compra.get())
            precio_venta  = float(entry_precio_venta.get())
            stock         = float(entry_stock.get())
            stock_minimo  = float(entry_stock_minimo.get())
            if precio_compra <= 0 or precio_venta <= 0 or stock < 0 or stock_minimo < 0:
                raise ValueError("Los valores numéricos deben ser positivos")
        except ValueError:
            messagebox.showerror("Error", "Los precios y el stock deben ser números positivos")
            return

        conn = database.conectar_db()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("SELECT id_proveedor FROM proveedores WHERE nombre = %s", (nombre_proveedor,))
                res_prov = cursor.fetchone()
                if not res_prov:
                    messagebox.showerror("Error", "Proveedor no encontrado")
                    conn.close()
                    return
                id_proveedor = res_prov[0]

                cursor.execute("SELECT id_categoria FROM categorias WHERE nombre = %s", (nombre_categoria,))
                res_cat = cursor.fetchone()
                if not res_cat:
                    messagebox.showerror("Error", "Categoría no encontrada")
                    conn.close()
                    return
                id_categoria = res_cat[0]

                cursor.execute("""
                    INSERT INTO productos_por_gramaje (nombre, descripcion, id_categoria, id_proveedor,
                        precio_compra, precio_venta, stock, stock_minimo, unidad_medida)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (nombre, descripcion, id_categoria, id_proveedor,
                      precio_compra, precio_venta, stock, stock_minimo, unidad_medida))
                conn.commit()
                messagebox.showinfo("Éxito", "Producto por gramaje agregado correctamente")
                ventana_agregar.destroy()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", f"No se pudo agregar el producto por gramaje. Error: {e}")
            finally:
                cursor.close()
                conn.close()
        else:
            print("Error: No se pudo conectar a la base de datos")

    btn_guardar = ttk.Button(ventana_agregar, text="Guardar", command=guardar_producto, style="Accent.TButton")
    btn_guardar.pack(pady=15)
    ToolTip(btn_guardar, "Guarda el producto por gramaje")


def editar_producto():
    global products_frame, tabla_productos
    products_frame = tk.Frame(container, bg=frame_bg)
    products_frame.grid(row=0, column=1, sticky="nsew")

    header = tk.Frame(products_frame, bg=label_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="✏️  Editar Productos",
             font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

    search_frame = tk.Frame(products_frame, bg=frame_bg)
    search_frame.pack(fill="x", padx=20, pady=(12, 5))

    tk.Label(search_frame, text="🔍 Buscar producto:",
             bg=frame_bg, fg=label_bg, font=bold_font).pack(side="left", padx=(0, 8))
    search_entry = tk.Entry(search_frame, width=40, font=default_font,
                            relief="solid", bd=1)
    search_entry.pack(side="left")

    hint = tk.Label(products_frame,
                    text="💡 Doble clic sobre una celda para editarla",
                    bg=frame_bg, fg="#7F8C8D", font=('Segoe UI', 9, 'italic'))
    hint.pack(anchor="w", padx=20, pady=(0, 4))

    tabla_frame = tk.Frame(products_frame, bg=frame_bg)
    tabla_frame.pack(fill="both", expand=True, padx=20, pady=(0, 5))

    columnas = ("ID", "Nombre", "Descripción", "Categoría", "Proveedor",
                "Precio Compra", "Precio Venta", "Stock", "Stock Mínimo")
    tabla_productos = ttk.Treeview(tabla_frame, columns=columnas,
                                   show="headings", style="Modern.Treeview")

    scroll_y = ttk.Scrollbar(tabla_frame, orient="vertical",   command=tabla_productos.yview)
    scroll_x = ttk.Scrollbar(tabla_frame, orient="horizontal", command=tabla_productos.xview)
    tabla_productos.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)

    scroll_y.pack(side="right",  fill="y")
    scroll_x.pack(side="bottom", fill="x")
    tabla_productos.pack(fill="both", expand=True)

    for col in columnas:
        tabla_productos.heading(col, text=col, anchor="center")
        tabla_productos.column(col, width=100, anchor="center")

    def cargar_productos(filtro=None):
        for item in tabla_productos.get_children():
            tabla_productos.delete(item)
        conn = database.conectar_db()
        if conn:
            consulta = """
                SELECT p.id_producto, p.nombre, p.descripcion, c.nombre AS categoria, pr.nombre AS proveedor,
                       p.precio_compra, p.precio_venta, p.stock, p.stock_minimo
                FROM productos p
                LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
                LEFT JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                ORDER BY p.id_producto
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
        cargar_productos(search_entry.get())

    search_entry.bind("<KeyRelease>", buscar_producto)

    def guardar_cambios_tabla():
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            for row in tabla_productos.get_children():
                values = list(tabla_productos.item(row, "values"))
                id_producto = tabla_productos.item(row, "text")
                try:
                    precio_compra = float(values[5])
                    precio_venta  = float(values[6])
                    stock         = int(values[7])
                    stock_minimo  = int(values[8])
                    if precio_compra <= 0 or precio_venta <= 0 or stock < 0 or stock_minimo < 0:
                        raise ValueError("Los valores numéricos deben ser positivos")
                except ValueError:
                    messagebox.showerror("Error", f"Error en los valores numéricos del producto {id_producto}")
                    return

                cursor.execute("SELECT id_categoria FROM categorias WHERE nombre = %s", (values[3],))
                id_categoria = cursor.fetchone()
                cursor.execute("SELECT id_proveedor FROM proveedores WHERE nombre = %s", (values[4],))
                id_proveedor = cursor.fetchone()

                if id_categoria and id_proveedor:
                    id_categoria = id_categoria[0]
                    id_proveedor = id_proveedor[0]

                    cursor.execute("SELECT stock FROM productos WHERE id_producto = %s", (id_producto,))
                    stock_actual = cursor.fetchone()[0]

                    cursor.execute("""
                        UPDATE productos
                        SET nombre=%s, descripcion=%s, id_categoria=%s, id_proveedor=%s,
                            precio_compra=%s, precio_venta=%s, stock=%s, stock_minimo=%s
                        WHERE id_producto=%s
                    """, (values[1], values[2], id_categoria, id_proveedor,
                          precio_compra, precio_venta, stock, stock_minimo, id_producto))

                    diferencia_stock = stock - stock_actual
                    if diferencia_stock != 0:
                        tipo_movimiento = 'entrada' if diferencia_stock > 0 else 'salida'
                        cursor.execute("""
                            INSERT INTO movimientos_inventario (id_producto, cantidad, precio_unitario, tipo_movimiento, motivo)
                            VALUES (%s, %s, %s, %s, 'Edicion de producto')
                        """, (id_producto, abs(diferencia_stock), precio_venta, tipo_movimiento))
                    conn.commit()
                else:
                    messagebox.showerror("Error", "Categoría o proveedor no encontrado")
                    return

            cursor.close()
            conn.close()
            messagebox.showinfo("Éxito", "Productos actualizados correctamente")
            cargar_productos()

    def make_cell_editable(event):
        if not tabla_productos.selection():
            return
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
        if not tabla_productos.selection():
            return
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
            conn = database.conectar_db()
            if conn:
                cats = [c[1] for c in database.ejecutar_consulta(conn, "SELECT id_categoria, nombre FROM categorias")]
                conn.close()
                make_combobox_editable(event, cats, 3)
        elif column_index == 4:
            conn = database.conectar_db()
            if conn:
                provs = [p[1] for p in database.ejecutar_consulta(conn, "SELECT id_proveedor, nombre FROM proveedores")]
                conn.close()
                make_combobox_editable(event, provs, 4)
        else:
            make_cell_editable(event)

    tabla_productos.bind("<Double-1>", on_double_click)

    btn_frame = tk.Frame(products_frame, bg=frame_bg)
    btn_frame.pack(pady=10)

    def cerrar_editar_producto():
        products_frame.destroy()

    actualizar_button = tk.Button(btn_frame, text="✔  Actualizar Productos",
                                  command=guardar_cambios_tabla,
                                  bg=button_bg, fg=button_fg, font=bold_font,
                                  relief="flat", padx=20, pady=8, cursor="hand2")
    actualizar_button.pack(side="left", padx=(0, 10))
    ToolTip(actualizar_button, "Guarda los cambios realizados en la tabla")

    btn_cerrar = tk.Button(btn_frame, text="✖  Cerrar",
                           command=cerrar_editar_producto,
                           bg=danger_bg, fg=button_fg, font=bold_font,
                           relief="flat", padx=20, pady=8, cursor="hand2")
    btn_cerrar.pack(side="left")

def eliminar_producto():
    products_frame = tk.Frame(container, bg=frame_bg)
    products_frame.grid(row=0, column=1, sticky="nsew")

    header = tk.Frame(products_frame, bg=danger_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="🗑️  Eliminar Producto",
             font=heading_font, bg=danger_bg, fg="white").pack(side="left", padx=20, pady=12)

    search_frame = tk.Frame(products_frame, bg=frame_bg)
    search_frame.pack(fill="x", padx=20, pady=(12, 5))

    tk.Label(search_frame, text="🔍 Buscar producto:",
             bg=frame_bg, fg=label_bg, font=bold_font).pack(side="left", padx=(0, 8))
    search_entry = tk.Entry(search_frame, width=40, font=default_font,
                            relief="solid", bd=1)
    search_entry.pack(side="left")

    hint = tk.Label(products_frame,
                    text="⚠️  Doble clic sobre un producto para eliminarlo",
                    bg=frame_bg, fg="#E74C3C", font=('Segoe UI', 9, 'italic'))
    hint.pack(anchor="w", padx=20, pady=(0, 4))

    tabla_frame = tk.Frame(products_frame, bg=frame_bg)
    tabla_frame.pack(fill="both", expand=True, padx=20, pady=(0, 5))

    tabla_productos = ttk.Treeview(tabla_frame, columns=("Nombre", "Precio", "Stock"),
                                   show="headings", style="Modern.Treeview")
    tabla_productos.heading("Nombre", text="Nombre", anchor="center")
    tabla_productos.heading("Precio", text="Precio Venta", anchor="center")
    tabla_productos.heading("Stock",  text="Stock",  anchor="center")
    tabla_productos.column("Nombre", anchor="center", width=300)
    tabla_productos.column("Precio", anchor="center", width=150)
    tabla_productos.column("Stock",  anchor="center", width=150)

    scroll_y = ttk.Scrollbar(tabla_frame, orient="vertical",   command=tabla_productos.yview)
    scroll_x = ttk.Scrollbar(tabla_frame, orient="horizontal", command=tabla_productos.xview)
    tabla_productos.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)

    scroll_y.pack(side="right",  fill="y")
    scroll_x.pack(side="bottom", fill="x")
    tabla_productos.pack(fill="both", expand=True)

    def cargar_productos(filtro=None):
        for item in tabla_productos.get_children():
            tabla_productos.delete(item)
        conn = database.conectar_db()
        if conn:
            productos = database.ejecutar_consulta(
                conn, "SELECT id_producto, nombre, precio_venta, stock FROM productos ORDER BY id_producto")
            conn.close()
            for p in productos:
                if filtro and filtro.lower() not in p[1].lower():
                    continue
                tabla_productos.insert("", "end", text=p[0], values=(p[1], p[2], p[3]))
        else:
            print("Error: No se pudo conectar a la base de datos")

    cargar_productos()

    def buscar_producto(event):
        cargar_productos(search_entry.get())

    search_entry.bind("<KeyRelease>", buscar_producto)

    def confirmar_eliminacion(event):
        seleccion = tabla_productos.selection()
        if seleccion:
            item = tabla_productos.item(seleccion[0])
            id_producto     = item['text']
            nombre_producto = item['values'][0]
            respuesta = messagebox.askyesno("Confirmar Eliminación",
                                            f"¿Está seguro que desea eliminar el producto '{nombre_producto}'?")
            if respuesta:
                conn = database.conectar_db()
                if conn:
                    cursor = conn.cursor()
                    cursor.execute("DELETE FROM detalle_ventas WHERE id_producto = %s", (id_producto,))
                    cursor.execute("DELETE FROM movimientos_inventario WHERE id_producto = %s", (id_producto,))
                    cursor.execute("DELETE FROM productos WHERE id_producto = %s", (id_producto,))
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

    btn_frame = tk.Frame(products_frame, bg=frame_bg)
    btn_frame.pack(pady=10)

    btn_cerrar = tk.Button(btn_frame, text="✖  Cerrar",
                           command=cerrar_tabla_productos,
                           bg=danger_bg, fg=button_fg, font=bold_font,
                           relief="flat", padx=20, pady=8, cursor="hand2")
    btn_cerrar.pack()


def agregar_proveedor():
    ventana = tk.Toplevel(root)
    configurar_ventana_emergente(ventana, "Agregar Proveedor", 460, 280)

    header = tk.Frame(ventana, bg=label_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="🚚  Agregar Proveedor",
             font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

    body = tk.Frame(ventana, bg=frame_bg)
    body.pack(fill="both", expand=True, padx=20, pady=15)

    sec = ttk.LabelFrame(body, text=" 📋 Datos del Proveedor ", padding=12)
    sec.pack(fill="x")
    sec.columnconfigure(1, weight=1)

    ttk.Label(sec, text="🏢 Nombre:", font=bold_font).grid(row=0, column=0, sticky="e", padx=5, pady=8)
    entry_nombre = ttk.Entry(sec, font=default_font, width=30)
    entry_nombre.grid(row=0, column=1, sticky="ew", padx=5, pady=8)

    ttk.Label(sec, text="📞 Contacto:", font=bold_font).grid(row=1, column=0, sticky="e", padx=5, pady=8)
    entry_contacto = ttk.Entry(sec, font=default_font, width=30)
    entry_contacto.grid(row=1, column=1, sticky="ew", padx=5, pady=8)

    def guardar_proveedor():
        nombre   = entry_nombre.get()
        contacto = entry_contacto.get()
        if not nombre:
            messagebox.showerror("Error", "El nombre del proveedor es obligatorio")
            return
        conn = database.conectar_db()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("INSERT INTO proveedores (nombre, contacto) VALUES (%s, %s)",
                               (nombre, contacto))
                conn.commit()
                messagebox.showinfo("Éxito", "Proveedor agregado correctamente")
                ventana.destroy()
            except Exception as e:
                messagebox.showerror("Error", f"No se pudo agregar el proveedor. Error: {e}")
            finally:
                cursor.close()
                conn.close()
        else:
            print("Error: No se pudo conectar a la base de datos")

    btn_frame = tk.Frame(ventana, bg=frame_bg)
    btn_frame.pack(pady=10)
    btn = ttk.Button(btn_frame, text="✔  Guardar Proveedor",
                     command=guardar_proveedor, style="Accent.TButton")
    btn.pack(ipadx=20, ipady=6)
    ToolTip(btn, "Guarda el proveedor en la base de datos")

def ver_proveedores():
    prov_frame = tk.Frame(container, bg=frame_bg)
    prov_frame.grid(row=0, column=1, sticky="nsew")

    header = tk.Frame(prov_frame, bg=label_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="🚚  Proveedores",
             font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

    search_frame = tk.Frame(prov_frame, bg=frame_bg)
    search_frame.pack(fill="x", padx=20, pady=(12, 5))

    tk.Label(search_frame, text="🔍 Buscar proveedor:",
             bg=frame_bg, fg=label_bg, font=bold_font).pack(side="left", padx=(0, 8))
    search_entry = tk.Entry(search_frame, width=40, font=default_font,
                            relief="solid", bd=1)
    search_entry.pack(side="left")

    hint = tk.Label(prov_frame,
                    text="💡 Doble clic sobre una celda para editarla",
                    bg=frame_bg, fg="#7F8C8D", font=('Segoe UI', 9, 'italic'))
    hint.pack(anchor="w", padx=20, pady=(0, 4))

    tabla_frame = tk.Frame(prov_frame, bg=frame_bg)
    tabla_frame.pack(fill="both", expand=True, padx=20, pady=(0, 5))

    columnas = ("ID", "Nombre", "Contacto")
    tabla_proveedores = ttk.Treeview(tabla_frame, columns=columnas,
                                     show="headings", style="Modern.Treeview")
    tabla_proveedores.heading("ID",       text="ID",       anchor="center")
    tabla_proveedores.heading("Nombre",   text="Nombre",   anchor="center")
    tabla_proveedores.heading("Contacto", text="Contacto", anchor="center")
    tabla_proveedores.column("ID",       anchor="center", width=60,  stretch=False)
    tabla_proveedores.column("Nombre",   anchor="center", width=250)
    tabla_proveedores.column("Contacto", anchor="center", width=250)

    scroll_y = ttk.Scrollbar(tabla_frame, orient="vertical",   command=tabla_proveedores.yview)
    scroll_x = ttk.Scrollbar(tabla_frame, orient="horizontal", command=tabla_proveedores.xview)
    tabla_proveedores.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)

    scroll_y.pack(side="right",  fill="y")
    scroll_x.pack(side="bottom", fill="x")
    tabla_proveedores.pack(fill="both", expand=True)

    def cargar_proveedores(filtro=None):
        for item in tabla_proveedores.get_children():
            tabla_proveedores.delete(item)
        conn = database.conectar_db()
        if conn:
            proveedores = database.ejecutar_consulta(
                conn, "SELECT id_proveedor, nombre, contacto FROM proveedores ORDER BY id_proveedor")
            conn.close()
            for p in proveedores:
                if filtro and filtro.lower() not in p[1].lower():
                    continue
                tabla_proveedores.insert("", "end", text=p[0], values=(p[0], p[1], p[2]))
        else:
            print("Error: No se pudo conectar a la base de datos")

    cargar_proveedores()

    def buscar_proveedor(event):
        cargar_proveedores(search_entry.get())

    search_entry.bind("<KeyRelease>", buscar_proveedor)

    def make_cell_editable(event):
        if not tabla_proveedores.selection():
            return
        row_id = tabla_proveedores.selection()[0]
        column = tabla_proveedores.identify_column(event.x)
        column_index = int(column[1:]) - 1
        if column_index == 0: 
            return
        x, y, width, height = tabla_proveedores.bbox(row_id, column)
        entry = ttk.Entry(tabla_proveedores, width=width)
        entry.place(x=x, y=y, width=width, height=height)
        entry.insert(0, tabla_proveedores.item(row_id, 'values')[column_index])
        entry.focus()
        def save_edit(event):
            tabla_proveedores.set(row_id, column=column, value=entry.get())
            entry.destroy()
        entry.bind("<Return>",   save_edit)
        entry.bind("<FocusOut>", save_edit)

    tabla_proveedores.bind("<Double-1>", make_cell_editable)

    def guardar_cambios():
        conn = database.conectar_db()
        if conn:
            try:
                cursor = conn.cursor()
                for row in tabla_proveedores.get_children():
                    values      = tabla_proveedores.item(row, "values")
                    id_proveedor = tabla_proveedores.item(row, "text")
                    nombre   = values[1]
                    contacto = values[2]
                    if not nombre:
                        messagebox.showerror("Error", f"El nombre del proveedor ID {id_proveedor} no puede estar vacío")
                        return
                    cursor.execute("""
                        UPDATE proveedores
                        SET nombre = %s, contacto = %s
                        WHERE id_proveedor = %s
                    """, (nombre, contacto, id_proveedor))
                conn.commit()
                messagebox.showinfo("Éxito", "Proveedores actualizados correctamente")
                cargar_proveedores()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", f"No se pudieron guardar los cambios. Error: {e}")
            finally:
                cursor.close()
                conn.close()
        else:
            messagebox.showerror("Error", "No se pudo conectar a la base de datos")

    btn_frame = tk.Frame(prov_frame, bg=frame_bg)
    btn_frame.pack(pady=10)

    def cerrar_ver_proveedores():
        prov_frame.destroy()

    btn_actualizar = tk.Button(btn_frame, text="✔  Actualizar Proveedores",
                               command=guardar_cambios,
                               bg=button_bg, fg=button_fg, font=bold_font,
                               relief="flat", padx=20, pady=8, cursor="hand2")
    btn_actualizar.pack(side="left", padx=(0, 10))
    ToolTip(btn_actualizar, "Guarda los cambios realizados en la tabla")

    btn_cerrar = tk.Button(btn_frame, text="✖  Cerrar",
                           command=cerrar_ver_proveedores,
                           bg=danger_bg, fg=button_fg, font=bold_font,
                           relief="flat", padx=20, pady=8, cursor="hand2")
    btn_cerrar.pack(side="left")

# 7. VENTAS
ventana_ventas = None

def mostrar_pantalla_ventas():
    global sales_frame
    if sales_frame is not None:
        sales_frame.destroy()
    sales_frame = tk.Frame(container, bg=frame_bg)
    sales_frame.grid(row=0, column=1, sticky='nsew')

    background_image_ref_sales = [None]

    def resize_background(event):
        w, h = event.width, event.height
        img = ima.open(resource_path("ondo3.png")).resize((w, h), ima.Resampling.LANCZOS)
        background_image_ref_sales[0] = ImageTk.PhotoImage(img)
        background_label.config(image=background_image_ref_sales[0])
        background_label.image = background_image_ref_sales[0]

    background_label = tk.Label(sales_frame)
    background_label.place(x=0, y=0, relwidth=1, relheight=1)
    sales_frame.bind("<Configure>", resize_background)

    left_panel = tk.Frame(sales_frame, bg=frame_bg, bd=0)
    left_panel.pack(side="left", fill="both", expand=True, padx=(10, 5), pady=10)

    left_header = tk.Frame(left_panel, bg=label_bg, height=45)
    left_header.pack(fill="x")
    left_header.pack_propagate(False)
    tk.Label(left_header, text="🛒  Productos Disponibles",
             font=bold_font, bg=label_bg, fg="white").pack(side="left", padx=15, pady=10)

    busqueda_frame = tk.Frame(left_panel, bg=frame_bg)
    busqueda_frame.pack(fill="x", pady=(8, 4))
    tk.Label(busqueda_frame, text="🔍", bg=frame_bg,
             font=('Segoe UI', 11)).pack(side="left", padx=(4, 2))
    entry_busqueda = tk.Entry(busqueda_frame, font=default_font, relief="solid", bd=1)
    entry_busqueda.pack(side="left", fill="x", expand=True, padx=(0, 4))
    tk.Button(busqueda_frame, text="Buscar",  command=lambda: buscar_producto(),
              bg=button_bg, fg=button_fg, font=default_font,
              relief="flat", padx=8, cursor="hand2").pack(side="left", padx=2)
    tk.Button(busqueda_frame, text="↺ Refresh", command=lambda: refrescar_tabla(),
              bg=label_bg, fg="white", font=default_font,
              relief="flat", padx=8, cursor="hand2").pack(side="left", padx=2)

    tk.Label(left_panel, text="💡 Doble clic sobre un producto para agregarlo al carrito",
             bg=frame_bg, fg="#7F8C8D", font=('Segoe UI', 9, 'italic')).pack(anchor="w", padx=4)

    tabla_left_frame = tk.Frame(left_panel, bg=frame_bg)
    tabla_left_frame.pack(fill="both", expand=True, pady=(4, 0))

    tabla_productos_disponibles = ttk.Treeview(tabla_left_frame,
        columns=("ID", "Nombre", "Precio", "Stock"), show="headings", style="Modern.Treeview")
    tabla_productos_disponibles.heading("ID",     text="ID",     anchor="center")
    tabla_productos_disponibles.heading("Nombre", text="Nombre", anchor="center")
    tabla_productos_disponibles.heading("Precio", text="Precio", anchor="center")
    tabla_productos_disponibles.heading("Stock",  text="Stock",  anchor="center")
    tabla_productos_disponibles.column("ID",     width=50,  anchor="center", stretch=False)
    tabla_productos_disponibles.column("Nombre", width=200, anchor="center")
    tabla_productos_disponibles.column("Precio", width=100, anchor="center")
    tabla_productos_disponibles.column("Stock",  width=80,  anchor="center")

    scroll_prod = ttk.Scrollbar(tabla_left_frame, orient="vertical",
                                command=tabla_productos_disponibles.yview)
    tabla_productos_disponibles.configure(yscrollcommand=scroll_prod.set)
    scroll_prod.pack(side="right", fill="y")
    tabla_productos_disponibles.pack(fill="both", expand=True)

    def cargar_productos_disponibles():
        for item in tabla_productos_disponibles.get_children():
            tabla_productos_disponibles.delete(item)
        conn = database.conectar_db()
        if conn:
            productos = database.ejecutar_consulta(
                conn, "SELECT id_producto, nombre, precio_venta, stock FROM productos ORDER BY id_producto")
            conn.close()
            for p in productos:
                tabla_productos_disponibles.insert("", tk.END, values=p)

    cargar_productos_disponibles()

    def buscar_producto():
        term = entry_busqueda.get().lower()
        conn = database.conectar_db()
        if conn:
            prods = database.ejecutar_consulta(
                conn,
                "SELECT id_producto, nombre, precio_venta, stock FROM productos WHERE LOWER(nombre) LIKE %s",
                (f"%{term}%",))
            conn.close()
            for item in tabla_productos_disponibles.get_children():
                tabla_productos_disponibles.delete(item)
            for p in prods:
                tabla_productos_disponibles.insert("", tk.END, values=p)

    def refrescar_tabla():
        entry_busqueda.delete(0, tk.END)
        cargar_productos_disponibles()

    right_panel = tk.Frame(sales_frame, bg=menu_bg, bd=0)
    right_panel.pack(side="right", fill="both", expand=True, padx=(5, 10), pady=10)

    bg_carrito_ref = [None]

    def resize_carrito(event):
        w, h = event.width, event.height
        img = ima.open(resource_path("ondo_venta.jpg")).resize((w, h), ima.Resampling.LANCZOS)
        bg_carrito_ref[0] = ImageTk.PhotoImage(img)
        bg_label_carrito.config(image=bg_carrito_ref[0])
        bg_label_carrito.image = bg_carrito_ref[0]

    bg_label_carrito = tk.Label(right_panel)
    bg_label_carrito.place(x=0, y=0, relwidth=1, relheight=1)
    right_panel.bind("<Configure>", resize_carrito)

    cart_header = tk.Frame(right_panel, bg=button_bg, height=45)
    cart_header.pack(fill="x")
    cart_header.pack_propagate(False)
    tk.Label(cart_header, text="🧾  Carrito de Compras",
             font=bold_font, bg=button_bg, fg="white").pack(side="left", padx=15, pady=10)

    tabla_cart_frame = tk.Frame(right_panel, bg=menu_bg)
    tabla_cart_frame.pack(fill="both", expand=True, padx=8, pady=(8, 0))

    tabla_reporte_producto = ttk.Treeview(tabla_cart_frame,
        columns=("Nombre", "Cantidad", "Precio Unitario", "Precio Total"),
        show="headings", style="Modern.Treeview")
    tabla_reporte_producto.heading("Nombre",         text="Nombre",         anchor="center")
    tabla_reporte_producto.heading("Cantidad",        text="Cantidad",       anchor="center")
    tabla_reporte_producto.heading("Precio Unitario", text="P. Unitario",    anchor="center")
    tabla_reporte_producto.heading("Precio Total",    text="P. Total",       anchor="center")
    tabla_reporte_producto.column("Nombre",          width=160, anchor="center")
    tabla_reporte_producto.column("Cantidad",         width=70,  anchor="center")
    tabla_reporte_producto.column("Precio Unitario",  width=90,  anchor="center")
    tabla_reporte_producto.column("Precio Total",     width=90,  anchor="center")

    scroll_cart = ttk.Scrollbar(tabla_cart_frame, orient="vertical",
                                command=tabla_reporte_producto.yview)
    tabla_reporte_producto.configure(yscrollcommand=scroll_cart.set)
    scroll_cart.pack(side="right", fill="y")
    tabla_reporte_producto.pack(fill="both", expand=True)

    bottom_frame = tk.Frame(right_panel, bg=menu_bg)
    bottom_frame.pack(fill="x", padx=8, pady=6)

    total_row = tk.Frame(bottom_frame, bg=label_bg, height=40)
    total_row.pack(fill="x", pady=(0, 6))
    total_row.pack_propagate(False)
    tk.Label(total_row, text="💰 Total:",
             bg=label_bg, fg="white", font=bold_font).pack(side="left", padx=12, pady=8)
    label_total = tk.Label(total_row, text="$0.00",
                           bg=label_bg, fg="#2ECC71", font=title_font)
    label_total.pack(side="left")

    pago_row = tk.Frame(bottom_frame, bg=menu_bg)
    pago_row.pack(fill="x", pady=(0, 6))

    def validar_pago(char):
        return char.isdigit() or char == "."

    vcmd = (root.register(validar_pago), '%S')
    tk.Label(pago_row, text="💵 Pago:", font=bold_font,
             bg=menu_bg, fg="white").pack(side="left", padx=(0, 4))
    entry_pago = tk.Entry(pago_row, font=default_font, validate="key",
                          validatecommand=vcmd, width=10, relief="solid", bd=1)
    entry_pago.pack(side="left", padx=(0, 10))
    label_cambio = tk.Label(pago_row, text="Cambio: $0.00",
                            font=bold_font, bg=menu_bg, fg="#F39C12")
    label_cambio.pack(side="left")

    def obtener_float_de_label(label):
        texto = label.cget("text")
        numero_str = ''.join(filter(lambda x: x.isdigit() or x == '.', texto))
        return float(numero_str) if numero_str else 0.0

    def calcular_total():
        total = 0.0
        for row in tabla_reporte_producto.get_children():
            total += float(tabla_reporte_producto.item(row)['values'][3])
        label_total.config(text=f"${total:.2f}")
        actualizar_cambio(None)

    def actualizar_cambio(event):
        try:
            pago = float(entry_pago.get()) if entry_pago.get() else 0
            total_precio = obtener_float_de_label(label_total)
            cambio = pago - total_precio
            label_cambio.config(text=f"Cambio: ${cambio:.2f}")
        except ValueError:
            label_cambio.config(text="Cambio: $0.00")

    entry_pago.bind("<KeyRelease>", actualizar_cambio)

    btn_row = tk.Frame(bottom_frame, bg=menu_bg)
    btn_row.pack(fill="x")

    def eliminar_del_carrito():
        seleccion = tabla_reporte_producto.selection()
        if seleccion:
            item_id = seleccion[0]
            item    = tabla_reporte_producto.item(item_id)
            nombre  = item['values'][0]
            cantidad = int(item['values'][1])
            if cantidad > 1:
                nueva_cantidad  = cantidad - 1
                precio_unitario = float(item['values'][2])
                tabla_reporte_producto.item(item_id,
                    values=(nombre, nueva_cantidad, precio_unitario, nueva_cantidad * precio_unitario))
            else:
                tabla_reporte_producto.delete(item_id)
            calcular_total()
        else:
            messagebox.showwarning("Advertencia", "Selecciona un producto para eliminar")

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
                    nombre_producto    = item['values'][0]
                    cantidad_a_comprar = int(item['values'][1])
                    resultado_stock = database.ejecutar_consulta(
                        conn, "SELECT stock FROM productos WHERE nombre = %s", (nombre_producto,))
                    if resultado_stock:
                        if resultado_stock[0][0] < cantidad_a_comprar:
                            messagebox.showerror("Error", f"No hay suficiente stock de {nombre_producto}")
                            conn.rollback()
                            return
                    else:
                        messagebox.showerror("Error", f"Producto {nombre_producto} no encontrado")
                        conn.rollback()
                        return

                resultado_venta = database.ejecutar_consulta(
                    conn, "INSERT INTO ventas (total, id_usuario) VALUES (%s, %s) RETURNING id_venta",
                    (total_venta, 1))
                if resultado_venta:
                    id_venta = resultado_venta[0][0]
                    for row in tabla_reporte_producto.get_children():
                        item            = tabla_reporte_producto.item(row)
                        nombre_producto = item['values'][0]
                        cantidad        = int(item['values'][1])
                        precio_unitario = float(item['values'][2])

                        resultado_producto = database.ejecutar_consulta(
                            conn,
                            "SELECT id_producto, stock, stock_minimo FROM productos WHERE nombre = %s",
                            (nombre_producto,))
                        if resultado_producto:
                            id_producto, stock_actual, stock_minimo = resultado_producto[0]
                            nuevo_stock = stock_actual - cantidad
                            database.ejecutar_consulta(
                                conn, "UPDATE productos SET stock = %s WHERE id_producto = %s",
                                (nuevo_stock, id_producto))
                            if nuevo_stock <= stock_minimo:
                                messagebox.showwarning("Advertencia",
                                    f"El stock de {nombre_producto} está bajo ({nuevo_stock} unidades)")
                            database.ejecutar_consulta(conn,
                                "INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES (%s, %s, %s, %s)",
                                (id_venta, id_producto, cantidad, precio_unitario))
                            database.ejecutar_consulta(conn, """
                                INSERT INTO movimientos_inventario (id_producto, cantidad, precio_unitario, tipo_movimiento, motivo)
                                VALUES (%s, %s, %s, 'salida', 'Venta de producto')
                            """, (id_producto, cantidad, precio_unitario))

                    for item in tabla_reporte_producto.get_children():
                        tabla_reporte_producto.delete(item)
                    calcular_total()
                    entry_pago.delete(0, tk.END)
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

    tk.Button(btn_row, text="➖  Quitar del Carrito",
              command=eliminar_del_carrito,
              bg=danger_bg, fg=button_fg, font=bold_font,
              relief="flat", padx=12, pady=6, cursor="hand2").pack(side="left", padx=(0, 6))

    tk.Button(btn_row, text="✔  Realizar Compra",
              command=realizar_compra,
              bg=success_bg, fg=button_fg, font=bold_font,
              relief="flat", padx=12, pady=6, cursor="hand2").pack(side="left")

    tk.Button(btn_row, text="✖  Cerrar",
              command=lambda: sales_frame.destroy(),
              bg="#7F8C8D", fg=button_fg, font=bold_font,
              relief="flat", padx=12, pady=6, cursor="hand2").pack(side="right")

    def agregar_al_carrito(event):
        item = tabla_productos_disponibles.identify_row(event.y)
        if item:
            prod   = tabla_productos_disponibles.item(item)
            nombre = prod['values'][1]
            precio = float(prod['values'][2])
            existe = False
            for row in tabla_reporte_producto.get_children():
                if tabla_reporte_producto.item(row)['values'][0] == nombre:
                    cant_act = int(tabla_reporte_producto.item(row)['values'][1])
                    nueva    = cant_act + 1
                    tabla_reporte_producto.item(row, values=(nombre, nueva, precio, nueva * precio))
                    existe = True
                    break
            if not existe:
                tabla_reporte_producto.insert("", tk.END, values=(nombre, 1, precio, precio))
            calcular_total()

    tabla_productos_disponibles.bind("<Double-Button-1>", agregar_al_carrito)

def ver_ventas():
    mostrar_pantalla_ventas()

def ver_reportes_ventas():
    mostrar_pantalla_ver_ventas(5)

def ver_reportes_ventas2():
    mostrar_pantalla_ver_ventas(0)

# 8. FUNCIONES DE DATOS DE VENTAS
def obtener_ventas_dia(fecha):
    conn = database.conectar_db()
    if conn:
        total_ingresos = database.ejecutar_consulta(conn,
            "SELECT SUM(total) FROM ventas WHERE DATE(fecha) = %s", (fecha,))[0][0] or 0
        total_ganancias = database.ejecutar_consulta(conn, """
            SELECT SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            JOIN productos p ON dv.id_producto = p.id_producto
            WHERE DATE(v.fecha) = %s
        """, (fecha,))[0][0] or 0
        cantidad_productos = database.ejecutar_consulta(conn, """
            SELECT SUM(dv.cantidad) FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta WHERE DATE(v.fecha) = %s
        """, (fecha,))[0][0] or 0
        cantidad_ventas = database.ejecutar_consulta(conn,
            "SELECT COUNT(*) FROM ventas WHERE DATE(fecha) = %s", (fecha,))[0][0] or 0
        conn.close()
        return total_ingresos, total_ganancias, cantidad_productos, cantidad_ventas
    return 0, 0, 0, 0

def actualizar_ventas_dia(fecha=None):
    if fecha is None:
        fecha = date.today()
    i, g, cp, cv = obtener_ventas_dia(fecha)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${i:.2f}")
    data_labels_ventas_dia["Total de ganancias:"].config(text=f"${g:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cp)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cv)

def obtener_ventas_semana(año, semana):
    conn = database.conectar_db()
    if conn:
        total_ingresos = database.ejecutar_consulta(conn,
            "SELECT SUM(total) FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s AND EXTRACT(WEEK FROM fecha)=%s",
            (año, semana))[0][0] or 0
        total_ganancias = database.ejecutar_consulta(conn, """
            SELECT SUM((dv.precio_unitario - p.precio_compra)*dv.cantidad)
            FROM detalle_ventas dv JOIN ventas v ON dv.id_venta=v.id_venta
            JOIN productos p ON dv.id_producto=p.id_producto
            WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(WEEK FROM v.fecha)=%s
        """, (año, semana))[0][0] or 0
        cantidad_productos = database.ejecutar_consulta(conn, """
            SELECT SUM(dv.cantidad) FROM detalle_ventas dv JOIN ventas v ON dv.id_venta=v.id_venta
            WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(WEEK FROM v.fecha)=%s
        """, (año, semana))[0][0] or 0
        cantidad_ventas = database.ejecutar_consulta(conn,
            "SELECT COUNT(*) FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s AND EXTRACT(WEEK FROM fecha)=%s",
            (año, semana))[0][0] or 0
        conn.close()
        return total_ingresos, total_ganancias, cantidad_productos, cantidad_ventas
    return 0, 0, 0, 0

def actualizar_ventas_semana(año, semana):
    i, g, cp, cv = obtener_ventas_semana(año, semana)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${i:.2f}")
    data_labels_ventas_dia["Total de ganancias:"].config(text=f"${g:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cp)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cv)

def obtener_ventas_mes(año, mes):
    conn = database.conectar_db()
    if conn:
        total_ingresos = database.ejecutar_consulta(conn,
            "SELECT SUM(total) FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s AND EXTRACT(MONTH FROM fecha)=%s",
            (año, mes))[0][0] or 0
        total_ganancias = database.ejecutar_consulta(conn, """
            SELECT SUM((dv.precio_unitario - p.precio_compra)*dv.cantidad)
            FROM detalle_ventas dv JOIN ventas v ON dv.id_venta=v.id_venta
            JOIN productos p ON dv.id_producto=p.id_producto
            WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(MONTH FROM v.fecha)=%s
        """, (año, mes))[0][0] or 0
        cantidad_productos = database.ejecutar_consulta(conn, """
            SELECT SUM(dv.cantidad) FROM detalle_ventas dv JOIN ventas v ON dv.id_venta=v.id_venta
            WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(MONTH FROM v.fecha)=%s
        """, (año, mes))[0][0] or 0
        cantidad_ventas = database.ejecutar_consulta(conn,
            "SELECT COUNT(*) FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s AND EXTRACT(MONTH FROM fecha)=%s",
            (año, mes))[0][0] or 0
        conn.close()
        return total_ingresos, total_ganancias, cantidad_productos, cantidad_ventas
    return 0, 0, 0, 0

def actualizar_ventas_mes(año, mes):
    i, g, cp, cv = obtener_ventas_mes(año, mes)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${i:.2f}")
    data_labels_ventas_dia["Total de ganancias:"].config(text=f"${g:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cp)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cv)

def obtener_ventas_año(año):
    conn = database.conectar_db()
    if conn:
        total_ingresos = database.ejecutar_consulta(conn,
            "SELECT SUM(total) FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s", (año,))[0][0] or 0
        total_ganancias = database.ejecutar_consulta(conn, """
            SELECT SUM((dv.precio_unitario - p.precio_compra)*dv.cantidad)
            FROM detalle_ventas dv JOIN ventas v ON dv.id_venta=v.id_venta
            JOIN productos p ON dv.id_producto=p.id_producto
            WHERE EXTRACT(YEAR FROM v.fecha)=%s
        """, (año,))[0][0] or 0
        cantidad_productos = database.ejecutar_consulta(conn, """
            SELECT SUM(dv.cantidad) FROM detalle_ventas dv JOIN ventas v ON dv.id_venta=v.id_venta
            WHERE EXTRACT(YEAR FROM v.fecha)=%s
        """, (año,))[0][0] or 0
        cantidad_ventas = database.ejecutar_consulta(conn,
            "SELECT COUNT(*) FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s", (año,))[0][0] or 0
        conn.close()
        return total_ingresos, total_ganancias, cantidad_productos, cantidad_ventas
    return 0, 0, 0, 0

def actualizar_ventas_año(año):
    i, g, cp, cv = obtener_ventas_año(año)
    data_labels_ventas_dia["Total de ingresos:"].config(text=f"${i:.2f}")
    data_labels_ventas_dia["Total de ganancias:"].config(text=f"${g:.2f}")
    data_labels_ventas_dia["Cantidad de productos vendidos:"].config(text=cp)
    data_labels_ventas_dia["Cantidad de ventas realizadas:"].config(text=cv)

# 9. PANTALLA "VER VENTAS"
toolbar_frame      = None
title_frame        = None
data_frame         = None
data_values_frame  = None
image_frame        = None
photo_ventas       = None
data_labels        = {}
btn_por_dia        = None
btn_por_categoría  = None
btn_por_producto   = None
btn_por_hora       = None
btn_dia            = None
btn_semana         = None
btn_mes            = None
btn_año            = None
data_labels_ventas_dia = {}


def mostrar_pantalla_ver_ventas(mostrar_botones=True):
    global toolbar_frame, title_frame, data_frame, data_values_frame, image_frame, photo_ventas
    global data_labels_ventas_dia, btn_por_dia, btn_por_categoría, btn_por_producto, btn_por_hora
    global btn_dia, btn_semana, btn_mes, btn_año

    show_frame(reports_frame)

    if toolbar_frame is None:

        header = tk.Frame(reports_frame, bg=label_bg, height=55)
        header.pack(fill="x")
        header.pack_propagate(False)
        tk.Label(header, text="📊  Reportes de Ventas",
                 font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

        toolbar_frame = tk.Frame(reports_frame, bg=menu_bg)
        toolbar_frame.pack(fill="x", padx=0, pady=0)

        nav_inner = tk.Frame(toolbar_frame, bg=menu_bg)
        nav_inner.pack(pady=10, padx=20)

        def make_nav_btn(parent, text, command):
            return tk.Button(parent, text=text, command=command,
                             bg=label_bg, fg="white", font=bold_font,
                             relief="flat", padx=14, pady=6, cursor="hand2",
                             activebackground=accent_bg, activeforeground="white")

        btn_por_dia       = make_nav_btn(nav_inner, "📋 Por Venta",     ver_reportes_ventas)
        btn_por_categoría = make_nav_btn(nav_inner, "🏷️ Por Categoría", mostrar_pantalla_reporte_categoria)
        btn_por_producto  = make_nav_btn(nav_inner, "📦 Por Producto",  mostrar_pantalla_reporte_producto)
        btn_por_hora      = make_nav_btn(nav_inner, "🕐 Por Hora",      mostrar_pantalla_reporte_hora)

        title_frame = tk.Frame(reports_frame, bg="")
        title_frame.pack(fill="x", padx=30, pady=(18, 0))
        tk.Label(title_frame, text="📅  Ventas del Día",
                 font=title_font, bg=frame_bg, fg=label_bg).pack(side="left")

        data_frame = tk.Frame(reports_frame, bg=frame_bg)
        data_frame.pack(fill="both", expand=True, padx=30, pady=15)

        bg_data_ref = [None]
        def resize_data_bg(event):
            w, h = event.width, event.height
            img = ima.open(resource_path("ondo_venta.jpg")).resize((w, h), ima.Resampling.LANCZOS)
            bg_data_ref[0] = ImageTk.PhotoImage(img)
            background_label_ventas.config(image=bg_data_ref[0])
            background_label_ventas.image = bg_data_ref[0]

        background_label_ventas = tk.Label(data_frame)
        background_label_ventas.place(x=0, y=0, relwidth=1, relheight=1)
        data_frame.bind("<Configure>", resize_data_bg)

        data_values_frame = tk.Frame(data_frame, bg="")
        data_values_frame.place(relx=0.27, rely=0.48, anchor="center")

        tarjetas = [
            ("💰 Total de Ingresos",           "$0.00", "#27AE60"),
            ("📈 Total de Ganancias",           "$0.00", "#2980B9"),
            ("📦 Productos Vendidos",           "0",     "#8E44AD"),
            ("🧾 Ventas Realizadas",            "0",     "#E67E22"),
        ]
        keys = ["Total de ingresos:", "Total de ganancias:",
                "Cantidad de productos vendidos:", "Cantidad de ventas realizadas:"]

        for i, ((titulo, valor_def, color), key) in enumerate(zip(tarjetas, keys)):
            card = tk.Frame(data_values_frame, bg=color, padx=18, pady=10)
            card.grid(row=i // 2, column=i % 2, padx=8, pady=8, sticky="ew")

            tk.Label(card, text=titulo,    bg=color, fg="white",
                     font=('Segoe UI', 9, 'bold')).pack(anchor="w")
            val = tk.Label(card, text=valor_def, bg=color, fg="white",
                           font=('Segoe UI', 18, 'bold'))
            val.pack(anchor="w", pady=(4, 0))
            data_labels_ventas_dia[key] = val

        image_frame = tk.Frame(data_frame, bg=frame_bg, width=250)
        image_frame.place(relx=0.73, rely=0.42, anchor="center")
        try:
            img = ima.open(resource_path("sales.png")).resize((250, 250), ima.Resampling.LANCZOS)
            photo_ventas = ImageTk.PhotoImage(img)
            tk.Label(image_frame, image=photo_ventas, bg=frame_bg).pack()
        except Exception:
            pass

        def mostrar_calendario_generico(titulo, callback):
            top = tk.Toplevel(root)
            configurar_ventana_emergente(top, titulo, 320, 320)
            cal = Calendar(top, font="Arial 12", selectmode='day',
                           year=date.today().year, month=date.today().month, day=date.today().day)
            cal.pack(fill="both", expand=True)
            def seleccionar():
                callback(cal.selection_get())
                top.destroy()
            ttk.Button(top, text="Seleccionar", command=seleccionar, style="Accent.TButton").pack(pady=10)

        def mostrar_calendario():
            mostrar_calendario_generico("Seleccionar Fecha", actualizar_ventas_dia)

        def mostrar_calendario_semana():
            def cb(fecha):
                año, semana = fecha.isocalendar()[:2]
                actualizar_ventas_semana(año, semana)
            mostrar_calendario_generico("Seleccionar Semana", cb)

        def mostrar_calendario_mes():
            def cb(fecha):
                actualizar_ventas_mes(fecha.year, fecha.month)
            mostrar_calendario_generico("Seleccionar Mes", cb)

        def mostrar_calendario_año():
            def cb(fecha):
                actualizar_ventas_año(fecha.year)
            mostrar_calendario_generico("Seleccionar Año", cb)

        bottom_bar = tk.Frame(reports_frame, bg="")
        bottom_bar.pack(fill="x", padx=30, pady=(0, 6))

        tk.Label(bottom_bar, text="Ver ventas por:",
                 bg=frame_bg, fg=label_bg, font=bold_font).pack(side="left", padx=(0, 12))

        def make_period_btn(parent, text, command, color):
            return tk.Button(parent, text=text, command=command,
                             bg=color, fg="white", font=bold_font,
                             relief="flat", padx=12, pady=5, cursor="hand2",
                             activebackground=label_bg, activeforeground="white")

        bottom_buttons_frame = tk.Frame(bottom_bar, bg="")
        bottom_buttons_frame.pack(side="left")

        btn_dia    = make_period_btn(bottom_buttons_frame, "📅 Día",    mostrar_calendario,        "#27AE60")
        btn_semana = make_period_btn(bottom_buttons_frame, "📅 Semana", mostrar_calendario_semana, "#2980B9")
        btn_mes    = make_period_btn(bottom_buttons_frame, "📅 Mes",    mostrar_calendario_mes,    "#8E44AD")
        btn_año    = make_period_btn(bottom_buttons_frame, "📅 Año",    mostrar_calendario_año,    "#E67E22")

        tk.Button(reports_frame, text="✖  Cerrar",
                  command=lambda: show_frame(welcome_frame),
                  bg=danger_bg, fg=button_fg, font=bold_font,
                  relief="flat", padx=14, pady=5, cursor="hand2"
                  ).pack(side="bottom", anchor="se", padx=20, pady=10)

    if mostrar_botones:
        btn_por_dia.pack(side="left", padx=6)
        btn_por_categoría.pack(side="left", padx=6)
        btn_por_producto.pack(side="left", padx=6)
        btn_por_hora.pack(side="left", padx=6)
        btn_dia.pack(side="left", padx=6)
        btn_semana.pack(side="left", padx=6)
        btn_mes.pack(side="left", padx=6)
        btn_año.pack(side="left", padx=6)
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

# 10. REPORTE POR CATEGORÍA
combobox_categoria     = None
calendario             = None
btn_mostrar_resultados = None
right_section_frame    = None
tabla_reporte_producto = None
tabla_reporte_hora     = None
reporte_categoria_frame = None
periodo_seleccionado   = None

label_bg2      = "#2980b9"
label_fg2      = "white"
frame_bg2      = "#ecf0f1"
button_bg2     = "#e67e22"
button_fg2     = "white"
highlight_bg2  = "#f0f0f0"
button_bg_blue2 = "#1D1454"


def mostrar_pantalla_reporte_categoria():
    global combobox_categoria, calendario, periodo_seleccionado, btn_mostrar_resultados
    global data_labels, data_values_frame, right_section_frame, title_frame, data_frame
    global toolbar_frame, reporte_categoria_frame

    if reporte_categoria_frame is not None:
        reporte_categoria_frame.destroy()

    reporte_categoria_frame = tk.Frame(container, bg="#1E2A38")
    reporte_categoria_frame.grid(row=0, column=1, sticky="nsew")

    bg_ref = [None]
    def resize_bg(event):
        w, h = event.width, event.height
        img = ima.open(resource_path("ondo2.webp")).resize((w, h), ima.Resampling.LANCZOS)
        bg_ref[0] = ImageTk.PhotoImage(img)
        bg_lbl.config(image=bg_ref[0])
        bg_lbl.image = bg_ref[0]
    bg_lbl = tk.Label(reporte_categoria_frame)
    bg_lbl.place(x=0, y=0, relwidth=1, relheight=1)
    reporte_categoria_frame.bind("<Configure>", resize_bg)
    show_frame(reporte_categoria_frame)

    header = tk.Frame(reporte_categoria_frame, bg=label_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="🏷️  Reporte por Categoría",
             font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

    toolbar_frame = tk.Frame(reporte_categoria_frame, bg=menu_bg)
    toolbar_frame.pack(fill="x")
    nav_inner = tk.Frame(toolbar_frame, bg=menu_bg)
    nav_inner.pack(pady=8, padx=20)

    def make_nav_btn(parent, text, command):
        return tk.Button(parent, text=text, command=command,
                         bg=label_bg, fg="white", font=bold_font,
                         relief="flat", padx=14, pady=6, cursor="hand2",
                         activebackground=accent_bg, activeforeground="white")

    make_nav_btn(nav_inner, "📋 Por Venta",     ver_reportes_ventas             ).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "🏷️ Por Categoría", mostrar_pantalla_reporte_categoria).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "📦 Por Producto",  mostrar_pantalla_reporte_producto ).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "🕐 Por Hora",      mostrar_pantalla_reporte_hora     ).pack(side="left", padx=6)

    body = tk.Frame(reporte_categoria_frame, bg="#1E2A38", bd=0)
    body.pack(fill="both", expand=True, padx=25, pady=15)
    body.columnconfigure(0, weight=3)
    body.columnconfigure(1, weight=2)
    body.rowconfigure(0, weight=1)

    left_col = tk.Frame(body, bg="#253545", relief="flat", bd=0)
    left_col.grid(row=0, column=0, sticky="nsew", padx=(0, 12), pady=0)

    left_header = tk.Frame(left_col, bg="#2C3E50", height=38)
    left_header.pack(fill="x")
    left_header.pack_propagate(False)
    tk.Label(left_header, text="📊  Resultados del Período",
             font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

    data_values_frame = tk.Frame(left_col, bg="#253545")
    data_values_frame.pack(fill="both", expand=True, padx=12, pady=12)

    tarjetas = [
        ("💵 Total de Venta",          "$0.00", "#1A6B3C", "#2ECC71"),
        ("📦 Productos Vendidos",       "0",     "#1A4A7A", "#3498DB"),
        ("📈 Ganancia Total",           "$0.00", "#5B2C6F", "#9B59B6"),
        ("💹 Margen de Ganancia ($)",   "$0.00", "#7D5300", "#F39C12"),
        ("📉 Margen de Ganancia (%)",   "0.00%", "#0E6655", "#1ABC9C"),
    ]
    keys = [
        "Total de venta:", "Cantidad de productos vendidos:",
        "Ganancia total por categoría:", "Margen de ganancia (cifra):", "Margen de ganancia (%):"
    ]
    data_labels = {}

    cards_grid = tk.Frame(data_values_frame, bg="#253545")
    cards_grid.pack(fill="both", expand=True)

    for i, ((titulo, valor_def, bg_card, accent_card), key) in enumerate(zip(tarjetas, keys)):
        outer = tk.Frame(cards_grid, bg=accent_card, padx=3, pady=0)
        outer.grid(row=i // 2, column=i % 2, padx=8, pady=8, sticky="ew")
        cards_grid.columnconfigure(i % 2, weight=1)

        card = tk.Frame(outer, bg=bg_card, padx=14, pady=10)
        card.pack(fill="both", expand=True)

        tk.Label(card, text=titulo, bg=bg_card, fg="#BDC3C7",
                 font=('Segoe UI', 9, 'bold')).pack(anchor="w")
        val = tk.Label(card, text=valor_def, bg=bg_card, fg=accent_card,
                       font=('Segoe UI', 18, 'bold'))
        val.pack(anchor="w", pady=(2, 0))
        data_labels[key] = val

    right_col = tk.Frame(body, bg="#253545", relief="flat", bd=0)
    right_col.grid(row=0, column=1, sticky="nsew")

    right_header = tk.Frame(right_col, bg="#2C3E50", height=38)
    right_header.pack(fill="x")
    right_header.pack_propagate(False)
    tk.Label(right_header, text="🔧  Filtros de Búsqueda",
             font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

    filters_body = tk.Frame(right_col, bg="#253545")
    filters_body.pack(fill="both", expand=True, padx=12, pady=12)

    tk.Label(filters_body, text="🏷️  Categoría",
             bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
    cat_container = tk.Frame(filters_body, bg="#2C3E50", padx=10, pady=8)
    cat_container.pack(fill="x", pady=(0, 12))
    combobox_categoria = ttk.Combobox(cat_container, state="readonly", width=28)
    combobox_categoria.pack(fill="x")

    tk.Label(filters_body, text="📅  Fecha",
             bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
    cal_container = tk.Frame(filters_body, bg="#2C3E50", padx=10, pady=8)
    cal_container.pack(fill="x", pady=(0, 12))
    calendario = Calendar(cal_container, selectmode='day',
                          background="#2C3E50", foreground='white',
                          headersbackground=label_bg, headersforeground='white',
                          selectbackground=accent_bg, selectforeground='white',
                          normalbackground="#253545", normalforeground="#ECF0F1",
                          weekendbackground="#1E2A38", weekendforeground="#BDC3C7",
                          othermonthbackground="#1A2530", othermonthforeground="#7F8C8D",
                          font=('Segoe UI', 9))
    calendario.pack(fill="x")

    tk.Label(filters_body, text="⏱️  Periodo",
             bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
    periodo_container = tk.Frame(filters_body, bg="#2C3E50", padx=10, pady=8)
    periodo_container.pack(fill="x", pady=(0, 12))
    periodo_seleccionado = tk.StringVar(value="dia")
    pf = tk.Frame(periodo_container, bg="#2C3E50")
    pf.pack()
    for txt, val in [("Día", "dia"), ("Semana", "semana"), ("Mes", "mes"), ("Año", "año")]:
        tk.Radiobutton(pf, text=txt, variable=periodo_seleccionado, value=val,
                       bg="#2C3E50", fg="#ECF0F1", selectcolor="#1E2A38",
                       activebackground="#2C3E50", activeforeground=accent_bg,
                       font=bold_font).pack(side="left", padx=8)

    btn_mostrar_resultados = tk.Button(filters_body, text="🔍  Mostrar Resultados",
                                       command=actualizar_reporte_categoria,
                                       bg=accent_bg, fg="white", font=bold_font,
                                       relief="flat", padx=16, pady=10, cursor="hand2",
                                       activebackground="#D35400", activeforeground="white")
    btn_mostrar_resultados.pack(fill="x")

    tk.Button(reporte_categoria_frame, text="✖  Cerrar",
              command=lambda: show_frame(welcome_frame),
              bg=danger_bg, fg=button_fg, font=bold_font,
              relief="flat", padx=14, pady=5, cursor="hand2"
              ).pack(side="bottom", anchor="se", padx=20, pady=10)

    conn = database.conectar_db()
    if conn:
        cats    = database.ejecutar_consulta(conn, "SELECT id_categoria, nombre FROM categorias")
        conn.close()
        nombres = [c[1] for c in cats]
        combobox_categoria['values'] = nombres
        if nombres:
            combobox_categoria.current(0)


def actualizar_reporte_categoria():
    categoria_seleccionada = combobox_categoria.get()
    fecha_seleccionada     = calendario.selection_get()
    periodo                = periodo_seleccionado.get()

    if not categoria_seleccionada:
        messagebox.showerror("Error", "Seleccione una categoría.")
        return
    conn = database.conectar_db()
    if not conn:
        messagebox.showerror("Error", "No se pudo conectar a la base de datos.")
        return
    try:
        base = """
            SELECT SUM(dv.cantidad * dv.precio_unitario),
                   SUM(dv.cantidad),
                   SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            JOIN productos p ON dv.id_producto = p.id_producto
            JOIN categorias c ON p.id_categoria = c.id_categoria
            WHERE c.nombre = %s
        """
        if periodo == "dia":
            query  = base + " AND DATE(v.fecha) = %s"
            params = (categoria_seleccionada, fecha_seleccionada)
        elif periodo == "semana":
            query  = base + " AND EXTRACT(WEEK FROM v.fecha) = EXTRACT(WEEK FROM %s)"
            params = (categoria_seleccionada, fecha_seleccionada)
        elif periodo == "mes":
            query  = base + " AND EXTRACT(MONTH FROM v.fecha) = EXTRACT(MONTH FROM %s)"
            params = (categoria_seleccionada, fecha_seleccionada)
        else:
            query  = base + " AND EXTRACT(YEAR FROM v.fecha) = EXTRACT(YEAR FROM %s)"
            params = (categoria_seleccionada, fecha_seleccionada)

        cursor = conn.cursor()
        cursor.execute(query, params)
        resultado = cursor.fetchone()
        if resultado and resultado[0]:
            total_venta, cantidad_vendida, ganancia_total = resultado
            total_venta     = total_venta     or 0
            cantidad_vendida = cantidad_vendida or 0
            ganancia_total  = ganancia_total  or 0
        else:
            total_venta = cantidad_vendida = ganancia_total = 0
        margen_cifra = ganancia_total
        margen_porc  = (ganancia_total / total_venta * 100) if total_venta else 0
        data_labels["Total de venta:"].config(text=f"${total_venta:,.2f}")
        data_labels["Cantidad de productos vendidos:"].config(text=f"{cantidad_vendida}")
        data_labels["Ganancia total por categoría:"].config(text=f"${ganancia_total:,.2f}")
        data_labels["Margen de ganancia (cifra):"].config(text=f"${margen_cifra:,.2f}")
        data_labels["Margen de ganancia (%):"].config(text=f"{margen_porc:.2f}%")
        cursor.close()
    except Exception as e:
        messagebox.showerror("Error", f"Error al obtener los datos: {e}")
    finally:
        conn.close()

# 11. REPORTE POR PRODUCTO
def mostrar_pantalla_reporte_producto():
    global combobox_categoria, calendario, periodo_seleccionado, btn_mostrar_resultados
    global data_labels, data_values_frame, right_section_frame, title_frame, data_frame
    global toolbar_frame, reporte_categoria_frame, tabla_reporte_producto

    if reporte_categoria_frame is not None:
        reporte_categoria_frame.destroy()

    reporte_categoria_frame = tk.Frame(container, bg="#1E2A38")
    reporte_categoria_frame.grid(row=0, column=1, sticky="nsew")

    bg_ref = [None]
    def resize_bg(event):
        w, h = event.width, event.height
        img = ima.open(resource_path("ondo2.webp")).resize((w, h), ima.Resampling.LANCZOS)
        bg_ref[0] = ImageTk.PhotoImage(img)
        bg_lbl.config(image=bg_ref[0])
        bg_lbl.image = bg_ref[0]
    bg_lbl = tk.Label(reporte_categoria_frame)
    bg_lbl.place(x=0, y=0, relwidth=1, relheight=1)
    reporte_categoria_frame.bind("<Configure>", resize_bg)
    show_frame(reporte_categoria_frame)

    header = tk.Frame(reporte_categoria_frame, bg=label_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="📦  Reporte por Producto",
             font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

    toolbar_frame = tk.Frame(reporte_categoria_frame, bg=menu_bg)
    toolbar_frame.pack(fill="x")
    nav_inner = tk.Frame(toolbar_frame, bg=menu_bg)
    nav_inner.pack(pady=8, padx=20)

    def make_nav_btn(parent, text, command):
        return tk.Button(parent, text=text, command=command,
                         bg=label_bg, fg="white", font=bold_font,
                         relief="flat", padx=14, pady=6, cursor="hand2",
                         activebackground=accent_bg, activeforeground="white")

    make_nav_btn(nav_inner, "📋 Por Venta",     ver_reportes_ventas             ).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "🏷️ Por Categoría", mostrar_pantalla_reporte_categoria).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "📦 Por Producto",  mostrar_pantalla_reporte_producto ).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "🕐 Por Hora",      mostrar_pantalla_reporte_hora     ).pack(side="left", padx=6)

    body = tk.Frame(reporte_categoria_frame, bg="#1E2A38", bd=0)
    body.pack(fill="both", expand=True, padx=25, pady=15)
    body.columnconfigure(0, weight=3)
    body.columnconfigure(1, weight=2)
    body.rowconfigure(0, weight=1)

    left_col = tk.Frame(body, bg="#253545", relief="flat", bd=0)
    left_col.grid(row=0, column=0, sticky="nsew", padx=(0, 12), pady=0)

    left_header = tk.Frame(left_col, bg="#2C3E50", height=38)
    left_header.pack(fill="x")
    left_header.pack_propagate(False)
    tk.Label(left_header, text="📊  Resultados del Período",
             font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

    tabla_frame = tk.Frame(left_col, bg="#253545")
    tabla_frame.pack(fill="both", expand=True, padx=12, pady=12)

    cols_prod = ("Producto", "Cantidad Vendida", "Venta Total", "Ganancia Total", "Margen de Ganancia (%)")
    tabla_reporte_producto = ttk.Treeview(tabla_frame, columns=cols_prod, show="headings",
                                          height=15, style="Modern.Treeview")
    for col in cols_prod:
        tabla_reporte_producto.heading(col, text=col, anchor="center")
        tabla_reporte_producto.column(col, width=120, anchor="center")

    scroll_y = ttk.Scrollbar(tabla_frame, orient="vertical",   command=tabla_reporte_producto.yview)
    scroll_x = ttk.Scrollbar(tabla_frame, orient="horizontal", command=tabla_reporte_producto.xview)
    tabla_reporte_producto.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)
    scroll_y.pack(side="right",  fill="y")
    scroll_x.pack(side="bottom", fill="x")
    tabla_reporte_producto.pack(fill="both", expand=True)

    right_col = tk.Frame(body, bg="#253545", relief="flat", bd=0)
    right_col.grid(row=0, column=1, sticky="nsew")

    right_header = tk.Frame(right_col, bg="#2C3E50", height=38)
    right_header.pack(fill="x")
    right_header.pack_propagate(False)
    tk.Label(right_header, text="🔧  Filtros de Búsqueda",
             font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

    filters_body = tk.Frame(right_col, bg="#253545")
    filters_body.pack(fill="both", expand=True, padx=12, pady=12)

    tk.Label(filters_body, text="📅  Fecha",
             bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
    cal_container = tk.Frame(filters_body, bg="#2C3E50", padx=10, pady=8)
    cal_container.pack(fill="x", pady=(0, 12))
    calendario = Calendar(cal_container, selectmode='day',
                          background="#2C3E50", foreground='white',
                          headersbackground=label_bg, headersforeground='white',
                          selectbackground=accent_bg, selectforeground='white',
                          normalbackground="#253545", normalforeground="#ECF0F1",
                          weekendbackground="#1E2A38", weekendforeground="#BDC3C7",
                          othermonthbackground="#1A2530", othermonthforeground="#7F8C8D",
                          font=('Segoe UI', 9))
    calendario.pack(fill="x")

    tk.Label(filters_body, text="⏱️  Periodo",
             bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
    periodo_container = tk.Frame(filters_body, bg="#2C3E50", padx=10, pady=8)
    periodo_container.pack(fill="x", pady=(0, 12))
    periodo_seleccionado = tk.StringVar(value="dia")
    pf = tk.Frame(periodo_container, bg="#2C3E50")
    pf.pack()
    for txt, val in [("Día", "dia"), ("Semana", "semana"), ("Mes", "mes"), ("Año", "año")]:
        tk.Radiobutton(pf, text=txt, variable=periodo_seleccionado, value=val,
                       bg="#2C3E50", fg="#ECF0F1", selectcolor="#1E2A38",
                       activebackground="#2C3E50", activeforeground=accent_bg,
                       font=bold_font).pack(side="left", padx=8)

    btn_mostrar_resultados = tk.Button(filters_body, text="🔍  Mostrar Resultados",
                                       command=actualizar_reporte_producto,
                                       bg=accent_bg, fg="white", font=bold_font,
                                       relief="flat", padx=16, pady=10, cursor="hand2",
                                       activebackground="#D35400", activeforeground="white")
    btn_mostrar_resultados.pack(fill="x")

    tk.Button(reporte_categoria_frame, text="✖  Cerrar",
              command=lambda: show_frame(welcome_frame),
              bg=danger_bg, fg=button_fg, font=bold_font,
              relief="flat", padx=14, pady=5, cursor="hand2"
              ).pack(side="bottom", anchor="se", padx=20, pady=10)

def actualizar_reporte_producto():
    fecha  = calendario.selection_get()
    periodo = periodo_seleccionado.get()
    conn   = database.conectar_db()
    if not conn:
        messagebox.showerror("Error", "No se pudo conectar a la base de datos.")
        return
    try:
        base = """
            SELECT p.nombre,
                   SUM(dv.cantidad),
                   SUM(dv.cantidad * dv.precio_unitario),
                   SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad),
                   (SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad) /
                    NULLIF(SUM(dv.cantidad * dv.precio_unitario), 0)) * 100
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            JOIN productos p ON dv.id_producto = p.id_producto
        """
        if periodo == "dia":
            query  = base + " WHERE DATE(v.fecha) = %s GROUP BY p.nombre"
            params = (fecha,)
        elif periodo == "semana":
            query  = base + " WHERE EXTRACT(WEEK FROM v.fecha) = EXTRACT(WEEK FROM %s) GROUP BY p.nombre"
            params = (fecha,)
        elif periodo == "mes":
            query  = base + " WHERE EXTRACT(MONTH FROM v.fecha) = EXTRACT(MONTH FROM %s) GROUP BY p.nombre"
            params = (fecha,)
        else:
            query  = base + " WHERE EXTRACT(YEAR FROM v.fecha) = EXTRACT(YEAR FROM %s) GROUP BY p.nombre"
            params = (fecha,)

        cursor = conn.cursor()
        cursor.execute(query, params)
        resultados = cursor.fetchall()
        for row in tabla_reporte_producto.get_children():
            tabla_reporte_producto.delete(row)
        for r in resultados:
            tabla_reporte_producto.insert("", "end", values=(
                r[0], r[1], f"${r[2]:.2f}" if r[2] else "$0.00",
                f"${r[3]:.2f}" if r[3] else "$0.00",
                f"{r[4]:.2f}%" if r[4] else "0.00%"
            ))
        cursor.close()
    except Exception as e:
        messagebox.showerror("Error", f"Error al obtener los datos: {e}")
    finally:
        conn.close()

# 12. REPORTE POR HORA
def obtener_ventas_por_hora(fecha):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id_venta),
                   SUM(dv.cantidad), SUM(dv.precio_unitario * dv.cantidad),
                   SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            JOIN productos p ON dv.id_producto = p.id_producto
            WHERE DATE(v.fecha) = %s GROUP BY hora ORDER BY hora
        """, (fecha,))
        res = cursor.fetchall()
        cursor.close()
        conn.close()
        return res
    return []

def obtener_ventas_por_dia_semana(año, semana):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id_venta),
                   SUM(dv.cantidad), SUM(dv.precio_unitario * dv.cantidad),
                   SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            JOIN productos p ON dv.id_producto = p.id_producto
            WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(WEEK FROM v.fecha)=%s
            GROUP BY hora ORDER BY hora
        """, (año, semana))
        res = cursor.fetchall()
        cursor.close()
        conn.close()
        return res
    return []

def obtener_ventas_por_semana_mes(año, mes):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id_venta),
                   SUM(dv.cantidad), SUM(dv.precio_unitario * dv.cantidad),
                   SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            JOIN productos p ON dv.id_producto = p.id_producto
            WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(MONTH FROM v.fecha)=%s
            GROUP BY hora ORDER BY hora
        """, (año, mes))
        res = cursor.fetchall()
        cursor.close()
        conn.close()
        return res
    return []

def obtener_ventas_por_mes_año(año):
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT EXTRACT(HOUR FROM v.fecha) AS hora, COUNT(DISTINCT v.id_venta),
                   SUM(dv.cantidad), SUM(dv.precio_unitario * dv.cantidad),
                   SUM((dv.precio_unitario - p.precio_compra) * dv.cantidad)
            FROM detalle_ventas dv
            JOIN ventas v ON dv.id_venta = v.id_venta
            JOIN productos p ON dv.id_producto = p.id_producto
            WHERE EXTRACT(YEAR FROM v.fecha)=%s
            GROUP BY hora ORDER BY hora
        """, (año,))
        res = cursor.fetchall()
        cursor.close()
        conn.close()
        return res
    return []

def mostrar_resultados_hora():
    periodo = periodo_seleccionado.get()
    fecha   = calendario.selection_get()
    if periodo == "dia":
        datos = obtener_ventas_por_hora(fecha)
    elif periodo == "semana":
        año, semana = fecha.isocalendar()[:2]
        datos = obtener_ventas_por_dia_semana(año, semana)
    elif periodo == "mes":
        año, mes = fecha.year, fecha.month
        datos = obtener_ventas_por_semana_mes(año, mes)
    else:
        año   = fecha.year
        datos = obtener_ventas_por_mes_año(año)

    for item in tabla_reporte_hora.get_children():
        tabla_reporte_hora.delete(item)
    for d in datos:
        hora         = f"{int(d[0]):02d}:00"
        cant_ventas  = d[1]
        cant_vendida = d[2]
        venta_total  = d[3]
        ganancia     = d[4]
        ticket_prom  = venta_total / cant_ventas if cant_ventas else 0
        margen       = (ganancia / venta_total * 100) if venta_total else 0
        tabla_reporte_hora.insert("", "end", values=(
            hora, cant_vendida,
            f"${venta_total:.2f}", f"${ganancia:.2f}",
            f"${ticket_prom:.3f}", f"{margen:.2f}%"))


def mostrar_pantalla_reporte_hora():
    global combobox_categoria, calendario, periodo_seleccionado, btn_mostrar_resultados
    global data_labels, data_values_frame, right_section_frame, title_frame, data_frame
    global toolbar_frame, reporte_categoria_frame, tabla_reporte_hora

    if reporte_categoria_frame is not None:
        reporte_categoria_frame.destroy()

    reporte_categoria_frame = tk.Frame(container, bg="#1E2A38")
    reporte_categoria_frame.grid(row=0, column=1, sticky="nsew")

    bg_ref = [None]
    def resize_bg(event):
        w, h = event.width, event.height
        img = ima.open(resource_path("ondo2.webp")).resize((w, h), ima.Resampling.LANCZOS)
        bg_ref[0] = ImageTk.PhotoImage(img)
        bg_lbl.config(image=bg_ref[0])
        bg_lbl.image = bg_ref[0]
    bg_lbl = tk.Label(reporte_categoria_frame)
    bg_lbl.place(x=0, y=0, relwidth=1, relheight=1)
    reporte_categoria_frame.bind("<Configure>", resize_bg)
    show_frame(reporte_categoria_frame)

    header = tk.Frame(reporte_categoria_frame, bg=label_bg, height=55)
    header.pack(fill="x")
    header.pack_propagate(False)
    tk.Label(header, text="🕐  Reporte por Hora",
             font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

    toolbar_frame = tk.Frame(reporte_categoria_frame, bg=menu_bg)
    toolbar_frame.pack(fill="x")
    nav_inner = tk.Frame(toolbar_frame, bg=menu_bg)
    nav_inner.pack(pady=8, padx=20)

    def make_nav_btn(parent, text, command):
        return tk.Button(parent, text=text, command=command,
                         bg=label_bg, fg="white", font=bold_font,
                         relief="flat", padx=14, pady=6, cursor="hand2",
                         activebackground=accent_bg, activeforeground="white")

    make_nav_btn(nav_inner, "📋 Por Venta",     ver_reportes_ventas             ).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "🏷️ Por Categoría", mostrar_pantalla_reporte_categoria).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "📦 Por Producto",  mostrar_pantalla_reporte_producto ).pack(side="left", padx=6)
    make_nav_btn(nav_inner, "🕐 Por Hora",      mostrar_pantalla_reporte_hora     ).pack(side="left", padx=6)

    body = tk.Frame(reporte_categoria_frame, bg="#1E2A38", bd=0)
    body.pack(fill="both", expand=True, padx=25, pady=15)
    body.columnconfigure(0, weight=3)
    body.columnconfigure(1, weight=2)
    body.rowconfigure(0, weight=1)

    left_col = tk.Frame(body, bg="#253545", relief="flat", bd=0)
    left_col.grid(row=0, column=0, sticky="nsew", padx=(0, 12), pady=0)

    left_header = tk.Frame(left_col, bg="#2C3E50", height=38)
    left_header.pack(fill="x")
    left_header.pack_propagate(False)
    tk.Label(left_header, text="📊  Resultados del Período",
             font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

    tabla_frame = tk.Frame(left_col, bg="#253545")
    tabla_frame.pack(fill="both", expand=True, padx=12, pady=12)

    cols_hora = ("Hora", "Cantidad Vendida", "Venta Total", "Ganancia Total", "Ticket Promedio", "Margen de Ganancia (%)")
    tabla_reporte_hora = ttk.Treeview(tabla_frame, columns=cols_hora, show="headings",
                                      height=15, style="Modern.Treeview")
    anchos = [80, 120, 120, 120, 120, 100]
    for col, w in zip(cols_hora, anchos):
        tabla_reporte_hora.heading(col, text=col, anchor="center")
        tabla_reporte_hora.column(col, width=w, anchor="center")

    scroll_y = ttk.Scrollbar(tabla_frame, orient="vertical",   command=tabla_reporte_hora.yview)
    scroll_x = ttk.Scrollbar(tabla_frame, orient="horizontal", command=tabla_reporte_hora.xview)
    tabla_reporte_hora.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)
    scroll_y.pack(side="right",  fill="y")
    scroll_x.pack(side="bottom", fill="x")
    tabla_reporte_hora.pack(fill="both", expand=True)

    right_col = tk.Frame(body, bg="#253545", relief="flat", bd=0)
    right_col.grid(row=0, column=1, sticky="nsew")

    right_header = tk.Frame(right_col, bg="#2C3E50", height=38)
    right_header.pack(fill="x")
    right_header.pack_propagate(False)
    tk.Label(right_header, text="🔧  Filtros de Búsqueda",
             font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

    filters_body = tk.Frame(right_col, bg="#253545")
    filters_body.pack(fill="both", expand=True, padx=12, pady=12)

    tk.Label(filters_body, text="📅  Fecha",
             bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
    cal_container = tk.Frame(filters_body, bg="#2C3E50", padx=10, pady=8)
    cal_container.pack(fill="x", pady=(0, 12))
    calendario = Calendar(cal_container, selectmode='day',
                          background="#2C3E50", foreground='white',
                          headersbackground=label_bg, headersforeground='white',
                          selectbackground=accent_bg, selectforeground='white',
                          normalbackground="#253545", normalforeground="#ECF0F1",
                          weekendbackground="#1E2A38", weekendforeground="#BDC3C7",
                          othermonthbackground="#1A2530", othermonthforeground="#7F8C8D",
                          font=('Segoe UI', 9))
    calendario.pack(fill="x")

    tk.Label(filters_body, text="⏱️  Periodo",
             bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
    periodo_container = tk.Frame(filters_body, bg="#2C3E50", padx=10, pady=8)
    periodo_container.pack(fill="x", pady=(0, 12))
    periodo_seleccionado = tk.StringVar(value="dia")
    pf = tk.Frame(periodo_container, bg="#2C3E50")
    pf.pack()
    for txt, val in [("Día", "dia"), ("Semana", "semana"), ("Mes", "mes"), ("Año", "año")]:
        tk.Radiobutton(pf, text=txt, variable=periodo_seleccionado, value=val,
                       bg="#2C3E50", fg="#ECF0F1", selectcolor="#1E2A38",
                       activebackground="#2C3E50", activeforeground=accent_bg,
                       font=bold_font).pack(side="left", padx=8)

    btn_mostrar_resultados = tk.Button(filters_body, text="🔍  Mostrar Resultados",
                                       command=mostrar_resultados_hora,
                                       bg=accent_bg, fg="white", font=bold_font,
                                       relief="flat", padx=16, pady=10, cursor="hand2",
                                       activebackground="#D35400", activeforeground="white")
    btn_mostrar_resultados.pack(fill="x")

    tk.Button(reporte_categoria_frame, text="✖  Cerrar",
              command=lambda: show_frame(welcome_frame),
              bg=danger_bg, fg=button_fg, font=bold_font,
              relief="flat", padx=14, pady=5, cursor="hand2"
              ).pack(side="bottom", anchor="se", padx=20, pady=10)

# 13. GRÁFICOS Y VISUALIZACIONES
graphs_frame = None
graph_area   = None

def obtener_ventas_totales_por_hora(fecha):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT EXTRACT(HOUR FROM fecha), SUM(total)
                FROM ventas WHERE DATE(fecha) = %s
                GROUP BY EXTRACT(HOUR FROM fecha) ORDER BY 1
            """, (fecha,))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_diarias_semana(año, semana):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT EXTRACT(DOW FROM fecha), SUM(total)
                FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s AND EXTRACT(WEEK FROM fecha)=%s
                GROUP BY EXTRACT(DOW FROM fecha) ORDER BY 1
            """, (año, semana))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_semana_mes(año, mes):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT EXTRACT(WEEK FROM fecha), SUM(total)
                FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s AND EXTRACT(MONTH FROM fecha)=%s
                GROUP BY EXTRACT(WEEK FROM fecha) ORDER BY 1
            """, (año, mes))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_mes_año(año):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT EXTRACT(MONTH FROM fecha), SUM(total)
                FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s
                GROUP BY EXTRACT(MONTH FROM fecha) ORDER BY 1
            """, (año,))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_por_hora_lineas(fecha):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT EXTRACT(HOUR FROM v.fecha), SUM(dv.cantidad * dv.precio_unitario)
                FROM detalle_ventas dv JOIN ventas v ON dv.id_venta=v.id_venta
                WHERE DATE(v.fecha)=%s
                GROUP BY EXTRACT(HOUR FROM v.fecha) ORDER BY 1
            """, (fecha,))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_diarias_semana_lineas(año, semana):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT EXTRACT(DOW FROM fecha), SUM(total)
                FROM ventas WHERE EXTRACT(YEAR FROM fecha)=%s AND EXTRACT(WEEK FROM fecha)=%s
                GROUP BY EXTRACT(DOW FROM fecha) ORDER BY 1
            """, (año, semana))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_semana_mes_lineas(año, mes):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT DATE_PART('day', v.fecha), SUM(v.total)
                FROM ventas v WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(MONTH FROM v.fecha)=%s
                GROUP BY DATE_PART('day', v.fecha) ORDER BY 1
            """, (año, mes))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_mes_año_lineas(año):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT DATE_PART('month', v.fecha), SUM(v.total)
                FROM ventas v WHERE EXTRACT(YEAR FROM v.fecha)=%s
                GROUP BY DATE_PART('month', v.fecha) ORDER BY 1
            """, (año,))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_por_hora_pastel(fecha):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT c.nombre, SUM(total)
                FROM ventas v JOIN detalle_ventas dv ON v.id_venta=dv.id_venta
                JOIN productos p ON dv.id_producto=p.id_producto
                JOIN categorias c ON p.id_categoria=c.id_categoria
                WHERE DATE(v.fecha)=%s GROUP BY c.nombre
            """, (fecha,))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_diarias_semana_pastel(año, semana):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT c.nombre, SUM(total)
                FROM ventas v JOIN detalle_ventas dv ON v.id_venta=dv.id_venta
                JOIN productos p ON dv.id_producto=p.id_producto
                JOIN categorias c ON p.id_categoria=c.id_categoria
                WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(WEEK FROM v.fecha)=%s
                GROUP BY c.nombre
            """, (año, semana))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_semana_mes_pastel(año, mes):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT c.nombre, SUM(total)
                FROM ventas v JOIN detalle_ventas dv ON v.id_venta=dv.id_venta
                JOIN productos p ON dv.id_producto=p.id_producto
                JOIN categorias c ON p.id_categoria=c.id_categoria
                WHERE EXTRACT(YEAR FROM v.fecha)=%s AND EXTRACT(MONTH FROM v.fecha)=%s
                GROUP BY c.nombre
            """, (año, mes))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def obtener_ventas_totales_mes_año_pastel(año):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT c.nombre, SUM(total)
                FROM ventas v JOIN detalle_ventas dv ON v.id_venta=dv.id_venta
                JOIN productos p ON dv.id_producto=p.id_producto
                JOIN categorias c ON p.id_categoria=c.id_categoria
                WHERE EXTRACT(YEAR FROM v.fecha)=%s GROUP BY c.nombre
            """, (año,))
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error: {e}")
    return []

def mostrar_grafico_barras(datos, titulo, xlabel, ylabel):
    for w in graph_area.winfo_children():
        w.destroy()
    if not datos:
        return
    categorias = [str(d[0]) for d in datos]
    valores    = [d[1] for d in datos]
    fig, ax = plt.subplots(figsize=(8, 5))
    fig.patch.set_facecolor(frame_bg)
    ax.set_facecolor(highlight_bg)
    bars = ax.bar(categorias, valores, color=accent_bg, edgecolor='white')
    ax.set_title(titulo, fontsize=14, fontweight='bold')
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel(ylabel, fontsize=12)
    ax.grid(True, linestyle='--', alpha=0.5)
    for bar in bars:
        height = bar.get_height()
        ax.annotate(f'{height:.0f}',
                    xy=(bar.get_x() + bar.get_width() / 2, height),
                    xytext=(0, 3), textcoords="offset points",
                    ha='center', va='bottom', fontsize=9, fontweight='bold')
    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)

def mostrar_grafico_lineas(datos, titulo, xlabel="Período", ylabel="Ventas Totales"):
    for w in graph_area.winfo_children():
        w.destroy()
    if not datos:
        return
    periodos = [str(d[0]) for d in datos]
    ventas   = [d[1] for d in datos]
    fig, ax = plt.subplots(figsize=(8, 5))
    fig.patch.set_facecolor(frame_bg)
    ax.set_facecolor(highlight_bg)
    ax.plot(periodos, ventas, marker='o', linestyle='-', color=button_bg,
            linewidth=2, markersize=6, markerfacecolor='red',
            markeredgewidth=2, markeredgecolor='black')
    ax.set_title(titulo, fontsize=14, fontweight='bold')
    ax.set_xlabel(xlabel, fontsize=12)
    ax.set_ylabel(ylabel, fontsize=12)
    ax.grid(True, linestyle='--', alpha=0.5)
    for i, txt in enumerate(ventas):
        ax.annotate(f'{txt:.0f}', (periodos[i], ventas[i]),
                    textcoords="offset points", xytext=(0, 10),
                    ha='center', fontsize=10, fontweight='bold')
    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)

def mostrar_grafico_pastel(datos):
    for w in graph_area.winfo_children():
        w.destroy()
    if not datos:
        return
    categorias = [d[0] for d in datos]
    valores    = [d[1] for d in datos]
    fig, ax = plt.subplots(figsize=(7, 7))
    fig.patch.set_facecolor(frame_bg)
    colores = ['#3498DB', '#E67E22', '#2ECC71', '#E74C3C', '#9B59B6', '#F1C40F', '#692395', '#2DB89C']
    explode = [0.05] * len(valores)
    wedges, texts, autotexts = ax.pie(
        valores, labels=categorias, autopct='%1.1f%%',
        startangle=140, colors=colores, shadow=True, explode=explode)
    for text in texts:
        text.set_fontsize(9)
    for autotext in autotexts:
        autotext.set_color('white')
        autotext.set_fontweight('bold')
        autotext.set_fontsize(9)
    ax.axis('equal')
    ax.set_title('Distribución de Ventas por Categoría', fontsize=14, fontweight='bold')
    canvas = FigureCanvasTkAgg(fig, master=graph_area)
    canvas.draw()
    canvas.get_tk_widget().pack(fill="both", expand=True)


def mostrar_bienvenida_graficos():
    global graphs_frame, graph_area

    tipo_grafico_seleccionado = tk.StringVar(value="barras")

    if graphs_frame is None:
        graphs_frame = tk.Frame(container, bg=frame_bg)
        graphs_frame.grid(row=0, column=1, sticky="nsew")

        bg_ref = [None]
        def resize_bg(event):
            w, h = event.width, event.height
            img = ima.open(resource_path("ondo2.webp")).resize((w, h), ima.Resampling.LANCZOS)
            bg_ref[0] = ImageTk.PhotoImage(img)
            bg_lbl.config(image=bg_ref[0])
            bg_lbl.image = bg_ref[0]
        bg_lbl = tk.Label(graphs_frame)
        bg_lbl.place(x=0, y=0, relwidth=1, relheight=1)
        graphs_frame.bind("<Configure>", resize_bg)

        tk.Label(graphs_frame, text="Bienvenido a la sección de análisis de ventas",
                 font=title_font, bg=menu_bg, fg="white").pack(pady=(20, 5))
        tk.Label(graphs_frame, text="Explora tus datos de ventas en diferentes formatos y períodos de tiempo",
                 font=default_font, bg=menu_bg, fg="white").pack()

        main_frame = tk.Frame(graphs_frame, bg=frame_bg)
        main_frame.pack(fill="both", expand=True)

        bg_main_ref = [None]
        def resize_main(event):
            w, h = event.width, event.height
            img = ima.open(resource_path("ondo_venta.jpg")).resize((w, h), ima.Resampling.LANCZOS)
            bg_main_ref[0] = ImageTk.PhotoImage(img)
            bg_main_lbl.config(image=bg_main_ref[0])
            bg_main_lbl.image = bg_main_ref[0]
        bg_main_lbl = tk.Label(main_frame)
        bg_main_lbl.place(x=0, y=0, relwidth=1, relheight=1)
        main_frame.bind("<Configure>", resize_main)

        left_frame = tk.Frame(main_frame, bg=menu_bg)
        left_frame.pack(side="left", fill="both", expand=True, padx=20, pady=20)

        sel_frame = tk.Frame(left_frame, bg=menu_bg)
        sel_frame.pack(pady=10)
        tk.Label(sel_frame, text="Selecciona el tipo de gráfico:", bg=label_bg, fg=label_fg, font=bold_font).pack()
        btn_frame = tk.Frame(sel_frame, bg=menu_bg)
        btn_frame.pack()
        ttk.Radiobutton(btn_frame, text="Gráfico de barras", variable=tipo_grafico_seleccionado, value="barras").pack(side="left", padx=5)
        ttk.Radiobutton(btn_frame, text="Gráfico de líneas", variable=tipo_grafico_seleccionado, value="lineas").pack(side="left", padx=5)
        ttk.Radiobutton(btn_frame, text="Gráfico de pastel", variable=tipo_grafico_seleccionado, value="pastel").pack(side="left", padx=5)

        cal_frame = tk.Frame(left_frame, bg=menu_bg)
        cal_frame.pack(pady=10)
        tk.Label(cal_frame, text="Calendario:", bg=label_bg, fg=label_fg, font=bold_font).pack()
        calendario_graf = Calendar(cal_frame, selectmode='day')
        calendario_graf.pack()

        period_frame = tk.Frame(left_frame, bg=menu_bg)
        period_frame.pack(pady=10)
        periodo_graf = tk.StringVar(value="dia")
        for txt, val in [("Día", "dia"), ("Semana", "semana"), ("Mes", "mes"), ("Año", "año")]:
            tk.Radiobutton(period_frame, text=txt, variable=periodo_graf, value=val,
                           bg=menu_bg, fg="white", selectcolor=menu_bg,
                           activebackground=menu_bg, activeforeground="white").pack(side="left", padx=5)

        def mostrar_resultados():
            periodo = periodo_graf.get()
            fecha   = calendario_graf.selection_get()
            tipo    = tipo_grafico_seleccionado.get()

            if tipo == "barras":
                if periodo == "dia":
                    datos = obtener_ventas_totales_por_hora(fecha)
                    mostrar_grafico_barras(datos, "Ventas por Hora", "Hora", "Total Ventas")
                elif periodo == "semana":
                    año, semana = fecha.isocalendar()[:2]
                    datos = obtener_ventas_diarias_semana(año, semana)
                    mostrar_grafico_barras(datos, "Ventas por Día de la Semana", "Día", "Total Ventas")
                elif periodo == "mes":
                    año, mes = fecha.year, fecha.month
                    datos = obtener_ventas_totales_semana_mes(año, mes)
                    mostrar_grafico_barras(datos, "Ventas por Semana en el Mes", "Semana", "Total Ventas")
                else:
                    año  = fecha.year
                    datos = obtener_ventas_totales_mes_año(año)
                    mostrar_grafico_barras(datos, "Ventas por Mes", "Mes", "Total Ventas")

            elif tipo == "lineas":
                if periodo == "dia":
                    datos = obtener_ventas_totales_por_hora_lineas(fecha)
                    mostrar_grafico_lineas(datos, "Ventas por Día")
                elif periodo == "semana":
                    año, semana = fecha.isocalendar()[:2]
                    datos = obtener_ventas_diarias_semana_lineas(año, semana)
                    mostrar_grafico_lineas(datos, "Ventas por Semana")
                elif periodo == "mes":
                    año, mes = fecha.year, fecha.month
                    datos = obtener_ventas_totales_semana_mes_lineas(año, mes)
                    mostrar_grafico_lineas(datos, "Ventas por Mes")
                else:
                    año  = fecha.year
                    datos = obtener_ventas_totales_mes_año_lineas(año)
                    mostrar_grafico_lineas(datos, "Ventas por Año")

            else: 
                if periodo == "dia":
                    datos = obtener_ventas_totales_por_hora_pastel(fecha)
                elif periodo == "semana":
                    año, semana = fecha.isocalendar()[:2]
                    datos = obtener_ventas_diarias_semana_pastel(año, semana)
                elif periodo == "mes":
                    año, mes = fecha.year, fecha.month
                    datos = obtener_ventas_totales_semana_mes_pastel(año, mes)
                else:
                    año  = fecha.year
                    datos = obtener_ventas_totales_mes_año_pastel(año)
                mostrar_grafico_pastel(datos)

        tk.Button(left_frame, text="Mostrar Resultados", command=mostrar_resultados,
                  bg=button_bg, fg=button_fg, font=bold_font, relief="flat").pack(pady=10)

        graph_area = tk.Frame(main_frame, bg=frame_bg)
        graph_area.pack(side="right", fill="both", expand=True, padx=20, pady=20)

        tk.Button(graphs_frame, text="Cerrar panel de reportes",
                  command=lambda: show_frame(welcome_frame),
                  bg=danger_bg, fg=button_fg).pack(side="bottom", anchor="se", padx=10, pady=10)

    show_frame(graphs_frame)

# 14. INVENTARIO
inventario_frame              = None
tabla_inventario              = None
entry_busqueda_inventario     = None
combobox_categoria_inventario = None
combobox_proveedor_inventario = None
check_stock_bajo              = None
check_agotados                = None
entry_editor_inv              = None


def mostrar_pantalla_inventario():
    global inventario_frame, tabla_inventario, entry_busqueda_inventario
    global combobox_categoria_inventario, combobox_proveedor_inventario
    global check_stock_bajo, check_agotados

    if inventario_frame is None:
        inventario_frame = tk.Frame(container, bg=frame_bg)
        inventario_frame.grid(row=0, column=1, sticky="nsew")

        header = tk.Frame(inventario_frame, bg=label_bg, height=55)
        header.pack(fill="x")
        header.pack_propagate(False)
        tk.Label(header, text="📦  Inventario de Productos",
                 font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

        search_frame = tk.Frame(inventario_frame, bg=frame_bg)
        search_frame.pack(fill="x", padx=20, pady=(12, 5))

        tk.Label(search_frame, text="🔍 Buscar producto:",
                 bg=frame_bg, fg=label_bg, font=bold_font).pack(side="left", padx=(0, 8))
        entry_busqueda_inventario = tk.Entry(search_frame, font=default_font, width=35,
                                             relief="solid", bd=1)
        entry_busqueda_inventario.pack(side="left", padx=(0, 8))

        tk.Button(search_frame, text="🔍 Buscar", command=buscar_producto_inventario,
                  bg=button_bg, fg=button_fg, font=bold_font,
                  relief="flat", padx=12, pady=4, cursor="hand2").pack(side="left", padx=(0, 6))
        tk.Button(search_frame, text="🔄 Refrescar", command=cargar_productos_en_tabla,
                  bg=label_bg, fg="white", font=bold_font,
                  relief="flat", padx=12, pady=4, cursor="hand2").pack(side="left")

        filtro_frame = tk.Frame(inventario_frame, bg=frame_bg)
        filtro_frame.pack(fill="x", padx=20, pady=(0, 5))

        tk.Label(filtro_frame, text="🏷️ Categoría:",
                 bg=frame_bg, fg=label_bg, font=bold_font).pack(side="left", padx=(0, 5))
        combobox_categoria_inventario = ttk.Combobox(filtro_frame,
                                                      values=["Todas las categorías"],
                                                      state="readonly", width=20)
        combobox_categoria_inventario.current(0)
        combobox_categoria_inventario.pack(side="left", padx=(0, 15))

        tk.Label(filtro_frame, text="🚚 Proveedor:",
                 bg=frame_bg, fg=label_bg, font=bold_font).pack(side="left", padx=(0, 5))
        combobox_proveedor_inventario = ttk.Combobox(filtro_frame,
                                                      values=["Todos los proveedores"],
                                                      state="readonly", width=20)
        combobox_proveedor_inventario.current(0)
        combobox_proveedor_inventario.pack(side="left", padx=(0, 15))

        check_stock_bajo = tk.BooleanVar()
        tk.Checkbutton(filtro_frame, text="⚠️ Stock Bajo", variable=check_stock_bajo,
                       bg=frame_bg, fg=label_bg, font=bold_font,
                       activebackground=frame_bg, cursor="hand2").pack(side="left", padx=(0, 8))

        check_agotados = tk.BooleanVar()
        tk.Checkbutton(filtro_frame, text="🚫 Agotados", variable=check_agotados,
                       bg=frame_bg, fg=label_bg, font=bold_font,
                       activebackground=frame_bg, cursor="hand2").pack(side="left")

        tk.Label(inventario_frame,
                 text="💡 Doble clic sobre la celda de Stock para editarla",
                 bg=frame_bg, fg="#7F8C8D",
                 font=('Segoe UI', 9, 'italic')).pack(anchor="w", padx=20, pady=(0, 4))

        tabla_frame = tk.Frame(inventario_frame, bg=frame_bg)
        tabla_frame.pack(fill="both", expand=True, padx=20, pady=(0, 5))

        tabla_inventario = ttk.Treeview(tabla_frame,
            columns=("ID", "Nombre", "Categoría", "Proveedor",
                     "Precio Compra", "Precio Venta", "Stock", "Stock Mínimo"),
            show="headings", style="Modern.Treeview")

        scroll_y = ttk.Scrollbar(tabla_frame, orient="vertical",   command=tabla_inventario.yview)
        scroll_x = ttk.Scrollbar(tabla_frame, orient="horizontal", command=tabla_inventario.xview)
        tabla_inventario.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)

        scroll_y.pack(side="right",  fill="y")
        scroll_x.pack(side="bottom", fill="x")
        tabla_inventario.pack(fill="both", expand=True)

        for col in tabla_inventario["columns"]:
            tabla_inventario.heading(col, text=col, anchor="center")
            tabla_inventario.column(col, anchor="center", width=100)

        tabla_inventario.bind('<Double-1>', editar_celda)

        btn_frame = tk.Frame(inventario_frame, bg=frame_bg)
        btn_frame.pack(pady=10, padx=20, fill="x")

        actualizar_button = tk.Button(btn_frame, text="✔  Actualizar Inventario",
                                      command=actualizar_inventario,
                                      bg=success_bg, fg=button_fg, font=bold_font,
                                      relief="flat", padx=20, pady=8, cursor="hand2")
        actualizar_button.pack(side="left")
        ToolTip(actualizar_button, "Guarda los cambios de stock en la base de datos")

        cerrar_button = tk.Button(btn_frame, text="✖  Cerrar",
                                  command=lambda: show_frame(welcome_frame),
                                  bg=danger_bg, fg=button_fg, font=bold_font,
                                  relief="flat", padx=20, pady=8, cursor="hand2")
        cerrar_button.pack(side="right")
        ToolTip(cerrar_button, "Cerrar el panel de inventario")

        cargar_productos_en_tabla()

    show_frame(inventario_frame)


def actualizar_inventario():
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        for item in tabla_inventario.get_children():
            valores  = tabla_inventario.item(item, 'values')
            id_prod  = valores[0]
            nuevo_stock = int(valores[6])
            cursor.execute("SELECT stock FROM productos WHERE id_producto = %s", (id_prod,))
            stock_actual = cursor.fetchone()[0]
            if stock_actual != nuevo_stock:
                cursor.execute("UPDATE productos SET stock = %s WHERE id_producto = %s",
                               (nuevo_stock, id_prod))
        conn.commit()
        cursor.close()
        conn.close()
        messagebox.showinfo("Actualización de Inventario", "El inventario ha sido actualizado exitosamente.")


def editar_celda(event):
    global entry_editor_inv
    item   = tabla_inventario.identify('item',   event.x, event.y)
    column = tabla_inventario.identify('column', event.x, event.y)
    if column == '#7':
        if entry_editor_inv:
            entry_editor_inv.destroy()
        bbox = tabla_inventario.bbox(item, column)
        if not bbox:
            return
        x, y, w, h = bbox
        entry_editor_inv = tk.Entry(tabla_inventario, font=default_font)
        entry_editor_inv.place(x=x, y=y, width=w, height=h)
        entry_editor_inv.insert(0, tabla_inventario.item(item, 'values')[6])
        entry_editor_inv.focus()

        def on_return(event):
            new_value = entry_editor_inv.get()
            vals = list(tabla_inventario.item(item, 'values'))
            vals[6] = new_value
            tabla_inventario.item(item, values=vals)
            entry_editor_inv.destroy()

        entry_editor_inv.bind('<Return>', on_return)

        def destroy_entry(event):
            if entry_editor_inv:
                entry_editor_inv.destroy()
        tabla_inventario.bind('<Button-1>', destroy_entry)


def buscar_producto_inventario():
    termino = entry_busqueda_inventario.get().lower()
    conn    = database.conectar_db()
    if conn:
        productos = database.ejecutar_consulta(conn, """
            SELECT p.id_producto, p.nombre, c.nombre, pr.nombre,
                   p.precio_compra, p.precio_venta, p.stock, p.stock_minimo
            FROM productos p
            JOIN categorias c ON p.id_categoria = c.id_categoria
            JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
            WHERE LOWER(p.nombre) LIKE %s
        """, (f"%{termino}%",))
        conn.close()
        for item in tabla_inventario.get_children():
            tabla_inventario.delete(item)
        for p in productos:
            tabla_inventario.insert("", tk.END, values=p)


def cargar_productos_en_tabla():
    global combobox_categoria_inventario, combobox_proveedor_inventario, tabla_inventario
    global check_stock_bajo, check_agotados

    for item in tabla_inventario.get_children():
        tabla_inventario.delete(item)

    conn = database.conectar_db()
    if conn:
        consulta   = """
            SELECT p.id_producto, p.nombre, c.nombre, pr.nombre,
                   p.precio_compra, p.precio_venta, p.stock, p.stock_minimo
            FROM productos p
            JOIN categorias c ON p.id_categoria = c.id_categoria
            JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
        """
        parametros  = []
        condiciones = []

        if combobox_categoria_inventario.get() not in ("", "Todas las categorías"):
            condiciones.append("c.nombre = %s")
            parametros.append(combobox_categoria_inventario.get())
        if combobox_proveedor_inventario.get() not in ("", "Todos los proveedores"):
            condiciones.append("pr.nombre = %s")
            parametros.append(combobox_proveedor_inventario.get())
        if check_stock_bajo.get():
            condiciones.append("p.stock <= p.stock_minimo")
        if check_agotados.get():
            condiciones.append("p.stock = 0")
        if condiciones:
            consulta += " WHERE " + " AND ".join(condiciones)

        productos   = database.ejecutar_consulta(conn, consulta, parametros if parametros else None)
        categorias  = database.ejecutar_consulta(conn, "SELECT nombre FROM categorias")
        proveedores = database.ejecutar_consulta(conn, "SELECT nombre FROM proveedores")

        combobox_categoria_inventario['values']  = ["Todas las categorías"] + [c[0] for c in categorias]
        combobox_proveedor_inventario['values']  = ["Todos los proveedores"] + [p[0] for p in proveedores]
        if not combobox_categoria_inventario.get():
            combobox_categoria_inventario.current(0)
        if not combobox_proveedor_inventario.get():
            combobox_proveedor_inventario.current(0)

        for p in productos:
            tabla_inventario.insert("", tk.END, values=p)
        conn.close()


def ver_inventario():
    mostrar_pantalla_inventario()

# 15. REPORTES DE INVENTARIO
reporte_inventario_frame      = None
tabla_inventario2             = None
entry_busqueda_inventario2    = None
combobox_categoria_inventario2 = None
combobox_proveedor_inventario2 = None
calendario_inventario         = None
active_button                 = None
radio_seleccion               = None
boton_stock_actual            = None
boton_stock_bajo              = None
boton_agotados                = None
boton_movimientos_stock       = None


def mostrar_pantalla_reportes_inventario():
    global reporte_inventario_frame, tabla_inventario2
    global combobox_categoria_inventario2, combobox_proveedor_inventario2
    global calendario_inventario, active_button, radio_seleccion
    global boton_stock_actual, boton_stock_bajo, boton_agotados, boton_movimientos_stock

    if radio_seleccion is None:
        radio_seleccion = tk.StringVar(value="día")

    if reporte_inventario_frame is None:
        reporte_inventario_frame = tk.Frame(container, bg=frame_bg)
        reporte_inventario_frame.grid(row=0, column=1, sticky="nsew")

        header = tk.Frame(reporte_inventario_frame, bg=label_bg, height=55)
        header.pack(fill="x")
        header.pack_propagate(False)
        tk.Label(header, text="📋  Reportes de Inventario",
                 font=heading_font, bg=label_bg, fg="white").pack(side="left", padx=20, pady=12)

        toolbar = tk.Frame(reporte_inventario_frame, bg=menu_bg)
        toolbar.pack(fill="x")
        nav_inner = tk.Frame(toolbar, bg=menu_bg)
        nav_inner.pack(pady=8, padx=20)

        boton_stock_actual = tk.Button(nav_inner, text="📦 Stock Actual",
                                       command=lambda: activar_boton(boton_stock_actual),
                                       bg=label_bg, fg="white", font=bold_font,
                                       relief="flat", padx=14, pady=6, cursor="hand2",
                                       activebackground=accent_bg, activeforeground="white")
        boton_movimientos_stock = tk.Button(nav_inner, text="🔄 Movimientos de Stock",
                                            command=lambda: activar_boton(boton_movimientos_stock),
                                            bg=label_bg, fg="white", font=bold_font,
                                            relief="flat", padx=14, pady=6, cursor="hand2",
                                            activebackground=accent_bg, activeforeground="white")
        boton_stock_bajo = tk.Button(nav_inner, text="⚠️ Stock Bajo",
                                     command=lambda: activar_boton(boton_stock_bajo),
                                     bg=label_bg, fg="white", font=bold_font,
                                     relief="flat", padx=14, pady=6, cursor="hand2",
                                     activebackground=accent_bg, activeforeground="white")
        boton_agotados = tk.Button(nav_inner, text="🚫 Agotados",
                                   command=lambda: activar_boton(boton_agotados),
                                   bg=label_bg, fg="white", font=bold_font,
                                   relief="flat", padx=14, pady=6, cursor="hand2",
                                   activebackground=accent_bg, activeforeground="white")
        for b in [boton_stock_actual, boton_movimientos_stock, boton_stock_bajo, boton_agotados]:
            b.pack(side="left", padx=6)

        body = tk.Frame(reporte_inventario_frame, bg=frame_bg)
        body.pack(fill="both", expand=True, padx=20, pady=15)
        body.columnconfigure(0, weight=0)
        body.columnconfigure(1, weight=1)
        body.rowconfigure(0, weight=1)

        left_col = tk.Frame(body, bg="#253545", width=350)
        left_col.grid(row=0, column=0, sticky="nsew", padx=(0, 15))
        left_col.pack_propagate(False)

        left_header = tk.Frame(left_col, bg="#2C3E50", height=38)
        left_header.pack(fill="x")
        left_header.pack_propagate(False)
        tk.Label(left_header, text="🔧  Filtros de Búsqueda",
                 font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

        filters_body = tk.Frame(left_col, bg="#253545")
        filters_body.pack(fill="both", expand=True, padx=12, pady=12)

        filtros_fila = tk.Frame(filters_body, bg="#253545")
        filtros_fila.pack(fill="x", pady=(0, 10))
        filtros_fila.columnconfigure(0, weight=1)
        filtros_fila.columnconfigure(1, weight=1)

        cat_col = tk.Frame(filtros_fila, bg="#253545")
        cat_col.grid(row=0, column=0, sticky="ew", padx=(0, 6))
        tk.Label(cat_col, text="🏷️ Categoría",
                 bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 3))
        cat_container = tk.Frame(cat_col, bg="#2C3E50", padx=6, pady=5)
        cat_container.pack(fill="x")
        combobox_categoria_inventario2 = ttk.Combobox(cat_container, state="readonly", width=11)
        combobox_categoria_inventario2.pack(fill="x")

        prov_col = tk.Frame(filtros_fila, bg="#253545")
        prov_col.grid(row=0, column=1, sticky="ew", padx=(6, 0))
        tk.Label(prov_col, text="🚚 Proveedor",
                 bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 3))
        prov_container = tk.Frame(prov_col, bg="#2C3E50", padx=6, pady=5)
        prov_container.pack(fill="x")
        combobox_proveedor_inventario2 = ttk.Combobox(prov_container, state="readonly", width=11)
        combobox_proveedor_inventario2.pack(fill="x")

        tk.Label(filters_body, text="📅  Fecha",
                 bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
        cal_container = tk.Frame(filters_body, bg="#2C3E50", padx=8, pady=6)
        cal_container.pack(fill="x", pady=(0, 10))
        calendario_inventario = Calendar(cal_container, selectmode='day',
                                         background="#2C3E50", foreground='white',
                                         headersbackground=label_bg, headersforeground='white',
                                         selectbackground=accent_bg, selectforeground='white',
                                         normalbackground="#253545", normalforeground="#ECF0F1",
                                         weekendbackground="#1E2A38", weekendforeground="#BDC3C7",
                                         othermonthbackground="#1A2530", othermonthforeground="#7F8C8D",
                                         font=('Segoe UI', 9))
        calendario_inventario.pack(fill="x")

        tk.Label(filters_body, text="⏱️  Periodo",
                 bg="#253545", fg="#BDC3C7", font=bold_font).pack(anchor="w", pady=(0, 4))
        periodo_container = tk.Frame(filters_body, bg="#2C3E50", padx=8, pady=6)
        periodo_container.pack(fill="x", pady=(0, 10))
        pf = tk.Frame(periodo_container, bg="#2C3E50")
        pf.pack()
        for txt, val in [("Día", "día"), ("Semana", "semana"), ("Mes", "mes"), ("Año", "año")]:
            tk.Radiobutton(pf, text=txt, variable=radio_seleccion, value=val,
                           bg="#2C3E50", fg="#ECF0F1", selectcolor="#1E2A38",
                           activebackground="#2C3E50", activeforeground=accent_bg,
                           font=bold_font).pack(side="left", padx=4)

        acciones_fila = tk.Frame(filters_body, bg="#253545")
        acciones_fila.pack(fill="x", pady=(0, 6))
        acciones_fila.columnconfigure(0, weight=1)
        acciones_fila.columnconfigure(1, weight=1)

        btn_mostrar = tk.Button(acciones_fila, text="🔍 Mostrar",
                                command=actualizar_tabla_stock_actual,
                                bg=accent_bg, fg="white", font=bold_font,
                                relief="flat", padx=8, pady=7, cursor="hand2",
                                activebackground="#D35400", activeforeground="white")
        btn_mostrar.grid(row=0, column=0, sticky="ew", padx=(0, 5))
        ToolTip(btn_mostrar, "Muestra el reporte con los filtros seleccionados")

        def calcular_numero_pdf():
            if active_button == boton_stock_actual:
                return 1
            elif active_button == boton_stock_bajo:
                return 2
            elif active_button == boton_agotados:
                return 3
            elif active_button == boton_movimientos_stock:
                p = radio_seleccion.get()
                if p == "día":      return 4
                elif p == "semana": return 5
                elif p == "mes":    return 6
                else:               return 7
            return 1

        btn_pdf = tk.Button(acciones_fila, text="📄 PDF",
                            command=lambda: generar_pdf_inventario(calcular_numero_pdf()),
                            bg=success_bg, fg="white", font=bold_font,
                            relief="flat", padx=8, pady=7, cursor="hand2",
                            activebackground="#1E8449", activeforeground="white")
        btn_pdf.grid(row=0, column=1, sticky="ew", padx=(5, 0))
        ToolTip(btn_pdf, "Exporta el reporte actual a un archivo PDF")

        btn_cerrar = tk.Button(filters_body, text="✖  Cerrar",
                               command=lambda: show_frame(welcome_frame),
                               bg=danger_bg, fg=button_fg, font=bold_font,
                               relief="flat", padx=16, pady=6, cursor="hand2",
                               activebackground="#C0392B", activeforeground="white")
        btn_cerrar.pack(fill="x")
        ToolTip(btn_cerrar, "Cerrar el panel de reportes de inventario")

        right_col = tk.Frame(body, bg="#253545")
        right_col.grid(row=0, column=1, sticky="nsew")

        right_header = tk.Frame(right_col, bg="#2C3E50", height=38)
        right_header.pack(fill="x")
        right_header.pack_propagate(False)
        tk.Label(right_header, text="📊  Resultados",
                 font=bold_font, bg="#2C3E50", fg="#BDC3C7").pack(side="left", padx=12, pady=8)

        tabla_frame = tk.Frame(right_col, bg="#253545")
        tabla_frame.pack(fill="both", expand=True, padx=12, pady=12)

        tabla_inventario2 = ttk.Treeview(tabla_frame, columns=(), show="headings",
                                          style="Modern.Treeview")

        scroll_y = ttk.Scrollbar(tabla_frame, orient="vertical",   command=tabla_inventario2.yview)
        scroll_x = ttk.Scrollbar(tabla_frame, orient="horizontal", command=tabla_inventario2.xview)
        tabla_inventario2.configure(yscrollcommand=scroll_y.set, xscrollcommand=scroll_x.set)
        scroll_y.pack(side="right",  fill="y")
        scroll_x.pack(side="bottom", fill="x")
        tabla_inventario2.pack(fill="both", expand=True)

    conn = database.conectar_db()
    if conn:
        categorias  = database.ejecutar_consulta(conn, "SELECT nombre FROM categorias")
        proveedores = database.ejecutar_consulta(conn, "SELECT nombre FROM proveedores")
        conn.close()
        combobox_categoria_inventario2['values']  = ["Todas las categorías"] + [c[0] for c in categorias]
        combobox_proveedor_inventario2['values']  = ["Todos los proveedores"] + [p[0] for p in proveedores]
        combobox_categoria_inventario2.current(0)
        combobox_proveedor_inventario2.current(0)

    activar_boton(boton_stock_actual)
    show_frame(reporte_inventario_frame)


def activar_boton(boton):
    global active_button
    if active_button is not None:
        active_button.config(bg=label_bg)
    boton.config(bg=accent_bg)
    active_button = boton
    actualizar_tabla_stock_actual()


def actualizar_tabla_stock_actual():
    global combobox_categoria_inventario2, combobox_proveedor_inventario2
    global calendario_inventario, radio_seleccion

    if active_button is None:
        return

    categoria = combobox_categoria_inventario2.get()
    proveedor = combobox_proveedor_inventario2.get()
    fecha     = calendario_inventario.selection_get()
    periodo   = radio_seleccion.get()

    if active_button in (boton_stock_actual, boton_stock_bajo, boton_agotados):
        columnas = ("ID", "Nombre", "Categoría", "Proveedor",
                    "Precio Com", "Precio Ven", "Stock", "Stock Mínimo", "Valor Inv")
        tabla_inventario2["columns"] = columnas
        for col in columnas:
            tabla_inventario2.heading(col, text=col, anchor="center")
            if col == "ID":
                tabla_inventario2.column(col, width=40,  anchor='center')
            elif col in ("Stock", "Stock Mínimo"):
                tabla_inventario2.column(col, width=60,  anchor='center')
            elif col in ("Precio Com", "Precio Ven", "Valor Inv"):
                tabla_inventario2.column(col, width=80,  anchor='center')
            else:
                tabla_inventario2.column(col, width=110, anchor='center')

        if active_button == boton_stock_actual:
            stocking = obtener_stock_actual(categoria, proveedor, fecha, periodo)
        elif active_button == boton_stock_bajo:
            stocking = obtener_stock_bajo(categoria, proveedor, fecha, periodo)
        else:
            stocking = obtener_productos_agotados(categoria, proveedor, fecha, periodo)

    else: 
        columnas = ("ID Movimiento", "Nombre Producto", "Fecha",
                    "Cantidad", "Precio Unitario", "Tipo Movimiento", "Motivo")
        tabla_inventario2["columns"] = columnas
        for col in columnas:
            tabla_inventario2.heading(col, text=col, anchor="center")
            tabla_inventario2.column(col, width=130 if col in ("Nombre Producto", "Fecha", "Motivo") else 110, anchor='center')

        fecha_inicio = fecha
        fecha_fin    = fecha + timedelta(days=1)
        if periodo == "día":
            stocking = obtener_movimientos_inventario(fecha_inicio, fecha_fin, categoria, proveedor, periodo)
        elif periodo == "semana":
            año, semana = fecha.isocalendar()[:2]
            stocking = obtener_movimientos_inventario_por_semana(año, semana, categoria, proveedor)
        elif periodo == "mes":
            año, mes = fecha.year, fecha.month
            stocking = obtener_movimientos_inventario_por_mes(año, mes, categoria, proveedor)
        else:
            año = fecha.year
            stocking = obtener_movimientos_inventario_por_año(año, categoria, proveedor)

    for item in tabla_inventario2.get_children():
        tabla_inventario2.delete(item)
    for producto in stocking:
        tabla_inventario2.insert("", tk.END, values=producto)


def obtener_stock_actual(categoria=None, proveedor=None, fecha=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            consulta = """
                SELECT p.id_producto, p.nombre, c.nombre, pr.nombre,
                       p.precio_compra, p.precio_venta, p.stock, p.stock_minimo,
                       (p.stock * p.precio_compra) AS valor_inventario
                FROM productos p
                JOIN categorias c ON p.id_categoria = c.id_categoria
                JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                WHERE 1=1
            """
            parametros = []
            if categoria and categoria != "Todas las categorías":
                consulta += " AND c.nombre = %s"
                parametros.append(categoria)
            if proveedor and proveedor != "Todos los proveedores":
                consulta += " AND pr.nombre = %s"
                parametros.append(proveedor)
            cursor.execute(consulta, parametros)
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
    return []

def obtener_stock_bajo(categoria=None, proveedor=None, fecha=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            consulta = """
                SELECT p.id_producto, p.nombre, c.nombre, pr.nombre,
                       p.precio_compra, p.precio_venta, p.stock, p.stock_minimo,
                       (p.stock * p.precio_compra) AS valor_inventario
                FROM productos p
                JOIN categorias c ON p.id_categoria = c.id_categoria
                JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                WHERE p.stock <= p.stock_minimo
            """
            parametros = []
            if categoria and categoria != "Todas las categorías":
                consulta += " AND c.nombre = %s"
                parametros.append(categoria)
            if proveedor and proveedor != "Todos los proveedores":
                consulta += " AND pr.nombre = %s"
                parametros.append(proveedor)
            cursor.execute(consulta, parametros)
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
    return []

def obtener_productos_agotados(categoria=None, proveedor=None, fecha=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            consulta = """
                SELECT p.id_producto, p.nombre, c.nombre, pr.nombre,
                       p.precio_compra, p.precio_venta, p.stock, p.stock_minimo,
                       (p.stock * p.precio_compra) AS valor_inventario
                FROM productos p
                JOIN categorias c ON p.id_categoria = c.id_categoria
                JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                WHERE p.stock = 0
            """
            parametros = []
            if categoria and categoria != "Todas las categorías":
                consulta += " AND c.nombre = %s"
                parametros.append(categoria)
            if proveedor and proveedor != "Todos los proveedores":
                consulta += " AND pr.nombre = %s"
                parametros.append(proveedor)
            cursor.execute(consulta, parametros)
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
    return []

def obtener_movimientos_inventario(fecha_inicio, fecha_fin, categoria=None, proveedor=None, periodo="dia"):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            consulta = """
                SELECT mi.id_movimiento, p.nombre, mi.fecha, mi.cantidad,
                       mi.precio_unitario, mi.tipo_movimiento, mi.motivo
                FROM movimientos_inventario mi
                JOIN productos p ON mi.id_producto = p.id_producto
                JOIN categorias c ON p.id_categoria = c.id_categoria
                JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                WHERE mi.fecha BETWEEN %s AND %s
            """
            parametros = [fecha_inicio, fecha_fin]
            if categoria and categoria != "Todas las categorías":
                consulta += " AND c.nombre = %s"
                parametros.append(categoria)
            if proveedor and proveedor != "Todos los proveedores":
                consulta += " AND pr.nombre = %s"
                parametros.append(proveedor)
            cursor.execute(consulta, parametros)
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
    return []

def obtener_movimientos_inventario_por_semana(año, semana, categoria=None, proveedor=None):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            consulta = """
                SELECT mi.id_movimiento, p.nombre, mi.fecha, mi.cantidad,
                       mi.precio_unitario, mi.tipo_movimiento, mi.motivo
                FROM movimientos_inventario mi
                JOIN productos p ON mi.id_producto = p.id_producto
                JOIN categorias c ON p.id_categoria = c.id_categoria
                JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                WHERE EXTRACT(YEAR FROM mi.fecha) = %s AND EXTRACT(WEEK FROM mi.fecha) = %s
            """
            parametros = [año, semana]
            if categoria and categoria != "Todas las categorías":
                consulta += " AND c.nombre = %s"
                parametros.append(categoria)
            if proveedor and proveedor != "Todos los proveedores":
                consulta += " AND pr.nombre = %s"
                parametros.append(proveedor)
            consulta += " ORDER BY mi.fecha"
            cursor.execute(consulta, parametros)
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
    return []

def obtener_movimientos_inventario_por_mes(año, mes, categoria=None, proveedor=None):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            consulta = """
                SELECT mi.id_movimiento, p.nombre, mi.fecha, mi.cantidad,
                       mi.precio_unitario, mi.tipo_movimiento, mi.motivo
                FROM movimientos_inventario mi
                JOIN productos p ON mi.id_producto = p.id_producto
                JOIN categorias c ON p.id_categoria = c.id_categoria
                JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                WHERE EXTRACT(YEAR FROM mi.fecha) = %s AND EXTRACT(MONTH FROM mi.fecha) = %s
            """
            parametros = [año, mes]
            if categoria and categoria != "Todas las categorías":
                consulta += " AND c.nombre = %s"
                parametros.append(categoria)
            if proveedor and proveedor != "Todos los proveedores":
                consulta += " AND pr.nombre = %s"
                parametros.append(proveedor)
            consulta += " ORDER BY mi.fecha"
            cursor.execute(consulta, parametros)
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
    return []

def obtener_movimientos_inventario_por_año(año, categoria=None, proveedor=None):
    try:
        conn = database.conectar_db()
        if conn:
            cursor = conn.cursor()
            consulta = """
                SELECT mi.id_movimiento, p.nombre, mi.fecha, mi.cantidad,
                       mi.precio_unitario, mi.tipo_movimiento, mi.motivo
                FROM movimientos_inventario mi
                JOIN productos p ON mi.id_producto = p.id_producto
                JOIN categorias c ON p.id_categoria = c.id_categoria
                JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor
                WHERE EXTRACT(YEAR FROM mi.fecha) = %s
            """
            parametros = [año]
            if categoria and categoria != "Todas las categorías":
                consulta += " AND c.nombre = %s"
                parametros.append(categoria)
            if proveedor and proveedor != "Todos los proveedores":
                consulta += " AND pr.nombre = %s"
                parametros.append(proveedor)
            consulta += " ORDER BY mi.fecha"
            cursor.execute(consulta, parametros)
            res = cursor.fetchall()
            cursor.close(); conn.close()
            return res
    except Exception as e:
        print(f"Error al ejecutar consulta SQL: {e}")
    return []

# 16. GENERAR PDF DE INVENTARIO
def generar_pdf_inventario(numero):
    categoria = combobox_categoria_inventario2.get()
    proveedor = combobox_proveedor_inventario2.get()
    fecha     = calendario_inventario.selection_get()
    periodo   = radio_seleccion.get()

    if numero == 1:
        stock_actual = obtener_stock_actual(categoria, proveedor, fecha, periodo)
    elif numero == 2:
        stock_actual = obtener_stock_bajo(categoria, proveedor, fecha, periodo)
    elif numero == 3:
        stock_actual = obtener_productos_agotados(categoria, proveedor, fecha, periodo)
    elif numero == 4:
        fecha_inicio = fecha
        fecha_fin    = fecha + timedelta(days=1)
        stock_actual = obtener_movimientos_inventario(fecha_inicio, fecha_fin, categoria, proveedor, periodo)
    elif numero == 5:
        año, semana  = fecha.isocalendar()[:2]
        stock_actual = obtener_movimientos_inventario_por_semana(año, semana, categoria, proveedor)
    elif numero == 6:
        año, mes     = fecha.year, fecha.month
        stock_actual = obtener_movimientos_inventario_por_mes(año, mes, categoria, proveedor)
    else:
        año          = fecha.year
        stock_actual = obtener_movimientos_inventario_por_año(año, categoria, proveedor)

    filepath = filedialog.asksaveasfilename(
        defaultextension=".pdf",
        filetypes=[("Archivos PDF", "*.pdf"), ("Todos los archivos", "*.*")])
    if not filepath:
        return

    doc = SimpleDocTemplate(filepath, pagesize=landscape(letter))
    story = []
    styles = getSampleStyleSheet()
    styleN = styles["Normal"]
    styleH = styles["Heading1"]
    styleH.alignment = 1
    styleH.fontSize  = 20

    try:
        logo = Image(resource_path("logo.png"), width=50, height=50)
        story.append(logo)
    except Exception:
        pass
    story.append(Spacer(1, 12))
    story.append(Paragraph("Reporte de Inventario", styleH))
    story.append(Paragraph(f"Fecha de generación: {date.today()}", styleN))
    story.append(Paragraph(f"Categoría: {categoria if categoria != 'Todas las categorías' else 'Todas'}", styleN))
    story.append(Paragraph(f"Proveedor: {proveedor if proveedor != 'Todos los proveedores' else 'Todos'}", styleN))
    if fecha:
        story.append(Paragraph(f"Fecha: {fecha.strftime('%Y-%m-%d')}", styleN))
        story.append(Paragraph(f"Periodo: {periodo}", styleN))
    story.append(Spacer(1, 24))

    if numero in (1, 2, 3):
        data = [["ID", "Nombre", "Categoría", "Proveedor",
                 "Precio Compra", "Precio Venta", "Stock", "Stock Mínimo", "Valor Inventario"]] + \
               [list(row) for row in stock_actual]
        col_widths = [0.5*inch, 1.5*inch, 1.5*inch, 1.5*inch,
                      1.2*inch, 1.2*inch, 1*inch, 1*inch, 1.2*inch]
    else:
        data = [["ID Movimiento", "Nombre Producto", "Fecha",
                 "Cantidad", "Precio Unitario", "Tipo Movimiento", "Motivo"]] + \
               [list(row) for row in stock_actual]
        col_widths = [1*inch, 1.5*inch, 1.5*inch, 1*inch, 1.2*inch, 1.5*inch, 1.5*inch]

    table = Table(data, colWidths=col_widths)
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#00A3A3")),
        ('TEXTCOLOR',  (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN',      (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME',   (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE',   (0, 0), (-1, 0), 10),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 8),
        ('BACKGROUND', (0, 1), (-1, -1), colors.white),
        ('GRID',       (0, 0), (-1, -1), 1, colors.black),
        ('FONTSIZE',   (0, 1), (-1, -1), 8),
    ]))
    story.append(table)
    story.append(Spacer(1, 12))
    story.append(Paragraph("--------------------------------------------------------------------------------", styleN))
    story.append(Paragraph("Tienda de Abarrotes 'El Buen Sabor' | Tel: (555) 123-4567", styleN))

    doc.build(story)
    messagebox.showinfo("Éxito", f"Reporte generado y guardado en:\n{filepath}")

# 17. RESPALDO Y LICENCIA
def respaldar_productos_si_necesario():
    conn = database.conectar_db()
    if conn:
        cursor = conn.cursor()
        ayer = date.today() - timedelta(days=1)
        cursor.execute("SELECT COUNT(*) FROM productos_respaldo WHERE DATE(fecha_respaldo) = %s", (ayer,))
        respaldo_existente = cursor.fetchone()[0] > 0
        hora_actual = datetime.now().time()
        if hora_actual >= time(0, 0) and not respaldo_existente:
            cursor.execute("""
                INSERT INTO productos_respaldo
                    (nombre, descripcion, id_categoria, id_proveedor,
                     precio_compra, precio_venta, stock, stock_minimo, fecha_respaldo)
                SELECT nombre, descripcion, id_categoria, id_proveedor,
                       precio_compra, precio_venta, stock, stock_minimo, %s
                FROM productos
            """, (ayer,))
            conn.commit()
            print("Respaldo de productos realizado correctamente")
        cursor.close()
        conn.close()
    else:
        print("Error: No se pudo conectar a la base de datos")


def verificar_licencia(conn):
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS registro_uso (
            id SERIAL PRIMARY KEY,
            fecha_inicio DATE,
            ultima_fecha_uso DATE
        )
    """)
    cursor.execute("SELECT fecha_inicio, ultima_fecha_uso FROM registro_uso LIMIT 1")
    resultado = cursor.fetchone()
    if resultado:
        fecha_inicio, ultima_fecha_uso = resultado
    else:
        fecha_inicio = date.today()
        ultima_fecha_uso = fecha_inicio
        cursor.execute("INSERT INTO registro_uso (fecha_inicio, ultima_fecha_uso) VALUES (%s, %s)",
                       (fecha_inicio, ultima_fecha_uso))
        conn.commit()
    fecha_actual = date.today()
    if fecha_actual < ultima_fecha_uso:
        messagebox.showerror("Error de Fecha",
                             "La fecha de la computadora ha sido manipulada. Por favor, ajuste la fecha correctamente.")
        cursor.close()
        conn.close()
        return False
    dias_transcurridos = (fecha_actual - fecha_inicio).days
    if dias_transcurridos >= 5:
        messagebox.showinfo("Prueba Gratuita Expirada",
                            "El periodo de prueba gratuita ha finalizado. ¡Gracias por probar nuestro software!")
        cursor.close()
        conn.close()
        return False
    cursor.execute("UPDATE registro_uso SET ultima_fecha_uso = %s WHERE id = 1", (fecha_actual,))
    conn.commit()
    print("fecha actualizada")
    cursor.close()
    return True

# 18. FUNCIÓN AUXILIAR DE NAVEGACIÓN
def show_frame(frame):
    frame.tkraise()

# 19. CONFIGURACIÓN PRINCIPAL Y ROOT
root = tk.Tk()
root.title("Punto de Venta - Tienda de Abarrotes")
root.geometry("1200x600")
root.configure(bg=frame_bg)
root.option_add('*Font', default_font)

setup_styles()

container = tk.Frame(root, bg=frame_bg)
container.pack(side="top", fill="both", expand=True)
container.grid_rowconfigure(0, weight=1)
container.grid_columnconfigure(1, weight=1)

radio_seleccion = tk.StringVar(value="día")

reporte_categoria_frame = tk.Frame(container, bg=frame_bg)
welcome_frame           = tk.Frame(container, bg=None)
products_frame          = tk.Frame(container, bg=frame_bg)
sales_frame             = tk.Frame(container, bg=frame_bg)
reports_frame           = tk.Frame(container, bg=frame_bg)

for frame in (welcome_frame, products_frame, sales_frame, reports_frame, reporte_categoria_frame):
    frame.grid(row=0, column=1, sticky="nsew")

background_image_ref = None

def resize_welcome(event):
    global background_image_ref
    w, h = event.width, event.height
    img = ima.open(resource_path("ondo3.png")).resize((w, h), ima.Resampling.LANCZOS)
    background_image_ref = ImageTk.PhotoImage(img)
    bg_label_welcome.config(image=background_image_ref)
    bg_label_welcome.image = background_image_ref

bg_label_welcome = tk.Label(welcome_frame)
bg_label_welcome.place(x=0, y=0, relwidth=1, relheight=1)
welcome_frame.bind("<Configure>", resize_welcome)

bg_reports_ref = [None]
def resize_reports(event):
    w, h = event.width, event.height
    img = ima.open(resource_path("ondo2.webp")).resize((w, h), ima.Resampling.LANCZOS)
    bg_reports_ref[0] = ImageTk.PhotoImage(img)
    bg_label_reports.config(image=bg_reports_ref[0])
    bg_label_reports.image = bg_reports_ref[0]
bg_label_reports = tk.Label(reports_frame)
bg_label_reports.place(x=0, y=0, relwidth=1, relheight=1)
reports_frame.bind("<Configure>", resize_reports)

inner_frame = tk.Frame(welcome_frame, bg=frame_bg)
inner_frame.place(relx=0.5, rely=0.5, anchor="center")
try:
    logo_img = ImageTk.PhotoImage(
        ima.open(resource_path("logo_grande.png")).resize((150, 150), ima.Resampling.LANCZOS))
    logo_label = tk.Label(inner_frame, image=logo_img, bg=frame_bg)
    logo_label.image = logo_img
    logo_label.pack(pady=10)
except Exception:
    pass

hora_actual = datetime.now().hour
if hora_actual < 12:
    saludo = "Buenos días"
elif hora_actual < 19:
    saludo = "Buenas tardes"
else:
    saludo = "Buenas noches"

inner_frame = tk.Frame(welcome_frame, bg="white",
                       highlightbackground=label_bg, highlightthickness=2)
inner_frame.place(relx=0.5, rely=0.5, anchor="center")

header_panel = tk.Frame(inner_frame, bg=label_bg)
header_panel.pack(fill="x")
try:
    logo_img = ImageTk.PhotoImage(
        ima.open(resource_path("logo_grande.png")).resize((32, 32), ima.Resampling.LANCZOS))
    tk.Label(header_panel, image=logo_img, bg=label_bg).pack(side="left", padx=(12, 6), pady=8)
    header_panel.logo_img = logo_img
except Exception:
    pass
tk.Label(header_panel, text=f"{saludo}  •  Sistema de Punto de Venta",
         font=bold_font, bg=label_bg, fg="white").pack(side="left", pady=8, padx=(0, 20))

botones_info = [
    {"emoji": "➕", "texto": "Agregar\nProducto",  "accion": agregar_producto,                    "color": "#1A4A7A", "accent": button_bg},
    {"emoji": "✏️", "texto": "Editar\nProducto",   "accion": editar_producto,                     "color": "#5B2C6F", "accent": "#9B59B6"},
    {"emoji": "🛒", "texto": "Generar\nVenta",      "accion": ver_ventas,                          "color": "#1A6B3C", "accent": success_bg},
    {"emoji": "📊", "texto": "Ver\nVentas",         "accion": ver_reportes_ventas2,                "color": "#7D5300", "accent": "#F39C12"},
    {"emoji": "📦", "texto": "Inventario",          "accion": ver_inventario,                      "color": "#0E6655", "accent": "#1ABC9C"},
    {"emoji": "📋", "texto": "Reportes",            "accion": ver_reportes_ventas,                 "color": "#6E2C2C", "accent": "#E74C3C"},
]

grid_frame = tk.Frame(inner_frame, bg="white")
grid_frame.pack(padx=2, pady=2)

btn_refs = [] 
for i, info in enumerate(botones_info):
    fila    = i // 3
    columna = i % 3

    cell = tk.Frame(grid_frame, bg=info["color"], width=130, height=110)
    cell.grid(row=fila, column=columna, padx=3, pady=3)
    cell.pack_propagate(False)

    tk.Frame(cell, bg=info["accent"], width=4).pack(side="left", fill="y")

    content = tk.Frame(cell, bg=info["color"])
    content.pack(fill="both", expand=True)

    tk.Label(content, text=info["emoji"],
             font=("Segoe UI Emoji", 26), bg=info["color"], fg="white").pack(pady=(12, 2))
    tk.Label(content, text=info["texto"],
             font=('Segoe UI', 8, 'bold'), bg=info["color"], fg="#BDC3C7",
             justify="center").pack()

    def make_hover(c, color, accent, fn):
        def enter(e): c.config(bg=accent); [w.config(bg=accent) for w in c.winfo_children()]
        def leave(e): c.config(bg=color);  [w.config(bg=color)  for w in c.winfo_children()]
        def click(e): fn()
        for w in [c] + list(c.winfo_children()):
            w.bind("<Enter>",   enter)
            w.bind("<Leave>",   leave)
            w.bind("<Button-1>",click)
    make_hover(content, info["color"], info["accent"], info["accion"])

NAV_WIDTH   = 260  
NAV_OFFSET  = 50   

nav_frame   = tk.Frame(root, bg=menu_bg, width=NAV_WIDTH)
nav_frame.place(x=-NAV_WIDTH, y=0, relheight=1)
is_nav_open = False


nav_images = []

def create_submenu(parent, options):
    submenu = tk.Menu(parent, tearoff=0, bg=menu_bg, fg=menu_fg,
                      activebackground=accent_bg, activeforeground="white",
                      font=default_font, borderwidth=0)
    for option, command, image_path in options:
        try:
            img = ima.open(image_path).convert("RGBA")
            img = img.resize((20, 20), ima.Resampling.LANCZOS)
            img_bg = ima.new("RGBA", img.size, (255, 255, 255, 255))
            img_bg.paste(img, (0, 0), img)
            photo = ImageTk.PhotoImage(img_bg, master=root)
            nav_images.append(photo)
            submenu.add_command(label=option, command=command, image=photo, compound="left")
        except Exception as e:
            print(f"Advertencia: no se pudo cargar la imagen {image_path} - {e}")
            submenu.add_command(label=option, command=command)
    return submenu

menu_options = [
    ("Productos", [
        ("Agregar Producto",        agregar_producto,             resource_path("gregar-producto.png")),
        ("Editar Producto",         editar_producto,              resource_path("editar.png")),
        ("Eliminar Producto",       eliminar_producto,            resource_path("eliminar.png")),
        ("Agregar Proveedor",       agregar_proveedor,            resource_path("proveedor.png")),
        ("Ver Proveedores", ver_proveedores, resource_path("proveedor.png")),
    ]),
    ("Ventas", [
        ("Generar Venta", ver_ventas,         resource_path("enta.png")),
        ("Ver Ventas",    ver_reportes_ventas2, resource_path("er_venta.png")),
    ]),
    ("Reportes", [
        ("Ver Reportes de Ventas",      ver_reportes_ventas,         resource_path("eporte.png")),
        ("Gráficos y Visualizaciones",  mostrar_bienvenida_graficos, resource_path("graficos.png")),
    ]),
    ("Inventario", [
        ("Ver Inventario",          ver_inventario,                      resource_path("inventario.png")),
        ("Reportes de Inventario",  mostrar_pantalla_reportes_inventario, resource_path("eportes.png")),
    ]),
]

def toggle_nav():
    global is_nav_open
    current_x = nav_frame.winfo_x()
    target_x  = 0 if not is_nav_open else -NAV_WIDTH
    step      = 10 if not is_nav_open else -10
    for x in range(current_x, target_x, step if step > 0 else step):
        nav_frame.place(x=x, y=0, relheight=1)
        root.update()
    is_nav_open = not is_nav_open
    toggle_button.config(text="X" if is_nav_open else "☰")

toggle_button = tk.Button(root, text="☰", command=toggle_nav,
                          bg=menu_bg, fg=menu_fg, font=('Segoe UI', 14, 'bold'),
                          width=3, height=1, relief="flat", cursor="hand2")
toggle_button.place(x=5, y=5)

tk.Frame(nav_frame, bg=menu_bg, height=NAV_OFFSET).pack(fill="x")

for option, suboptions in menu_options:
    btn = tk.Menubutton(nav_frame, text=option, bg=menu_bg, fg=menu_fg,
                        activebackground=accent_bg, activeforeground="white",
                        font=bold_font, relief="flat", padx=10, pady=8,
                        width=22)         
    btn.pack(fill="x", pady=5, padx=10)
    sub = create_submenu(btn, suboptions)
    btn.config(menu=sub)


status_bar   = tk.Frame(root, bg=menu_bg, height=25)
status_bar.pack(side="bottom", fill="x")
status_label = tk.Label(status_bar, text="Listo", bg=menu_bg, fg=menu_fg,
                         font=default_font, anchor="w")
status_label.pack(side="left", padx=10)

def actualizar_reloj():
    now = datetime.now()
    status_label.config(text=f"{now.strftime('%d/%m/%Y %H:%M:%S')} | Usuario: Administrador")
    root.after(1000, actualizar_reloj)

actualizar_reloj()

show_frame(welcome_frame)
respaldar_productos_si_necesario()

conn = database.conectar_db()
root.mainloop()
conn.close()