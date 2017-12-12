package com.example.vikasdeshpande.inclass08;

/**
 * Created by Vikas Deshpande on 11/30/2017.
 */

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.EditTextPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;
import android.util.Log;
import android.widget.Toast;

public class SettingPreferences extends PreferenceActivity
{

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        addPreferencesFromResource(R.xml.preferences);

        ListPreference sortByPreferences = (ListPreference) findPreference("sortBy");

        final ListPreference sortOrderPreferences = (ListPreference) findPreference("sortOrder");

        sortByPreferences.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                SharedPreferences.Editor prefsEditor;

                SharedPreferences pref = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
                prefsEditor = pref.edit();
                prefsEditor.putString("sortBy",newValue.toString());
                prefsEditor.putInt("id",0);
                prefsEditor.commit();
                //String tempType = pref.getString("sortBy","");

                Toast.makeText(getApplicationContext(),newValue + "  hii", Toast.LENGTH_LONG).show();

                Intent i = new Intent(getApplicationContext(),MainActivity.class);
                finish();
                startActivity(i);



                return false;
            }
        });

        sortOrderPreferences.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                SharedPreferences.Editor prefsEditor;

                SharedPreferences pref = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
                prefsEditor = pref.edit();
                prefsEditor.putString("sortOrder",newValue.toString());
                prefsEditor.putInt("id",0);
                prefsEditor.commit();
                //String tempType = pref.getString("sortBy","");

                Toast.makeText(getApplicationContext(),newValue + "  is the order", Toast.LENGTH_LONG).show();

                Intent i = new Intent(getApplicationContext(),MainActivity.class);
                finish();
                startActivity(i);



                return false;
            }
        });
    }


}
