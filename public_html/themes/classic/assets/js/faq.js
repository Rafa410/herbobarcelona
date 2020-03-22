/** 
 * jQuery
 * This function toggles the visibility of an answer when clicking on a question.
*/

jQuery(document).ready(function($) {

    const $questions = $( '.question' );
    const $answers = $( '.answer' );

        $questions.on( 'click' , function() { 
            $answers.eq( $questions.index( this ) ).slideToggle();
    });

});