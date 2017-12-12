package com.example.vikasdeshpande.inclass08;

import android.content.Context;
import android.graphics.Color;
import android.graphics.Typeface;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

/**
 * Created by Vikas Deshpande on 11/30/2017.
 */

public class RecyclerAdapter extends RecyclerView.Adapter<RecyclerAdapter.AdapterHolder> {

    private List<Person> listData;
    private LayoutInflater inflater;
    private Context mContext;

    public void setListData(List<Person> appslist) {
        this.listData.clear();
        this.listData.addAll(appslist);
    }

    public RecyclerAdapter(List<Person> listData, Context c) {
        inflater = LayoutInflater.from(c);
        this.listData = listData;
        mContext = c;
    }

    @Override
    public AdapterHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.custom_saved, parent, false);
        return new AdapterHolder(view);
    }

    @Override
    public void onBindViewHolder(AdapterHolder holder, int position)
    {
        Person person = listData.get(position);
        holder.tvFname.setText("First Name: "+person.getFname());
        holder.tvLname.setText("Last Name: "+person.getLname());
        holder.tvGender.setText("Gender: "+person.getGender());
    }

    @Override
    public int getItemCount() {
        return listData.size();
    }

    public class AdapterHolder extends RecyclerView.ViewHolder
    {
        private TextView tvFname;
        private TextView tvLname;
        private TextView tvGender;

        public AdapterHolder(View itemView)
        {
            super(itemView);
            tvFname = (TextView) itemView.findViewById(R.id.tvFname);
            tvLname = (TextView) itemView.findViewById(R.id.tvLname);
            tvGender = (TextView) itemView.findViewById(R.id.tvGender);

            tvFname.setTypeface(null, Typeface.BOLD);
            tvLname.setTypeface(null, Typeface.BOLD);
            tvGender.setTypeface(null, Typeface.BOLD);
        }
    }


}
