-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select customers.company_name, concat(employees.last_name, '' ,employees.first_name) as employer_fullname
from customers
join orders on customers.customer_id=orders.customer_id
join employees on employees.employee_id=orders.employee_id
join shippers on customers.company_name=shippers.company_name
where employees.city='London' AND customers.city='London' AND shippers.company_name='United Package'



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