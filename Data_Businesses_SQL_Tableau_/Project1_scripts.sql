SELECT  product_category_name_english as Tech
FROM product_category_name_translation
WHERE product_category_name_english LIKE "informatica_acessorios%"  OR product_category_name_english LIKE "%computers%" 
OR product_category_name_english LIKE "%telephony%" OR product_category_name_english LIKE "%electronics%" 
OR product_category_name_english LIKE "%home_appliances%" OR product_category_name_english LIKE "%consoles_games%" 
OR product_category_name_english LIKE "%air_conditioning%" OR product_category_name_english LIKE "%fixed_telephony%" 
OR product_category_name_english LIKE "%signaling_and_security%" OR product_category_name_english LIKE "%home_appliances_2%" 
OR product_category_name_english LIKE "%audio%" OR product_category_name_english LIKE "%dvds_blu_ray%"
OR product_category_name_english LIKE "%pc_gamer%"OR product_category_name_english LIKE "%cds_dvds_musicals%";


#####################################################
#####################################################

#How many products of these tech categories have been sold (within the time window of the database snapshot)? 
#What percentage does that represent from the overall number of products sold?
select COUNT(o.order_status) as "TECK_SOLD"
from orders o

inner join order_items oi   
on o.order_id = oi.order_id

inner join products p
on oi.product_id = p.product_id  
  
where p.product_category_name in 
 (  'informatica_acessorios',
            'telefonia',
            'eletronicos',
            'consoles_games',
            'audio',
            'pcs',
            'tablets_impressao_imagem',
            'pc_gamer'  ) 
 
 and  o.order_status in ("delivered", "shipped", "invoiced", "created");
 #####################################################
 #####################################################
 
select COUNT(o.order_status) as ALL_SOLD
from orders o

inner join order_items oi   
on o.order_id = oi.order_id

inner join products p
on oi.product_id = p.product_id  
inner join product_category_name_translation pc
on p.product_category_name = pc.product_category_name
  
where p.product_category_name in (
'agro_industria_e_comercio'
'alimentos'
'alimentos_bebidas'
'artes'
'artes_e_artesanato'
'artigos_de_festas'
'artigos_de_natal'
'audio'
'automotivo'
'bebes'
'bebidas'
'beleza_saude'
'brinquedos'
'cama_mesa_banho'
'casa_conforto'
'casa_conforto_2'
'casa_construcao'
'cds_dvds_musicais'
'cine_foto'
'climatizacao'
'consoles_games'
'construcao_ferramentas_construcao'
'construcao_ferramentas_ferramentas'
'construcao_ferramentas_iluminacao'
'construcao_ferramentas_jardim'
'construcao_ferramentas_seguranca'
'cool_stuff'
'dvds_blu_ray'
'eletrodomesticos'
'eletrodomesticos_2'
'eletronicos'
'eletroportateis'
'esporte_lazer'
'fashion_bolsas_e_acessorios'
'fashion_calcados'
'fashion_esporte'
'fashion_roupa_feminina'
'fashion_roupa_infanto_juvenil'
'fashion_roupa_masculina'
'fashion_underwear_e_moda_praia'
'ferramentas_jardim'
'flores'
'fraldas_higiene'
'industria_comercio_e_negocios'
'informatica_acessorios'
'instrumentos_musicais'
'la_cuisine'
'livros_importados'
'livros_interesse_geral'
'livros_tecnicos'
'malas_acessorios'
'market_place'
'moveis_colchao_e_estofado'
'moveis_cozinha_area_de_servico_jantar_e_jardim'
'moveis_decoracao'
'moveis_escritorio'
'moveis_quarto'
'moveis_sala'
'musica'
'outros'
'papelaria'
'pc_gamer'
'pcs'
'perfumaria'
'pet_shop'
'portateis_casa_forno_e_cafe'
'portateis_cozinha_e_preparadores_de_alimentos'
'relogios_presentes'
'seguros_e_servicos'
'sinalizacao_e_seguranca'
'tablets_impressao_imagem'
'telefonia'
'telefonia_fixa'
'utilidades_domesticas') 
and  o.order_status in ("delivered", "shipped", "invoiced", "created");

##############################################################



#What’s the average price of the products being sold?........1.3

select avg(oi.price) as a_price

from order_items oi

inner join products p

on oi.product_id = p.product_id;


############################################
############################################

select oi.price as tech_price,

 CASE
        when price >= 70 THEN 'High Expensive'
        when price >60 THEN 'Medium Expensive'
        else 'Cheap'
    end as sales_category

from order_items oi

inner join products p

on oi.product_id = p.product_id

where product_category_name in 
 (  'informatica_acessorios',
            'telefonia',
            'eletronicos',
            'consoles_games',
            'audio',
            'pcs',
            'tablets_impressao_imagem',
            'pc_gamer' ) ;


#########################################################--SECTION 2
#########################################################
#########################################################

#How many months of data are included in the magist database?-1
SELECT  

YEAR(order_purchase_timestamp) AS Year, MONTH(order_purchase_timestamp) AS MONTH

FROM
    orders
GROUP BY year;


############################################--2
#############################################
#How many sellers are there? 

Select count(distinct seller_id) as N_seller

from sellers;


############################################--2b
#############################################
#What percentage of overall sellers are Tech sellers?

Select count(distinct s.seller_id) as N_seller_Tech

from  products p  

inner join order_items oi

on p.product_id = oi.product_id

inner join sellers s 

on oi.seller_id =s.seller_id

where p.product_category_name in 

 (  'informatica_acessorios',
            'telefonia',
            'eletronicos',
            'consoles_games',
            'audio',
            'pcs',
            'tablets_impressao_imagem',
            'pc_gamer'   ) ;

# 28%


###########################################################----3
##########################################################
#What is the total amount earned by all sellers? 

select sum(oi.price) as Total_Seller_sum

from order_items oi

inner join sellers s 

on oi.seller_id = s.seller_id;

########################################------3b
#######################################
#What is the total amount earned by all Tech sellers?

select sum(oi.price) as Total_TECH_Seller_sum

from order_items oi

inner join sellers s 

on oi.seller_id = s.seller_id

inner join products p 

on oi.product_id = p.product_id

where p.product_category_name in 

 (  'informatica_acessorios',
            'telefonia',
            'eletronicos',
            'consoles_games',
            'audio',
            'pcs',
            'tablets_impressao_imagem',
            'pc_gamer'   );   # join oder table and add and o.order_status in
            #("delivered", "shipped", "invoiced", "approved", "created", "processing");

 
############################################----4
###########################################
#Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?
select avg(oi.price) as avg_income, sum(oi.price)

from order_items oi

inner join sellers s

on oi.seller_id = s.seller_id;

###################################################################-----section 3
###################################################################
##########What’s the average time between the order being placed and the product being delivered?

select 
    sum(if(order_estimated_delivery_date>=order_delivered_customer_date,1,0)) as timely_delivery, 
    sum(if(order_estimated_delivery_date<order_delivered_customer_date,1,0)) as delayed_delivery
from orders;

# Orders_in_time 88476
#-- Orders_delayed 6666


###################################################################
#How many orders are delivered on time vs orders delivered with a delay?

DELIMITER $$
 
CREATE FUNCTION on_time(
     actual DATETIME,
     estimated DATETIME
)
RETURNS VARCHAR(10)
 
DETERMINISTIC
 
BEGIN
DECLARE result_var VARCHAR(10);
     IF TIMESTAMPDIFF(DAY, actual, estimated) >= 0 THEN
          SET result_var = 'On time';
     ELSE
          SET result_var = 'Late';
     END IF;
RETURN (result_var);
END$$
 
DELIMITER ;

SELECT
     order_id,
     on_time(order_delivered_customer_date, order_estimated_delivery_date) AS ontime
FROM orders
WHERE order_status like 'delivered';


############################################################################
#Is there any pattern for delayed orders, e.g. big products being delayed more often?



































