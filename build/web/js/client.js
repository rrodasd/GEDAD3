var frameInvoker;
var typeOption;
var invokerDomain = 'https://dsp.reniec.gob.pe/refirma_invoker/invokerstatus.html';
//var invokerDomain = 'http://localhost:8080/refirma_invoker/invokerstatus.html';

window.onload = insertFrame;
function insertFrame() {
    alert("oooooo");
	if (document.getElementById('frameInvoker') == null){
		div = document.createElement('div');
	    div.innerHTML = 
	    	'<style type="text/css">\
		    	.invokerMain {position: fixed;top:0;left:0;right:0;bottom:0;z-index: 20000;overflow: hidden;background:transparent;display: none;}\
		    	.invokerScreen {position: absolute;width: 100% !important;height: 100%;z-index:10000;}\
		    </style>\
		    <div id="invoker" class="invokerMain">\
		    	<div class="invokerScreen">\
		    		<iframe id="frameInvoker" onload="onLoadFrame();" style="height:100%;width:100%; border:none;" src="#"></iframe> \
		    	</div>\
	    	</div>';    
	     document.getElementById('addComponent').appendChild(div);
	}    
//     <input type="button" value="-" onclick="removeRow()">
//     function removeRow(input) {
//	    document.getElementById('insertFrameInvoker').removeChild( input.parentNode );
//     }	
}

function initInvoker(srt){
     alert("initInvoker");
	typeOption=srt;
        alert("typeOption"+typeOption);
	document.getElementById('frameInvoker').setAttribute('src', invokerDomain);
         alert("llama a div id=invoker");
	document.getElementById('invoker').style.display = 'inline';		
}

function onLoadFrame(){	
     alert("llama al onLoadFrame");
	if (document.getElementById('frameInvoker').src === invokerDomain){		
		frameInvoker = document.getElementById('frameInvoker').contentWindow;		
		postMessageToFrame({init: typeOption});
	}    
}


function postMessageToFrame(message) {	
      alert("llama al postMessageToFrame"+message);
	frameInvoker.postMessage(message, '*');
}


window.addEventListener('message', function messageFromFrame(e){
     alert("y estoooo-----------"+e.data);
	message = e.data;
	if(message != null && message === 'getArguments'){			
		dispatchEventClient('getArguments', typeOption);
	}else if(message != null && message === 'invokerOk'){
		dispatchEventClient('invokerOk', typeOption);
	}else if(message != null && message === 'invokerCancel'){
		dispatchEventClient('invokerCancel', null);
	}else if(message != null && message === 'close'){
		document.getElementById('invoker').style.display = 'none';		
	}
        
       
});


function dispatchEventClient(e, data) {    
      alert("y aaaaahoraaaaa-->"+e+data);
	//No funciona en IE11
	//var evt = new CustomEvent(e, {detail: data});
    //window.dispatchEvent(evt);
	//
    params = {bubbles: false, cancelable: false, detail: data};
     alert("1");
	evt = document.createEvent('CustomEvent');
          alert("2"+evt);
	evt.initCustomEvent( e, params.bubbles, params.cancelable, params.detail );
          alert("3");
    CustomEvent.prototype = window.Event.prototype;
     alert("4");
    window.CustomEvent = CustomEvent;
     alert("5");
    window.dispatchEvent(evt);
    alert("6");
}


window.addEventListener('sendArguments', function (e) {  
     alert("y puede serrrrrrrr");
	message = {arguments: e.detail};    
	frameInvoker.postMessage(message, '*');
});


