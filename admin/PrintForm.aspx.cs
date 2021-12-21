using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat.admin
{
    public partial class PrintForm : System.Web.UI.Page
    {

        public long threadid_client = clientthreads.threadid_client;
        public string threadsubject_client = clientthreads.threadsubject_client;
        public string threadfullname_client = clientthreads.threadfullname_client;
        public string threadfulllocation_client = clientthreads.threadfulllocation_client;
        public string threadscore_client = clientthreads.threadscore_client;
        public string threaddep_client = clientthreads.threaddep_client;
        public string threadmobile_client = clientthreads.threadmobile_client;
        public string threadnational_client = clientthreads.threadnational_client;
        public string threadinsurance_client = clientthreads.threadinsurance_client;
        public string threadfixedtoken = clientthreads.threadfixedtoken;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool status = false;
            if (SessionHelpers.validateAdmin())
            {
                status = true;
            }

            if (status != true)
            {
                Response.Redirect("~/admin/logout.aspx", true);
            }

            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            bool pagepermission = PermissionChecks.CheckPermission(15, adminid);
            if (!pagepermission)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "closewindow", "window.close();", true);
                return;
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "print", "window.print();", true);
            }




        }
}
}