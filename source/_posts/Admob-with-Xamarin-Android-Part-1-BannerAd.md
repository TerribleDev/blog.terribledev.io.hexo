title: 'Admob with Xamarin Android Part 1: BannerAd'
tags:

  - Xamarin
  - c#
  - Xamarin For Android
  - Tutorial
permalink: admob-with-xamarin-part-1-banner-ads
id: 21
updated: '2014-04-25 23:15:12'
date: 2014-03-11 00:51:51
---

<span style="float: right">[<i class="fa fa-hand-o-right"></i> Part 2: Interstitial Ads](/admob-with-xamarin-part-2-interstitialad/)</span><br />

This will be a brief overview on how to get admob working with Xamarin.

## Disclaimer

I highly suggest you run this on a real phone. I'm not sure if the virtual phones can load content on the internet. I always develop on a real phone.

Sample code located in a [repo at github](https://github.com/TerribleDev/XamarinAdmobTutorial)
<!-- more -->
## Create an admob account

First you will need to create an account. After you do so create an ad, you must choose either full page aka Interstitial, or banner ad.


## Install Play Services Component

This is quite simple right click on the components folder (in visual studio, or xamarin studio) and click get more components.

![get a componant](/content/images/2014/Mar/componant.png)

Find the play services you require and click Add to App.

![](/content/images/2014/Mar/playservices.PNG)

Add the following XML to your Android Manifest file, place it in between the `<application></application>` tags.

```xml

    <meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />
    <activity android:name="com.google.android.gms.ads.AdActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize" />



```



## Add proper permissions

You need to add these permissions to your AssemblyInfo.cs

```csharp
[assembly: UsesPermission(Android.Manifest.Permission.Internet)]
[assembly: UsesPermission(Android.Manifest.Permission.AccessNetworkState)]
```

## The Basics

The standard code to create an ad is something like this:


```csharp
using Android.Gms.Ads;

namespace funtimes
{

  class a : Activity
  {
  		public void Method()
        {
          var ad = new AdView(con);
          ad.AdSize = AdSize.SmartBanner;
          ad.AdUnitId = 'your id here';
          var requestbuilder = new AdRequest.Builder();
          ad.LoadAd(requestbuilder.Build());
          var layout = FindViewById<LinearLayout>(Resource.Id.mainlayout);
          layout.AddView(ad);
         }

  }
}


```

## Doing things better

However in the interests of showing, and creating more flexible code this tutorial will guide you through the wrapper implementation I constructed, and posted on [github](https://github.com/TerribleDev/XamarinAdmobTutorial).

To start I created admobDemo.AndroidPhone.ad.AdWrapper.cs This code abstracts out some of the verbose building process, and allows the building Ad code to be reused. the code pertaining banner ads looks like this


```csharp


using Android.Gms.Ads;

namespace admobDemo.AndroidPhone.ad
{
    public static class AdWrapper
    {


        public static AdView ConstructStandardBanner(Context con, AdSize adsize, string UnitID)
        {
           var ad = new AdView(con);
           ad.AdSize = adsize;
           ad.AdUnitId = UnitID;
           return ad;
        }


        public static AdView CustomBuild(this AdView ad)
        {
            var requestbuilder = new AdRequest.Builder();
            ad.LoadAd(requestbuilder.Build());
            return ad;
        }

    }


```

The ConstructStandardBanner method takes in a context (usually this in an activity class), an ad size which usually people use AdSize.SmartBanner, and the unitID of your Ad (ID that you got from admob).

The [extension](http://msdn.microsoft.com/en-us/library/bb383977.aspx) method `CustomBuild` allows you to define things in the requestbuilder *(which I have not changed in this implementation)*. The request builder is mostly to give demographic information to Google, to help serve up a *better* ad.


Your main activity should end up looking something like this:

```csharp



using System;
using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;
using Android.Gms.Ads;
using admobDemo;
using admobDemo.AndroidPhone.ad;
namespace admobDemo.AndroidPhone
{
    [Activity(Label = "admobDemo.AndroidPhone", MainLauncher = true, Icon = "@drawable/icon")]
    public class Activity1 : Activity
    {
        AdView _bannerad;
        protected override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            _bannerad = AdWrapper.ConstructStandardBanner(this, AdSize.SmartBanner, "your ad id here");
             _bannerad.CustomBuild();
            var layout = FindViewById<LinearLayout>(Resource.Id.mainlayout);
            layout.AddView(_bannerad);
		}



        protected override void OnResume()
        {
            if (_bannerad != null) _bannerad.Resume();
            base.OnResume();
        }
        protected override void OnPause()
        {
            if(_bannerad != null)_bannerad.Pause();
            base.OnPause();
        }
    }
}


```

As you can see we are constructing the banner using our wrapper. Then we are calling it's custom build extension method.  We are getting a LinearLayout that has been defined in the views's .axml file (you can add your own their if you wish) and then we are injecting the banner into this LinearLayout.

You need to make sure you pause and resume the bannerAds by including them in the overrides on the Activity class. You also need to make sure you give it your ad ID.

If you have issues where the ad does not show, you may want to make sure whatever LinearLayout (or other UI control) you inject the banner into is being shown in the UI. I once saw a problem where one layout was filling the parent so the other was not being shown, therefore the banner was hidden.
