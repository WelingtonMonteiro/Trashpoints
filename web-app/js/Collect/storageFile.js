/**
 * Created by Welington on 13/03/2017.
 */
// Set the configuration for your app
    // Replace with your project's config object

var config = {
        apiKey: "AIzaSyBQb_m2US9GkFPBhBfqBpsI_UXMnwkSv7c",
        authDomain: "trashpoints-3fccf.firebaseapp.com",
        databaseURL: "https://trashpoints-3fccf.firebaseio.com",
        storageBucket: "trashpoints-3fccf.appspot.com",
        messagingSenderId: "307691409645"
    };
firebase.initializeApp(config);

// Get a reference to the storage service, which is used to create references in your storage bucket
var storage = firebase.storage();

// Create a storage reference from our storage service
var storageRef = storage.ref();

// Points to 'images'
var imagesRef = storageRef.child('images');
var fileName = '';
var uploadTask = '';

//File path is 'images/space.jpg'
var path = '';

// File name is 'space.jpg'
var name = '';


// Points to 'images'
// var getImagesRef = spaceRef.parent;

// Create file metadata including the content type
var metadata = {
    contentType: 'image/jpeg',
};


function uploadImage(file, cb) {

    if(!file) return cb(null, null);
    // Points to 'images/space.jpg'
// Note that you can use variables to create child values
    fileName = generateUUID() + '.jpg';
    uploadTask = imagesRef.child(fileName).put(file, metadata);

// File path is 'images/space.jpg'
     path = uploadTask.fullPath;
// File name is 'space.jpg'
     name = uploadTask.name;

    // uploadTask.put(file, metadata)

    onStatesUploads(cb)

}

function onStatesUploads(cb){
    // Register three observers:
// 1. 'state_changed' observer, called any time the state changes
// 2. Error observer, called on failure
// 3. Completion observer, called on successful completion
// Listen for state changes, errors, and completion of the upload.
    uploadTask.on('state_changed', onStateChange, onErrorUpload, onSuccessUpload);

    function onSuccessUpload() {
        // Upload completed successfully, now we can get the download URL
        // var downloadURL = uploadTask.snapshot.downloadURL;
        $('#imageUploadUrl').attr( 'value',fileName);
        cb(null, fileName)
    }

    function onStateChange(snapshot) {
        // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
        var progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        console.log('Upload is ' + progress + '% done');

        switch (snapshot.state) {
            case 'paused':
                console.log('Upload is paused');
                break;
            case 'running':
                console.log('Upload is running');
                break;
        }
    }

    function onErrorUpload(error) {

        switch (error.code) {
            case 'storage/unauthorized':
                // User doesn't have permission to access the object
                cb('Usuário não tem permissão para acessar o arquivo.',null);
                break;

            case 'storage/canceled':
                // User canceled the upload
                cb('Usuário cancelou o upload.',null);
                break;

            case 'storage/unknown':
                // Unknown error occurred, inspect error.serverResponse
                cb('Erro desconhecido: ' + error.serverResponse ,null);
                break;
        }
    }
}


function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
    return uuid;
};