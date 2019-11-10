(function () {

    $(document).ready(function () {
        
        const isMobile = /Android|webOS|iPhone|iPad|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

        // Carrier ID (Cambiar cada vez que actualizamos los ajustes de un transportista)
        const correosExpID = '138';
        const correosEstID = '139';
        const oficinaCorreosID = '150';
        const feliuBcnID = '142';
        const feliuCatID = '144';
        const feliuEspID = '146';
        const puntoRecogidaID = '149'; // Hora limite 12:30. Similar a feliubadalo BCN

        // Countdown variables
        let now = new Date();
        let nowH = now.getHours();
        var date;
        var day;
        let today = false;
        let tomorrow = false;
   

        /*************  Functions *************/
        function leapY() {
            return ((now.getFullYear() % 400 === 0) || ((now.getFullYear() % 4 === 0) && (now.getFullYear() % 100 !== 0)));
        }
        //function hollidays()    // Retraso en envío días festivos
        //{

        //    if ((month == 4) && (date == 1)) // 1 de mayo - Dia del trabajador
        //    {
        //        return true;
        //    }
        //}
        function DFCafterH(d, w) { // Distribudiet & Feliubadalo Cat despues de la hora limite 
            date = now.getDate();
            if (d == 6) {
                day = w[2];
                date += 3;
            } else {
                if (d == 5) {
                    day = w[2];
                    date += 4;
                } else {
                    if (d === 0) {
                        day = w[2];
                        date += 2;
                    } else {
                        if (d == 4) {
                            day = w[1];
                            date += 4;
                        } else {
                            day = w[d + 2];
                            date += 2;
                        }
                    }
                }
            }
        }
        function DFCbeforeH(d, w) { // Distribudiet && Feliubadalo cat antes de la hora limite
            date = now.getDate();
            if (d == 6) {
                day = w[2];
                date += 3;
            } else {
                if (d === 0) {
                    day = w[2];
                    date += 2;
                } else {
                    if (d == 5) {
                        day = w[1];
                        date += 3;
                    } else {
                        day = w[d + 1];
                        date++;
                        tomorrow = true;
                    }
                }
            }
        }
        function FafterH(d, w) { //Feliubadalo BCN && Actibios despues de la hora limite
            date = now.getDate();
            if (d == 6) {
                day = w[1];
                date += 2;
            } else {
                if (d == 5) {
                    day = w[1];
                    date += 3;
                } else {
                    day = w[d + 1];
                    date++;
                    tomorrow = true;
                }
            }
        }
        function FbeforeH(d, w) { // Feliubadalo BCN && Actibios antes de la hora limite
            date = now.getDate();
            if (d == 6) {
                day = w[1];
                date += 2;
            } else {
                if (d === 0) {
                    day = w[1];
                    date++;
                    tomorrow = true;
                } else {
                    day = w[d];
                    today = true;
                }
            }
        }

        function CEafterH(d,w)  // Correos estandar despues de la hora limite
        {
            date = now.getDate();
            if (d == 6) {
                day = w[3];
                date += 4;
            } else {
                if (d == 5) {
                    day = w[3];
                    date += 5;
                } else {
                    if (d === 0) {
                        day = w[3];
                        date += 3;
                    } else {
                        if (d == 4) {
                            day = w[2];
                            date += 5;
                        } else {
                            if (d == 3) {
                                day = w[1];
                                date += 5;
                            }
                            else {
                                day = w[d + 3];
                                date += 3;
                            }
                        }
                    }
                }
            }
        }
  
        function CEbeforeH(d,w) // Correos estandar antes de la hora limite
        {
            date = now.getDate();
            if (d == 6) {
                day = w[3];
                date += 4;
            } else {
                if (d == 5) {
                    day = w[2];
                    date += 4;
                } else {
                    if (d === 0) {
                        day = w[3];
                        date += 3;
                    } else {
                        if (d == 4) {
                            day = w[1];
                            date += 4;
                        } else {
                            day = w[d + 2];
                            date += 2;
                        }
                    }
                }
            }
        }

        function OCafterH(d,w)  // Oficina de correos despues de la hora limite
        {
            date = now.getDate();
            if (d == 6) {
                day = w[4];
                date += 5;
            } else {
                if (d == 5) {
                    day = w[4];
                    date += 6;
                } else {
                    if ((d == 0) || (d == 1)) {
                        day = w[d + 4];
                        date += 4;
                    } else {
                        day = w[d - 1];
                        date += 6;
                    }
                }
            }
        }

        function OCbeforeH(d,w) // Oficina de correos antes de la hora limite
        {
            date = now.getDate();
            if (d == 6) {
                day = w[4];
                date += 5;
            } else {
                if (d == 5) {
                    day = w[3];
                    date += 5;
                } else {
                    if (d === 0) {
                        day = w[4];
                        date += 4;
                    } else {
                        if (d == 4) {
                            day = w[2];
                            date += 5;
                        } else {
                            if (d == 3) {
                                day = w[1];
                                date += 5;
                            }
                            else {
                                day = w[d + 3];
                                date += 3;
                            }
                        }
                    }
                }
            }
        }

        function countDown(supp,carrier = 0) 
            {
                const CD = document.getElementById("CountDown");
                let maxDate = new Date();
                let mH;
                let month = now.getMonth(); 
                today = false;
                tomorrow = false;

                const weekDay = [
                "domingo",   // 0
                "lunes",     // 1
                "martes",    // 2
                "miércoles", // 3
                "jueves",    // 4
                "viernes",   // 5
                "sábado"];   // 6

                const monthName = [
                    "Enero",        // 0
                    "Febrero",      // 1
                    "Marzo",        // 2
                    "Abril",        // 3
                    "Mayo",         // 4
                    "Junio",        // 5
                    "Julio",        // 6
                    "Agosto",       // 7
                    "Septiembre",   // 8
                    "Octubre",      // 9
                    "Noviembre",    // 10
                    "Diciembre"];   // 11

                //Asignar Day & Date
                switch(supp)
                {
                    default:
                        supp = 1;
                    case '1':
                        maxDate.setHours(16, 0, 0); // Correos express
                        mH = maxDate.getHours();
                        nowH >= mH ? DFCafterH(now.getDay(), weekDay) : DFCbeforeH(now.getDay(), weekDay);
                        break;
                    case '2':
                        maxDate.setHours(13, 0, 0); // Feliubadalo BCN
                        mH = maxDate.getHours();
                        nowH >= mH ? FafterH(now.getDay(), weekDay) : FbeforeH(now.getDay(), weekDay);
                        break;
                    case '3':
                        maxDate.setHours(18, 0, 0); // Distribudiet + feliubadalo
                        mH = maxDate.getHours();
                        nowH >= mH ? DFCafterH(now.getDay(), weekDay) : DFCbeforeH(now.getDay(), weekDay);
                        break;
                    case '4':
                        maxDate.setHours(18, 0, 0); // Correos estándar
                        mH = maxDate.getHours();
                        nowH >= mH ? CEafterH(now.getDay(), weekDay) : CEbeforeH(now.getDay(), weekDay);
                        break;
                    case '5':
                        maxDate.setHours(18, 0, 0); // Oficina correos
                        mH = maxDate.getHours();
                        nowH >= mH ? OCafterH(now.getDay(), weekDay) : OCbeforeH(now.getDay(), weekDay);
                        break;
                    case '6':
                        maxDate.setHours(12, 30, 0); // Punto de recogida
                        mH = maxDate.getHours();
                        nowH >= mH ? FafterH(now.getDay(), weekDay) : FbeforeH(now.getDay(), weekDay);
                        break;
                }

                //Comprobar overflow días/mes
                switch (month) {
                    case 0:
                    case 2:
                    case 4:
                    case 6:
                    case 7:
                    case 9:
                    case 11:
                        if (date > 31) {
                            date -= 31;
                            if (month == 11) {
                                month = 0;
                            }
                            else {
                                month++;
                            }
                        }
                        break;
                    case 1:
                        if (leapY == 1) {
                            if (date > 29) {
                                date -= 29;
                                month++;
                            }
                        } else {
                            if (date > 28) {
                                date -= 28;
                                month++;
                            }
                        }
                        break;
                    case 3:
                    case 5:
                    case 8:
                    case 10:
                        if (date > 30) {
                            date -= 30;
                            month++;
                        }
                        break;
                }

                month = monthName[month]; // Transformar mes de Int a string

                if (((supp == 1) || (supp == 2)) && (prestashop.page.page_name != 'checkout')) {

                    setInterval(function () {  // Intervalo cada 1s

                        now = new Date();
                        nowH = now.getHours();
                        let h = 0;
                        let m = 0;

                        //Asignación hora & min antes/después de las 16hrs  
                        h = (nowH >= mH) ? 24 - now.getHours() + maxDate.getHours() : maxDate.getHours() - now.getHours();

                        if ((now.getDay() == 5) && (nowH > mH)) {  //Comprobar hora fin de semana
                            h += 48;
                        } else {
                            if ((now.getDay() == 6) && (nowH < mH)) {
                                h += 48;
                            } else {
                                if ((now.getDay() == 6) && (nowH > mH)) {
                                    h += 24;
                                } else {
                                    if ((now.getDay() === 0) && (nowH < mH)) {
                                        h += 24;
                                    }
                                }
                            }
                        }
                        m = 60 - now.getMinutes();
                        if (m == 60) m = 0;
                        if (m !== 0) h--;

                        //Mostrar hora y min
                        h === 0 ? CD.innerHTML = m + "min " : CD.innerHTML = h + (h == 1 ? " hr " : " hrs ") + m + (m == 1 ? " min " : " mins ");

                    }, 1000);

                    // Mostrar dia y fecha
                    if (today) {
                        document.getElementsByClassName("dateCountdown")[0].innerHTML = "hoy, " + day + " " + date + " de " + month + ".";
                    }
                    else {
                        if (tomorrow) {
                            document.getElementsByClassName("dateCountdown")[0].innerHTML = "mañana, " + day + " " + date + " de " + month + ".";
                        }
                        else {
                            document.getElementsByClassName("dateCountdown")[0].innerHTML = "el " + day + ", " + date + " de " + month + ".";
                        }
                    }

                }
                if (prestashop.page.page_name == 'checkout') {
                    // Mostrar dia y fecha
                    let DC = document.querySelectorAll(".dateCountdown");
                    if (today) {
                        DC[carrier].innerHTML = " hoy, " + day + " " + date + " de " + month + ".";
                    }
                    else {
                        if (tomorrow) {
                            DC[carrier].innerHTML = " mañana, " + day + " " + date + " de " + month + ".";   
                        }
                        else {
                            DC[carrier].innerHTML = " el " + day + ", " + date + " de " + month + ".";
                        }
                    }

                    if (DC[carrier].id == puntoRecogidaID)
                    {
                        let msg = '<p style="margin-top: 0.3rem;"><a href="#" id="btn-toggle-info_' + DC[carrier].id + '"><i class="material-icons add">add_circle</i><i class="material-icons remove" style="display:none;">remove_circle</i> Información</a></p><p id="more-info_' + DC[carrier].id + '">Recibirás un correo cuando tu pedido esté listo para su recogida en <a href="https://goo.gl/maps/oSXTrW7uB7rRcEBf8" target="_blank" rel="nofollow noopener noreferrer">Calle Putget 78, 1º A, 08023 Barcelona</a>.</p>';
                        morePickupInfo(DC[carrier], msg, DC[carrier].id);
                    }
                    else if (DC[carrier].id == oficinaCorreosID)
                    {
                        let msg = '<p style="margin-top: 0.3rem;"><a href="#" id="btn-toggle-info_' + DC[carrier].id + '"><i class="material-icons add">add_circle</i><i class="material-icons remove" style="display:none;">remove_circle</i> Información</a></p><p id="more-info_' + DC[carrier].id + '">Por defecto, se enviará tu pedido a la oficina de Correos más cercana a la dirección introducida en el paso anterior. Puedes añadir un comentario al pedido si prefieres que lo enviemos a otra oficina.</p>';
                        morePickupInfo(DC[carrier], msg, DC[carrier].id);
                    }
                    
                }
            }

            /*  morePickupInfo(element, string, number)
                * @currentMessage ==> Elemento HTML con el mensaje que contiene actualmente
                * @additionalInfo ==> String que contiene el HTML adicional a añadir al currentmessage
                * @id ==> Identificador único para cada transportista, se concatena con el nombre del ID y de la clase para identificar a que transportista pertenece
            */
            function morePickupInfo(currentMessage, additionalInfo, id) // Miestra información adicional sobre la recogida en tienda en el checkout
            {
                currentMessage.innerHTML += additionalInfo;

                $(document).on('click', '#btn-toggle-info_' + id, function() {
                    $('#more-info_' + id).slideToggle();
                    $('#btn-toggle-info_' + id + ' i').toggle();
                    return false;
                })
            }

            function addToCartBtnEffects() //Efectos en el botón añadir al carrito
            {
                // Efecto tracking al hacer hover
                const btn = document.querySelector('.add-to-cart') || {};
                btn.onmousemove = function (e) {
                    let x = e.pageX - btn.offsetLeft - btn.offsetParent.offsetLeft;
                    let y = e.pageY - btn.offsetTop - btn.offsetParent.offsetTop;
                    btn.style.setProperty('--x', x + 'px');
                    btn.style.setProperty('--y', y + 'px');
                }
                //Loading animation al hacer click
                $(document).on("click", ".add-to-cart", function () {
                    $(this).addClass("loading");
                });
            }

            function loadingAnimation() { // Loading animation al hacer click en boton continuar del paso 3 del checkout (envio)

                $(document).on("click", "button[name='confirmDeliveryOption']", function () {
                    $(this).addClass("loading");
                });
    
                /* TODO: 
                   * Añadir el mismo efecto a los pasos 1 y 2
                   * Detectar cuando hay errores para quitar la animación
                */

            }
            function socialLogin() // Muestra el social login en el paso 1 del checkout al hacer click
            {
                if (!prestashop.customer.is_logged) {
                    const sl = document.getElementsByClassName("social-login")[0];
                    document.getElementById("social-login").onclick = function () {
                        if (sl.style.display == "none") {
                            sl.style.display = "block";
                        } else {
                            sl.style.display = "none";
                        }
                    }
                }
            }

            // StickyNavElements variables
            const SB = $("#search_widget");
            const si = $(".ui-autocomplete-input");
            const pos = SB.offset();

            function stickyNavElements() { // Efecto sticky a elementos en el header
                const LG = $("#sticky-logo");
                const c = $(".l_cart");
                const u = $(".user-info").eq(1);
                const du = $("#_desktop_user_info");
                const SS = $("#sticky-search");

                if (window.pageYOffset > pos.top) {

                    SB.addClass("sticky");
                    SB.css("margin-top", "0");
                    SB.hide();
                    LG.fadeIn();
                    c.hide();
                    u.removeClass("hidden-xs-up");
                    du.addClass("hidden-xs-up");
                    SS.show();
                } else {

                    SB.removeClass("sticky");
                    SB.css("margin-top", "20px");
                    SB.fadeIn("fast");
                    LG.fadeOut("slow");
                    c.show();
                    u.addClass("hidden-xs-up");
                    du.removeClass("hidden-xs-up");
                    SS.hide();
                }
            }

            // StickyCat variables
            const cat = $("#_desktop_top_menu");
            let cPos = cat.offset();
            let topPos = 19;
            let pS = 0;

            function stickyCat() { // Efecto sticky a las categorias
                let cS = $(window).scrollTop();
                if (window.pageYOffset > cPos.top - 30) {
                    if ((cS > pS) && (topPos < 49)) {
                        topPos += 2;
                        cat.css("top", topPos + "px");
                    }
                    if ((cS < pS) && (topPos > 19) && (window.pageYOffset < cPos.top + 10)) {
                        topPos -= 1;
                        cat.css("top", topPos + "px");
                    }
                    cat.addClass("sticky-cat");
                    $(".header-top").css("padding-bottom", "3rem");
                    $(".popover").css("top", "30px");
                } else {
                    cat.removeClass("sticky-cat");
                    $(".header-top").css("padding-bottom", "1.25rem");
                    $(".popover").css("top", "122px");
                    topPos = 19;
                    cat.css("top", topPos);
                }
                pS = cS;
            }

            function stickyThings()
            {
                const a = $("#contact-link a:first");

                if (isMobile) {
                    $(document).on("click", "#search-icon", function () {
                        if (SB.css("display") == "block") {
                            SB.fadeOut();
                        } else {
                            SB.fadeIn("fast");
                            si.focus();
                        }
                    });
                } else {
                    window.onscroll = function () {
                        stickyNavElements();
                        stickyCat();
                    };
                    $(document).on("click", "#sticky-search", function () {
                        if (SB.css("display") == "block") {
                            SB.fadeOut();
                            a.removeClass("show-md");
                        } else {
                            a.addClass("show-md");
                            SB.fadeIn("fast");
                            si.focus();
                        }
                    });
                }
            }   

            function hideCookies() // Ocultar mensaje cookies al cabo de 10 seg
            {
                if ($("#cookieNotice").css("bottom") == "0px") {
                    setTimeout(function () {
                        closeUeNotify();
                    }, 10000);
                }
            }

            function serviceWorker() // Registrar service worker
            {
                if ('serviceWorker' in navigator) {
                    window.addEventListener('load', function() {
                        navigator.serviceWorker.register('/OneSignalSDKWorker.js').then(function(registration) {
                            console.log('ServiceWorker registration successful with scope: ', registration.scope);
                        }, function(err) {
                            console.log('ServiceWorker registration failed: ', err);
                        });
                    });
                }
            }

            function changeStyleBlogFooter()
            {
                $('.home_blog_post_area.displayFooterBefore').parents('.container').addClass('blog-footer')
            }

            /*************  End functions *************/

            if (prestashop.page.page_name != "checkout") {
                stickyThings();
            }

            let supplier = '1';

            switch(prestashop.page.page_name)
            {
                case 'product':
                    if (($("#product-details").data("product").quantity > 0) 
                        || ($("#product-details").data("product").availability == 'available') 
                          || ($("#product-details").data("product").availability == 'last_remaining_items')) {
                        const supplier = $("#product-details").data("product").id_supplier;
                        countDown(supplier);
                        if (supplier == '2')
                        {
                            document.getElementsByClassName("avisoFB")[0].style.display = 'block';
                        }
                    }
                    addToCartBtnEffects();
                    break;

                case 'cart':
                    if ((prestashop.cart.subtotals.shipping.amount == 2.70) || (prestashop.cart.subtotals.shipping.amount == 3.60) 
                        || (prestashop.cart.subtotals.shipping.amount == 2.60) || (prestashop.cart.subtotals.shipping.amount == 3.40) 
                            || (prestashop.cart.subtotals.shipping.amount == 2.40))
                    {
                        supplier = '2';
                    }
                    countDown(supplier);
                    addToCartBtnEffects();
                    break;

                case 'checkout':
                    socialLogin();
                    loadingAnimation();
                    const carrier = document.querySelectorAll(".dateCountdown");
                    const carrierPrice = document.querySelectorAll(".carrier-price");
                    for (let i = 0; i < carrier.length; i++)
                    {
                        switch (carrier[i].id)
                        {
                            case correosExpID:   // Correos Express
                                supplier = '1';
                                break;

                            case feliuEspID:   // Feliubabalo Esp
                        
                                if ((carrierPrice[i].innerText.slice(0,4) == "8,90") || (carrierPrice[i].innerText.slice(0,4) == "7,35") || (carrierPrice[i].innerText.slice(0,4) == "2,95")) // Feliubadalo & Distribudiet urgente
                                {
                                    supplier = '1';
                                }
                                else if ((carrierPrice[i].innerText.slice(0,4) == "7,90") || (carrierPrice[i].innerText.slice(0,4) == "6,15")) // Feliubadalo & Distribudiet estandar
                                {   
                                    supplier = '4';
                                }
                                else if ((carrierPrice[i].innerText.slice(0,4) == "7,65") || (carrierPrice[i].innerText.slice(0,4) == "5,90")) // Feliubadalo & Distribudiet correos
                                {
                                    supplier = '5';
                                }
                                else
                                {
                                    supplier = '4';
                                }
                                break;

                            case feliuBcnID:    // Super-Urgente Feliubadalo Bcn
                                if ((carrierPrice[i].innerText.slice(0,4) == "7,20") || (carrierPrice[i].innerText.slice(0,4) == "3,95") || (carrierPrice[i].innerText.slice(0,4) == "2,95")) // Feliubadalo & Distribudiet urgente
                                {
                                    supplier = '1';
                                }
                                else if ((carrierPrice[i].innerText.slice(0,4) == "6,20") || (carrierPrice[i].innerText.slice(0,4) == "2,75")) // Feliubadalo & Distribudiet estandar
                                {
                                    supplier = '4';
                                }
                                else if ((carrierPrice[i].innerText.slice(0,4) == "5,95") || (carrierPrice[i].innerText.slice(0,4) == "5,20")) // Feliubadalo & Distribudiet oficina 
                                {
                                    supplier = '5';
                                }
                                else
                                {
                                    supplier = '2';
                                }
                                break;

                            case feliuCatID:    // Feliubadalo dia siguiente Cat
                                if ((carrierPrice[i].innerText.slice(0,4) == "8,10") || (carrierPrice[i].innerText.slice(0,4) == "6,55") || (carrierPrice[i].innerText.slice(0,4) == "2,95")) // Feliubadalo & Distribudiet urgente
                                {
                                    supplier = '1';
                                }
                                else if ((carrierPrice[i].innerText.slice(0,4) == "7,10") || (carrierPrice[i].innerText.slice(0,4) == "5,35")) // Feliubadalo & Distribudiet estandar
                                {
                                    supplier = '4';
                                }
                                else if ((carrierPrice[i].innerText.slice(0,4) == "6,85") || (carrierPrice[i].innerText.slice(0,4) == "5,10")) // Feliubadalo & Distribudiet correos
                                {
                                    supplier = '5';
                                }
                                else
                                {
                                    supplier = '3';
                                }
                                break;

                            case correosEstID:    // Correos estandar
                                supplier = '4';
                                break;

                            case oficinaCorreosID:    // Oficina Correos
                                supplier = '5';
                                break;
                            case puntoRecogidaID:
                                supplier = '6';
                                break;
                            default:
                                supplier = '4';
                                break;
                        }           
                        countDown(supplier,i);
                    }
                    break;

                case 'cms':
                    addToCartBtnEffects();
                    break;
                case 'module-blockwishlist-view':
                    addToCartBtnEffects();
                    break;
                default:
                    break;
            }

            changeStyleBlogFooter()

            hideCookies();

            // serviceWorker();
   
        }); /**End doc.Ready**/

    })();
