const OneSignal = require('onesignal-node');
const config = require('../load/load.env');

module.exports = {
    send
};


async function send(title, content, onesignal_playerids, is_shop) {   
    if(!onesignal_playerids || onesignal_playerids.length == 0) return;

    let appAuthKey = is_shop ? config.OneSignal.app_auth_key_shop : config.OneSignal.app_auth_key;
    let appId = is_shop ? config.OneSignal.app_id_shop : config.OneSignal.app_id;
    let client = new OneSignal.Client({
        app: { 
            appAuthKey: appAuthKey, 
            appId: appId 
        }    
    });  

    let onesignal_notification = new OneSignal.Notification({    
        headings:{
            en: title
        },
        contents: {    
            en: content
        }    
    });    
        
    onesignal_notification.postBody["include_player_ids"] = onesignal_playerids;
    try {
        await client.sendNotification(onesignal_notification);
    } catch (e) {
        console.error(e)
    }
}