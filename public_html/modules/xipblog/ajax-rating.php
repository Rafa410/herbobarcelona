<?php

require_once(dirname(__FILE__).'/../../config/config.inc.php'); // Db class

if ( isset($_POST) && !empty($_POST) ) {

    $rating = $_POST['rating'];
    $post_id = $_POST['postID'];

    if ($post_id == NULL || $post_id == 0 || $rating < 0 || $rating > 5) {
        return false;
    }

    $sql = 'UPDATE ' . _DB_PREFIX_ . 'xipposts ' 
            . 'SET rating = ((rating * review_count + ' . $rating . ') / (review_count + 1)), ' 
            . 'review_count = (review_count + 1) ' 
            . 'WHERE id_xipposts = ' . $post_id;

    if (Db::getInstance()->execute($sql)) {

        $sql = 'SELECT rating ' 
                . 'FROM ' . _DB_PREFIX_ . 'xipposts '
                . 'WHERE id_xipposts = ' . $post_id;
        $result = Db::getInstance()->executeS($sql);

        echo(round($result[0]['rating'] * 2) / 2);
        
    }
    else {
        return false;
    }
}
