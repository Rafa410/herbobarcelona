{*
*  Please read the terms of the CLUF license attached to this module(cf "licences" folder)
*
*  @author    Línea Gráfica E.C.E. S.L.
*  @copyright Lineagrafica.es - Línea Gráfica E.C.E. S.L. all rights reserved.
*  @license   https://www.lineagrafica.es/licenses/license_en.pdf https://www.lineagrafica.es/licenses/license_es.pdf https://www.lineagrafica.es/licenses/license_fr.pdf
*}

<link href="{$content_dir|escape:'htmlall':'UTF-8'}modules/lgcomments/views/css/review_form.css" rel="stylesheet" type="text/css"/>

{extends file=$layout}
{block name='content'}
<div id="favoriteproducts_block_account" class="card card-block">
    <h2 class="page-heading">{l s='Ratings and reviews' mod='lgcomments'}</h2>
    {if $verify == 1}
        <div>
            {if $voted == 1}
                <p class="alert alert-success">{l s='Thank you very much. Your reviews have been successfully sent, we will publish them soon.' mod='lgcomments'}</p>
            {else}
                <form method="post" action="{$form_action|escape:'htmlall':'UTF-8'}" id="validate-form">
                    <label for="lg_nick">{l s='Nick' mod='lgcomments'}</label>
                    <input type="text" id="lg_nick" name="lg_nick" value="{$nick}" style="display:block;margin-bottom:1em;">

                    {if $opinionform == 1 || $opinionform == 3}
                        <fieldset>
                            <legend class="info-title">{l s='Please, rate your products' mod='lgcomments'}</legend>
                            <table class="std table">
                                {foreach from=$products item=product}
                                    <tr class="item">
                                        <th class="item" colspan="2">
                                            <img src="{$product.image|escape:'htmlall':'UTF-8'}"
                                                 alt="{$product.product_name|escape:'html':'UTF-8'}" border="1" height="75px">
                                            &nbsp;&nbsp;{$product.product_name|escape:'htmlall':'UTF-8'}
                                        </th>
                                    </tr>
                                    <tr>
                                        <td class="history_link bold" style="width:200px;">
                                            <div style="float:left;">
                                                <select class="score"
                                                        name="product_score_{$product.id_order_detail|escape:'htmlall':'UTF-8'}_{$product.product_id|escape:'htmlall':'UTF-8'}"
                                                        data-who="{$product.id_order_detail|escape:'htmlall':'UTF-8'}_{$product.product_id|escape:'htmlall':'UTF-8'}">
                                                    <option value="0">{if $ratingscale == 5}0/5{elseif $ratingscale == 10}0/10{elseif $ratingscale == 20}0/20{else}0/10{/if}</option>
                                                    <option value="1">{if $ratingscale == 5}0,5/5{elseif $ratingscale == 10}1/10{elseif $ratingscale == 20}2/20{else}1/10{/if}</option>
                                                    <option value="2">{if $ratingscale == 5}1/5{elseif $ratingscale == 10}2/10{elseif $ratingscale == 20}4/20{else}2/10{/if}</option>
                                                    <option value="3">{if $ratingscale == 5}1,5/5{elseif $ratingscale == 10}3/10{elseif $ratingscale == 20}6/20{else}3/10{/if}</option>
                                                    <option value="4">{if $ratingscale == 5}2/5{elseif $ratingscale == 10}4/10{elseif $ratingscale == 20}8/20{else}4/10{/if}</option>
                                                    <option value="5">{if $ratingscale == 5}2,5/5{elseif $ratingscale == 10}5/10{elseif $ratingscale == 20}10/20{else}5/10{/if}</option>
                                                    <option value="6">{if $ratingscale == 5}3/5{elseif $ratingscale == 10}6/10{elseif $ratingscale == 20}12/20{else}6/10{/if}</option>
                                                    <option value="7">{if $ratingscale == 5}3,5/5{elseif $ratingscale == 10}7/10{elseif $ratingscale == 20}14/20{else}7/10{/if}</option>
                                                    <option value="8">{if $ratingscale == 5}4/5{elseif $ratingscale == 10}8/10{elseif $ratingscale == 20}16/20{else}8/10{/if}</option>
                                                    <option value="9">{if $ratingscale == 5}4,5/5{elseif $ratingscale == 10}9/10{elseif $ratingscale == 20}18/20{else}9/10{/if}</option>
                                                    <option value="10" selected>{if $ratingscale == 5}5/5{elseif $ratingscale == 10}10/10{elseif $ratingscale == 20}20/20{else}10/10{/if}</option>
                                                </select>
                                            </div>
                                            <div style="float:left;">
                                                <img style="width:{$starsize|escape:'htmlall':'UTF-8'}px" alt="rating"
                                                     src="{$modules_dir|escape:'htmlall':'UTF-8'}lgcomments/views/img/stars/{$starstyle|escape:'htmlall':'UTF-8'}/{$starcolor|escape:'htmlall':'UTF-8'}/10stars.png"
                                                     id="stars_{$product.id_order_detail|escape:'htmlall':'UTF-8'}_{$product.product_id|escape:'htmlall':'UTF-8'}">
                                            </div>
                                            <div style="clear:both;"></div>
                                        </td>
                                        <td class="history_link bold">{l s='Title:' mod='lgcomments'}
                                            <textarea maxlength="50" style="width:100%;height:25px;overflow:hidden;"
                                                      name="product_title_{$product.id_order_detail|escape:'htmlall':'UTF-8'}_{$product.product_id|escape:'htmlall':'UTF-8'}" {**required**}></textarea>
                                            <br>
                                            {l s='Comment:' mod='lgcomments'}
                                            <textarea name="product_comment_{$product.id_order_detail|escape:'htmlall':'UTF-8'}_{$product.product_id|escape:'htmlall':'UTF-8'}"
                                                      style="width:100%;height:60px;" {**required**}></textarea>
                                            <br>
                                    </tr>
                                {/foreach}
                            </table>
                        </fieldset>
                        <br/>
                    {/if}
                    {if $opinionform == 1 || $opinionform == 2}
                        <fieldset>
                            <legend class="info-title">{l s='Please rate our shop' mod='lgcomments'}</legend>
                            <table class="std table">
                                <tr class="item">
                                    <th class="item" colspan="2">
                                        {*<img class="logo" src="{$logo_url|escape:'htmlall':'UTF-8'}"*}
                                                          {*alt="{$shop_name|escape:'html':'UTF-8'}"*}
                                                          {*width="150">*}
                                    </th>
                                </tr>
                                <tr>
                                    <td class="history_link bold" style="width:200px;">
                                        <div style="float:left;">
                                            <select name="score_store" class="score" data-who="store">
                                                <option value="0">{if $ratingscale == 5}0/5{elseif $ratingscale == 10}0/10{elseif $ratingscale == 20}0/20{else}0/10{/if}</option>
                                                <option value="1">{if $ratingscale == 5}0,5/5{elseif $ratingscale == 10}1/10{elseif $ratingscale == 20}2/20{else}1/10{/if}</option>
                                                <option value="2">{if $ratingscale == 5}1/5{elseif $ratingscale == 10}2/10{elseif $ratingscale == 20}4/20{else}2/10{/if}</option>
                                                <option value="3">{if $ratingscale == 5}1,5/5{elseif $ratingscale == 10}3/10{elseif $ratingscale == 20}6/20{else}3/10{/if}</option>
                                                <option value="4">{if $ratingscale == 5}2/5{elseif $ratingscale == 10}4/10{elseif $ratingscale == 20}8/20{else}4/10{/if}</option>
                                                <option value="5">{if $ratingscale == 5}2,5/5{elseif $ratingscale == 10}5/10{elseif $ratingscale == 20}10/20{else}5/10{/if}</option>
                                                <option value="6">{if $ratingscale == 5}3/5{elseif $ratingscale == 10}6/10{elseif $ratingscale == 20}12/20{else}6/10{/if}</option>
                                                <option value="7">{if $ratingscale == 5}3,5/5{elseif $ratingscale == 10}7/10{elseif $ratingscale == 20}14/20{else}7/10{/if}</option>
                                                <option value="8">{if $ratingscale == 5}4/5{elseif $ratingscale == 10}8/10{elseif $ratingscale == 20}16/20{else}8/10{/if}</option>
                                                <option value="9">{if $ratingscale == 5}4,5/5{elseif $ratingscale == 10}9/10{elseif $ratingscale == 20}18/20{else}9/10{/if}</option>
                                                <option value="10" selected>{if $ratingscale == 5}5/5{elseif $ratingscale == 10}10/10{elseif $ratingscale == 20}20/20{else}10/10{/if}</option>
                                            </select>
                                        </div>
                                        <div style="float:left;">
                                            <img style="width:{$starsize|escape:'htmlall':'UTF-8'}px" id="stars_store" alt="rating"
                                                 src="{$modules_dir|escape:'htmlall':'UTF-8'}lgcomments/views/img/stars/{$starstyle|escape:'htmlall':'UTF-8'}/{$starcolor|escape:'htmlall':'UTF-8'}/10stars.png">
                                        </div>
                                        <div style="clear:both;"></div>
                                    </td>
                                    <td class="history_link bold">{l s='Title:' mod='lgcomments'}
                                        <textarea maxlength="50" name="title_store" style="width:100%;height:25px;overflow:hidden;" {**required**}></textarea>
                                        <br>{l s='Comment:' mod='lgcomments'}
                                        <textarea name="comment_store" style="width:100%;height:60px;" {**required**}></textarea>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    {/if}
                    <input type="hidden" name="sendcomments" value="1"/>
                    {if isset($lgcomments_id_module)}
                        {hook h='displayGDPRConsent' mod='psgdpr' id_module=$lgcomments_id_module}
                    {/if}
                    <input type="submit" id="sendcomments" value="{l s='Send' mod='lgcomments'}" class="button btn btn-default"/>
                </form>
            {/if}
        </div>
    {elseif $verify == 2}
        <p class="alert alert-warning">{l s='This order has already been rated and reviewed.' mod='lgcomments'}</p>
    {else}
        <p class="alert alert-warning">{l s='An error occurred while checking your identity. Please get in touch with the store admin in order to fix the problem.' mod='lgcomments'}</p>
    {/if}
</div>
{/block}