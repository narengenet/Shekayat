using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shekayat.handlers
{
    /// <summary>
    /// Summary description for deleteThread
    /// </summary>
    public class deleteThread : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string _adminid = context.Request.QueryString["adminid"].ToString();
            string _threadid = context.Request.QueryString["threadid"].ToString();
            int result = -1;



            if (PermissionChecks.CheckPermission(7, Convert.ToInt32(_adminid)))
            {

                int adminid = Convert.ToInt32(_adminid);
                long threadid = Convert.ToInt64(_threadid);
                ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
                ShekayatTableAdapters.postsTableAdapter postTA = new ShekayatTableAdapters.postsTableAdapter();
                // delete posts relevant to thread id
                postTA.DeletePostsByThreadID(threadid);
                // delete thread
                result= threadTA.DeleteThreadByThreadID(threadid);

                // log delete thread
                logs.CreateLog(-1, adminid, 24, "delete thread by admin:", adminid.ToString(), Convert.ToInt32(threadid), "");


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