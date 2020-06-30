{*
*  Please read the terms of the CLUF license attached to this module(cf "licences" folder)
*
*  @author    Línea Gráfica E.C.E. S.L.
*  @copyright Lineagrafica.es - Línea Gráfica E.C.E. S.L. all rights reserved.
*  @license   https://www.lineagrafica.es/licenses/license_en.pdf https://www.lineagrafica.es/licenses/license_es.pdf https://www.lineagrafica.es/licenses/license_fr.pdf
*}

<div class="comment_anchor_content">
    {if isset($comments) && $comments}
        <img src="{$content_dir|escape:'htmlall':'UTF-8'}/views/img/stars/{$starstyle|escape:'htmlall':'UTF-8'}/{$starcolor|escape:'htmlall':'UTF-8'}/{$averagecomments|escape:'htmlall':'UTF-8'}stars.png" alt="rating" style="width:{$starsize|escape:'htmlall':'UTF-8'}px">
        {if $comments > 1}
            <span class="comment_anchor">{l s='Read the' mod='lgcomments'} {$comments|escape:'htmlall':'UTF-8'} {l s='reviews' mod='lgcomments'}</span>
        {else}
            <span class="comment_anchor">{l s='Read the review' mod='lgcomments'}</span>
        {/if}
    {else}
        {if $zerostar}
            <img src="{$content_dir|escape:'htmlall':'UTF-8'}/views/img/stars/{$starstyle|escape:'htmlall':'UTF-8'}/{$starcolor|escape:'htmlall':'UTF-8'}/{$averagecomments|escape:'htmlall':'UTF-8'}stars.png" alt="rating" style="width:{$starsize|escape:'htmlall':'UTF-8'}px">
            <span class="comment_anchor">{l s='No review at the moment' mod='lgcomments'}</span>
        {/if}
    {/if}
    {if $displaysnippets && $comments}
        <div id="googleRichSnippets">
            <span itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                {if $ratingscale == 5}
                    {l s='Average rating:' mod='lgcomments'}
                    <span itemprop="ratingValue">{$averagecomments/2|escape:'quotes':'UTF-8'}</span>/<span itemprop="bestRating">5</span> -
                {elseif $ratingscale == 10}
                    {l s='Average rating:' mod='lgcomments'}
                    <span itemprop="ratingValue">{$averagecomments|escape:'quotes':'UTF-8'}</span>/<span itemprop="bestRating">10</span> -
                {elseif $ratingscale == 20}
                    {l s='Average rating:' mod='lgcomments'}
                    <span itemprop="ratingValue">{($averagecomments*2)|round:0|escape:'quotes':'UTF-8'}</span>/<span itemprop="bestRating">20</span> -
                {else}
                    {l s='Average rating:' mod='lgcomments'}
                    <span itemprop="ratingValue">{$averagecomments|escape:'quotes':'UTF-8'}</span>/<span itemprop="bestRating">10</span> -
                {/if}
                {l s='Number of reviews:' mod='lgcomments'}
                <span itemprop="ratingCount">{$comments|escape:'htmlall':'UTF-8'}</span>
            </span>
        </div>
    {/if}
</div>
