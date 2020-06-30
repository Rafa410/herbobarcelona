{if $products}
    {if !$refresh}
        <div class="wishlistLinkTop">
    {/if}


    <section class="featured-products wlp_bought">
        <div class="products">
            {foreach from=$products item="product"}
                <div id="wlp_{$product.id_product}_{$product.id_product_attribute}">
                    {include file="catalog/_partials/miniatures/product.tpl" product=$product}
                    <a class="lnkdel" href="javascript:;" onclick="WishlistProductManage('wlp_bought', 'delete', '{$id_wishlist}', '{$product.id_product}', '{$product.id_product_attribute}', $('#quantity_{$product.id_product}_{$product.id_product_attribute}').val(), $('#priority_{$product.id_product}_{$product.id_product_attribute}').val());" title="{l s='Delete' mod='blockwishlist'}">
                        <i class="material-icons">clear</i>
                    </a>
                </div>
            {/foreach}
        </div>
    </section>

  {*
    <div class="wlp_bought">
        <ul class="row wlp_bought_list">
            {foreach from=$products item=product name=i}
                {math equation="(total%perLine)" total=$smarty.foreach.i.total perLine=$nbItemsPerLine assign=totModulo}
                {math equation="(total%perLineT)" total=$smarty.foreach.i.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
                {if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
                {if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
                <li id="wlp_{$product.id_product}_{$product.id_product_attribute}"
                    class="col-xs-12 col-sm-4 col-md-3 {if $smarty.foreach.i.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.i.iteration%$nbItemsPerLine == 1} first-in-line{/if} {if $smarty.foreach.i.iteration > ($smarty.foreach.i.total - $totModulo)}last-line{/if} {if $smarty.foreach.i.iteration%$nbItemsPerLineTablet == 0}last-item-of-tablet-line{elseif $smarty.foreach.i.iteration%$nbItemsPerLineTablet == 1}first-item-of-tablet-line{/if} {if $smarty.foreach.i.iteration > ($smarty.foreach.i.total - $totModuloTablet)}last-tablet-line{/if}">
                    <div class="row">
                        <div class="col-sm-12">
                            <p style="text-align: center;">
                                <strong>
                                    <a href="{url entity=product id=$product.id_product ipa=$product.id_product_attribute}" id="s_title" title="{l s='Product detail' mod='blockwishlist'}">{$product.name|escape:'html':'UTF-8'}</a>
                                </strong>
                            </p>
                            <div class="product_image">
                                <a href="{url entity=product id=$product.id_product ipa=$product.id_product_attribute}" title="{l s='Product detail' mod='blockwishlist'}">
                                    <img class="replace-2x img-responsive" src="//{$product.image_link}" alt="{$product.name|escape:'html':'UTF-8'}"/>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="product_infos">
                                <a class="lnkdel" href="javascript:;" onclick="WishlistProductManage('wlp_bought', 'delete', '{$id_wishlist}', '{$product.id_product}', '{$product.id_product_attribute}', $('#quantity_{$product.id_product}_{$product.id_product_attribute}').val(), $('#priority_{$product.id_product}_{$product.id_product_attribute}').val());" title="{l s='Delete' mod='blockwishlist'}">
                                    <i class="material-icons">clear</i> Eliminar de la lista
                                </a>
                            </div>
                        </div>
                    </div>
                <br>
                </li>
            {/foreach}
        </ul>
    </div>

   *}
    <br />
    {if !$refresh}
        <p class="submit">
            <div id="showSendWishlist">
                <a class="btn btn-default button button-small" href="#" onclick="WishlistVisibility('wl_send', 'SendWishlist'); return false;" title="{l s='Send this wishlist' mod='blockwishlist'}">
                    <i class="material-icons">email</i> {l s='Send this wishlist' mod='blockwishlist'}
                </a>
            </div>
        </p>
        <form method="post" class="wl_send box unvisible" onsubmit="return (false);" style="display: none;">
        <a id="hideSendWishlist" class="button_account btn icon"  href="#" onclick="WishlistVisibility('wl_send', 'SendWishlist'); return false;" rel="nofollow" title="{l s='Close this wishlist' mod='blockwishlist'}" style="display: none; text-align: left;">
            <i class="material-icons">remove_circle</i> {l s='Send this wishlist' mod='blockwishlist'}
        </a>
            <fieldset>
                <div class="form-group">
                    <label for="email1">{l s='Email' mod='blockwishlist'}</label>
                    <input type="text" name="email1" id="email1" class="form-control"/>
                </div>
                <div class="submit">
                    <button class="btn btn-primary" type="submit" name="submitWishlist"
                            onclick="WishlistSend('wl_send', '{$id_wishlist}', 'email');">
                        <span>{l s='Send' mod='blockwishlist'}</span>
                    </button>
                </div>
            </fieldset>
        </form>
        <p class="wl-send-success" style="display:none;">El email se ha enviado correctamente!</p>
    {/if}
{else}
    <p class="alert alert-warning">
        {l s='No products' mod='blockwishlist'}
    </p>
{/if}
