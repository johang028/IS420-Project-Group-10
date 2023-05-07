/*
Feature 7

Update status of an order. Input is order ID, new status (1 is in progress, 2 is delivered, 3 is canceled), and input time. The procedure does the following:
First check whether the order ID is valid. If not, print a message saying invalid order id.  
Update the status of the order to the input status. In case new status is in progress, no additional action is needed. 
In case the new status is ‘delivered’, insert a message into the message table for the corresponding customer, with message time as input time, and a message body saying 'Your order X has been delivered!' where X is the order ID. 
In case the new status is ‘canceled’, update the status to canceled, insert a message into the message table for the corresponding customer, with message time as input time, and a message body saying 'Your order X has been canceled and refund issued!' where X is the order ID. Please also insert into the payment table a refund record with a new payment ID, the corresponding customer id and order id, time as input time, and amount as the negative of the total amount in the order, and payment method the same as the original payment record.    
Lead: Sung Ji
Assist: Jawan Blunt

*/

create or replace procedure update_itemOrder_status(p_order_id in int, p_status in int, p_input_time in timestamp)
as
refund_amount payment.pamount%type;
payment_method payment.method%type;
customer_id itemOrder.cid%type;
payment_id payment.payid%type;
order_id_count integer;

begin
    -- check if the order id is valid
    select count(*)
    into order_id_count
    from itemOrder
    where orderid = p_order_id;
    
    if order_id_count = 0 then
        dbms_output.put_line('Invalid order id.');
        
    -- update the status of the order (status of order will be 1 (in progress))    
    elsif p_status = 1 then
        update itemOrder
        set status = p_status
        where orderid = p_order_id;
    
    -- insert a message into the message table for the corresponding customer, with message time as input time, and a message body saying 'Your order X has been delivered!' where X is the order ID. 
    elsif p_status = 2 then
        --need to get customer id from itemOrder
        select cid 
        into customer_id
        from itemOrder
        where orderid = p_order_id;
        
        insert into message values(mes_seq.nextval, customer_id, p_input_time, 'Your order ' || p_order_id || ' has been delivered!');
        
    else
        --In case the new status is ‘canceled’, update the status to canceled.
        update itemOrder
        set status = p_status
        where orderid = p_order_id;
        
        /*Insert a message into the message table for the corresponding customer, with message time as input time, and a message body saying
        'Your order X has been canceled and refund issued!' where X is the order ID.*/
        
        --need to get customer id from itemOrder
        select cid 
        into customer_id
        from itemOrder
        where orderid = p_order_id;

        --insert into message(mesid int, cid int, mtime date, mbody varchar) values
        insert into message values(mes_seq.nextval, customer_id, p_input_time, 'Your order ' || p_order_id || ' has been canceled and refund issued!');
        
        
        /*insert into the payment table a refund record with a new payment ID, the corresponding 
        customer id and order id, time as input time, and amount as the negative of the total amount in the 
        order, and payment method the same as the original payment record*/
        
        --get pamount for refund
        select pamount
        into refund_amount
        from payment
        where orderid = p_order_id;
        
        --make refund_amount negative to indicate a credit
        refund_amount := refund_amount * -1;
        
        --get method for payment method
        select method
        into payment_method
        from payment
        where orderid = p_order_id;
        
        insert into payment values(pay_seq.nextval, p_order_id, customer_id, refund_amount, payment_method);
    end if;
end;
/
