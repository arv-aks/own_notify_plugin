package com.liberin.ownNotifyPlugin.own_notify

interface Definitions {

//    const CHANNEL_FLUTTER_PLUGIN = 'own_notify';
//    val CHANNEL_FLUTTER_PLUGIN="own_notify";
//    const CHANNEL_METHOD_SHOW_SOME_DATA = "show_some_data";
//    const CHANNEL_METHOD_SHOW_PLATFROM_VERSION = "show_platform_version";

    companion object{
        const val CHANNEL_FLUTTER_PLUGIN="own_notify"
        const val  CHANNEL_METHOD_INITIALIZE = "initialize"
        const val CHANNEL_METHOD_SHOW_SOME_DATA = "show_some_data"
        const val CHANNEL_METHOD_SHOW_PLATFORM_VERSION = "show_platform_version"

         const val CHANNEL_ID1 = "channel_1"
         const val CHANNEL_ID2 = "channel_2"
        const val REMOTE_INPUT_KEY = "TEXT_REMOTE_INPUT_KEY"
        const val CHANNEL_METHOD_CREATE_NOTIFICATION ="create_notification"


    }
}