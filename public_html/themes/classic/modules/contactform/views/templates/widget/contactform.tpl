{**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2018 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<section class="contact-form">
  <form action="{if isset($nutritionist)}{$nutritionist_url}{else}{$urls.pages.contact}{/if}" method="post" {if $contact.allow_file_upload}enctype="multipart/form-data"{/if}>

    {if $notifications}
      <div class="col-xs-12 alert {if $notifications.nw_error}alert-danger{else}alert-success{/if}">
        <ul>
          {foreach $notifications.messages as $notif}
            <li>{$notif}</li>
          {/foreach}
        </ul>
      </div>
    {/if}

    {if !$notifications || $notifications.nw_error}
      <section class="form-fields">

        <div class="form-group row">
          <div class="col-md-9 col-md-offset-3">
            {if isset($nutritionist)}
              <h3>{l s='Servicio de Dietista - Nutricionista' d='Shop.Theme.Global'}</h3>
              <h5>&middot; {l s='Solicita tu primera consulta gratuita' d='Shop.Theme.Global'} &middot;</h5>
            {else}
              <h3>{l s='Contact us' d='Shop.Theme.Global'}</h3>
            {/if}
          </div>
        </div>

        <div style="display:none!important" class="form-group row">
          <label class="col-md-3 form-control-label">{l s='Subject' d='Shop.Forms.Labels'}</label>
          <div class="col-md-6">
            <select name="id_contact" class="form-control form-control-select">
              {foreach from=$contact.contacts item=contact_elt}
                <option value="{$contact_elt.id_contact}" {if (isset($nutritionist) && {$contact_elt.id_contact} == 2) || (!isset($nutritionist) && {$contact_elt.id_contact} == 1)}selected{/if}>{$contact_elt.name}</option>
              {/foreach}
            </select>
          </div>
        </div>  

        <div class="form-group row">
          <label class="col-md-3 form-control-label">{l s='Email address' d='Shop.Forms.Labels'}</label>
          <div class="col-md-6">
            <input
              class="form-control"
              name="from"
              type="email"
              value="{$contact.email}"
              placeholder="{l s='your@email.com' d='Shop.Forms.Help'}"
            >
          </div>
        </div>

        {if $contact.orders && !$nutritionist}
          <div class="form-group row">
            <label class="col-md-3 form-control-label">{l s='Order reference' d='Shop.Forms.Labels'}</label>
            <div class="col-md-6">
              <select name="id_order" class="form-control form-control-select">
                <option value="">{l s='Select reference' d='Shop.Forms.Help'}</option>
                {foreach from=$contact.orders item=order}
                  <option value="{$order.id_order}">{$order.reference}</option>
                {/foreach}
              </select>
            </div>
            <span class="col-md-3 form-control-comment">
              {l s='optional' d='Shop.Forms.Help'}
            </span>
          </div>
        {/if}

        {if $contact.allow_file_upload}
          <div class="form-group row">
            <label class="col-md-3 form-control-label">{l s='Attachment' d='Shop.Forms.Labels'}</label>
            <div class="col-md-6">
              <input type="file" name="fileUpload" class="filestyle" data-buttonText="{l s='Choose file' d='Shop.Theme.Actions'}">
            </div>
            <span class="col-md-3 form-control-comment">
              {l s='optional' d='Shop.Forms.Help'}
            </span>
          </div>
        {/if}

        <div class="form-group row">
          <label class="col-md-3 form-control-label">{l s='Message' d='Shop.Forms.Labels'}</label>
          <div class="col-md-9">
            <textarea
              class="form-control"
              name="message"
              placeholder="{l s='How can we help?' d='Shop.Forms.Help'}"
              rows="3"
            >{if $contact.message}{$contact.message}{/if}</textarea>
          </div>
        </div>

        {if isset($id_module)}
          <div class="form-group row">
            <div class="offset-md-3">
              {hook h='displayGDPRConsent' id_module=$id_module}
            </div>
          </div>
        {/if}
        
        {if isset($nutritionist)}
            <script type="text/javascript">
            //Recaptcha CallBack Function
            var onloadCallback = function() {
                //Fix captcha box issue in ps 1.7.7
                if ( ! document.getElementById("captcha-box")){
                        var container = document.createElement("div");
                        container.setAttribute("id","captcha-box");
                        if ( null !== document.querySelector(".form-fields") ){
                             document.querySelector(".form-fields").appendChild(container);
                        }
                }
                if ( document.getElementById("captcha-box")){
                    const eicaptchaSitekey = "{Configuration::get('CAPTCHA_PUBLIC_KEY')}";
                    {literal}
                    grecaptcha.render("captcha-box", {"theme" : "light", "sitekey" : eicaptchaSitekey});
                    {/literal}
                } else {
                    console.warn("eicaptcha: unable to add captcha-box placeholder to display captcha ( not an error when form is submited sucessfully )");
                }
            };
            </script>
            <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl={Configuration::get('CAPTCHA_FORCE_LANG')}" async defer></script>
        {/if}

      </section>

      <footer class="form-footer text-sm-right">
        <style>
          input[name=url] {
            display: none !important;
          }
        </style>
        <input type="text" name="url" value=""/>
        <input type="hidden" name="token" value="{$token}" />
        <input class="btn btn-primary" type="submit" name="submitMessage" value="{l s='Send' d='Shop.Theme.Actions'}">
      </footer>
    {/if}

  </form>
</section>