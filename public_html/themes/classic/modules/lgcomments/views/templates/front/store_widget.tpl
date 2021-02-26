{*
*  Please read the terms of the CLUF license attached to this module(cf "licences" folder)
*
*  @author    Línea Gráfica E.C.E. S.L.
*  @copyright Lineagrafica.es - Línea Gráfica E.C.E. S.L. all rights reserved.
*  @license   https://www.lineagrafica.es/licenses/license_en.pdf https://www.lineagrafica.es/licenses/license_es.pdf https://www.lineagrafica.es/licenses/license_fr.pdf
*}

{*{if !isset($smarty.cookies.reviewWidget)}*}
    {** {assign var='reviews_link' value=$link->getModuleLink('lgcomments','reviews')|escape:'htmlall':'UTF-8'} * Error con doofinder *}
    <!-- lgcomments -->
    <div id="widget_block" class="col-xs-12 col-md-12 col-lg-2{**{$display_side|escape:'htmlall':'UTF-8'}**}">
    {if $displaycross == 1}
        <div  class="close_widget_block" style="top:{$top7|escape:'htmlall':'UTF-8'}px;right:{$right7|escape:'htmlall':'UTF-8'}px;">
            <img src="{$path_lgcomments|escape:'html':'UTF-8'}/views/img/close.png" alt="close">
        </div>
    {/if}
        <div class="block_content" style="background:url({$path_lgcomments|escape:'htmlall':'UTF-8'}/views/img/bg/{$bgdesign1|escape:'htmlall':'UTF-8'}-{$bgdesign2|escape:'htmlall':'UTF-8'}.png) no-repeat center center;background-size:100%;width:{$bgwidth|escape:'htmlall':'UTF-8'}px;height:{$bgheight|escape:'htmlall':'UTF-8'}px;margin: 0 auto;padding:0px;">
            <div style="position:absolute;width:1px;height:1px;">
                <div{if $rotate0 > 0} class="rotate"{/if} style="position:relative;
                        width:{$width0|escape:'htmlall':'UTF-8'}px;
                        top:{$top0|escape:'htmlall':'UTF-8'}px;
                        left:{$left0|escape:'htmlall':'UTF-8'}px;
                        color:#{$widgettextcolor|escape:'htmlall':'UTF-8'};
                        text-align:{$textalign0|escape:'htmlall':'UTF-8'};
                        font-family:{$fontfamily0|escape:'htmlall':'UTF-8'};
                        font-size:{$fontsize0|escape:'htmlall':'UTF-8'}px;
                        font-weight:{$fontweight0|escape:'htmlall':'UTF-8'};
                        line-height:{$lineheight0|escape:'htmlall':'UTF-8'}px;
                        text-transform:uppercase;">
                    <a href="{$urls.base_url}opiniones{*{$reviews_link|escape:'htmlall':'UTF-8'}*}" style="color:#{$widgettextcolor|escape:'htmlall':'UTF-8'};">{l s='Customer Reviews' mod='lgcomments'}</a>
                </div>
            </div>
            {if $bgdesign1 != 'vertical' && $bgdesign1 != 'horizontal'}
                <div style="position:absolute;width:1px;height:1px;">
                    <div style="position:relative;
                                width:{$width1|escape:'htmlall':'UTF-8'}px;
                                top:{$top1|escape:'htmlall':'UTF-8'}px;
                                left:{$left1|escape:'htmlall':'UTF-8'}px;
                                color:{$color1|escape:'htmlall':'UTF-8'};
                                text-align:{$textalign1|escape:'htmlall':'UTF-8'};
                                font-family:{$fontfamily1|escape:'htmlall':'UTF-8'};
                                font-size:{$fontsize1|escape:'htmlall':'UTF-8'}px;
                                font-weight:{$fontweight1|escape:'htmlall':'UTF-8'};">
                        {$numericRating|escape:'htmlall':'UTF-8'}
                    </div>
                </div>
                <div style="position:absolute;width:1px;height:1px;">
                    <div id="reviewSlide" style="position:relative;
                            width:{$width2|escape:'htmlall':'UTF-8'}px;
                            top:{$top2|escape:'htmlall':'UTF-8'}px;
                            left:{$left2|escape:'htmlall':'UTF-8'}px;
                            color:{$color2|escape:'htmlall':'UTF-8'};
                            text-align:{$textalign2|escape:'htmlall':'UTF-8'};
                            font-family:{$fontfamily2|escape:'htmlall':'UTF-8'};
                            font-size:{$fontsize2|escape:'htmlall':'UTF-8'}px;
                            font-weight:{$fontweight2|escape:'htmlall':'UTF-8'};
                            vertical-align:middle;font-style:italic;">
                    {foreach from=$comentarioazar item=randomReview}
                        <div style="display:none;">{stripslashes($randomReview.comment|strip_tags|truncate:'50':'...'|escape:'htmlall':'UTF-8')}
                        </div>
                    {/foreach}
                    </div>
                </div>
            {/if}
            <div style="position:absolute;width:1px;height:1px;">
                <div {if $rotate3 > 0}class="rotate"{/if} style="position:relative;
                        width:{$width3|escape:'htmlall':'UTF-8'}px;
                        top:{$top3|escape:'htmlall':'UTF-8'}px;
                        left:{$left3|escape:'htmlall':'UTF-8'}px;">
                    <a href="{$urls.base_url}opiniones{*{$reviews_link|escape:'htmlall':'UTF-8'}*}"><img style="width:{$starsize|escape:'htmlall':'UTF-8'}px" src="{$path_lgcomments|escape:'htmlall':'UTF-8'}/views/img/stars/{$starstyle|escape:'htmlall':'UTF-8'}/{$starcolor|escape:'htmlall':'UTF-8'}/{$mediacomentarios|escape:'htmlall':'UTF-8'}stars.png" alt="rating"></a>
                </div>
            </div>
            {if $bgdesign1 != 'vertical' && $bgdesign1 != 'horizontal'}
                <div style="position:absolute;width:1px;height:1px;">
                    <div style="position:relative;
                            width:{$width4|escape:'htmlall':'UTF-8'}px;
                            top:{$top4|escape:'htmlall':'UTF-8'}px;
                            left:{$left4|escape:'htmlall':'UTF-8'}px;
                            text-align:{$textalign4|escape:'htmlall':'UTF-8'};
                            font-family:{$fontfamily4|escape:'htmlall':'UTF-8'};
                            font-size:{$fontsize4|escape:'htmlall':'UTF-8'}px;
                            font-weight:{$fontweight4|escape:'htmlall':'UTF-8'};">
                        <a href="{$urls.base_url}opiniones{*{$reviews_link|escape:'htmlall':'UTF-8'}*}">{l s='see more' mod='lgcomments'}</a>
                    </div>
                </div>
            {/if}
        </div>
    </div>
    <!-- /lgcomments -->
{*{/if}*}