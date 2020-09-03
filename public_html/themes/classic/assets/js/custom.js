(function () {

    $(document).ready(function () {

        const isMobile = /Android|webOS|iPhone|iPad|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

        // Carrier ID (Cambiar cada vez que se actualicen los ajustes de un transportista)
        // TODO: Mirar una forma de no tener que actualizarlo cada vez (id_reference_carrier en vez de id_carrier)
        const correosExpID = '177';
        const correosEstID = '175';
        const oficinaCorreosID = '176';
        const feliuBcnID = '142';
        const feliuCatID = '144';
        const feliuEspID = '146';
        const puntoRecogidaID = '149';
        const correosExpIntID = '169';
        const tipsaID = '172';

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
                    || ($("#product-details").data("product").availability == 'last_remaining_items'))  {
                    const supplier = $("#product-details").data("product").id_supplier;
                    countdown(supplier);
                    if (supplier == '2') {
                        document.getElementsByClassName("avisoFB")[0].style.display = 'block';
                    }
                }
                
                break;

            case 'cart': // TODO: Buscar una mejor forma de detectar el transportista
                if ((prestashop.cart.subtotals.shipping.amount == 2.70) || (prestashop.cart.subtotals.shipping.amount == 3.60)
                    || (prestashop.cart.subtotals.shipping.amount == 2.60) || (prestashop.cart.subtotals.shipping.amount == 3.40)
                    || (prestashop.cart.subtotals.shipping.amount == 2.40)) {
                    supplier = '2';
                }
                countdown(supplier);
                loadingAnimation(".remove-from-cart")
                break;

            case 'checkout':
                socialLogin();
                loadingAnimation("button[name='confirmDeliveryOption']");
                const carrier = document.querySelectorAll(".dateCountdown");
                const carrierPrice = document.querySelectorAll(".carrier-price");
                for (let i = 0; i < carrier.length; i++) {
                    switch (carrier[i].id) {
                        case correosExpID:   // Correos Express
                        case tipsaID:        // Tipsa
                            supplier = '1';
                            break;

                        case feliuEspID:   // Feliubabalo Esp

                            if ((carrierPrice[i].innerText.slice(0, 4) == "8,90") || (carrierPrice[i].innerText.slice(0, 4) == "7,15") || (carrierPrice[i].innerText.slice(0, 4) == "2,50")) // Feliubadalo & Distribudiet urgente
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
                            if ((carrierPrice[i].innerText.slice(0, 4) == "7,20") || (carrierPrice[i].innerText.slice(0, 4) == "3,75") || (carrierPrice[i].innerText.slice(0, 4) == "2,50")) // Feliubadalo & Distribudiet urgente
                            {
                                supplier = '1';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "6,20") || (carrierPrice[i].innerText.slice(0, 4) == "2,75")) // Feliubadalo & Distribudiet estandar
                            {
                                supplier = '4';
                            }
                            else if ((carrierPrice[i].innerText.slice(0, 4) == "5,95") || (carrierPrice[i].innerText.slice(0, 4) == "2,50")) // Feliubadalo & Distribudiet oficina 
                            {
                                supplier = '5';
                            }
                            else {
                                supplier = '2';
                            }
                            break;

                        case feliuCatID:    // Feliubadalo dia siguiente Cat
                            if ((carrierPrice[i].innerText.slice(0, 4) == "8,10") || (carrierPrice[i].innerText.slice(0, 4) == "6,35") || (carrierPrice[i].innerText.slice(0, 4) == "2,50")) // Feliubadalo & Distribudiet urgente
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
                        case correosExpIntID:   // Correos Express Internacional
                            supplier = '7';
                            break;
                        default:
                            supplier = '4';
                            break;
                    }
                    countdown(supplier, i);
                }
                break;

            case 'cms':
                const isFAQ = document.getElementsByClassName('page-cms-12').length;
                if (isFAQ) {
                    faq();
                }
                break;
            
            default:
                break;
        }

        /* Functions to execute on ALL PAGES */

        addToCartBtnEffects();
        
        changeStyleBlogFooter()

        hideCookies();

        // serviceWorker();


        /*  countdown ==> Esta funcion calcula el tiempo estimado de entrega para cada transportista.
            * @supp --> Contiene el ID del proveedor o del transportista.
            * @carrier --> Contiene el ID del transportista cuando hay varios en la misma pagina (en el Paso 3 del checkout). Por defecto es 0.
         */
        function countdown(supp, carrier = 0) { // TODO: Sabado y domingo por la tarde la fecha de entrega sale un dia mas (miercoles en vez de martes).

            const countdownMsg = document.getElementById('countdown'); // Elemento HTML que contiene el mensaje del Countdown

            let currentDate = new Date();               // Fecha actual
            let maxDate = new Date();                   // Hora limite para pasar el pedido y que se prepare el mismo dia
            let today = false,                          // Booleanos que indican si el paquete se entrega hoy o mañana, para añadirlo al mensaje.
                tomorrow = false;
            let isBeforeMaxDate = false;                // Booleano que indica si el pedido se prepara el mismo dia o no, dependiendo de la hora limite (@maxDate).

            const hollidays = [     // Lista con los dias festivos. El mes va de 0 (Enero) a 11 (Diciembre).
              // Dias fijos todos los años:
                [1, 0, 'Año Nuevo'],
                [6, 0, 'Reyes Magos'],
                [1, 4, 'Fiesta del trabajo'],
                [15, 7, 'Asunción de la Virgen'],
                [12, 9, 'Fiesta Nacional de España'],
                [1, 10, 'Todos los Santos'],
                [6, 11, 'Día de la Constitución española'],
                [8, 11, 'Immaculada Concepción'],
                [25, 11, 'Navidad']

              // Dias variables: (TODO)
              // Por ej: Primer jueves de Abril 

            ];
            let hollidaysInUse = []; // Lista con los dias festivos que afectan a la fecha de entrega actual.

            const weekDay = [     // Array con los dias de la semana para pasar de un numero a string
                "domingo",   // 0
                "lunes",     // 1
                "martes",    // 2
                "miércoles", // 3
                "jueves",    // 4
                "viernes",   // 5
                "sábado"     // 6
            ];

            const monthName = [     // Array con los meses para pasar de un numero a string
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


            let shippingDays = getShippingDays();   // Numero de dias a añadir a la fecha actual hasta llegar a la fecha de entrega

            let deliveryDateMillisec = calculateDeliveryDate(shippingDays); // Fecha de entrega del pedido en milisegundos
            let deliveryDate = new Date(deliveryDateMillisec);              // Fecha de entrega del pedido en formato Date()

            showDeliveryDate(); // Muestra por pantalla la fecha de entrega.

            if (prestashop.page.page_name != 'checkout') // Todas las paginas menos el checkout
            {
                showRemainingTime();                       // Calcula el tiempo restante y lo muestra por pantalla una vez, para no tener que esperar los 30 segundos del intervalo.
                setInterval(showRemainingTime, 30000);   // Calcula el tiempo restante y lo muestra por pantalla cada 30 segundos.

                if (hollidaysInUse.length != 0) {
                    showHollidayMsg(); // Muestra por pantalla el mensaje de dias festivos si es necesario.
                }
            }
            else // Checkout
            {
                const carrierID = document.getElementsByClassName('dateCountdown')[carrier].id;

                if (carrierID == oficinaCorreosID) // Si el transportista es Oficina de Correos
                {
                    let additionalMsg = '<p style="margin-top: 0.3rem;"><a href="#" id="btn-toggle-info_' + carrierID + '"><i class="material-icons add">add_circle</i><i class="material-icons remove" style="display:none;">remove_circle</i> Informaci&oacute;n</a></p><p id="more-info_' + carrierID + '">Por defecto, se enviar&aacute; tu pedido a la <a href="https://www.correos.es/ss/Satellite/site/aplicacion-1349167812848-herramientas_y_apps/detalle_app-sidioma=es_ES" rel="noopener noreferrer" target="_blank">Oficina de Correos</a> m&aacute;s cercana a la direcci&oacute;n introducida en el paso anterior. Puedes a&ntilde;adir un comentario al pedido si prefieres que lo enviemos a una oficina espec&iacute;fica.</p>';
                    showCarrierInfoCheckout(carrierID, additionalMsg);
                }
                else if (carrierID == puntoRecogidaID) // Si el transportista es Punto de recogida
                {
                    let additionalMsg = '<p style="margin-top: 0.3rem;"><a href="#" id="btn-toggle-info_' + carrierID + '"><i class="material-icons add">add_circle</i><i class="material-icons remove" style="display:none;">remove_circle</i> Informaci&oacute;n</a></p><p id="more-info_' + carrierID + '">Recibir&aacute;s un correo cuando tu pedido est&eacute; listo para su recogida en <a href="https://goo.gl/maps/oSXTrW7uB7rRcEBf8" target="_blank" rel="nofollow noopener noreferrer">Calle Putget 78, 08023 Barcelona</a>.</p>';
                    showCarrierInfoCheckout(carrierID, additionalMsg);
                }
                // else if (carrierID == correosExpID) // Si el transportista es Correos Express
                // {
                //     let additionalMsg = '<p style="margin-top: 0.3rem;"><a href="#" id="btn-toggle-info_' + carrierID + '"><i class="material-icons add">add_circle</i><i class="material-icons remove" style="display:none;">remove_circle</i> Informaci&oacute;n</a></p><p id="more-info_' + carrierID + '">Correos Express ha activado el protocolo <b>Entregas seguras sin contacto</b> para garantizar la seguridad de clientes y repartidores. Se llevará a cabo una correcta higiene de las manos antes, durante y después del reparto. El paquete se depositará en el suelo antes de llamar al timbre y se identificará al cliente con el DNI en vez de con la firma digital, manteniendo en todo momento una distancia de 2 metros.</p>';
                //     showCarrierInfoCheckout(carrierID, additionalMsg);
                // }
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
                * showCarrierInfoCheckout(number, string) ==> Muestra información adicional en determinados transportistas en el checkout. @carrierID, @additionalMsg.

            **************************/


            function isWeekend(milliseconds) { // Devuelve TRUE si es fin de semana (sábado o domingo), en cualquier otro caso devuelve FALSE
                const day = new Date(milliseconds).getDay();
                return ((day == 6) || (day == 0));
            }


            function isHolliday(milliseconds) { // Devuelve TRUE si es un dia festivo (y lo añade a la lista @hollidaysInUse), FALSE si no lo es

                const date = new Date(milliseconds);
                const checkHolliday = (holliday) => { // Funcion que devuelve un booleano indicando si la fecha actual coincide con alguno de los dias festivos.
                    if ((date.getDate() == holliday[0]) && (date.getMonth() == holliday[1])) // Comprueba si coinciden el dia (holliday[0]) Y el mes (holliday[1]).
                    {
                        for (let i = 0; i < hollidaysInUse.length; i++) {
                            if ((hollidaysInUse[i][0] == holliday[0]) && (hollidaysInUse[i][1] == holliday[1])) { // Comprueba que no haya sido añadido anteriormente este festivo
                                return true;
                            }
                        }
                        hollidaysInUse.push(holliday);  // Añade esta fecha a los dias festivos en uso.
                        return true;
                    }
                    else {
                        return false;
                    }
                };

                return hollidays.some(checkHolliday);

            }


            function getShippingDays() // Devuelve el nº de dias que hay que añadir a la fecha actual, dependiendo del proveedor y transportista
            {
                let shippingDays;

                switch (supp)   // Asigna el numero de dias 'shippingDays' en funcion del transportista y/o proveedor
                {
                    case '0': 
                    case distribudietID:   // Distribudiet - Correos Express
                        // maxDate.setHours(14, 0, 0);
                        maxDate.setHours(12, 30, 0); // Horario verano
                        shippingDays = 1;

                        if (currentDate < maxDate) { // Antes de la hora limite
                            isBeforeMaxDate = true;
                        }

                        break;

                    case feliubadaloID:  // Feliubadalo BCN
                    case '6':            // Punto de recogida oficina Barcelona
                        maxDate.setHours(12, 30, 0);
                        shippingDays = 0;

                        if (currentDate < maxDate) {
                            isBeforeMaxDate = true;
                        }

                        break;

                    case '3':    // Feliubadalo CAT
                        maxDate.setHours(18, 0, 0);
                        shippingDays = 1;

                        if (currentDate < maxDate) {
                            isBeforeMaxDate = true;
                        }

                        break;

                    case '4':   // Correos Estandar
                    case '5':   // Oficina Correos
                        // maxDate.setHours(17, 30, 0);
                        maxDate.setHours(12, 30, 0); // Horario verano
                        shippingDays = 2;

                        if (currentDate < maxDate)  // Antes de la hora limite      
                        {
                            isBeforeMaxDate = true;
                        }

                        break;
                    case '7': // TODO
                    default:
                        // maxDate.setHours(14, 0, 0);
                        maxDate.setHours(12, 30, 0); // Horario verano
                        shippingDays = 2;
                        break;
                }

                if ( (isBeforeMaxDate) &&  (isWeekend(currentDate.getTime()) || isHolliday(currentDate.getTime())) ) {
                    isBeforeMaxDate = false;
                }

                return shippingDays;
            }

            /**  caculateDeliveryDate ==> Esta funcion calcula la fecha de entrega estimada
                * @nDays --> Numero de dias a añadir a la fecha actual para llegar a la fecha de entrega prevista.
            */
            function calculateDeliveryDate(nDays) {
                let deliveryDateMillisec = new Date().getTime();
                let count = 0;  // Contador para saber el nº de dias que pasan desde la fecha actual y la fecha de entrega. Si es 1, today = TRUE, si es 2, tomorrow = TRUE.
                let lastDay; // Booleano para saber si hay que añadir mas dias a la fecha de entrega o si es el ultimo dia

                maxDate = maxDate.getTime(); // Fecha limite en milisegundos

                if (!isBeforeMaxDate) { // Si ya ha pasado la hora limite añadimos un dia a la fecha maxima para pasar pedido. Se usa para calcular la cuenta atras (countdown).
                    maxDate += addMillisecondsDay();
                    deliveryDateMillisec += addMillisecondsDay();
                    count++;
                }

                // console.log('DeliveryDate BEFORE while: ' + new Date(deliveryDateMillisec)); // TEST
                // console.log('Max date BEFORE while: ' + new Date(maxDate)); // TEST
                // console.log('count BEFORE  while: ' + count); // TEST
                // console.log('nDays BEFORE while: ' + nDays); // TEST
                // console.log('------------ BEGINING WHILE -----------'); // TEST

                while (nDays > 0) { // TODO: Cuando nDays==0 y es festivo se añade un dia de mas

                    // console.log('count begining while: ' + count); // TEST
                    // console.log('nDays begining while: ' + nDays); // TEST

                    if ((isWeekend(deliveryDateMillisec)) || (isHolliday(deliveryDateMillisec))) { // Comprueba si la fecha de entrega es fin de semana o festivo

                        // console.log('deliveryDate is weekend OR isHolliday: TRUE : ' + new Date(deliveryDateMillisec)); // TEST

                        if ((isWeekend(maxDate)) || (isHolliday(maxDate))) {  // Comprueba si la fecha maxima para pasar el pedido es fin de semana o festivo
                            maxDate += addMillisecondsDay();
                        }
                    }
                    else {
                        nDays--;
                    }

                    if (lastDay) {
                        nDays--;
                    }
                    else {
                        deliveryDateMillisec += addMillisecondsDay();
                        count++;
                    }

                    if ((nDays == 0) && ((isWeekend(deliveryDateMillisec)) || (isHolliday(deliveryDateMillisec)))) {

                        // console.log('nDays == 0 AND deliveryDate isWeekend OR isHolliday : ' + new Date(deliveryDateMillisec)); // TEST
                        
                        deliveryDateMillisec += addMillisecondsDay();
                        lastDay = true;
                        
                        // console.log('lastDay = TRUE ' + new Date(deliveryDateMillisec)); // TEST
                        
                        nDays++;
                        count++;
                    }
                    else {
                        lastDay = false;
                    }

                    // console.log('lastDay = ' + lastDay); // TEST
                    // console.log('DeliveryDate: ' + new Date(deliveryDateMillisec)); // TEST
                    // console.log('count END  while: ' + count); // TEST
                    // console.log('nDays END while: ' + nDays); // TEST
                    // console.log(' ----------- END WHILE ------------'); // TEST
                }

                if (count == 0) {
                    today = true;
                }
                else if (count == 1) {
                    tomorrow = true;
                }

                return deliveryDateMillisec;
            }

            function addMillisecondsDay() // Devuelve los milisegundos que hay en un dia
            {
                return (1 * 24 * 60 * 60 * 1000); // Dias * horas * minutos * segundos * milisegundos
            }

            function showRemainingTime() {
                currentDate = new Date();   // Fecha actual

                let minsLeft = Math.floor((maxDate - currentDate) / (60 * 1000));     // Minutos totales que hay entre la fecha limite y la fecha actual
                let hoursLeft = Math.floor(minsLeft / 60);                            // Horas restantes antes de el tiempo limite
                minsLeft %= 60;                                                       // Minutos restantes antes de el tiempo limite, teniendo en cuenta las horas restantes

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
                    dateMsg.innerHTML = ' ma&ntilde;ana, ' + day + ' ' + date + ' de ' + month + '.';
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

                    if (index == 0) // Si es el primer dia festivo
                    {
                        hollidayDate.innerHTML = holliday[0] + ' de ' + monthName[holliday[1]]; // @Dia de @Mes
                        hollidayName.innerHTML = holliday[2]; // @NombreDiaFestivo
                    }
                    else // Si hay mas de un dia festivo que afecta a la fecha de entrega actual
                    {
                        const dateHTML = '<b id="holliday-date">' + holliday[0] + ' de ' + monthName[holliday[1]] + '</b>'; // String con la fecha del dia festivo ( @Dia de @Mes ) en formato HTML.
                        const nameHTML = '<i id="holliday-name">' + holliday[2] + '</i>'; // String con el nombre del dia festivo en formato HTML.

                        hollidayName.outerHTML += ' y el ' + dateHTML + ' es ' + nameHTML; // Añade otro dia festivo al lado del anterior festivo.
                    }

                });

                document.getElementsByClassName('holliday-message')[0].style.display = 'block';

            }

            function showCarrierInfoCheckout(carrierID, additionalInfo) {

                document.getElementById('additional-msg_' + carrierID).innerHTML += additionalInfo;

                $(document).on('click', '#btn-toggle-info_' + carrierID, function () {
                    $('#more-info_' + carrierID).slideToggle();
                    $('#btn-toggle-info_' + carrierID + ' i').toggle();
                    return false;
                })
            }


            /***** END functions countdown *****/

        } // END countdown()



        function addToCartBtnEffects() // Efecto tracking en el boton añadir al carrito al pasar el raton por encima
        {
            const buttons = document.querySelectorAll('.add-to-cart');

            buttons.forEach(btn => {
                btn.onmousemove = function(e) {
                    let x = e.pageX - btn.offsetLeft - btn.offsetParent.offsetLeft;
                    let y = e.pageY - btn.offsetTop - btn.offsetParent.offsetTop;
                    btn.style.setProperty('--x', x + 'px');
                    btn.style.setProperty('--y', y + 'px');
                }
                btn.onclick = function() {
                    btn.classList.add('loading');
                }
            });
        }

        function loadingAnimation($selector) { // Loading animation al hacer click en boton continuar del paso 3 del checkout (envio)

            $(document).on("click", $selector, function () {
                $(this).addClass("loading");
            });

            /* TODO: 
               * Añadir el mismo efecto a los pasos 1 y 2
               * Detectar cuando hay errores para quitar la animacion
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
                    if (SB.hasClass("active")) {
                        SB.removeClass("active");    
                    } 
                    else {
                        SB.addClass("active");
                        si.focus()
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
       
       
        function faq() {
            const items = document.querySelectorAll(".faq-item h2");

            items.forEach(item => 
                item.addEventListener('click', toggleAnswer)
            );

            function toggleAnswer(){
                this.classList.toggle('active');
                this.nextElementSibling.classList.toggle('active');
            }
        }


        function stickyAddToCart() { // TODO
        }

        // NEXT function


        function serviceWorker() // Registrar service worker [NO SE ESTA USANDO ACTUALMENTE]
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


    }); /** End doc.Ready **/

})();
