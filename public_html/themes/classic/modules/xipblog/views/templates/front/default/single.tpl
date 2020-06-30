{block name='head_seo_description'}{$meta_description}{/block}
{block name='head_seo_keywords'}{$meta_keywords}{/block}
{extends file='page.tpl'}

{block name='page_header_container'}{/block}


{block name="page_content_container"}
	<section id="content" class="page-content">
		<div class="kr_blog_post_area single">
			<div class="kr_blog_post_inner">
				<article id="blog_post" class="blog_post blog_post_{$xipblogpost.post_format}">
					<div class="blog_post_content">
						<div class="blog_post_content_top">
							<div class="post_thumbnail">
								{if $xipblogpost.post_format == 'video'}
									{assign var="postvideos" value=','|explode:$xipblogpost.video}
									{if $postvideos|@count > 1 }
										{assign var="class" value='carousel'}
									{else}
										{assign var="class" value=''}
									{/if}
									{include file="module:xipblog/views/templates/front/default/post-video.tpl" postvideos=$postvideos width='870' height="482" class=$class}
								{elseif $xipblogpost.post_format == 'audio'}
									{assign var="postaudio" value=','|explode:$xipblogpost.audio}
									{if $postaudio|@count > 1 }
										{assign var="class" value='carousel'}
									{else}
										{assign var="class" value=''}
									{/if}
									{include file="module:xipblog/views/templates/front/default/post-audio.tpl" postaudio=$postaudio width='870' height="482" class=$class}
								{elseif $xipblogpost.post_format == 'gallery'}
									{if $xipblogpost.gallery_lists|@count > 1 }
										{assign var="class" value='carousel'}
									{else}
										{assign var="class" value=''}
									{/if}
									{include file="module:xipblog/views/templates/front/default/post-gallery.tpl" gallery_lists=$xipblogpost.gallery_lists imagesize="medium" class=$class}
								{else}
									<img class="xipblog_img img-responsive" src="{$xipblogpost.post_img_large}" alt="{$xipblogpost.post_title}">
								{/if}
							</div>
						</div>

						<div class="blog_post_content_bottom">
							<h1 class="post_title">{$xipblogpost.post_title}</h3>
							<div class="post_meta clearfix">
								<div class="meta_author">
									<i class="material-icons">account_circle</i>
									<span>{l s='By' mod='xipblog'} {$xipblogpost.post_author_arr.firstname} {$xipblogpost.post_author_arr.lastname}</span>
								</div>
								{* <div class="post_meta_date">
									<i class="material-icons">event</i>
									{$xpblgpst.post_date|date_format:"%d/%m/%y"}
								</div> *}
								<div class="meta_category">
									<i class="material-icons">local_offer</i>
									<span>{l s='In' mod='xipblog'}</span>
									<span>{$xipblogpost.category_default_arr.name}</span>
								</div>
								<div class="meta_comment">
									 <i class="material-icons">remove_red_eye</i>
									<span>{*{l s='Views' mod='xipblog'}*} ({$xipblogpost.comment_count})</span>
								</div>
							</div>
							<div class="post_content page-content page-cms">
								{$xipblogpost.post_content nofilter}
							</div>
						</div>

					</div>
				</article>
			</div>
		</div>
	</section>


<!-- Rating -->
<div class="rating">
	<svg display="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 32 32" enable-background="new 0 0 32 32">
		<defs>
			<g id="icon-star">
				<path d="M20.388,10.918L32,12.118l-8.735,7.749L25.914,31.4l-9.893-6.088L6.127,31.4l2.695-11.533L0,12.118 l11.547-1.2L16.026,0.6L20.388,10.918z"></path>
			</g>
			<g id="icon-star-half"> 
				<polygon fill="var(--star-color-right)" points="32,12.118 20.389,10.918 16.026,0.6 16,0.66 16,25.325 16.021,25.312 25.914,31.4 23.266,19.867"></polygon>
				<polygon fill="var(--star-color-left)" points="11.547,10.918 0,12.118 8.822,19.867 6.127,31.4 16,25.325 16,0.66"></polygon>
			</g>  
		</defs>
	</svg>

	<div class="stars">

		<span>
			<svg viewBox="0 0 32 32" width="25" height="25" {if $xipblogpost.rating > 0.7}class="selected"{/if}>
				<use xlink:href="#icon-star{if $xipblogpost.rating > 0.2 && $xipblogpost.rating < 0.8}-half{/if}"></use>
			</svg>
		</span>

		<span>
			<svg viewBox="0 0 32 32" width="25" height="25" {if $xipblogpost.rating > 1.7}class="selected"{/if}>
				<use xlink:href="#icon-star{if $xipblogpost.rating > 1.2 && $xipblogpost.rating < 1.8}-half{/if}"></use>
			</svg>
		</span>
			
		<span>
			<svg viewBox="0 0 32 32" width="25" height="25" {if $xipblogpost.rating > 2.7}class="selected"{/if}>
				<use xlink:href="#icon-star{if $xipblogpost.rating > 2.2 && $xipblogpost.rating < 2.8}-half{/if}"></use>
			</svg>
		</span>

		<span>
			<svg viewBox="0 0 32 32" width="25" height="25" {if $xipblogpost.rating > 3.7}class="selected"{/if}>
				<use xlink:href="#icon-star{if $xipblogpost.rating > 3.2 && $xipblogpost.rating < 3.8}-half{/if}"></use>
			</svg>
		</span>

		<span>
			<svg viewBox="0 0 32 32" width="25" height="25" {if $xipblogpost.rating > 4.7}class="selected"{/if}>
				<use xlink:href="#icon-star{if $xipblogpost.rating > 4.2 && $xipblogpost.rating < 4.8}-half{/if}"></use>
			</svg>
		</span>
	
	</div>

	<p>&nbsp;(<span id="review-count">{$xipblogpost.review_count} {if $xipblogpost.review_count == 1}valoraci&oacute;n{else}valoraciones{/if}</span>)</p>
	<p class="rating-message"></p>
</div>

<script type="text/javascript">
    window.onload = function() {
        const stars = $('.stars span');
        let rated = getCookie('rated').split(',');
		const postID = '{$xipblogpost.id_xipposts}';
    
        if (rated.indexOf(postID) > -1)
        {
            $(stars).on('click', function() {
                $('.rating-message').text('Ya habías valorado este artículo anteriormente.').fadeIn(200).delay(5000).fadeOut(600);
            });
        }
        else
        {
            $(stars).one('click', function() {
				const rating = $(stars).index(this) + 1;
							
				$.ajax(
				{
					method: 'POST',
					url: baseDir + 'modules/xipblog/ajax-rating.php',
					data: 'rating=' + rating + 
						  '&postID=' + postID
				})
				.done (function(data) {
					if (data) {
						if (rated[0]) {
							rated.push(postID);
						}
						else {
							rated = postID
						}
						const review_count_updated = {$xipblogpost.review_count} + 1;
						setCookie('rated', rated, 30);
						document.getElementById('review-count').innerHTML = review_count_updated + ((review_count_updated == 1) ? ' valoración' : ' valoraciones');
						updateStars(data);
						$('.rating-message').text('Gracias por tu valoración (' + rating + ')!').fadeIn(200).delay(10000).fadeOut(600);
						$(stars).off('click');
					}
					else {
						document.getElementsByClassName('rating-message')[0].innerText = 'No se ha podido enviar la valoración, por favor, vuelve a intentarlo.';
					}
				})
				.fail (function() {
					document.getElementsByClassName('rating-message')[0].innerText = 'No se ha podido enviar la valoración, por favor, vuelve a intentarlo.';
				});
			});
        }
    }

	function updateStars(currentRating) {
		const previousRating = Math.round({$xipblogpost.rating} * 2) / 2;
		const previousRatingTrunc = Math.trunc(previousRating);
		const currentRatingTrunc = Math.trunc(currentRating);
		const halfStarPrev = (previousRating != previousRatingTrunc);
		const halfStarCurr = (currentRating != currentRatingTrunc);

		if (currentRating < previousRating) {
			$('.stars span svg').slice(currentRating).removeClass('selected');
			if (halfStarPrev) {
				$('.stars span svg').eq(previousRatingTrunc).children().attr('xlink:href', '#icon-star');
			}
			if (halfStarCurr) {
				$('.stars span svg').not('.selected').first().children().attr('xlink:href', '#icon-star-half');
			}
		}
		else if (currentRating > previousRating) {
			 $('.stars span svg').slice(0,currentRating).addClass('selected');
			 if (halfStarPrev) {
				$('.stars span svg').eq(previousRatingTrunc).children().attr('xlink:href', '#icon-star');
			}
			if (halfStarCurr) {
				$('.stars span svg').not('.selected').first().children().attr('xlink:href', '#icon-star-half');
			}
		}
	}

    function setCookie(name, value, days) {
           let expires;
		   value = btoa(value);
		   if (days) {
               const date = new Date();
               date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
               expires = ';expires=' + date.toGMTString();
           }
           else {
			   expires = '';
           }
           document.cookie = name + "=" + value + expires + ";path=/";
    }     
    
    function getCookie(name) {
		var name = name + "=";
        const decodedCookie = decodeURIComponent(document.cookie);
        const ca = decodedCookie.split(';');

        for(let i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return atob(c.substring(name.length, c.length));
            }
        }
           
        return '';
	}
</script>

<!-- AddThis -->
<div class="addthis_inline_share_toolbox"></div>
<div class="addthis_relatedposts_inline"></div>
<script async defer type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5c5db3710f5627e5"></script>

{if ($xipblogpost.comment_status == 'open') || ($xipblogpost.comment_status == 'close')}
	{include file="module:xipblog/views/templates/front/default/comment-list.tpl"}
{/if}
{if (isset($disable_blog_com) && $disable_blog_com == 1) && ($xipblogpost.comment_status == 'open')}
			{include file="module:xipblog/views/templates/front/default/comment.tpl"}
{/if}
{/block}
{block name="left_column"}
	{assign var="layout_column" value=$layout|replace:'layouts/':''|replace:'.tpl':''|strval}
	{if ($layout_column == 'layout-left-column')}
		<div id="left-column" class="sidebar col-xs-12 col-sm-12 col-md-3 pull-md-9">
			{if ($xipblog_column_use == 'own_ps')}
				{hook h="displayxipblogleft"}
			{else}
				{hook h="displayLeftColumn"}
			{/if}
		</div>
	{/if}
{/block}
{block name="right_column"}
	{assign var="layout_column" value=$layout|replace:'layouts/':''|replace:'.tpl':''|strval}
	{if ($layout_column == 'layout-right-column')}
		<div id="right-column" class="sidebar col-xs-12 col-sm-4 col-md-3">
			{if ($xipblog_column_use == 'own_ps')}
				{hook h="displayxipblogright"}
			{else}
				{hook h="displayRightColumn"}
			{/if}
		</div>
	{/if}
{/block}