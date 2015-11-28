title: 'Admob with Xamarin Android Part 2: InterstitialAd'
tags:

  - Xamarin
  - c#
  - Xamarin For Android
  - Tutorial
permalink: admob-with-xamarin-part-2-interstitialad
id: 22
updated: '2014-03-19 21:27:37'
date: 2014-03-11 01:44:06
---

<span style="float: left">[Part 1: Banner Ads <i class="fa fa-hand-o-left"></i>](/admob-with-xamarin-part-1-banner-ads/)</span><br />

Interested in Interstital ads, but not banner? Thats ok, but I recommend your read my first post about [banner ads](/admob-with-xamarin-part-1-banner-ads/). The first steps, installing Google Play Services, altering your permissions, adding to your manifests files, and reviewing my [github demo](https://github.com/tparnell8/XamarinAdmobTutorial) are located in that tutorial.
<!-- more -->
## The Basics

The very basic amount of code to do Interstitial Ad's are below

```csharp

 var ad = new InterstitialAd(con);
 ad.AdUnitId = "unitID";
 var requestbuilder = new AdRequest.Builder();
 ad.LoadAd(requestbuilder.Build());
 ad.Show()
```
The problem with the above code is it tries to show the ad right away, but the ad may not be loaded already. The unique way interstitial ads work, are you must call `Show()`, after the banner is downloaded. So we must have an event listener that hears when the ad is loaded, before we can show it.

## Doing things better

Back to my github code, the Adwrapper class contains build methods for *full page ad* aka Interstitial.

```csharp
using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.Gms.Ads;

namespace admobDemo.AndroidPhone.ad
{
    public static class AdWrapper
    {


 public static InterstitialAd ConstructFullPageAdd(Context con, string UnitID)
        {
            var ad = new InterstitialAd(con);
            ad.AdUnitId = UnitID;
            return ad;
        }

          public static InterstitialAd CustomBuild(this InterstitialAd ad)
        {
            var requestbuilder = new AdRequest.Builder();
            ad.LoadAd(requestbuilder.Build());
            return ad;
        }

    }
}

```
The custom build extension method works the same as the banner ad method, and has not been customized in this template.

The InterstitialAd class does not come with native event listeners. To implement listeners you must create a class that inherits from AdListner and then define the event listeners. We will want to do this so we can show the ad once it is downloaded to the phone, and not have to keep checking to see if it has downloaded. The demo code AdEventListener.cs file in the ad folder of AndroidPhone project contains an implementaiton of this.

```csharp


namespace admobDemo
{
    class adlistener : AdListener
    {
        // Declare the delegate (if using non-generic pattern).
        public delegate void AdLoadedEvent();
        public delegate void AdClosedEvent();
        public delegate void AdOpenedEvent();



        // Declare the event.
        public event AdLoadedEvent AdLoaded;
        public event AdClosedEvent AdClosed;
        public event AdOpenedEvent AdOpened;

        public override void OnAdLoaded()
        {
            if (AdLoaded != null) this.AdLoaded();
            base.OnAdLoaded();
        }

        public override void OnAdClosed()
        {
            if (AdClosed != null) this.AdClosed();
            base.OnAdClosed();
        }
        public override void OnAdOpened()
        {
            if (AdOpened != null) this.AdOpened();
 	        base.OnAdOpened();
        }
    }
}
```

Once you have these componants in place your activity should end up looking like this.


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
        protected override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            // Set our view from the "main" layout resource
            SetContentView(Resource.Layout.Main);

            var FinalAd = AdWrapper.ConstructFullPageAdd(this, "your ad id here");
            var intlistener = new admobDemo.adlistener();
            intlistener.AdLoaded += () => { if (FinalAd.IsLoaded)FinalAd.Show(); };
            FinalAd.AdListener = intlistener;
            FinalAd.CustomBuild();

        }

    }
}

```

To walk you through the code...after `SetContentView()`....We make a full page Ad *(and pass it our AD id)*, we create an event listener based on the ad listener class. We set the event listener to trigger an annonymous function that will show the ad. we make the Ad's event listener to be the event listener we made, then we run CustomBuild which builds the Ad and starts loading the Ad. Once the ad loads it will call the event handler, and Boom! Show the ad to the user.

Obviously this is a basic implementation, and showing the ad when the app first starts may, or may not be the best stratergy for **You**.
