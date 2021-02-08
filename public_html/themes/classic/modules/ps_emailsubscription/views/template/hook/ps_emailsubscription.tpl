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
<div class="block_newsletter col-lg-9 col-md-12 col-sm-12">
  <div class="row">
    <p id="block-newsletter-label" class="col-md-5 col-xs-12">{l 
    s='Get our latest news and special sales' 
    sprintf=[
          '[1]' => '<a href="/ventajas-club_10" target="_blank">',
          '[/1]' => '</a>'
        ]
    d='Shop.Theme.Global'}
    </p>
    <div class="col-md-7 col-xs-12">
                <!-- Begin Mailchimp Signup Form -->
{** (Se ha movido a custom.css) <link href="//cdn-images.mailchimp.com/embedcode/horizontal-slim-10_7.css" rel="stylesheet" type="text/css">**}
<div id="mc_embed_signup">
<form action="https://herbobarcelona.us17.list-manage.com/subscribe/post?u=365128b75089e0a79bdf71efc&amp;id=2a18c84060" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
    <div id="mc_embed_signup_scroll">
    <div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_365128b75089e0a79bdf71efc_2a18c84060" tabindex="-1" value=""></div>
    <div class="clear">
        <input type="submit" value="Unirse al club" name="subscribe" id="mc-embedded-subscribe" class="btn btn-primary float-xs-right hidden-xs-down">
        <input type="submit" value="Ok" name="subscribe" id="mc-embedded-subscribe" class="btn btn-primary float-xs-right hidden-sm-up">
        <div class="input-wrapper"><input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="Direccion de email" required></div>
    </div>
    </div>
</form>
</div>
                <!--End mc_embed_signup-->
{****** Prestashop Sign up form ******
<form action="{$urls.pages.index}#footer" method="post">
        <div class="row">
          <div class="col-xs-12">
            <input
              class="btn btn-primary float-xs-right hidden-xs-down"
              name="submitNewsletter"
              type="submit"
              value="{l s='Subscribe' d='Shop.Theme.Actions'}"
            >
            <input
              class="btn btn-primary float-xs-right hidden-sm-up"
              name="submitNewsletter"
              type="submit"
              value="{l s='OK' d='Shop.Theme.Actions'}"
            >
            <div class="input-wrapper">
              <input
                name="email"
                type="email"
                value="{$value}"
                placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
                aria-labelledby="block-newsletter-label"
              >
            </div>
            <input type="hidden" name="action" value="0">
            <div class="clearfix"></div>
          </div>
          <div class="col-xs-12">
              {if $conditions}
                <p>{$conditions}</p>
              {/if}
              {if $msg}
                <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
                  {$msg}
                </p>
              {/if}
              {if isset($id_module)}
                {hook h='displayGDPRConsent' id_module=$id_module}
              {/if}
          </div>
        </div>
      </form>
*************************}
    </div>
  </div>
</div>