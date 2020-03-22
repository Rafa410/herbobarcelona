{*
 *
 * @author   ->  Rafa Soler
 * @email    ->  rafasoler10+xipblog@gmail.com
 *
 *}

{if $feedtype == 'noProducts'}
    <p class="alert alert-warning">{l s='No products available in this feed.' d='Modules.CmsProducts.Shop'}</p>
{else}
    <section class="featured-products">
        <div class="products">
            {foreach from=$products item="product"}
                {include file="catalog/_partials/miniatures/product.tpl" product=$product}
            {/foreach}
        </div>
    </section>
{/if}