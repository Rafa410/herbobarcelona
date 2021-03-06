<?php
/*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

/* SSL Management */
$useSSL = true;

// use PrestaShop\PrestaShop\Adapter\Image\ImageRetriever;
// use PrestaShop\PrestaShop\Adapter\Product\PriceFormatter;
// use PrestaShop\PrestaShop\Core\Product\ProductListingPresenter;
// use PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever;

require_once(dirname(__FILE__).'/../../config/config.inc.php');
require_once(dirname(__FILE__).'/../../init.php');
require_once(dirname(__FILE__).'/WishList.php');
require_once(dirname(__FILE__).'/blockwishlist.php');

$context = Context::getContext();
if ($context->customer->isLogged())
{
	$action = Tools::getValue('action');
	$id_wishlist = (int)Tools::getValue('id_wishlist');
	$id_product = (int)Tools::getValue('id_product');
	$id_product_attribute = (int)Tools::getValue('id_product_attribute');
	$quantity = (int)Tools::getValue('quantity');
	$priority = Tools::getValue('priority');
	$wishlist = new WishList((int)($id_wishlist));
	$refresh = (($_GET['refresh'] == 'true') ? 1 : 0);

	if (empty($id_wishlist) === false)
	{
		if (!strcmp($action, 'update'))
		{
			WishList::updateProduct($id_wishlist, $id_product, $id_product_attribute, $priority, $quantity);
		}
		else
		{
			if (!strcmp($action, 'delete'))
				WishList::removeProduct($id_wishlist, (int)$context->customer->id, $id_product, $id_product_attribute);

			$products = WishList::getProductByIdCustomer($id_wishlist, $context->customer->id, $context->language->id);
			$bought = WishList::getBoughtProduct($id_wishlist);
			$link = new Link();

			
			for ($i = 0; $i < sizeof($products); ++$i)
			{
                
				if (!Validate::isLoadedObject($obj)) {
                    continue;
                }
				else
				{
                    if ($products[$i]['id_product_attribute'] != 0)
					{
						$combination_imgs = $obj->getCombinationImages($context->language->id);
						if (isset($combination_imgs[$products[$i]['id_product_attribute']][0])){

							$coverImg = $obj->id.'-'.$combination_imgs[$products[$i]['id_product_attribute']][0]['id_image'];
							$products[$i]['image_link'] = $link->getImageLink($products[$i]['link_rewrite'], $coverImg, 'home_default');

						}
						else
						{
							$cover = Product::getCover($obj->id);
							$coverImg = $obj->id.'-'.$cover['id_image'];
							$products[$i]['image_link'] = $link->getImageLink($products[$i]['link_rewrite'], $coverImg, 'home_default');
							
						}
					}
					else
					{
						$images = $obj->getImages($context->language->id);
						foreach ($images AS $k => $image)
							if ($image['cover'])
							{
								$coverImg = $obj->id.'-'.$image['id_image'];
								$products[$i]['image_link'] = $link->getImageLink($products[$i]['link_rewrite'], $coverImg, 'home_default');

								break;
							}
					}
					if (!isset($products[$i]['image_link']))
                        $products[$i]['image_link'] = 'img/p/'.$context->language->iso_code.'-default-home_default.jpg';	
						
                }

				$products[$i]['bought'] = false;
				for ($j = 0, $k = 0; $j < sizeof($bought); ++$j)
				{
					if ($bought[$j]['id_product'] == $products[$i]['id_product'] AND
						$bought[$j]['id_product_attribute'] == $products[$i]['id_product_attribute'])
						$products[$i]['bought'][$k++] = $bought[$j];
				}
            }

			/*
			for ($i = 0; $i < sizeof($products); ++$i) {
				
				$ids[] = $products[$i]['id_product'];
				foreach($ids as $id) {

					if ($id != '') {
						$obj = (array)new Product($id, true, $context->language->id);
						
						if (is_int($obj['id'])) {
							$productss[$id] = $obj;
                			$productss[$id]['id_product'] = $id;
						}
					}
				}				
			}

            $products = Product::getProductsProperties($context->language->id, $productss);
            $assembler = new ProductAssembler($context);
            $presenterFactory = new ProductPresenterFactory($context);
            $presentationSettings = $presenterFactory->getPresentationSettings();
	
            $presenter = new ProductListingPresenter(
                new ImageRetriever(
                    $context->link
                ),
                $context->link,
                new PriceFormatter(),
                new ProductColorsRetriever(),
                $context->getTranslator()
            );

            $products_for_template = [];
            foreach ($products as $rawProduct) {
                $products_for_template[] = $presenter->present(
                    $presentationSettings,
                    $assembler->assembleProduct($rawProduct),
                    $context->language
                );
            }
            */
            
			$productBoughts = array();
            
            foreach ($products as $product) {
				if (sizeof($product['bought'])) {
                    $productBoughts[] = $product;
                }
            }
            
                    
			$context->smarty->assign(array(
					// 'products' => ((version_compare(_PS_VERSION_, '1.7.0', '>=') === true) ? $products_for_template : $products,
					'products' => $products,
					'productsBoughts' => $productBoughts,
					'id_wishlist' => $id_wishlist,
					'refresh' => $refresh,
					'token_wish' => $wishlist->token,
                    'wishlists' => WishList::getByIdCustomer($cookie->id_customer),
                    // 'feedtype', "wishlistProductsFeed"
				));


			// Instance of module class for translations
			$module = new BlockWishList();

			if (Tools::file_exists_cache(_PS_THEME_DIR_.'modules/blockwishlist/views/templates/front/managewishlist.tpl'))
				$context->smarty->display(_PS_THEME_DIR_.'modules/blockwishlist/views/templates/front/managewishlist.tpl');
			elseif (Tools::file_exists_cache(dirname(__FILE__).'/views/templates/front/managewishlist.tpl'))
				$context->smarty->display(dirname(__FILE__).'/views/templates/front/managewishlist.tpl');
			elseif (Tools::file_exists_cache(dirname(__FILE__).'/managewishlist.tpl'))
				$context->smarty->display(dirname(__FILE__).'/managewishlist.tpl');
			else
				echo $module->l('No template found', 'managewishlist');
				
		}
	}
}

