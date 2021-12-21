using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;

namespace Shekayat.controllers
{
    public static class SessionHelpers
    {

        public static string GetSession(string session_key,bool useCookies)
        {
            try
            {
                if (HttpContext.Current.Session[session_key] != null)
                {
                    if (useCookies)
                    {
                        HttpContext.Current.Request.Cookies[session_key].Value = HttpContext.Current.Session[session_key].ToString();
                    }

                    return HttpContext.Current.Session[session_key].ToString();
                }
                else
                {
                    if (useCookies && HttpContext.Current.Request.Cookies[session_key] != null)
                    {
                        HttpContext.Current.Session[session_key] = HttpContext.Current.Request.Cookies[session_key].Value;
                        return HttpContext.Current.Request.Cookies[session_key].Value;
                    }
                    return null;
                }
            }
            catch (Exception)
            {
                HttpContext.Current.Response.Redirect("~/admin/logout.aspx", true);
                throw;
            }



        }



        public static void SetSession(string session_key, bool useCookies,object session_value,int days=20)
        {

            // set session
            if (session_value!=null)
            {
                HttpContext.Current.Session[session_key] = session_value.ToString();
            }
            else
            {
                HttpContext.Current.Session[session_key] = null;
            }
            

            // set cookie
            if (useCookies)
            {
                if (session_value!=null)
                {
                    HttpContext.Current.Response.Cookies[session_key].Value = session_value.ToString();
                    HttpContext.Current.Response.Cookies[session_key].Expires.AddDays(days);
                }
                else
                {
                    HttpContext.Current.Response.Cookies[session_key].Expires = DateTime.Now.AddDays(-1);
                }

            }

        }

        public static bool validateAdmin()
        {

            string adminid = GetSession("adminid", true);
            string admin_mobile = GetSession("mobile", true);
            if (adminid==null || admin_mobile==null)
            {
                return false;
            }

            ShekayatTableAdapters.adminsTableAdapter adminsTA = new ShekayatTableAdapters.adminsTableAdapter();
            long _adminid = Convert.ToInt64(adminid);
            Shekayat.adminsDataTable _dt = new Shekayat.adminsDataTable();
            _dt= adminsTA.GetDataByID(_adminid);
            if (_dt.Rows.Count>0){
                if (_dt.Rows[0]["mobile"].ToString()==admin_mobile)
                {
                    SetSession("adminfullname", true, _dt.Rows[0]["name"] + " " + _dt.Rows[0]["family"]);
                    return true;
                }
            }

            return false;
        }
    }
}