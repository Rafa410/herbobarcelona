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
        const puntoRecogidaID = '149';

        const distribudietID = '1';
        const feliubadaloID = '2';

        if (prestashop.page.page_name != 'checkout') {
            stickyThings();
        }

        let supplier = '1';

        switch (prestashop.page.page_name) {
            case 'product':
                if (($("#product-details").data("product").quantity > 0)
                    || ($("#product-details").data("product").availability == 'available')
                    || ($("#product-details").data("product").availability == 'last_remaining_items')) {
                    const supplier = $("#product-details").data("product").id_supplier;
                    countdown(supplier);
                    if (supplier == '2') {
                        document.getElementsByClassName("avisoFB")[0].style.display = 'block';
                    }
                }

                addToCartBtnEffects();
                
                break;

            case 'cart':
                if ((prestashop.cart.subtotals.shipping.amount == 2.70) || (prestashop.cart.subtotals.shipping.amount == 3.60)
                    || (prestashop.cart.subtotals.shipping.amount == 2.60) || (prestashop.cart.subtotals.shipping.amount == 3.40)
                    || (prestashop.cart.subtotals.shipping.amount == 2.40)) {
                    supplier = '2';
                }
                countdown(supplier);
                addToCartBtnEffects();
                break;

            case 'checkout':
                socialLogin();
                loadingAnimation();
                const carrier = document.querySelectorAll(".dateCountdown");
                const carrierPrice = document.querySelectorAll(".carrier-price");
                for (let i = 0; i < carrier.length; i++) {
                    switch (carrier[i].id) {
                        case correosExpID:   // Correos Express
                            supplier = '1';
                            break;

                        case feliuEspID:   // Feliubabalo Esp

                            if ((carrierPrice[i].innerText.slice(0, 4) == "8,90") || (carrierPrice[i].innerText.slice(0, 4) == "7,35") || (carrierPrice[i].innerText.slice(0, 4) == "2,95")) // Feliubadalo & Distribudiet urgente
                            {
                                supplier = '1';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "7,90") || (carrierPrice[i].innerText.slice(0, 4) == "6,15")) // Feliubadalo & Distribudiet estandar
                            {
                                supplier = '4';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "7,65") || (carrierPrice[i].innerText.slice(0, 4) == "5,90")) // Feliubadalo & Distribudiet correos
                            {
                                supplier = '5';
                            }
                            else {
                                supplier = '4';
                            }
                            break;

                        case feliuBcnID:    // Super-Urgente Feliubadalo Bcn
                            if ((carrierPrice[i].innerText.slice(0, 4) == "7,20") || (carrierPrice[i].innerText.slice(0, 4) == "3,95") || (carrierPrice[i].innerText.slice(0, 4) == "2,95")) // Feliubadalo & Distribudiet urgente
                            {
                                supplier = '1';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "6,20") || (carrierPrice[i].innerText.slice(0, 4) == "2,75")) // Feliubadalo & Distribudiet estandar
                            {
                                supplier = '4';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "5,95") || (carrierPrice[i].innerText.slice(0, 4) == "5,20")) // Feliubadalo & Distribudiet oficina 
                            {
                                supplier = '5';
                            }
                            else {
                                supplier = '2';
                            }
                            break;

                        case feliuCatID:    // Feliubadalo dia siguiente Cat
                            if ((carrierPrice[i].innerText.slice(0, 4) == "8,10") || (carrierPrice[i].innerText.slice(0, 4) == "6,55") || (carrierPrice[i].innerText.slice(0, 4) == "2,95")) // Feliubadalo & Distribudiet urgente
                            {
                                supplier = '1';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "7,10") || (carrierPrice[i].innerText.slice(0, 4) == "5,35")) // Feliubadalo & Distribudiet estandar
                            {
                                supplier = '4';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "6,85") || (carrierPrice[i].innerText.slice(0, 4) == "5,10")) // Feliubadalo & Distribudiet correos
                            {
                                supplier = '5';
                            }
                            else {
                                supplier = '3';
                            }
                            break;

                        case correosEstID:      // Correos estandar
                            supplier = '4';
                            break;

                        case oficinaCorreosID:  // Oficina Correos
                            supplier = '5';
                            break;
                        case puntoRecogidaID:   // Punto de recogida en oficina Barcelona
                            supplier = '6';
                            break;
                        default:
                            supplier = '4';
                            break;
                    }
                    countdown(supplier, i);
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


        /*  countdown ==> Esta función calcula el tiempo estimado de entrega para cada transportista.
            * @supp --> Contiene el ID del proveedor o del transportista.
            * @carrier --> Contiene el ID del transportista cuando hay varios en la misma página (en el Paso 3 del checkout). Por defecto es 0.
         */
        function countdown(supp, carrier = 0) {

            const countdownMsg = document.getElementById('countdown'); // Elemento HTML que contiene el mensaje del Countdown

            let currentDate = new Date();               // Fecha actual
            let maxDate = new Date();                   // Hora límite para pasar el pedido y que se prepare el mismo día
            let shippingDays;                           // Número de días a añadir a la fecha actual hasta llegar a la fecha de entrega
            let today = false,                          // Booleanos que indican si el paquete se entrega hoy o mañana, para añadirlo al mensaje.
                tomorrow = false;
            let isBeforeMaxDate = false;                // Booleano que indica si el pedido se prepara el mismo día o no, dependiendo de la hora límite (@maxDate).

            const hollidays = [     // Lista con los días festivos. El mes va de 0 (Enero) a 11 (Diciembre).
              // Días fijos todos los años:
                [1, 0, 'Año Nuevo'],
                [6, 0, 'Epifanía del Señor'],
                [1, 4, 'Fiesta del trabajo'],
                [15, 7, 'Asunción de la Virgen'],
                [12, 9, 'Fiesta Nacional de España'],
                [1, 10, 'Todos los Santos'],
                [6, 11, 'Día de la Constitución española'],
                [8, 11, 'Immaculada Concepción'],
                [25, 11, 'Navidad']

              // Días variables:

            ];
            let hollidaysInUse = []; // Lista con los días festivos que afectan a la fecha de entrega actual.

            const weekDay = [     // Array con los días de la semana para pasar de un número a string
                "domingo",   // 0
                "lunes",     // 1
                "martes",    // 2
                "miércoles", // 3
                "jueves",    // 4
                "viernes",   // 5
                "sábado"     // 6
            ];

            const monthName = [     // Array con los meses para pasar de un número a string
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
                "Diciembre"     // 11
            ];


            shippingDays = getShippingDays();

            let deliveryDateMillisec = calculateDeliveryDate(shippingDays); // Fecha de entrega del pedido en milisegundos
            let deliveryDate = new Date(deliveryDateMillisec);              // Fecha de entrega del pedido en formato Date()

            showDeliveryDate(); // Muestra por pantalla la fecha de entrega.

            if (prestashop.page.page_name != 'checkout') // Todas las páginas menos el checkout
            {
                showRemainingTime();                       // Calcula el tiempo restante y lo muestra por pantalla una vez, para no tener que esperar los 30 segundos del intervalo.
                setInterval(showRemainingTime(), 30000);   // Calcula el tiempo restante y lo muestra por pantalla cada 30 segundos.

                if (hollidaysInUse.length != 0) {
                    showHollidayMsg(); // Muestra por pantalla el mensaje de días festivos si es necesario.
                }
            }
            else // Checkout
            {
                console.log('checkout true, carrier: ' + carrier); // TEST

                const dateCheckoutMsg = document.getElementsByClassName('dateCountdown')[carrier]; // Selecciona el elemento HTML correspondiente al transportista actual
                if (dateCheckoutMsg.id == puntoRecogidaID)      // Si el transportista es Punto de recogida
                {
                    let additionalMsg = '<p style="margin-top: 0.3rem;"><a href="#" id="btn-toggle-info_' + dateCheckoutMsg.id + '"><i class="material-icons add">add_circle</i><i class="material-icons remove" style="display:none;">remove_circle</i> Información</a></p><p id="more-info_' + dateCheckoutMsg.id + '">Recibirás un correo cuando tu pedido esté listo para su recogida en <a href="https://goo.gl/maps/oSXTrW7uB7rRcEBf8" target="_blank" rel="nofollow noopener noreferrer">Calle Putget 78, 1º A, 08023 Barcelona</a>.</p>';
                    showCarrierInfoCheckout(dateCheckoutMsg, additionalMsg, dateCheckoutMsg.id);
                }
                else if (dateCheckoutMsg.id == oficinaCorreosID) // Si el transportista es Oficina de Correos
                {
                    let additionalMsg = '<p style="margin-top: 0.3rem;"><a href="#" id="btn-toggle-info_' + dateCheckoutMsg.id + '"><i class="material-icons add">add_circle</i><i class="material-icons remove" style="display:none;">remove_circle</i> Información</a></p><p id="more-info_' + dateCheckoutMsg.id + '">Por defecto, se enviará tu pedido a la oficina de Correos más cercana a la dirección introducida en el paso anterior. Puedes añadir un comentario al pedido si prefieres que lo enviemos a otra oficina.</p>';
                    showCarrierInfoCheckout(dateCheckoutMsg, additionalMsg, dateCheckoutMsg.id);
                }
            }


            /******* Functions COUNTDOWN *******
        
                * isWeekend(miliseconds) ==> Devuelve TRUE si es fin de semana (sábado o domingo), en cualquier otro caso devuelve FALSE.
                * isHolliday(miliseconds) ==> Devuelve TRUE si es un día festivo, FALSE si no lo es.
                * getShippingDays(supp) ==> Devuelve el nº de días (@nDays) que hay que añadir a la fecha actual, dependiendo del proveedor y transportista.
                * calculateDeliveryDate(number) ==> Calcula la fecha de entrega estimada. @nDays es el nº de días a añadir a la fecha actual hasta llegar a la fecha de entrega (dependiendo del transportista).
                * addMillisecondsDay() ==> Devuelve los milisegundos que hay en un día.
                * showRemainingTime() ==> Calcula el tiempo restante para pasar el pedido y que se prepare el mismo día. Añade el resultado a un elemento HTML.
                * showDeliveryDate() ==> Añade la fecha de entrega a un elemento HTML.
                * showHollidayMsg() ==> Muestra un mensaje con los días festivos que afectan a la fecha de entrega.
                * showCarrierInfoCheckout(HTML element, string, number) ==> Muestra información adicional en determinados transportistas en el checkout

            **************************/


            function isWeekend(milliseconds) { // Devuelve TRUE si es fin de semana (sábado o domingo), en cualquier otro caso devuelve FALSE
                const day = new Date(milliseconds).getDay();
                return ((day == 6) || (day == 0));
            }


            function isHolliday(milliseconds) { // Devuelve TRUE si es un día festivo, FALSE si no lo es

                const date = new Date(milliseconds);
                const checkHolliday = (holliday) => { // Función que devuelve un booleano indicando si la fecha actual coincide con alguno de los días festivos.
                    if ((date.getDate() == holliday[0]) && (date.getMonth() == holliday[1])) // Comprueba si coinciden el día (holliday[0]) Y el mes (holliday[1]).
                    {
                        hollidaysInUse.push(holliday);  // Añade esta fecha a los días festivos en uso.
                        return true;
                    }
                    else {
                        return false;
                    }
                };

                return hollidays.some(checkHolliday);

            }


            function getShippingDays() // Devuelve el nº de días que hay que añadir a la fecha actual, dependiendo del proveedor y transportista
            {
                let shippingDays;

                switch (supp)   // Asigna el número de días 'shippingDays' en función del transportista y/o proveedor
                {
                    case '0': 
                    case distribudietID:   // Distribudiet - Correos Express
                        maxDate.setHours(16, 0, 0);

                        if (currentDate < maxDate) { // Antes de la hora límite
                            shippingDays = 1;
                            isBeforeMaxDate = true;
                        }
                        else                        // Después de la hora límite
                        {
                            shippingDays = 2;
                        }

                        break;

                    case feliubadaloID:  // Feliubadaló BCN
                    case '6':            // Punto de recogida oficina Barcelona
                        maxDate.setHours(12, 30, 0);

                        if (currentDate < maxDate) {
                            shippingDays = 0;
                            isBeforeMaxDate = true;
                        }
                        else {
                            shippingDays = 1;
                        }

                        break;

                    case '3':    // Feliubadaló CAT
                        maxDate.setHours(18, 0, 0);

                        if (currentDate < maxDate) {
                            shippingDays = 1;
                            isBeforeMaxDate = true;
                        }
                        else {
                            shippingDays = 2;
                        }

                        break;

                    case '4':   // Correos Estándar
                    case '5':   // Oficina Correos
                        maxDate.setHours(18, 0, 0);

                        if (currentDate < maxDate)  // Antes de la hora límite      
                        {
                            shippingDays = 2;
                            isBeforeMaxDate = true;
                        }
                        else          // Después de la hora límite
                        {
                            shippingDays = 3;
                        }

                        break;

                    default:
                        maxDate.setHours(16, 0, 0);
                        shippingDays = 2;
                        break;
                }

                return shippingDays;
            }

            /**  caculateDeliveryDate ==> Esta función calcula la fecha de entrega estimada
                * @nDays --> Número de días a añadir a la fecha actual para llegar a la fecha de entrega prevista.
            */
            function calculateDeliveryDate(nDays) {
                let deliveryDateMillisec = new Date().getTime();
                let count = 0;  // Contador para saber el nº de días que pasan desde la fecha actual y la fecha de entrega. Si es 1, today = TRUE, si es 2, tomorrow = TRUE.

                while (nDays > 0) {
                    deliveryDateMillisec += addMillisecondsDay();

                    if (!(isWeekend(deliveryDateMillisec)) && !(isHolliday(deliveryDateMillisec))) {
                        nDays--;
                    }
                    count++;
                }

                if (count == 0) {
                    today = true;
                }
                else if (count == 1) {
                    tomorrow = true;
                }

                if (!isBeforeMaxDate) { // Si ya ha pasado la hora límite añadimos un día a la fecha máxima para pasar pedido. Se usa para calcular la cuenta atrás (countdown).
                    maxDate = maxDate.getTime() + addMillisecondsDay();
                }
                
                count = 0; // Resetea el contador a 0 por si hay que calcular varias fechas de entrega

                return deliveryDateMillisec;
            }

            function addMillisecondsDay() // Devuelve los milisegundos que hay en un día
            {
                return (1 * 24 * 60 * 60 * 1000); // Días * horas * minutos * segundos * milisegundos
            }

            function showRemainingTime() {
                currentDate = new Date();   // Fecha actual

                let minsLeft = Math.floor((maxDate - currentDate) / (60 * 1000));     // Minutos totales que hay entre la fecha límite y la fecha actual
                let hoursLeft = Math.floor(minsLeft / 60);                            // Horas restantes antes de el tiempo límite
                minsLeft %= 60;                                                       // Minutos restantes antes de el tiempo límite, teniendo en cuenta las horas restantes

                if (hoursLeft === 0) {
                    countdownMsg.innerHTML = minsLeft + ((minsLeft == 1) ? ' minuto' : ' minutos');
                }
                else {
                    countdownMsg.innerHTML = hoursLeft + ((hoursLeft == 1) ? ' hr ' : ' hrs ') + minsLeft + ((minsLeft == 1) ? ' min' : ' mins');
                }
            }

            function showDeliveryDate() {
                const dateMsg = document.getElementsByClassName('dateCountdown')[carrier];
                const day = weekDay[deliveryDate.getDay()];
                const date = deliveryDate.getDate();
                const month = monthName[deliveryDate.getMonth()];

                if (today)          // Si el pedido se entrega hoy
                {
                    dateMsg.innerHTML = ' hoy, ' + day + ' ' + date + ' de ' + month + '.';
                }
                else if (tomorrow)  // Si el pedido se entrega mañana
                {
                    dateMsg.innerHTML = ' mañana, ' + day + ' ' + date + ' de ' + month + '.';
                }
                else                // Si no se entrega ni hoy ni mañana
                {
                    dateMsg.innerHTML = ' el ' + day + ', ' + date + ' de ' + month + '.';
                }
            }

            function showHollidayMsg() {
                const hollidayDate = document.getElementById('holliday-date');
                const hollidayName = document.getElementById('holliday-name');
                

                hollidaysInUse.forEach( (holliday, index) => {

                    if (index == 0) // Si es el primer día festivo
                    {
                        hollidayDate.innerHTML = holliday[0] + ' de ' + monthName[holliday[1]]; // @Dia de @Mes TODO: Poner nombre del mes en vez de numero
                        hollidayName.innerHTML = holliday[2]; // @NombreDiaFestivo
                    }
                    else // Si hay más de un día festivo que afecta a la fecha de entrega actual
                    {
                        const dateHTML = '<b id="holliday-date">' + holliday[0] + 'de' + monthName[holliday[1]] + '</b>'; // String con la fecha del día festivo ( @Dia de @Mes ) en formato HTML.
                        const nameHTML = '<i id="holliday-name">' + holliday[2] + '</i>'; // String con el nombre del día festivo en formato HTML.

                        hollidayName.outerHTML += ' y el ' + dateHTML + ' es ' + nameHTML; // Añade otro día festivo al lado del anterior festivo.
                    }

                });

            }

            function showCarrierInfoCheckout(currentMsg, additionalInfo, carrierID) {
                currentMsg.innerHTML += additionalInfo;

                $(document).on('click', '#btn-toggle-info_' + carrierID, function () {
                    $('#more-info_' + carrierID).slideToggle();
                    $('#btn-toggle-info_' + carrierID + ' i').toggle();
                    return false;
                })
            }


            /***** END functions countdown *****/

        } // END countdown()



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

        function stickyThings() {
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

        function changeStyleBlogFooter() {
            $('.home_blog_post_area.displayFooterBefore').parents('.container').addClass('blog-footer')
        }

        function stickyAddToCart() { // TODO (Mirar Media markt mobile)
        }

        // NEXT function


        function serviceWorker() // Registrar service worker [NO SE ESTÁ USANDO ACTUALMENTE]
        {
            if ('serviceWorker' in navigator) {
                window.addEventListener('load', function () {
                    navigator.serviceWorker.register('/OneSignalSDKWorker.js').then(function (registration) {
                        console.log('ServiceWorker registration successful with scope: ', registration.scope);
                    }, function (err) {
                        console.log('ServiceWorker registration failed: ', err);
                    });
                });
            }
        }


    }); /**End doc.Ready**/

})();
