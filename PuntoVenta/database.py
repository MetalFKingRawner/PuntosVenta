import psycopg2

def conectar_db():
    try:
        conn = psycopg2.connect(
            dbname="puntoventa",
            user="postgres",
            password="hangar81",
            host="localhost",
            options="-c client_encoding=UTF8"
        )
        return conn
    except Exception as e:
        print(f"Error al conectar a la base de datos: {e}")
        return None

def ejecutar_consulta(conn, consulta, parametros=None):
    try:
        cur = conn.cursor()
        cur.execute(consulta, parametros)

        # Verificar si la consulta es INSERT, UPDATE o DELETE
        if cur.description is None:
            conn.commit()
            return cur.rowcount > 0  # Devolver True si se afectó alguna fila, False si no
        else:
            resultados = cur.fetchall()
            return resultados

    except psycopg2.errors.UniqueViolation as e:  # Capturar la excepción UNIQUE
        #print(f"Error de restricción UNIQUE: {e}")
        conn.rollback()
        return False  # Indicar que hubo un error
    except Exception as e:
        #print(f"Error al ejecutar consulta: {e}")
        conn.rollback()
        return False  # Indicar que hubo un error