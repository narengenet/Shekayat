using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class loginxyzroosta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // check and validate login
            if (SessionHelpers.validateAdmin())
            {
                // user is logged in
                Response.Redirect("~/admin/dashboard.aspx", true);
            }


            if (IsPostBack)
            {
                if (Session["tokenerrors"].ToString().Length > 2)
                {
                    DateTime _tokendate = Convert.ToDateTime(Session["tokenerrors"]);
                    if (!checkExpireHour(_tokendate))
                    {
                        mobile.Enabled = false;
                        Button1.Enabled = false;
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Expire()", true);
                    }
                    else
                    {
                        Session["tokenerrors"] = 4;
                    }
                }

            }
            else
            {
                if (Session["tokenerrors"] != null && Session["tokenerrors"].ToString().Length > 2)
                {
                    DateTime _tokendate = Convert.ToDateTime(Session["tokenerrors"]);
                    if (!checkExpireHour(_tokendate))
                    {
                        mobile.Enabled = false;
                        Button1.Enabled = false;
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Expire()", true);
                    }
                    else
                    {
                        Session["tokenerrors"] = 4;
                    }

                }
                else
                {
                    Session["tokenerrors"] = 4;
                }
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["tokenerrors"].ToString().Length > 2)
            {
                return;
            }
            // search for admin with mobile number
            ShekayatTableAdapters.adminsTableAdapter adminTA = new ShekayatTableAdapters.adminsTableAdapter();
            Shekayat.adminsDataTable dt = new Shekayat.adminsDataTable();
            dt = adminTA.GetActiveAdminByMobile(mobile.Text);


            // generate new random token
            var rnd = new Random(DateTime.Now.Millisecond);
            int token = rnd.Next(1000, 9999);

            if (dt.Rows.Count > 0)
            {
                // admin has records and success login
                int adminid = Convert.ToInt32(dt.Rows[0]["adminid"]);
                successLogin(adminid, token, dt.Rows[0]["name"].ToString(), dt.Rows[0]["family"].ToString());
            }
            else
            {
                int _tokencount = Convert.ToInt32(Session["tokenerrors"]);
                if (_tokencount > 0)
                {
                    _tokencount = _tokencount - 1;
                    Session["tokenerrors"] = _tokencount;
                    RemoveCssClass(mobile, "is-invalid");
                    AddCssClass(mobile, "is-invalid");
                }
                else
                {

                    Session["tokenerrors"] = DateTime.Now;
                }


            }

        }

        void successLogin(int adminid, int token, string admin_name, string admin_family)
        {
            ShekayatTableAdapters.adminsTableAdapter adminTA = new ShekayatTableAdapters.adminsTableAdapter();
            adminTA.UpdateToken(DateTime.Now, token.ToString(), Convert.ToInt64(adminid));



            Session["adminid"] = adminid;
            Session["adminfullname"] = admin_name + " " + admin_family;
            Session["tokenerrors"] = 4; // token error count reset
            Session["token"] = token;
            Session["mobile"] = mobile.Text;
            Session["newthread"] = "2";



            Response.Redirect("/verifier.aspx", true);
        }

        bool checkExpireHour(DateTime tokendate)
        {
            if (tokendate.Year == DateTime.Now.Year)
            {
                if (tokendate.Month == DateTime.Now.Month)
                {
                    if (tokendate.Day == DateTime.Now.Day)
                    {
                        if (tokendate.Hour == DateTime.Now.Hour)
                        {
                            return false;
                        }
                    }

                }
            }
            return true;
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