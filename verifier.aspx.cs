﻿using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class verifier : System.Web.UI.Page
    {
        public static string DoGET(string URL, NameValueCollection QueryStringParameters = null, NameValueCollection RequestHeaders = null)
        {
            string ResponseText = null;
            using (WebClient client = new WebClient())
            {
                try
                {
                    if (RequestHeaders != null)
                    {
                        if (RequestHeaders.Count > 0)
                        {
                            foreach (string header in RequestHeaders.AllKeys)
                                client.Headers.Add(header, RequestHeaders[header]);
                        }
                    }
                    if (QueryStringParameters != null)
                    {
                        if (QueryStringParameters.Count > 0)
                        {
                            foreach (string parm in QueryStringParameters.AllKeys)
                                client.QueryString.Add(parm, QueryStringParameters[parm]);
                        }
                    }
                    byte[] ResponseBytes = client.DownloadData(URL);
                    ResponseText = Encoding.UTF8.GetString(ResponseBytes);
                }
                catch (WebException exception)
                {
                    if (exception.Response != null)
                    {
                        var responseStream = exception.Response.GetResponseStream();

                        if (responseStream != null)
                        {
                            using (var reader = new StreamReader(responseStream))
                            {
                                string read = reader.ReadToEnd();
                            }
                        }
                    }
                }
            }
            return ResponseText;
        }


        public static string SendSMS(string body,string mobile)
        {
            NameValueCollection QueryStringParameters = new NameValueCollection();
            QueryStringParameters.Add("cbody", body);
            QueryStringParameters.Add("cmobileno", mobile);
            QueryStringParameters.Add("cUsername", "hoze");
            QueryStringParameters.Add("cpassword", "1qaz@WSX");
            QueryStringParameters.Add("cDomainName", "ssbera");
            QueryStringParameters.Add("cEncoding", "1");

            string ss = DoGET("http://172.16.3.94/sms/default.aspx", QueryStringParameters);
            return ss;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["mobile"] != null)
            {
                string mobile = Session["mobile"].ToString();
                string orgmobile = Session["mobile"].ToString();
                //txtMobile.InnerText = mobile + " , " + Session["token"].ToString();
                mobile = mobile.Substring(0, 4) + "***" + mobile.Substring(7, 4);
                txtMobile.InnerText = mobile;

                SendSMS("کد ورود شما به سامانه شکایات مردمی\n code:" + Session["token"].ToString(), orgmobile);

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (floatingInput.Value == Session["token"].ToString())
            {

                switch (Session["newthread"].ToString())
                {
                    case "-1":
                        // log success login to threads
                        int _userid = Session["userid"] != null ? Convert.ToInt32(Session["userid"]) : -1;
                        int _logtypeid = 3;
                        string _subject = "thread:" + Session["threadid"];
                        // login by mobile or thread id
                        if (Session["bymobile"].ToString() == "1")
                        {
                            _logtypeid = 14;
                            _subject = "mobile:" + Session["mobile"];
                        }
                        logs.CreateLog(_userid, -1, _logtypeid,_subject , "token:" + Session["token"], -1, "");

                        Response.Redirect("/thread.aspx", true);
                        break;

                    case "1":
                        // log success login to new thread
                        int userid = Session["userid"] != null ? Convert.ToInt32(Session["userid"]) : -1;
                        logs.CreateLog(userid, -1, 1, "mobile:" + Session["mobile"], "token:" + Session["token"], -1, "");

                        Response.Redirect("/newdiscontent.aspx", true);
                        break;
                    case "2":
                        // log success login to admin dashboard
                        int _adminid = Session["adminid"] != null ? Convert.ToInt32(Session["adminid"]) : -1;
                        logs.CreateLog(-1, _adminid, 5, "mobile:" + Session["mobile"], "token:" + Session["token"], -1, "");

                        SessionHelpers.SetSession("adminid", true, _adminid);
                        SessionHelpers.SetSession("adminfullname", true, Session["adminfullname"]);
                        SessionHelpers.SetSession("tokenerrors", false, 4); // token error count reset
                        SessionHelpers.SetSession("token", false, Session["token"]);
                        SessionHelpers.SetSession("mobile", true, Session["mobile"]);

                        Response.Redirect("/admin/dashboard.aspx", true);
                        break;
                    default:
                        break;
                }



            }
            else
            {
                /* Token Error */

                Session["tokenerrors"] = Convert.ToInt32(Session["tokenerrors"]) - 1;
                if (Convert.ToInt32(Session["tokenerrors"]) == 0)
                {


                    switch (Session["newthread"].ToString())
                    {
                        case "-1":
                            Response.Redirect("/Default.aspx?verifier=false", true);
                            break;

                        case "1":
                            Response.Redirect("/Default.aspx?verifier=false", true);
                            break;
                        case "2":
                            Response.Redirect("/loginxyzroosta.aspx?verifier=false", true);
                            break;
                        default:
                            break;
                    }








                }



                // create correct log type id
                int _logtype = -1;
                int _userid = -1;
                int _adminid = -1;

                switch (Session["newthread"].ToString())
                {
                    case "-1":
                        _logtype = 4;
                        _userid = Convert.ToInt32(Session["userid"]);
                        _adminid = -1;
                        break;

                    case "1":
                        _logtype = 2;
                        _userid= Convert.ToInt32(Session["userid"]);
                        _adminid = -1;
                        break;
                    case "2":
                        _logtype = 13;
                        _userid = -1;
                        _adminid = Convert.ToInt32(Session["adminid"]);
                        break;
                    default:
                        break;
                }

                logs.CreateLog(_userid,_adminid, _logtype, "mobile:" + Session["mobile"], "original token:" + Session["token"], -1, floatingInput.Value);
                errorToken.Text = "کد چهاررقمی وارد شده اشتباه است. فقط " + Session["tokenerrors"] + " بار دیگر میتوانید تلاش کنید.";
                RemoveCssClass(errorToken, "d-none");
                floatingInput.Value = "";
            }
        }





        void AddCssClass(WebControl obj, string classname)
        {
            // Add a class
            obj.Attributes.Add("class", String.Join(" ", obj
                       .Attributes["class"]
                       .Split(' ')
                       .Except(new string[] { "", classname })
                       .Concat(new string[] { classname })
                       .ToArray()
               ));
        }

        void RemoveCssClass(WebControl obj, string classname)
        {
            // Remove a class
            obj.Attributes.Add("class", String.Join(" ", obj
                      .Attributes["class"]
                      .Split(' ')
                      .Except(new string[] { "", classname })
                      .ToArray()
              ));
        }
    }
}