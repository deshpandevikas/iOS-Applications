package com.example.vikasdeshpande.inclass08;

import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by Vikas Deshpande on 11/30/2017.
 */

public class JsonParser
{
    static public class parserr{
        static ArrayList<Person> parseJsonFunction(JSONArray input)
        {
            ArrayList<Person> personList = new ArrayList<Person>();

            try
            {
                JSONArray jsonArray= input;

                for(int i=0;i<jsonArray.length();i++)
                {
                    Person person = new Person();
                    JSONObject eachobj = jsonArray.getJSONObject(i);

                    person.setFname(eachobj.getString("first_name"));
                    person.setLname(eachobj.getString("last_name"));
                    person.setGender(eachobj.getString("gender"));
                    person.setRank(eachobj.getInt("rank"));
                    personList.add(person);
                }

            }
            catch (Exception e)
            {
                Log.d("debug1",e.getMessage());
            }

            return personList;
        }

    }
}
