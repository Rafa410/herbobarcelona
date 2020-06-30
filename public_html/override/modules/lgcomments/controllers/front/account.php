<?php

/**
 * Override to the front controller of the module lgcomments to add nick automatically on review_form
 * 
 * @author   -> Rafa Soler
 * @email    -> rafasoler10+lgcomments@gmail.com
 * 
 */ 

if ( ! defined( '_PS_VERSION_' ) ) {
    exit;
}

class LGCommentsAccountModuleFrontControllerOverride extends LGCommentsAccountModuleFrontController
{

    public function initContent()
    {
        parent::initContent();
        
        $id_order = (int)Tools::getValue('id_order');
        $order_data = $this->getOrderData($id_order);
        $customer = new Customer((int)$order_data['id_customer']);
        $nick = $customer->firstname . ' ' . $customer->lastname;

        $this->context->smarty->assign(
            'nick', $nick
        );

    }

}