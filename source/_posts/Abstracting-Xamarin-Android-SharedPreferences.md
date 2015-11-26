title: Abstracting Xamarin Android SharedPreferences
tags:

  - Xamarin
  - c#
  - Xamarin For Android
permalink: xamarin-android-sharedpreferences
id: 20
updated: '2014-03-19 21:30:32'
date: 2014-03-06 13:55:25
---

The standard way to get/set SharedPreferences in Xamarin is with the following code.

Get Preference:

```clike

 var shared = con.GetSharedPreferences(_preferenceName, FileCreationMode.WorldReadable);
 var value = shared.All.Where(x => x.Key == key).FirstOrDefault().Value;

```

Set Preference:

```clike

var shared = con.GetSharedPreferences("PreferenceName", FileCreationMode.WorldWriteable);
            var edit = shared.Edit();
            edit.PutString(key, val);
            edit.Commit();

```

The main issue I have/had with this is you often have to know what will be returned, and what type you need to save as. Usually this isn't difficult, but it adds an un-needed level of complexity.

The other major issues I have with this, is that it is quite verbose, and unnecessary. The code duplication here can be quite high.
<!-- more -->
## The Solution

I recently added on [github](https://github.com/tparnell8/XamAndroidSettings) an abstraction around the shared preferences that make it easier to use. This class uses [c# generics](http://msdn.microsoft.com/en-us/library/512aeb7t.aspx), and an extension method I wrote for `ISharedPreferencesEditor` that make SharedPreferences easier to use.

The sample code below shows how to use it.

```clike

var sk = new SettingsKey<string>("KeyName", "PreferenceName", "DefaultValuehere");
           var setting = sk.GetSetting(this)
           var setsetting = sk.SetSetting(this, "New Value!")

```

To start create a new `SettingsKey` class and provide a primative type (Note: it only accepts String, Bool, Int, Float, Long).

`var sk = new SettingsKey<string>("KeyName", "PreferenceName", "DefaultValuehere");`

My example creates an object called sk with T of type string. You must give the key a name, you must provide the preferenceName (name used to share the settings with other classes),and you must give it a default value (because the user setting may not exist yet).

Below is a version that uses int:

``var sk = new SettingsKey<int>("Times app has been loaded", "PreferenceName", 15);`

Afterwards you can simply use `sk.GetSetting(this)` to get the setting and `sk.SetSetting(this, 25)` to set a new setting.

The way I used this, was to have the settingskey classes wrapped in a repository-type class with the keys pre-defined (in a struct). Using this I was able to call `repo.sk1.GetSetting();` throughout my application without having to worry if I typed the correct key in or not. This was especially valuable when I wrote my [GravatarSync](https://play.google.com/store/apps/details?id=ultimategravatarsync.ultimategravatarsyncfree) app which has a service backend service, and a front end activity that both access the preferences.


## The Result

After making this I wanted to start using SharedPreferences as a storage medium. Setting up localSQL for your app is a pain, and maintaing that data when an update to your app is pushed out can be risky. The SharedPreferences are maintained even upon an update, and android does not let these settings get deleted (unless the user deletes them).
