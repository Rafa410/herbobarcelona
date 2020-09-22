{**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
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
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2018 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<div class="block-contact col-md-4 links wrapper">
  <div>
    <p class="h4 text-uppercase block-contact-title">{l s='Store information' d='Shop.Theme.Global'}</p>
      {*{$contact_infos.address.formatted nofilter}*}
      <br>
      <p><a href="{$urls.base_url}contacto"><i class="material-icons">contact_mail</i> Formulario de contacto</a></p>
      {if $contact_infos.phone}
        {l s='Call us: [1]%phone%[/1]'
          sprintf=[
          '[1]' => '<p><a href="tel:%phone%"><i class="material-icons">phone</i> ',
          '[/1]' => '</a></p>',
          '%phone%' => $contact_infos.phone
          ]
          d='Shop.Theme.Global'
        }
      {/if}
      {if $contact_infos.fax}
        {l
          s='Fax: [1]%fax%[/1]'
          sprintf=[
            '[1]' => '<span>',
            '[/1]' => '</span>',
            '%fax%' => $contact_infos.fax
          ]
          d='Shop.Theme.Global'
        }
      {/if}
      {if $contact_infos.email}
        {l
          s='Email us: [1]%email%[/1]'
          sprintf=[
            '[1]' => '<p><a href="mailto:'|cat:$contact_infos.email|cat:'"><i class="material-icons">mail_outline</i> ',
            '[/1]' => '</a></p>',
            '%email%' => $contact_infos.email
          ]
          d='Shop.Theme.Global'
        }
      {/if}
    <div class="block-social">
     <ul>
      <a href="https://www.facebook.com/herbobarcelona" target="_blank" rel="noopener noreferrer"><li class="facebook"></li></a>
      <a href="https://www.instagram.com/herbobcn" target="_blank" rel="noopener noreferrer"><li class="instagram"></li></a>
      <a href="https://wa.me/34644428821" target="_blank" rel="noopener noreferrer"><li class="whatsapp"></li></a>
      </ul>
     </div>
  </div>
 {* <div class="hidden-md-up">
    <div class="title">
      <a class="h3" href="{$urls.pages.stores}">{l s='Store information' d='Shop.Theme.Global'}</a>
    </div>
  </div>  *}
</div>