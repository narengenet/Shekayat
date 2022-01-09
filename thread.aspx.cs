﻿using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class thread : System.Web.UI.Page
    {
        public bool isReplied = false;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["thread"] != null)
            {
                ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
                Shekayat.threadsDataTable dt = threadTA.GetThreadByThreadID(Convert.ToInt64((Request.QueryString["thread"])));

                ShekayatTableAdapters.thread_fixed_tokensTableAdapter fixedTA = new ShekayatTableAdapters.thread_fixed_tokensTableAdapter();
                Shekayat.thread_fixed_tokensDataTable fixedDT = fixedTA.GetDataByThreadID(Convert.ToInt64((Request.QueryString["thread"])));
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["userid"].ToString() != Session["userid"].ToString())
                    {
                        Response.Redirect("~/thread.aspx", true);
                    }
                    else
                    {
                        Session["replied"] = dt.Rows[0]["replied"];
                        Session["threadid"] = dt.Rows[0]["thread_id"];
                        Session["threadsubject"] = dt.Rows[0]["subject"].ToString();
                        Session["threadscore"] = dt.Rows[0]["score"].ToString();
                        Session["threaddepartment"] = dt.Rows[0]["department_id"].ToString();
                        isReplied = Convert.ToBoolean(Session["replied"]);
                        Session["threadtoken"] = fixedDT.Rows[0]["thread_fixed_token"];


                        //SqlDataSource1.DataBind();
                        //Repeater1.DataBind();
                    }
                }
            }

            // update thread's admin reply posts to read by client and set seen date
            ShekayatTableAdapters.postsTableAdapter _postTA = new ShekayatTableAdapters.postsTableAdapter();
            _postTA.UpdateFirstSeenByThreadID(DateTime.Now, Convert.ToInt64(Session["threadid"]));
            // log view thread and replys by client
            logs.CreateLog(Convert.ToInt32(Session["userid"]), -1, 39, "دیدن برگه شکایت و پاسخ صندوق توسط شاکی:"+ Session["userid"] , "شناسه شکایت:" + Session["threadid"], Convert.ToInt32(Session["threadid"]), "موضوع شکایت:"+Session["threadsubject"]);

            try
            {
                subject.Value = Session["threadsubject"].ToString();
                fixedtoken.Value = Session["threadtoken"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("~/Default.aspx", true);
                throw;
            }





        }
    }
}