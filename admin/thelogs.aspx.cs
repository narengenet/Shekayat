using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat.admin
{
    public partial class thelogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int adminid = Convert.ToInt32(Session["adminid"]);
            bool pagepermission = true;
            // check admin permission for view threads
            pagepermission = PermissionChecks.CheckPermission(19, adminid);
            if (!pagepermission)
            {
                Response.Redirect("~/admin/dashboard.aspx", true);
            }



            if (DropDownList1.SelectedValue=="-1")
            {
                GridView3.DataSource = SqlDataSource1;
                GridView3.DataBind();

                //var dv = new DataView();
                //var dt = new DataTable();

                //// Here mySQLDataSource is the ID of SQLDataSource
                //dv = SqlDataSource1.Select(DataSourceSelectArguments.Empty) as DataView;
                //dt = dv.ToTable();
                //countall.Text = dt.Rows.Count.ToString();
            }
            else
            {
                GridView3.DataSource = SqlDataSource2;
                GridView3.DataBind();

                //var dv = new DataView();
                //var dt = new DataTable();

                //// Here mySQLDataSource is the ID of SQLDataSource
                //dv = SqlDataSource2.Select(DataSourceSelectArguments.Empty) as DataView;
                //dt = dv.ToTable();
                //countall.Text = dt.Rows.Count.ToString();
            }
        }

        protected void DropDownList1_DataBound(object sender, EventArgs e)
        {
            DropDownList1.Items.Insert(0,  new System.Web.UI.WebControls.ListItem("همه لاگ ها ...", "-1"));
            GridView3.DataSource = SqlDataSource1;
            GridView3.DataBind();
        }

        protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView3.PageIndex = e.NewPageIndex;
            GridView3.DataBind();
            GridView3.SelectedIndex = -1;
        }

        protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();

        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }
    }
}