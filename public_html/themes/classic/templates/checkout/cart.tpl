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
{extends file=$layout}

{block name='content'}

  <section id="main">
    <div class="cart-grid row">

      <!-- Left Block: cart product informations & shpping -->
      <div class="cart-grid-body col-xs-12 col-lg-8">

        <!-- cart products detailed -->
        <div class="card cart-container">
          <div class="card-block">
            <h1 class="h1">{l s='Shopping Cart' d='Shop.Theme.Checkout'}</h1>
          </div>
          <hr class="separator">
          {block name='cart_overview'}
            {include file='checkout/_partials/cart-detailed.tpl' cart=$cart}
          {/block}
        </div>

        {block name='continue_shopping'}
          <a class="label" href="{$urls.pages.index}">
            <i class="material-icons">chevron_left</i>{l s='Continue shopping' d='Shop.Theme.Actions'}
          </a>
        {/block}

        <!-- shipping informations -->
        <div class="countdown"><span>C&oacute;mpralo antes de </span><span id="countdown"></span><span> y recibe tu pedido </span><span class="dateCountdown"></span></div>
        <p class="holliday-message">* Para calcular la fecha prevista de entrega hemos tenido en cuenta que el <b id="holliday-date"></b> es <i id="holliday-name"></i>.</p>
        {block name='hook_shopping_cart_footer'}
          {hook h='displayShoppingCartFooter'}
        {/block}
      </div>

      <!-- Right Block: cart subtotal & cart total -->
      <div class="cart-grid-right col-xs-12 col-lg-4">

        {block name='cart_summary'}
          <div class="card cart-summary">

            {block name='hook_shopping_cart'}
              {hook h='displayShoppingCart'}
            {/block}

            {block name='cart_totals'}
              {include file='checkout/_partials/cart-detailed-totals.tpl' cart=$cart}
            {/block}
            
            {block name='cart_actions'}
              {include file='checkout/_partials/cart-detailed-actions.tpl' cart=$cart}
            {/block}
            
            <hr class="separator">
            {widget name='gmgetfreeshipping'}
          </div>
        {/block}

        {block name='hook_reassurance'}
          {hook h='displayReassurance'}
        {/block}

      </div>
      
        {block name='hook_cross_selling_shopping_cart'}
          {hook h='displayCrossSellingShoppingCart'}
        {/block}
      
    </div>
  </section>
{/block}
