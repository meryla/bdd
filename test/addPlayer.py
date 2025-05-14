import sys
import os

# Ajouter le dossier parent au chemin d'import
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from Database.db_utils import get_connection


def ajouter_joueur(username, password, niveau=1, experience=0, montant_or=0):
    conn = get_connection()
    cursor = conn.cursor()

    query = """
    INSERT INTO Joueur (username, password, niveau, experience, montant_or)
    VALUES (%s, %s, %s, %s, %s)
    """
    valeurs = (username, password, niveau, experience, montant_or)

    try:
        cursor.execute(query, valeurs)
        conn.commit()
        print("✅ Joueur ajouté avec succès !")
    except Exception as e:
        print("❌ Erreur :", e)
    finally:
        cursor.close()
        conn.close()

# Exemple d’utilisation
ajouter_joueur("meryeme", "testtest", 2, 150, 200)
