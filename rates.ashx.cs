using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shekayat
{
    /// <summary>
    /// Summary description for rates
    /// </summary>
    public class rates : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string threadid = context.Request.QueryString["threadid"].ToString();
            string rate= context.Request.QueryString["rate"].ToString();
            string userid = context.Request.QueryString["userid"].ToString();

            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            int result=threadTA.UpdateThreadScoreByThreadIDAndUserID(Convert.ToInt32(rate), Convert.ToInt64(threadid), Convert.ToInt64(userid));
            logs.CreateLog(Convert.ToInt32(userid), -1, 9, "امتیاز به شکایت", rate, Convert.ToInt32(threadid), rate);

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