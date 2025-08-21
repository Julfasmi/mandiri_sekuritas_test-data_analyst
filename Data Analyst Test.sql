create database mandiri_sekuritas;
use mandiri_sekuritas;

SELECT COUNT(*) AS jumlah_data
FROM consumen;

-- create a new table
CREATE TABLE consumen AS
SELECT
    -- From transactions_data     
    t.id AS transaksi_id,
    t.date AS transaksi_date,
    t.amount AS transaksi_amount,
    t.use_chip,
    t.errors,
    t.merchant_id,
    t.merchant_city,
    t.merchant_state,
    t.zip,
    t.mcc,

    -- From cards_data
    c.id AS card_id,
    c.card_brand,
    c.card_type,
    c.has_chip,
    c.num_cards_issued,
    c.credit_limit,
    c.acct_open_date,
    c.year_pin_last_changed,
    c.card_on_dark_web,

    -- From users_data
    u.id AS user_id,
    u.gender,
    u.current_age,
    u.retirement_age,
    u.birth_year,
    u.birth_month,
    u.address,
    u.latitude,
    u.longitude,
    u.per_capita_income,
    u.yearly_income,
    u.total_debt,
    u.credit_score,
    u.num_credit_cards

FROM transactions_data t
LEFT JOIN cards_data c 
    ON t.card_id = c.id
LEFT JOIN users_data u 
    ON t.client_id = u.id;

-- sql to csv
SELECT 
    'transaksi_id','transaksi_date','transaksi_amount','use_chip','errors',
    'merchant_id','merchant_city','merchant_state','zip','mcc',
    'card_id','card_brand','card_type','has_chip','num_cards_issued',
    'credit_limit','acct_open_date','year_pin_last_changed','card_on_dark_web',
    'user_id','gender','current_age','retirement_age','birth_year','birth_month',
    'address','latitude','longitude','per_capita_income','yearly_income',
    'total_debt','credit_score','num_credit_cards'
UNION ALL
SELECT
    t.id, t.date, t.amount, t.use_chip, t.errors,
    t.merchant_id, t.merchant_city, t.merchant_state, t.zip, t.mcc,
    c.id, c.card_brand, c.card_type, c.has_chip, c.num_cards_issued,
    c.credit_limit, c.acct_open_date, c.year_pin_last_changed, c.card_on_dark_web,
    u.id, u.gender, u.current_age, u.retirement_age, u.birth_year, u.birth_month,
    u.address, u.latitude, u.longitude, u.per_capita_income, u.yearly_income,
    u.total_debt, u.credit_score, u.num_credit_cards
FROM transactions_data t
LEFT JOIN cards_data c ON t.card_id = c.id
LEFT JOIN users_data u ON t.client_id = u.id
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/consumen.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
