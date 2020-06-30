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
{block name='product_miniature_item'}
  <article class="product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
        
    <meta itemprop="brand" content="{if !empty(Manufacturer::getnamebyid($product.id_manufacturer))}{Manufacturer::getnamebyid($product.id_manufacturer)}{else}{Configuration::get('PS_SHOP_NAME')}{/if}">
    <meta itemprop="image" content="{$product.cover.bySize.home_default.url}">
    <meta itemprop="sku" content="{$product->id}" />
    <meta itemprop="mpn" content="{$product->reference}" />
    {if !empty($product->ean13)}
        <meta itemprop="gtin13" content="{$product->ean13}" />
    {/if}

    <div class="thumbnail-container">
      {block name='product_thumbnail'}
        {if $product.cover}
          <a href="{$product.url}" class="thumbnail product-thumbnail  is_stlazyloading">
                        {**Lazy load**}
<img src="{$stlazyloading.img_prod_url}{$stlazyloading.lang_iso_code}-default-home_default.jpg" class="stlazyloading_holder" width="{$product.cover.bySize.home_default.width}" height="{$product.cover.bySize.home_default.height}" alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name}{/if}" />
<img data-src = "{$product.cover.bySize.home_default.url}" class="stlazyloadthis"
                            {*End*}
              alt = "{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
              data-full-size-image-url = "{$product.cover.large.url}"
            >
          </a>
        {else}
          <a href="{$product.url}" class="thumbnail product-thumbnail">
            <img
              src = "{$urls.no_picture_image.bySize.home_default.url}"
            >
          </a>
        {/if}
      {/block}

      <div class="product-description">

        {if !empty($product.description_short)}
            <div itemprop="description" style="display:none">{$product.description_short nofilter}</div>
        {/if}
        
        {block name='product_name'}
          {if $page.page_name == 'index'}
            <h3 class="h3 product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
          {else}
            <h2 class="h3 product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h2>
          {/if}
        {/block}

        {block name='product_price_and_shipping'}
          {if $product.show_price}
            <div class="product-price-and-shipping" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                <link itemprop="availability" href="{$product.seo_availability}"/>
                <meta itemprop="priceCurrency" content="{$currency.iso_code}">

                <meta itemprop="priceValidUntil" content="{'Y'|date+1}-12-31">
                <meta itemprop="url" content="{$product.url}">

              {if $product.has_discount}
                {hook h='displayProductPriceBlock' product=$product type="old_price"}

                <span class="sr-only">{l s='Regular price' d='Shop.Theme.Catalog'}</span>
                <span class="regular-price">{$product.regular_price}</span>
                {if $product.discount_type === 'percentage'}
                  <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
                {elseif $product.discount_type === 'amount'}
                  <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                {/if}
              {/if}

              {hook h='displayProductPriceBlock' product=$product type="before_price"}

              <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
              <span itemprop="price" content="{$product.price_amount}" class="price">{$product.price}</span>

              {hook h='displayProductPriceBlock' product=$product type='unit_price'}

              {hook h='displayProductPriceBlock' product=$product type='weight'}
            </div>
          {/if}
        {/block}

        {block name='product_reviews'}
          {hook h='displayProductListReviews' product=$product}
        {/block}
      </div>

      {block name='product_flags'}
        <ul class="product-flags">
          {foreach from=$product.flags item=flag}
            <li class="product-flag {$flag.type}">{$flag.label}</li>
          {/foreach}
        </ul>
      {/block}

      <div class="highlighted-informations{if !$product.main_variants} no-variants{/if} hidden-sm-down">
        {block name='quick_view'}
          <a class="quick-view" href="#" data-link-action="quickview">
            <i class="material-icons search">&#xE8B6;</i> {l s='Quick view' d='Shop.Theme.Actions'}
          </a>
        {/block}

        {block name='product_variants'}
          {if $product.main_variants}
            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
          {/if}
        {/block}
      </div>
    
    <!-- add-to-cart button on miniatures -->
    <div class="product-add-cart btn-cart-miniature"> {*product-actions*}
          <form action="{$urls.pages.cart}?add=1&amp;id_product={$product.id}&amp;id_product_attribute={$product.id_customization}&amp;token={$static_token}" method="post">
            <input type="hidden" name="id_product" value="{$product.id}">
            <div class="product-add-to-cart">
                <div class="product-quantity clearfix">
                
                  <input type="hidden" name="qty" value="1" class="form-control input-qty" min="1">

                  <div class="add">
                      <button 
                        class="btn btn-primary add-to-cart" 
                        data-button-action="add-to-cart" 
                        type="submit"
                        {if $product.availability == 'unavailable'}
                            title="Sin stock"
                            disabled
                        {/if}
                      >
                        <i class="material-icons shopping-cart">&#xE547;</i>
                          <div class="loader">
                            <div></div><div></div><div></div><div></div>
                          </div>
                          <span>{l s='Add to cart' d='Shop.Theme.Actions'}</span>
                      </button>
                  </div>
                </div>
            </div>       
            {block name='product_refresh'}{/block}
          </form>
    </div>
    <!-- End add-to-cart -->
    
    </div>
  </article>
{/block}
