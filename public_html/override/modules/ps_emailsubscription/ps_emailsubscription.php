<?php

class Ps_EmailsubscriptionOverride extends Ps_Emailsubscription
{
    public function hookAdditionalCustomerFormFields($params)
    {
            $label = $this->trans(
                'Sign up for our newsletter[1][2]%conditions%[/2]',
                array(
                    '[1]' => '<br>',
                    '[2]' => '<em>',
                    '%conditions%' => Configuration::get('NW_CONDITIONS', $this->context->language->id),
                    '[/2]' => '</em>',
                ),
                'Modules.Emailsubscription.Shop'
            );

            return array(
                (new FormField())
                    ->setName('newsletter')
                    ->setType('checkbox')
                    ->setLabel($label), 
            );
    }
    
}

?>