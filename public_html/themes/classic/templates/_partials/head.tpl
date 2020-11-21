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
{block name='head_charset'}
  
{/block}
{block name='head_ie_compatibility'}
  <meta http-equiv="x-ua-compatible" content="ie=edge">
{/block}
{block name='head_seo'}
  <title>{block name='head_seo_title'}{$page.meta.title}{/block}</title>
  <meta name="description" content="{block name='head_seo_description'}{$page.meta.description}{/block}">
  <meta name="keywords" content="{block name='head_seo_keywords'}{$page.meta.keywords}{/block}">
  {if $page.meta.robots !== 'index'}
    <meta name="robots" content="{$page.meta.robots}">
  {/if}
  {if $page.canonical}
    <link rel="canonical" href="{$page.canonical}">
  {/if}
{/block}
{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1">
{/block}
{block name='head_icons'}
  <link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
  <link rel="shortcut icon" type="image/x-icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
{/block}
<link rel="preconnect" href="//fonts.googleapis.com">
{*<link rel="preconnect" href="//connect.facebook.net">*}
<link rel="preconnect" href="//www.googletagmanager.com">
<link rel="dns-prefetch" href="//embed.tawk.to">
<link rel="dns-prefetch" href="//chimpstatic.com">
<link rel="dns-prefetch" href="//rec.smartlook.com">
<link rel="dns-prefetch" href="//www.googleadservices.com">
<link rel="dns-prefetch" href="//www.google-analytics.com">
{*<link rel="dns-prefetch" href="//www.facebook.com">*}
<link rel="dns-prefetch" href="//va.tawk.to">
<link rel="dns-prefetch" href="//stats.g.doubleclick.net">
<link rel="dns-prefetch" href="//googleads.g.doubleclick.net">
<link rel="dns-prefetch" href="//www.google.es">
<link rel="dns-prefetch" href="//www.google.com">
<link rel="dns-prefetch" href="//cdn.jsdelivr.net">
<link rel="dns-prefetch" href="https://herbobarcelona.api.oneall.com">

<link rel="manifest" href="/manifest.json">
<meta name="theme-color" content="#336633"/>
{if $page.page_name == 'module-xipblog-single'}
<meta property="fb:app_id" content="2279809748716826">
<meta property="og:locale" content="es_ES">
<meta property="og:type" content="article">
<meta property="og:title" content="{$xipblogpost.post_title}">
<meta property="og:description" content="{$xipblogpost.post_excerpt}">
<meta property="og:url" content="{$xipblogpost.link}">
<meta property="og:site_name" content="{$shop.name}">
<meta property="article:publisher" content="https://www.facebook.com/herbobarcelona">
<meta property="og:image" content="{$urls.base_url}{$xipblogpost.post_img_large}">
<meta property="og:image:secure_url" content="{$urls.base_url}{$xipblogpost.post_img_large}">
<meta property="og:image:alt" content="{$xipblogpost.post_title}">
<meta property="og:image:width" content="1170">
<meta property="og:image:height" content="421">
{/if}
{block name='stylesheets'}
  {include file="_partials/stylesheets.tpl" stylesheets=$stylesheets}
{/block}
{block name='javascript_head'}
  {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}
{/block}
{block name='hook_header'}
  {$HOOK_HEADER nofilter}
{/block}
{block name='hook_extra'}
    <meta name="google-site-verification" content="6sP5D6-kD_1fLCp0lT5tnuP3A5nF8TbC7zNWpt3_dUU" />
    <!-- Google Tag Manager -->
    {literal}
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-M5VRDNT');</script>
    {/literal}
<!-- End Google Tag Manager -->
{/block}