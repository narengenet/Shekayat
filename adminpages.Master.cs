using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class adminpages : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //bool status = false;
            //if (Session["adminid"]!=null)
            //{
            //    try
            //    {
            //        if (Convert.ToInt32(Session["adminid"]) > 0)
            //        {
            //            status = true;
            //        }
            //    }
            //    catch (Exception)
            //    {

            //        throw;
            //    }

            //}

            //if (status!=true)
            //{
            //    Response.Redirect("~/login.aspx", true);
            //}








            bool status = false;
            if (SessionHelpers.validateAdmin())
            {
                status = true;
                
                Session["todaydate"] = DateTime.Today;
                // get all threads count
                DataView dv = new DataView();
                DataTable dt = new DataTable();
                dv = SqlDataSource1.Select(DataSourceSelectArguments.Empty) as DataView;
                dt = dv.ToTable();
                allThreads.InnerHtml = dt.Rows.Count.ToString();

                // get today threads count
                DataView dv2 = new DataView();
                DataTable dt2 = new DataTable();
                dv2 = SqlDataSource2.Select(DataSourceSelectArguments.Empty) as DataView;
                dt2 = dv2.ToTable();
                todayThreads.InnerHtml = dt2.Rows.Count.ToString();
            }

            if (status != true)
            {
                Response.Redirect("~/admin/logout.aspx", true);
            }
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

            //dt.Rows.Count;
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}