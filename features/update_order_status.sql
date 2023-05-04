--Feature 7
/*
Update status of an order. Input is order ID, new status (1 is in progress, 2 is delivered, 3 is canceled), and input time. The procedure does the following:
First check whether the order ID is valid. If not, print a message saying invalid order id.  
Update the status of the order to the input status. In case new status is in progress, no additional action is needed. 
In case the new status is ‘delivered’, insert a message into the message table for the corresponding customer, with message time as input time, and a message body saying 'Your order X has been delivered!' where X is the order ID. 
In case the new status is ‘canceled’, update the status to canceled, insert a message into the message table for the corresponding customer, with message time as input time, and a message body saying 'Your order X has been canceled and refund issued!' where X is the order ID. Please also insert into the payment table a refund record with a new payment ID, the corresponding customer id and order id, time as input time, and amount as the negative of the total amount in the order, and payment method the same as the original payment record.    
*/

CREATE OR REPLACE FUNCTION update_order_status (
    p_order_id IN itemOrder.orderid%TYPE,
    p_status IN itemOrder.status%TYPE,
    p_input_time IN itemOrder.delivery_time%TYPE
) RETURN BOOLEAN AS
    v_customer_id itemOrder.cid%TYPE;
    v_total_cost itemOrder.total_cost%TYPE;
    v_payment_method itemOrder.payment_method%TYPE;
BEGIN
    -- Check if the order ID is valid
    SELECT cid, total_cost, payment_method INTO v_customer_id, v_total_cost, v_payment_method
    FROM itemOrder
    WHERE orderid = p_order_id;
    
    IF v_customer_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Invalid order ID');
        RETURN FALSE;
    END IF;
    
    -- Update the status of the order
    UPDATE itemOrder
    SET status = p_status
    WHERE orderid = p_order_id;
    
    -- Insert message to message table if status is 'delivered'
    IF p_status = 2 THEN
        INSERT INTO message (cid, message_time, message_body)
        VALUES (v_customer_id, p_input_time, 'Your order ' || p_order_id || ' has been delivered!');
    -- Update status to canceled and insert message and refund record to payment table if status is 'canceled'
    ELSIF p_status = 3 THEN
        UPDATE itemOrder
        SET status = p_status
        WHERE orderid = p_order_id;
        INSERT INTO message (cid, message_time, message_body)
        VALUES (v_customer_id, p_input_time, 'Your order ' || p_order_id || ' has been canceled and refund issued!');
        INSERT INTO payment (paymentid, cid, orderid, payment_time, amount, payment_method)
        VALUES (payment_id_seq.NEXTVAL, v_customer_id, p_order_id, p_input_time, -v_total_cost, v_payment_method);
    END IF;
    
    RETURN TRUE;
END;
