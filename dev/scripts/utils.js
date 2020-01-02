function enableButton(id = '') {
    id.replace("#", '');

    let element = document.getElementById(id);
    element.classList.remove("disabled");
}

function disableButton(id) {
    id.replace("#", '');

    let element = document.getElementById(id);
    element.classList.add("disabled");
}

function showElement(id = "loading") {
    id = id.replace("#", '');

    let element = document.getElementById(id);
    element.classList.remove("hide");
}

function hideElement(id = "loading") {
    id = id.replace("#", '');

    let element = document.getElementById(id);
    element.classList.add("hide");
}

// function setActiveMenuItem(idMenu) {
//     let liElements = document.getElementsByTagName('li');

//     idMenu = idMenu.replace("#", '');
    
//     for (var i = 0; i < liElements.length; i++) {
//         liElements[i].classList.remove("active");
//     }

//     document.getElementById(idMenu).classList.add("active");
// }

function deactivateMenuItem() {
    let liElement = document.querySelector('li.active');
    if(liElement) liElement.classList.remove("active");

    let linkElement = document.querySelector('.collapse-item.active')
    if(linkElement) linkElement.classList.remove("active");
}

function activateMenuItem(element) {
    if(element) element.classList.add("active");
}

// Toastr
function configureToastr() {
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-bottom-right",
        "preventDuplicates": true,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
}

function isEmpty(str) {
    if(str)
        return str.trim().length === 0;

    return true;
}

// ************ File ***************

function hasFileAttached() {
    return fileUploader.files.length > 0;
}

function formatBytes(bytes, decimals = 2) {
    if(bytes == 0) return '0 Bytes';
 
     const k = 1024;
     const dm = decimals < 0 ? 0 : decimals;
     const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
 
     const i = Math.floor(Math.log(bytes) / Math.log(k));
 
     return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
 }
 
 function getExtensionFile(fileName) {
     if(!fileName) return '';
 
     return fileName.trim().substr(fileName.length - 3);  
 }

 function removeFileExtension(fileName) {
    if(hasExtensionFile)
        return fileName.substr(0, fileName.length - 4);
    
    return fileName;
 }

function hasExtensionFile(fileName) {
    const pattern = /\.\w{3}$/i;

    return pattern.test(fileName);
}

function removeFileInvalidChar(fileName){
    const pattern = /(\\|\/|\||\?|<|>|\*|:|")+/g;

    return fileName.trim().replace(pattern, "");
}

function generateSearchName(name) {
    const fullName = name.toLowerCase();
    return removeEspecialChar(removeAccents(fullName).replace(/ /gi,'').toLowerCase());
}

function removeEspecialChar(str) {
    if (!str || typeof str !== 'string') return '';

    str = str.replace(/[^\w\s]/gi, '');

    return str;
}

function removeAccents(str) {
    if (!str || typeof str !== 'string') return '';

    str = str
        .replace(/[ÁÀÂÃ]/g, 'A')
        .replace(/[ÉÈÊ]/g, 'E')
        .replace(/[ÍÌÎ]/g, 'I')
        .replace(/[ÓÒÔÕ]/g, 'O')
        .replace(/[ÚÙÛ]/g, 'U')
        .replace(/[Ç]/g, 'C')
        .replace(/[Ñ]/g, 'N')

        .replace(/[áàâã]/g, 'a')
        .replace(/[éèê]/g, 'e')
        .replace(/[íìî]/g, 'i')
        .replace(/[óòôõ]/g, 'o')
        .replace(/[úùû]/g, 'u')
        .replace(/[ç]/g, 'c')
        .replace(/[ñ]/g, 'n');

    return str;
}
