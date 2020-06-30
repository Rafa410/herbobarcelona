{*
*  Please read the terms of the CLUF license attached to this module(cf "licences" folder)
*
*  @author    Línea Gráfica E.C.E. S.L.
*  @copyright Lineagrafica.es - Línea Gráfica E.C.E. S.L. all rights reserved.
*  @license   https://www.lineagrafica.es/licenses/license_en.pdf https://www.lineagrafica.es/licenses/license_es.pdf https://www.lineagrafica.es/licenses/license_fr.pdf
*}
<script>
var lgcomments_owl = {$sliderblocks|intval};
</script>
{if $ps16 && $displayslider && $allreviews}
    <div class="row" style="padding: 10px;">
        <div id="w-title">
            <a href="{$link->getModuleLink('lgcomments','reviews')|escape:'htmlall':'UTF-8'}">{l s='Last reviews' mod='lgcomments'}</a>
        </div>
        <div id="w-more">
            <a href="{$link->getModuleLink('lgcomments','reviews')|escape:'htmlall':'UTF-8'}">{l s='see more' mod='lgcomments'}
                <i class="material-icons"></i>
            </a>
        </div>
    </div>
    <div id="lgcomments-owl" class="owl-carousel owl-theme">
        {foreach from=$allreviews item=lgcomment}
            <div class="item">
                <div class="slide-container">
                    <div class="slide-title">{$lgcomment.title|truncate:'50':'...'|escape:'htmlall':'UTF-8'}</div>
                    <div class="slide-thumbnail">
                        <img src="{$content_dir|escape:'htmlall':'UTF-8'}/views/img/stars/{$starstyle|escape:'htmlall':'UTF-8'}/{$starcolor|escape:'htmlall':'UTF-8'}/{$lgcomment.stars|escape:'htmlall':'UTF-8'}stars.png" alt="rating">
                    </div>
                    <div class="slide-comment">
                        {$lgcomment.comment|strip_tags|truncate:'200':'...'|escape:'htmlall':'UTF-8'}
                    </div>
                    <span class="slide-name">{$lgcomment.customer|escape:'htmlall':'UTF-8'}</span>
                    <span class="slide-date">{$lgcomment.date|date_format:"$dateformat"|escape:'htmlall':'UTF-8'}</span>
                </div>
            </div>
        {/foreach}
    </div>
    <div class="lg-button-container pagination">
        <span class="icon-previous page-list lgcomments_slider_button_next"><i class="material-icons">&#xE314;</i></span>
        <span class="icon-next page-list lgcomments_slider_button_previous"><i class="material-icons">&#xE315;</i></span>
    </div>
{/if}

{if $displaysnippets && $numerocomentarios}
    <div itemscope="itemscope" itemtype="http://schema.org/LocalBusiness" style="text-align:center;">
        <meta itemprop="image" content="{$base_url|escape:'quotes':'UTF-8'}{$shop.logo|escape:'htmlall':'UTF-8'}"/>
        <meta itemprop="name" content="{if isset($shop.name)}{$shop.name|escape:'quotes':'UTF-8'}{else}{$shop_name|escape:'quotes':'UTF-8'}{/if}"/>
        <span itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
            {if $address_street1}
                <meta itemprop="streetAddress" content=" {if $address_street1}{$address_street1|escape:'quotes':'UTF-8'}, {/if} {if $address_street2}{$address_street2|escape:'quotes':'UTF-8'}{/if}"/>
            {/if}
            {if $address_zip}
                <meta itemprop="postalCode" content="{$address_zip|escape:'quotes':'UTF-8'}"/>
            {/if}
            {if $address_city}
                <meta itemprop="addressLocality" content="{$address_city|escape:'quotes':'UTF-8'}"/>
            {/if}
            {if $address_state}
                <meta itemprop="addressRegion" content="{$address_state|escape:'quotes':'UTF-8'}"/>
            {/if}
            {if $address_country}
                <meta itemprop="addressCountry" content="{$address_country|escape:'quotes':'UTF-8'}"/>
            {/if}
        </span>
        {if $address_phone}
            <meta itemprop="telephone" content="{$address_phone|escape:'quotes':'UTF-8'}"/>
        {/if}
        {if $price_range}
            <meta itemprop="priceRange" content="{$price_range|escape:'quotes':'UTF-8'}"/>
        {/if}
        <span itemprop="aggregateRating" itemscope="itemscope" itemtype="http://schema.org/AggregateRating">
            {if $ratingscale == 5}
                <meta content="{$mediacomentarios2/2|escape:'quotes':'UTF-8'}" itemprop="ratingValue"/>
                <meta content="5" itemprop="bestRating"/>
            {elseif $ratingscale == 10}
                <meta content="{$mediacomentarios2|escape:'quotes':'UTF-8'}" itemprop="ratingValue"/>
                <meta content="10" itemprop="bestRating"/>
            {elseif $ratingscale == 20}
                <meta content="{$mediacomentarios2*2|escape:'quotes':'UTF-8'}" itemprop="ratingValue"/>
                <meta content="20" itemprop="bestRating"/>
            {else}
                <meta content="{$mediacomentarios2|escape:'quotes':'UTF-8'}" itemprop="ratingValue"/>
                <meta content="10" itemprop="bestRating"/>
            {/if}
            <meta content="{$numerocomentarios|escape:'quotes':'UTF-8'}" itemprop="ratingCount"/>
        </span>
    </div>
{/if}


