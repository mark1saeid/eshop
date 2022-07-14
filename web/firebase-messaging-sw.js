importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
  apiKey: "AIzaSyA0ulihnHA46KU3thJsAzHqOm2gMTdbfSw",
    authDomain: "eshop-a1.firebaseapp.com",
    databaseURL: "https://eshop-a1-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "eshop-a1",
    storageBucket: "eshop-a1.appspot.com",
    messagingSenderId: "1025713045592",
    appId: "1:1025713045592:web:e09d33859cda6bf78dca2d",
    measurementId: "G-78N1S092H1"
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});