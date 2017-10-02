$(function() {
    $(window).scroll(function () {
        if(!$('body').hasClass('probably-mobile'))
        {
            if ($(this).scrollTop() > 50) {
                $('a#scroll-top').fadeIn();
            } else {
                $('a#scroll-top').fadeOut();
            }
        }
        else
        {
            $('a#scroll-top').fadeOut();
        }
    });

    $('a#scroll-top').on('click', function(){
        if(!$('body').hasClass('probably-mobile'))
        {
            $('html, body').animate({scrollTop:0}, 'slow' );
            return false;
        }
    });
});