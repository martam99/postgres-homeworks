"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv

PARAMS = {"host": "localhost",
          "database": "north",
          "user": "postgres",
          "password": "mariam001."}
with psycopg2.connect(**PARAMS) as connection:
    with connection.cursor() as cursor:
        try:
            with open("north_data/customers_data.csv", newline='', encoding='utf-8') as csvfile:
                data = csv.DictReader(csvfile)
                for row in data:
                    customer_id = row['customer_id']
                    company_name = row['company_name']
                    contact_name = row['contact_name']
                    cursor.execute("INSERT INTO customers VALUES (%s, %s, %s)",
                                   (customer_id, company_name, contact_name))

            with open("north_data/employees_data.csv", newline='', encoding='utf-8') as csvfile:
                data = csv.DictReader(csvfile)
                for row in data:
                    employee_id = row['employee_id']
                    first_name = row['first_name']
                    last_name = row['last_name']
                    title = row['title']
                    birth_date = row['birth_date']
                    notes = row['notes']
                    cursor.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                                   (employee_id, first_name, last_name, title, birth_date, notes))

            with open("north_data/orders_data.csv", newline='', encoding='utf-8') as csvfile:
                data = csv.DictReader(csvfile)
                for row in data:
                    order_id = row['order_id']
                    customer_id = row['customer_id']
                    employee_id = row['employee_id']
                    order_date = row['order_date']
                    ship_city = row['ship_city']
                    cursor.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                                   (order_id, customer_id, employee_id, order_date, ship_city))
        except FileNotFoundError:
            print("File isn't found")
        except KeyError:
            print(" ")


connection.close()
