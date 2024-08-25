$(function(){
	var actionContainer = $("#actionmenu");
	window.addEventListener('message',function(event){
		var item = event.data;
		
		if (item.action == 'input'){
			document.querySelector('body').style.display = 'block'
			document.querySelector('.input').value = item.data
		}
	});
})