package com.example.vikasdeshpande.inclass08;

import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Toast;

import org.json.JSONArray;

import java.io.IOException;
import java.util.ArrayList;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MainActivity extends AppCompatActivity implements AsyncData.DataCallBack
{
    ArrayList<Person> personsList = new ArrayList<Person>();
    ArrayList<Person> tempList = new ArrayList<Person>();
    private RecyclerView recViewSaved;
    private RecyclerAdapter adapterSaved;
    static String ip = "http://18.216.218.221:1337/";
    RequestBody formBody;
    OkHttpClient client;
    Button loadMoreData;
    static int flag =0;
    int loadmore = 1;

    SharedPreferences mPrefs;
    SharedPreferences.Editor prefsEditor;
    SwipeRefreshLayout swipeRefreshLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        swipeRefreshLayout = (SwipeRefreshLayout) findViewById(R.id.swipe);

        swipeRefreshLayout.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                swipeRefreshLayout.setRefreshing(true);
                loadmore=0;
                getPreviousData();

                swipeRefreshLayout.setRefreshing(false);
            }
        });

        loadMoreData = (Button) findViewById(R.id.btnLoadMore);


        recViewSaved = (RecyclerView)findViewById(R.id.saved_recycler);
        recViewSaved.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false));

        final String url = "http://34.203.225.11:8080/list";

        mPrefs =  PreferenceManager.getDefaultSharedPreferences(this);
        prefsEditor = mPrefs.edit();
        if(MainActivity.flag==0) {


            prefsEditor.putString("sortBy", "first_name");
            prefsEditor.putString("sortOrder", "ASC");
            prefsEditor.putInt("id", 0);

            prefsEditor.commit();
            MainActivity.flag =1;
        }

        getMoreData();

        loadMoreData.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loadmore = 1;
                getMoreData();
            }
        });

    }

    public void getMoreData()
    {
        int idVal = mPrefs.getInt("id",0);
        String sortBy = mPrefs.getString("sortBy","first_name");
        String sortOrder = mPrefs.getString("sortOrder","ASC");
        if(idVal<1000)
        {
            new AsyncData(this).execute(MainActivity.ip + "getBy",idVal+"",sortBy,sortOrder);
        }
        else
        {
            Toast.makeText(getApplicationContext(),"No more Data to load",Toast.LENGTH_LONG).show();
        }



    }

    public void getPreviousData()
    {
        int idVal = mPrefs.getInt("id",0);
        String sortBy = mPrefs.getString("sortBy","first_name");
        String sortOrder = mPrefs.getString("sortOrder","ASC");
        if(idVal<=100)
        {
            Toast.makeText(getApplicationContext(),"No more Data to load",Toast.LENGTH_LONG).show();

        }
        else
        {
            idVal = idVal-150;
            new AsyncData(this).execute(MainActivity.ip + "getBy",idVal+"",sortBy,sortOrder);
        }



    }

    @Override
    public void callBackD(String body)
    {
        try
        {
            JSONArray jsonData = new JSONArray(body);
            if(jsonData.length()>0)
            {
                tempList = new JsonParser.parserr().parseJsonFunction(jsonData);

                if(loadmore==1) {
                    if (personsList.size() == 0 || personsList.size() == 50) {
                        personsList.addAll(tempList);
                    } else {
                        // personsList = (ArrayList<Person>) personsList.subList(49,100);
                        personsList = new ArrayList<Person>(personsList.subList(49, 100));
                        personsList.addAll(tempList);
                    }

                    int idVal = mPrefs.getInt("id",0);

                    idVal = idVal+50;

                    prefsEditor.putInt("id",idVal);
                    prefsEditor.commit();
                }
                else
                {
                    if (personsList.size() <= 100) {

                    } else {
                        // personsList = (ArrayList<Person>) personsList.subList(49,100);
                        ArrayList<Person> personsList2 = new ArrayList<Person>(personsList.subList(0, 50));
                        personsList = new ArrayList<Person>();
                        personsList.addAll(tempList);
                        personsList.addAll(personsList2);

                        int idVal = mPrefs.getInt("id",0);

                        idVal = idVal-50;

                        prefsEditor.putInt("id",idVal);
                        prefsEditor.commit();
                    }
                }

                adapterSaved = new RecyclerAdapter(personsList, MainActivity.this);

                MainActivity.this.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {

                        recViewSaved.setAdapter(adapterSaved);
                        adapterSaved.notifyDataSetChanged();


                    }
                });

                Log.d("data", jsonData.toString());
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            Log.d("error","exception occured");
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        getMenuInflater().inflate(R.menu.menu, menu);
        return true;
    }

    @Override
    public MenuInflater getMenuInflater() {


        return super.getMenuInflater();
    }



    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        try{
            int id = item.getItemId();

            if(id == R.id.settings){

                Intent i = new Intent(this, SettingPreferences.class);
                finish();
                startActivity(i);
            }
        }catch (Exception e)
        {
            Log.d("debug2",e.getMessage());
        }

        return super.onOptionsItemSelected(item);
    }
}
