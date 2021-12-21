using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shekayat.handlers
{
    /// <summary>
    /// Summary description for deletePost
    /// </summary>
    public class deletePost : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string _adminid = context.Request.QueryString["adminid"].ToString();
            string _postid = context.Request.QueryString["postid"].ToString();
            int result = -1;



            if (PermissionChecks.CheckPermission(13, Convert.ToInt32(_adminid)))
            {

                int adminid = Convert.ToInt32(_adminid);
                long postid = Convert.ToInt64(_postid);
                ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
                ShekayatTableAdapters.postsTableAdapter postTA = new ShekayatTableAdapters.postsTableAdapter();
                Shekayat.postsDataTable postDT= postTA.GetPostByPostID(postid);
                if (postDT.Rows.Count>0)
                {

                    // delete post reply
                    string posttext = postDT.Rows[0]["text"].ToString();
                    long threadid = Convert.ToInt64(postDT.Rows[0]["thread_id"]);
                    result = postTA.DeletePostByPostID(postid);

                    // log delete post
                    logs.CreateLog(-1, adminid, 31, "حذف پاسخ شکایت توسط ادمین:", adminid.ToString(), Convert.ToInt32(postid), posttext);
//                    SessionHelpers.SetSession("successdeleted", false, "1");

                    // check if thread has no reply after delete last reply, set the thread is replyed to false
                    Shekayat.postsDataTable _dt= postTA.GetReplyPostsByThreadID(threadid);
                    if (_dt.Rows.Count==0)
                    {
                        threadTA.UpdateReplyedByThreadID(false,null ,threadid);
                        threadTA.UpdateIsClosedThreadByThreadID(false, threadid);
                    }

                }
                else
                {
                    logs.CreateLog(-1, adminid, 32, "حذف پاسخ توسط مدیر موفقیت آمیز نبود، شناسه پاسخ یافت نشد :", adminid.ToString(), Convert.ToInt32(postid), "No Post TEXT");
                }





            }
            else
            {
                logs.CreateLog(-1, Convert.ToInt32(_adminid), 32, "دسترسی لازم برای حذف پاسخ وجوئ نداشت:", _adminid, Convert.ToInt32(_postid), "Go to post to see text");
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