using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class newdiscontent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var userid = Session["userid"];
                Session["recorded"] = -1;


                ShekayatTableAdapters.thread_fixed_tokensTableAdapter _ta = new ShekayatTableAdapters.thread_fixed_tokensTableAdapter();
                string theguid = CreateGuid(5).ToLower();
                Shekayat.thread_fixed_tokensDataTable _dt = _ta.GetALL();
                string thetoken = "-1";
                bool result = false;
                do
                {
                    thetoken = CreateGuid(5).ToLower();
                    for (int i = 0; i < _dt.Rows.Count; i++)
                    {
                        if (_dt.Rows[i]["thread_fixed_token"].ToString().ToLower() == thetoken)
                        {
                            result = true;
                        }
                    }
                } while (result);



                ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
                object threadid = threadTA.InsertNewThread(Convert.ToInt64(userid), DateTime.Now);
                Session["threadid"] = threadid;
                _ta.Insert(Convert.ToInt64(threadid), thetoken);
                Session["threadfixedtoken"] = thetoken;


            }
        }

        protected string CreateGuid(int idLength)
        {
            var builder = new StringBuilder();
            while (builder.Length < idLength)
            {
                builder.Append(Guid.NewGuid().ToString());
            }
            return builder.ToString(0, idLength);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string val = HiddenField1.Value;
            if (HiddenField1.Value == "1")
            {
                // insert threat's text to posts
                if (texts.Text.Length > 0)
                {
                    // insert text post to thread
                    ShekayatTableAdapters.postsTableAdapter postTA = new ShekayatTableAdapters.postsTableAdapter();
                    object postid = postTA.InsertText(Convert.ToInt64(Session["threadid"]), texts.Text, DateTime.Now);
                    // log success text post
                    logs.CreateLog(Convert.ToInt32(Session["userid"]), -1, 11, "ارسال متن شکایت برای شکایت:" + Session["threadid"].ToString(), "postid:" + postid, Convert.ToInt32(Session["threadid"]), subject.Text);
                }

                // update thread's subject
                ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
                int dep_id = 2;
                if (DropDownList1.SelectedValue!="-2")
                {
                    // set department id of thread by selected subject
                    int sub_id = Convert.ToInt32(DropDownList1.SelectedValue);
                    ShekayatTableAdapters.departments_subjectsTableAdapter subjTA = new ShekayatTableAdapters.departments_subjectsTableAdapter();
                    Shekayat.departments_subjectsDataTable subjDT=subjTA.GetDataBySubjectID(sub_id);
                    if (subjDT.Rows.Count>0)
                    {
                        dep_id = Convert.ToInt32(subjDT[0]["department_id"]);
                    }
                }
                // update thread's subject and department 
                threadTA.UpdateSubmitThread(subject.Text, dep_id,Convert.ToInt64(Session["threadid"]));

                Response.Redirect("/discontentresult.aspx", true);

            }
        }

        protected void sqldsSubjects_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

            
        }

        protected void DropDownList1_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownList1.Items.Insert(0,new System.Web.UI.WebControls.ListItem("انتخاب موضوع ...", "-1"));
                DropDownList1.Items.Add(new System.Web.UI.WebControls.ListItem("سایر", "-2"));

            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue=="-2")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "PageUp", @"<script type='text/javascript'>$('#ContentPlaceHolder1_subject').removeClass('d-none');</script>", false);
                subject.Text = "";
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "PageUp", @"<script type='text/javascript'>$('#ContentPlaceHolder1_subject').addClass('d-none');</script>");
                subject.Text = DropDownList1.SelectedItem.Text;
            }
        }
    }
}