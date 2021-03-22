{extends file='parent:catalog/_partials/product-details.tpl'}

{block name='product_reference'}
{if isset($product_manufacturer->id)}
  <div class="product-manufacturer">
    {if isset($manufacturer_image_url)}
      <a href="{$product_brand_url}">
        <img src="{$manufacturer_image_url}" class="img img-thumbnail manufacturer-logo" alt="{$product_manufacturer->name}">
      </a>
      <meta itemprop="brand" content="{$product_manufacturer->name}">
    {else}
      <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
      <span itemprop="brand">
        <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
      </span>
    {/if}
  </div>
{/if}
{if isset($product.reference_to_display) && $product.reference_to_display neq ''}
  <div class="product-reference">
    <label class="label">{l s='Reference' d='Shop.Theme.Catalog'} </label>
    <span itemprop="sku">{$product.reference_to_display}</span>
  </div>
{/if}
{/block}
