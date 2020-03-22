<?php

/**
 * Override to the module xipblog to add a new functionality
 * 
 * @author   -> Rafa Soler
 * @email    -> rafasoler10+xipblog@gmail.com
 * 
 */  

use PrestaShop\PrestaShop\Adapter\Image\ImageRetriever;
use PrestaShop\PrestaShop\Adapter\Product\PriceFormatter;
use PrestaShop\PrestaShop\Core\Product\ProductListingPresenter;
use PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever;

if ( ! defined( '_PS_VERSION_' ) ) {
    exit;
}

class xipblogSingleModuleFrontControllerOverride extends xipblogSingleModuleFrontController
{

    public function initContent()
    {
        global $smarty;

        parent::initContent();
        
        $xipblogpost = $smarty->getTemplateVars('xipblogpost');

        if ( $xipblogpost['id_xipposts'] == 12 ) { // TEST Articulaciones
            $xipblogpost['post_content'] = $this->returnContent($xipblogpost['post_content']); 
        }

        $this->context->smarty->assign('xipblogpost', $xipblogpost);

    }

    public function returnContent($contents)
    {
         /** PRODUCTS **/
         preg_match_all('/\{products\:[(0-9\,)]+\}/i', $contents, $matches);
         foreach ($matches[0] as $index => $match)
         {
             $explode = explode(":", $match);
             $contents = str_replace($match, $this->returnProducts(str_replace("}", "", $explode[1])), $contents);
         }
 
         /** PRODUCT **/
         preg_match_all('/\{product\:[(0-9\,)]+\}/i', $contents, $matches);
         foreach ($matches[0] as $index => $match)
         {
             $explode = explode(":", $match);
             $contents = str_replace($match, $this->returnProduct(str_replace("}", "", $explode[1])), $contents);
         }

         return $contents;
    }

    public function returnProduct($id_product) // TODO
    {
        $x = (array)new Product($id_product, true, $this->context->language->id);
        if (is_int($x['id'])) {
            $productss[$id_product] = $x;
            $productss[$id_product]['id_product'] = $id_product;
        }

        $products = Product::getProductsProperties($this->context->language->id, $productss);
        $assembler = new ProductAssembler($this->context);
        $presenterFactory = new ProductPresenterFactory($this->context);
        $presentationSettings = $presenterFactory->getPresentationSettings();
        $presenter = new ProductListingPresenter(
            new ImageRetriever(
                $this->context->link
            ),
            $this->context->link,
            new PriceFormatter(),
            new ProductColorsRetriever(),
            $this->context->getTranslator()
        );

        $products_for_template = [];
        foreach ($products as $rawProduct) {
            $products_for_template[] = $presenter->present(
                $presentationSettings,
                $assembler->assembleProduct($rawProduct),
                $this->context->language
            );
        }

        $this->context->smarty->assign('products', $products_for_template);
        $this->context->smarty->assign('feedtype', "xipblogSingleProductFeed");

        return $this->context->smarty->fetch('module:xipblog/views/templates/front/default/products.tpl');
    }

    public function returnProducts($id_product)
    {
        $explode_products = explode(",", $id_product);
        foreach ($explode_products AS $idp)
        {
            $explode[] = $idp;
            foreach ($explode as $tproduct)
            {
                if ($tproduct != '')
                {
                    $x = (array)new Product($tproduct, true, $this->context->language->id);
                    if (is_int($x['id'])) {
                        $productss[$tproduct] = $x;
                        $productss[$tproduct]['id_product'] = $tproduct;
                    }
                }
            }
        }
        $products = Product::getProductsProperties($this->context->language->id, $productss);
        $assembler = new ProductAssembler($this->context);
        $presenterFactory = new ProductPresenterFactory($this->context);
        $presentationSettings = $presenterFactory->getPresentationSettings();
        $presenter = new ProductListingPresenter(
            new ImageRetriever(
                $this->context->link
            ),
            $this->context->link,
            new PriceFormatter(),
            new ProductColorsRetriever(),
            $this->context->getTranslator()
        );

        $products_for_template = [];
        foreach ($products as $rawProduct) {
            $products_for_template[] = $presenter->present(
                $presentationSettings,
                $assembler->assembleProduct($rawProduct),
                $this->context->language
            );
        }

        $this->context->smarty->assign('products', ((version_compare(_PS_VERSION_, '1.7.0', '>=') === true) ? $products_for_template : $products));
        $this->context->smarty->assign('feedtype', "xipblogProductsFeed");

        return $this->context->smarty->fetch('module:xipblog/views/templates/front/default/products.tpl');
    }


}