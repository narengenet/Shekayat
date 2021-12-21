using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shekayat.handlers
{
    /// <summary>
    /// Summary description for deleteAdmin
    /// </summary>
    public class deleteAdmin : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            
            string adminid = context.Request.QueryString["adminid"].ToString();
            string targetadmin = context.Request.QueryString["targetadmin"].ToString();
            int result = -1;



            if(PermissionChecks.CheckPermission(4, Convert.ToInt32(adminid)) && adminid!=targetadmin)
            {
                ShekayatTableAdapters.adminsTableAdapter adminTA = new ShekayatTableAdapters.adminsTableAdapter();
                result= adminTA.DeleteAdminByID(Convert.ToInt64(targetadmin));

                logs.CreateLog(-1,Convert.ToInt32(adminid), 17, "حذف مدیر توسط:",adminid, Convert.ToInt32(targetadmin),"");

            }


            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}