-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT c.company_name AS customer, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM orders as o
JOIN customers as c USING(customer_id)
JOIN employees as e USING(employee_id)
JOIN shippers as s ON o.ship_via = s.shipper_id
WHERE c.city = 'London' AND e.city = 'London' AND s.company_name = 'United Package';



-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, contact_name, phone from products
join suppliers on products.supplier_id=suppliers.supplier_id
join categories on products.category_id=categories.category_id
where products.discontinued=0 and products.units_in_stock<25 and categories.category_name IN ('Dairy Products','Condiments')
ORDER BY products.units_in_stockL,O

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name from customers
left join orders on customers.customer_id=orders.customer_id
where orders.customer_id is null

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select product_name from products
where product_id=any(select product_id from order_details where quantity=10)