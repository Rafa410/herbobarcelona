
<div id="wishlists_product_block">
	
	<p class="hidden">
		<input type="hidden" name="id_product_attribute" id="idCombination" value="{$product.id_product_attribute|intval}"/>
	</p>

	{if $wishlists|@count == 1}
		<a id="wishlist_button_nopop"  class="btn btn-wishlist" href="#" onclick="WishlistCart('wishlist_block_list', 'add', '{$id_product|intval}', $('#idCombination').val(), document.getElementById('quantity_wanted').value); return false;" rel="nofollow"  title="{l s='Add to my wishlist' mod='blockwishlist'}">
			<span>
			    <i class="material-icons">favorite_border</i> {l s='Add to wishlist' mod='blockwishlist'}
		    </span>
		</a>
	{else}
		
		{foreach name=wl from=$wishlists item=wishlist}
			
			{if $smarty.foreach.wl.first}
				
				<a id="wishlist_button" class="btn btn-wishlist" tabindex="0" data-toggle="popover" data-trigger="focus" title="{l s='Add to:' mod='blockwishlist'}" data-placement="bottom">
					<span>
			            <i class="material-icons">favorite_border</i> {l s='Add to wishlist' mod='blockwishlist'}
		            </span>
				</a>

				<div hidden id="popover-content">
					<ul class="wishlist-list-add">
			{/if}

						<li title="{$wishlist.name|escape:'html':'UTF-8'}" value="{$wishlist.id_wishlist}" onclick="WishlistCart('wishlist_block_list', 'add', '{$id_product|intval}', $('#idCombination').val(), document.getElementById('quantity_wanted').value, '{$wishlist.id_wishlist}');">
							<i class="material-icons">add</i> {$wishlist.name}
						</li>

			{if $smarty.foreach.wl.last}
					</ul>
				</div>
			{/if}

		{foreachelse}

			<a href="#" id="wishlist_button_nopop"  class="btn btn-wishlist" onclick="WishlistCart('wishlist_block_list', 'add', '{$id_product|intval}', $('#idCombination').val(), document.getElementById('quantity_wanted').value); return false;" rel="nofollow"  title="{l s='Add to my wishlist' mod='blockwishlist'}">
				<span>
			        <i class="material-icons">favorite_border</i> {l s='Add to wishlist' mod='blockwishlist'}
		        </span>
			</a>
		{/foreach}
	{/if}
</div>
