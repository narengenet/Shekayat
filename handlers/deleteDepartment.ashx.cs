using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shekayat.handlers
{
    /// <summary>
    /// Summary description for deleteDepartment
    /// </summary>
    public class deleteDepartment : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string _adminid = context.Request.QueryString["adminid"].ToString();
            string _depid = context.Request.QueryString["depid"].ToString();
            int result = -1;



            if (PermissionChecks.CheckPermission(10, Convert.ToInt32(_adminid)))
            {

                int adminid = Convert.ToInt32(_adminid);
                int depid = Convert.ToInt32(_depid);
                ShekayatTableAdapters.departmentsTableAdapter depTA = new ShekayatTableAdapters.departmentsTableAdapter();
                ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
                // change threat's dep relevant to this dep to null dep
                threadTA.UpdateDepIDByDepID(-1, depid);
                // delete dep
                result = depTA.DeleteDepByID(depid);

                // log delete thread
                logs.CreateLog(-1, adminid, 26, "حذف دپارتمان توسط مدیر:", depid.ToString(), Convert.ToInt32(depid), "");

                SessionHelpers.SetSession("successdeleted", false, "1");

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