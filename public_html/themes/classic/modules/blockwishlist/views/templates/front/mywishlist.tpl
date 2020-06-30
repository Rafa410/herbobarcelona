
{extends file='customer/page.tpl'}

{block name='page_title'}
    {l s='Wishlist' mod='blockwishlist'}
{/block}

{block name='page_content'}
<!--front/mywishlist.tpl-->
<div class="container">
    <section class="page_content">
		<div id="mywishlist">
			{if isset($errors) && $errors}
				<div class="alert alert-danger" role="alert">
					<ol>
						{foreach from=$errors key=k item=error}
							<li>{$error}</li>
						{/foreach}
					</ol>
				</div>
			{/if}

			{* <a class="btn btn-default btn-newWishlist" href="#" onclick="WishlistVisibility('new-wishlist', 'NewWishlist'); return false;" title="{l s='New wishlist' mod='blockwishlist'}">
			<i id="showNewWishlist" class="material-icons" style="float: left;">add_circle</i><i id="hideNewWishlist" class="material-icons" style="display: none; float: left;">remove_circle</i> {l s='New wishlist' mod='blockwishlist'}
			</a> *}

			{if $id_customer|intval neq 0}
			
				<form method="post" class="std box new-wishlist" id="form_wishlist" style="display: none;">
					<fieldset>
						<div class="form-group">
							<input type="hidden" name="token" value="{$token|escape:'html':'UTF-8'}" />
							<label class="align_right" for="name">
								{l s='Name' mod='blockwishlist'}
							</label>
							<input type="text" id="name" name="name" class="inputTxt form-control" value="{if isset($smarty.post.name) and $errors|@count > 0}{$smarty.post.name|escape:'html':'UTF-8'}{/if}" />
						</div>
						<p class="submit">
							<button id="submitWishlist" class="btn btn-primary" type="submit" name="submitWishlist">
									<span>{l s='Save' mod='blockwishlist'}<i class="icon-chevron-right right"></i></span>
							</button>
						</p>
					</fieldset>
				</form>
				
				<br>
				{if $wishlists}
					{* <div id="block-history" class="block-center">
						<table class="table table-responsive">
							<thead>
								<tr>
									<th class="first_item">{l s='Name' mod='blockwishlist'}</th>
									<th class="item mywishlist_second">{l s='Created' mod='blockwishlist'}</th>
									<th class="item mywishlist_second">{l s='Default' mod='blockwishlist'}</th>
									<th class="last_item mywishlist_first">{l s='Delete' mod='blockwishlist'}</th>
								</tr>
							</thead>
							<tbody>
								{section name=i loop=$wishlists}
									<tr id="wishlist_{$wishlists[i].id_wishlist|intval}">
										<td style="width:200px;">
											<a href="#" onclick="javascript:event.preventDefault();WishlistManage('block-order-detail', '{$wishlists[i].id_wishlist|intval}');">
												{$wishlists[i].name|truncate:30:'...'|escape:'htmlall':'UTF-8'}
											</a>
										</td>
										<td>{$wishlists[i].date_add|date_format:"%d-%m-%Y"}</td>
										<td class="wishlist_default">
											{if isset($wishlists[i].default) && $wishlists[i].default == 1}
												<p class="is_wish_list_default">
													<i class="material-icons">check_box</i>
												</p>
											{else}
												<a href="#" onclick="javascript:event.preventDefault();(WishlistDefault('wishlist_{$wishlists[i].id_wishlist|intval}', '{$wishlists[i].id_wishlist|intval}'));">
													<i class="material-icons">check_box_outline_blank</i>
												</a>
											{/if}
										</td>
										<td class="wishlist_delete">
											<a class="icon" href="#" onclick="javascript:event.preventDefault();return (WishlistDelete('wishlist_{$wishlists[i].id_wishlist|intval}', '{$wishlists[i].id_wishlist|intval}', '{l s='Do you really want to delete this wishlist ?' mod='blockwishlist' js=1}'));">
												<i class="material-icons">delete_forever</i>
											</a>
										</td>
									</tr>
								{/section}
							</tbody>
						</table>
					</div> *}
					<div id="block-order-detail">
					{* managewishlist.tpl *}
						{if $products}
							<div class="wishlistLinkTop">
								<section class="featured-products wlp_bought">
									<div class="products">
										{foreach from=$products item="product"}
											<div id="wlp_{$product.id_product}_{$product.id_product_attribute}" class="wishlist-product">
												{include file="catalog/_partials/miniatures/product.tpl" product=$product}
												<a 
													class="lnkdel" 
													href="javascript:;" 
													onclick="WishlistProductManage(
															'wlp_bought', 
															'delete', 
															'{$wishlists[0].id_wishlist|intval}', 
															'{$product.id_product}', 
															'{$product.id_product_attribute}', 
															$('#quantity_{$product.id_product}_{$product.id_product_attribute}').val(), 
															$('#priority_{$product.id_product}_{$product.id_product_attribute}').val()
													);" 
													title="{l s='Delete' mod='blockwishlist'}">
														<i class="material-icons">remove_shopping_cart</i>
												</a>
											</div>
										{/foreach}
									</div>
								</section>

								<br />

								<a href="#" class="text-xs-center" onclick="WishlistVisibility('share-wishlist'); return false;" style="display:block">
									<span>
										<i class="material-icons">share</i> Compartir lista de deseos
									</span>
								</a>
								
								<hr>
								
								<div class="share-wishlist" style="display:none">
									
									<div class="share-link">
										<a href="#" onclick="
											copyToClipboard('wish_url');
											WishlistVisibility('','Wishlist-link-copy');
											setTimeout( function() {
												document.getElementById('hideWishlist-link-copy').style.display = 'none'
											},3000);
											return false;"
										>
											<i class="material-icons copy"></i> Copiar enlace</a>
										
										<input id="wish_url" type="text" value="{$wish_url}" style="position:absolute;opacity:0;z-index:-1;left:0" readonly>

										<div class="centered-popup">
											<div id="hideWishlist-link-copy" class="changeover" style="display:none">
												<div class="changeover-inner">
													<i class="material-icons">done</i> Enlace copiado
												</div>
											</div>
										</div>

									</div>

									<div class="share-email">
										<div class="submit">
											<a class="btn btn-default button button-small" href="#" onclick="WishlistVisibility('wl_send', 'SendWishlist'); return false;" title="{l s='Send this wishlist' mod='blockwishlist'}">
												<span id="showSendWishlist" style="display:block"><i class="material-icons">email</i> Compartir por email</span> {* {l s='Send this wishlist' mod='blockwishlist'} *}
												<span id="hideSendWishlist" style="display:none"><i class="material-icons">drafts</i> Compartir por email</span>
											</a>
										</div>
										<form method="post" class="wl_send box unvisible" onsubmit="WishlistVisibility('wl-send-success');document.getElementsByClassName('wl-send-success')[0].classList.add('sent');return false" style="display: none;">
											<fieldset>
												<div class="form-group">
													<label for="email1">{l s='Email' mod='blockwishlist'}</label>
													<input type="text" name="email1" id="email1" class="form-control" placeholder="Direcci&oacute;n de correo" />
												</div>
												<div class="submit">
													<button class="btn btn-primary" type="submit" name="submitWishlist"
															onclick="WishlistSend('wl_send', '{$wishlists[0].id_wishlist|intval}', 'email');">
														<span>{l s='Send' mod='blockwishlist'}</span>
													</button>
												</div>
											</fieldset>
										</form>
										<p class="wl-send-success" style="display:none;">El email se ha enviado correctamente!</p>
									</div>
								</div>
							<br>
							</div>
						{else}
							<p class="alert alert-warning">
								No hay productos en tu lista de deseos
								{* {l s='No products' mod='blockwishlist'} *}
							</p>
						{/if}
					{* end managewishlist.tpl *}
					</div>
				{/if}
			{/if}
		</div>
	</section>
</div>
<!-- End front/mywishlist.tpl -->

{/block}
