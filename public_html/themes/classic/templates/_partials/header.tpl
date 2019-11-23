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
 <!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M5VRDNT"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
{block name='header_banner'}
  <div class="header-banner">
    {hook h='displayBanner'}
  </div>
{/block}


{block name='header_top'}
  <div class="header-top">
    <div class="container">
       <div class="row">
        <div class="col-md-3 hidden-sm-down" id="_desktop_logo">
            {if $page.page_name == 'index'}
              <h1>
                <a href="{$urls.base_url}" title="{$shop.name}">
                  <img class="logo img-responsive" src="{$shop.logo}" alt="{$shop.name}">
                </a>
              </h1>
            {else}
                <a href="{$urls.base_url}" title="{$shop.name}">
                  <img class="logo img-responsive" src="{$shop.logo}" alt="{$shop.name}">
                </a>
            {/if}
        </div>
        {**<div class="col-md-12 col-sm-12 position-static">**}
          {hook h='displayTop'}
        {*<div class="clearfix"></div>
        </div>*}
      </div>
      <div id="mobile_top_menu_wrapper" class="row hidden-md-up" style="display:none;">
        <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
        <div class="js-top-menu-bottom">
          <div id="_mobile_currency_selector"></div>
          <div id="_mobile_language_selector"></div>
          <div id="_mobile_contact_link"></div>
        </div>
      </div>
    </div>
  </div>
  {hook h='displayNavFullWidth'}
{/block}

{block name='header_nav'}
  <nav class="header-nav">
    <div class="container">
      <div class="row">
        <div class="hidden-sm-down">
          <div class="col-md-5 col-xs-12">
            {hook h='displayNav1'}
          </div>
          <div class="col-md-7 right-nav">
            <div id="sticky-search" style="display:none">
                <i class="material-icons">search</i>
            </div>
              {hook h='displayNav2'}
          </div>
        </div>
        <div class="hidden-md-up text-sm-center mobile">
          <div class="float-xs-left" id="menu-icon">
            <span data-target="#mobile_top_menu_wrapper" data-toggle="collapse" class="collapse-icons">
                <i class="material-icons add">&#xE5D2;</i>
                <i class="material-icons remove">close</i>
            </span>
          </div>
          <div class="float-xs-left" id="search-icon">
            <span>
                <i class="material-icons">search</i>
            </span>
          </div>
          <div class="float-xs-right" id="_mobile_cart"></div>
          <div class="float-xs-right" id="_mobile_user_info"></div>
          <div class="top-logo" id="_mobile_logo"></div>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <a href="{$urls.base_url}" title="{$shop.name}"><img id="sticky-logo" width="47px" height="47px" src="{$urls.base_url}img/mini-logo.png" alt="{$shop.name}"</a>
  </nav>
{/block}