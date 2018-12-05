
var isEq = function(source, target){
    return source===target;
}

/**
 * Valida las funcionalidades requeridas por la aplicación que sean soportadas 
 * por el navegador web
 * @returns {undefined}
 */
var assertSuportBrowser = function(){
    
    // Valida si se puede enviar por ajax archivos
    if( typeof FormData !== 'undfined'){
        throw "Navegador no soporta envío de archivos por Ajax (FormData)";
    }
    
}