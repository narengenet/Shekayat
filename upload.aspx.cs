﻿using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class upload : System.Web.UI.Page
    {
        ShekayatTableAdapters.postsTableAdapter postsTA = new ShekayatTableAdapters.postsTableAdapter();
        protected void Page_Load(object sender, EventArgs e)
        {
            //string strFolder =Server.MapPath("./sounds");
            string strYear = DateTime.Now.Year.ToString();
            string strMonth = DateTime.Now.Month.ToString();

            bool exists = System.IO.Directory.Exists(Server.MapPath("sounds/"+strYear));

            if (!exists)
                System.IO.Directory.CreateDirectory(Server.MapPath("sounds/" + strYear));

            exists = System.IO.Directory.Exists(Server.MapPath("sounds/"+strYear+"/"+strMonth));

            if (!exists)
                System.IO.Directory.CreateDirectory(Server.MapPath("sounds/" + strYear + "/" + strMonth));

            

            bool finished = false;
            int index = -1;
            foreach (string file in Request.Files)
            {
                index += 1;
                string filename = Session["userid"].ToString()+"-"+ Session["threadid"].ToString()+"_"+index+".wav";
                var hpf = Request.Files[file] as HttpPostedFile;
                if (hpf.ContentLength == 0)
                    break;


                var savedFileName = Server.MapPath(Path.Combine("sounds/"+strYear+"/"+strMonth, filename));
                hpf.SaveAs(savedFileName);
                finished = true;
                string fullVoiceName = "sounds/" + strYear + "/" + strMonth+"/"+ filename;
                object postid=postsTA.InsertVoice(Convert.ToInt64(Session["threadid"]),fullVoiceName,DateTime.Now);
                Session["recorded"] = filename;
                logs.CreateLog(Convert.ToInt32(Session["userid"]), -1, 8, "wav","postid:"+postid.ToString(), Convert.ToInt32(Session["threadid"]), fullVoiceName);
                //save file
            }
            Response.ContentType = "text/plain";
            if (finished)
            {
                Response.Write("ok");
            }
            else
            {
                logs.CreateLog(Convert.ToInt32(Session["userid"]), -1, 7, "wav", "error", Convert.ToInt32(Session["threadid"]), "");
                Response.Write("no");
            }
            
        }
    }
}