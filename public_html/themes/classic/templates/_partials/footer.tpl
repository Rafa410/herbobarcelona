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
{** (Se ha movido a modulo ps_emailsubscription)
<div class="container">
  <div class="row">**}
    {block name='hook_footer_before'}
      {hook h='displayFooterBefore'}
    {/block}
{**  </div>
</div>**}
<div class="footer-container">
  <div class="container">
    <div class="row">
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>
    <div class="row">
      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>
    <div class="row" style="margin-top:15px">
      <div class="col-md-12">
        <p class="text-sm-left">
          {block name='copyright_link'}
            <span{*a class="_blank" href="{$urls.base_url}" target="_blank"*} style="color:#336633">
              {l s='%copyright% %year% - Ecommerce software by %prestashop%' sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Global'}
            </span>
          {/block}
            <span> | </span>
            <a href="{$urls.base_url}aviso-legal_2">Aviso legal</a>
            <span> | </span>
            <a href="{$urls.base_url}terminos-y-condiciones-de-uso_3">Términos y condiciones</a>
            <span> | </span>
            <a href="{$urls.base_url}pago-seguro_5">Pago seguro</a>
            <span> | </span>
            <a href="{$urls.base_url}politica-de-cookies_7">Política de cookies</a>
            <span> | </span>
            <a href="{$urls.base_url}politica-de-privacidad_8">Política de privacidad</a>
            <span> | </span>
            <a href="{$urls.base_url}mapa del sitio">Mapa del sitio</a>
        </p>
      </div>
    </div>
  </div>
</div>
{****
<!--OneSignal-->
{literal}
<script>
  var OneSignal = window.OneSignal || [];
  OneSignal.push(function() {
    OneSignal.init({
      appId: "d3dbd127-8558-4622-b41d-f47fafabb421",
    });
    OneSignal.sendTags({
        Nombre: prestashop.customer.firstname,
        Club: prestashop.customer.newsletter,
        Cumple: prestashop.customer.birthday,
        N_productos: prestashop.cart.products_count
    });
  });
</script>
{/literal}
<script src="https://cdn.onesignal.com/sdks/OneSignalSDK.js" async></script>
****}
{if $page.page_name == 'search' && $search_string != ''}
<script>
window.onload = function(){
    document.getElementById("input_search").setAttribute("value","{$search_string}");
}
</script>
{/if}