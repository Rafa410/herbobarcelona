{extends "$layout"}

{block name='breadcrumb_item'}
    {$smarty.block.parent}
    <li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
      <a itemprop="item" href="{url entity='module' name='blockwishlist' controller='mywishlist'}">
        <span itemprop="name">{l s='Wishlist' mod='blockwishlist'}</span>
      </a>
    </li>   
{/block}

{block name="content"}
<div id="view_wishlist">

    <h1 class="page-heading bottom-indent">
        {l s='Wishlist' mod='blockwishlist'} de {$firstname} {$lastname}
    </h1>
    <br>
    {if $wishlists}
        <p>
            <strong class="dark">
                {l s='Other wishlists of %1s %2s:' sprintf=[$current_wishlist.firstname, $current_wishlist.lastname] mod='blockwishlist'}
            </strong>
            {foreach from=$wishlists item=wishlist name=i}
                {if $wishlist.id_wishlist != $current_wishlist.id_wishlist}
                    <a href="{url entity='module' name='blockwishlist' controller='view' params=['token' => $wishlist.token]}" rel="nofollow" title="{$wishlist.name|escape:'html':'UTF-8'}">
                        {$wishlist.name|escape:'htmlall':'UTF-8'}
                    </a>
                    {if !$smarty.foreach.i.last}
                        /
                    {/if}
                {/if}
            {/foreach}
        </p>
    {/if}


    <section class="featured-products wlp_bought">
        <div class="products">
            {foreach from=$products item="product"}
                {include file="catalog/_partials/miniatures/product.tpl" product=$product}
            {/foreach}
        </div>
    </section>


  {*
    <div class="wlp_bought">
        {assign var='nbItemsPerLine' value=3}
        {assign var='nbItemsPerLineTablet' value=2}
        {assign var='nbLi' value=$products|@count}
        {math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
        {math equation="nbLi/nbItemsPerLineTablet" nbLi=$nbLi nbItemsPerLineTablet=$nbItemsPerLineTablet assign=nbLinesTablet}
        <ul class="row wlp_bought_list">
            {foreach from=$products item=product name=i}
                {math equation="(total%perLine)" total=$smarty.foreach.i.total perLine=$nbItemsPerLine assign=totModulo}
                {math equation="(total%perLineT)" total=$smarty.foreach.i.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
                {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                {if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
                <li
                        id="wlp_{$product.id_product}_{$product.id_product_attribute}"
                        class="ajax_block_product col-xs-12 col-sm-6 col-md-4 {if $smarty.foreach.i.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.i.iteration%$nbItemsPerLine == 1} first-in-line{/if} {if $smarty.foreach.i.iteration > ($smarty.foreach.i.total - $totModulo)}last-line{/if} {if $smarty.foreach.i.iteration%$nbItemsPerLineTablet == 0}last-item-of-tablet-line{elseif $smarty.foreach.i.iteration%$nbItemsPerLineTablet == 1}first-item-of-tablet-line{/if} {if $smarty.foreach.i.iteration > ($smarty.foreach.i.total - $totModuloTablet)}last-tablet-line{/if}">
                    <div class="row">
                        <div class="col-sm-12">
                            <p style="text-align: center;">
                                <strong>
                                    <a href="{url entity=product id=$product.id_product ipa=$product.id_product_attribute}" id="s_title" title="{l s='Product detail' mod='blockwishlist'}">{$product.name|escape:'html':'UTF-8'}</a>
                                </strong>
                            </p>
                            <div class="product_image">
                                <a href="{url entity=product id=$product.id_product ipa=$product.id_product_attribute}" title="{l s='Product detail' mod='blockwishlist'}">
                                    <img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.cover, 'home_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}"/>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="product_infos product-actions">
                                <div class="wishlist_product_detail">
                                    <div class="btn_action">
                                        {if (isset($product.attribute_quantity) && $product.attribute_quantity >= 1) || (!isset($product.attribute_quantity) && $product.product_quantity >= 1) || (isset($product.allow_oosp) && $product.allow_oosp)}
                                            {if !$ajax}
                                                <form id="addtocart_{$product.id_product|intval}_{$product.id_product_attribute|intval}"
                                                      action="{url entity='cart'}"
                                                      method="post">
                                                    <p class="hidden">
                                                        <input type="hidden" name="id_product"
                                                               value="{$product.id_product|intval}"
                                                               id="product_page_product_id"/>
                                                        <input type="hidden" name="add" value="1"/>
                                                        <input type="hidden" name="token" value="{$token}"/>
                                                        <input type="hidden" name="id_product_attribute"
                                                               id="idCombination"
                                                               value="{$product.id_product_attribute|intval}"/>
                                                    </p>
                                                </form>
                                            {/if}
                                            
                                            <a
                                                href="javascript:void(0);"
                                                class="ajax_add_to_cart_button btn btn-primary add-to-cart"
                                                onclick="WishlistBuyProduct('{url entity="cart"}','{$product.id_product}', '{$product.id_product_attribute}', '{$product.id_product}_{$product.id_product_attribute}', this, {$ajax}, '{$token}');"
                                                title="{l s='Add to cart' mod='blockwishlist'}"
                                                rel="nofollow">
                                                <i class="material-icons shopping-cart">shopping_cart</i>
                                                <div class="loader"><div></div><div></div><div></div><div></div></div>
                                                <span>{l s='Add to cart' mod='blockwishlist'}</span>
                                            </a>
                                        {else}
                                            <span class="ajax_add_to_cart_button btn btn-primary add-to-cart disabled">
												<i class="material-icons shopping-cart">shopping_cart</i>
												<span>{l s='Add to cart' mod='blockwishlist'}</span>
											</span>
                                        {/if}
                                    </div>
                                    <!-- .btn_action -->
                                </div>
                                <!-- .wishlist_product_detail -->
                            </div>
                            <!-- .product_infos -->
                        </div>
                    </div>
                </li>
            {/foreach}
        </ul>
    </div>
  *}

</div> <!-- #view_wishlist -->
{/block}