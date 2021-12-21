using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat.admin
{
    public partial class admins : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid",true));
            bool pagepermission= PermissionChecks.CheckPermission(1, adminid);
            if (!pagepermission)
            {
                Response.Redirect("~/admin/dashboard.aspx");
                return;
            }

            if (TextBox1.Text=="")
            {
                Repeater1.DataSource = allAdminsDataSource;
            }
            else
            {
                Repeater1.DataSource = adminsDataSource;
            }

            Repeater1.DataBind();
        }
    }
}