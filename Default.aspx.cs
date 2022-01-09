using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class Default : System.Web.UI.Page
    {
        ShekayatTableAdapters.clientsTableAdapter clientsTA = new ShekayatTableAdapters.clientsTableAdapter();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void discontentByMobile_Click(object sender, EventArgs e)
        {
            bool result = true;
            // get user by mobile
            ShekayatTableAdapters.clientsTableAdapter clientsTA = new ShekayatTableAdapters.clientsTableAdapter();
            Shekayat.clientsDataTable cDT = clientsTA.GetClientsByMobile(phone.Text);
            string userid = "";
            if (cDT.Rows.Count > 0)
            {
                // get thread by user id
                userid = cDT.Rows[0]["userid"].ToString();
                ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
                Shekayat.threadsDataTable threadDT = threadTA.GetThreadsByUserID(Convert.ToInt64(userid));
                if (threadDT.Rows.Count > 0)
                {
                    Session["threadid"] = threadDT.Rows[0]["thread_id"];
                    Session["threadsubject"] = threadDT.Rows[0]["subject"];
                    Session["userid"] = threadDT.Rows[0]["userid"];
                    Session["replied"] = threadDT.Rows[0]["replied"];
                    Session["threadscore"] = threadDT.Rows[0]["score"];
                    Session["threaddepartment"] = threadDT.Rows[0]["department_id"].ToString();
                    ShekayatTableAdapters.clientsTableAdapter clientTA = new ShekayatTableAdapters.clientsTableAdapter();
                    Shekayat.clientsDataTable clientDT = clientsTA.GetUserByID(Convert.ToInt64(Session["userid"].ToString()));
                    ShekayatTableAdapters.thread_fixed_tokensTableAdapter fixedTA = new ShekayatTableAdapters.thread_fixed_tokensTableAdapter();
                    Shekayat.thread_fixed_tokensDataTable fixedDT = fixedTA.GetDataByThreadID(Convert.ToInt64(threadDT.Rows[0]["thread_id"]));
                    if (clientDT.Rows.Count > 0)
                    {
                        // generate new random token
                        var rnd = new Random(DateTime.Now.Millisecond);
                        int token = rnd.Next(1000, 9999);
                        Session["tokenerrors"] = 4; // token error count reset
                        Session["token"] = token;
                        Session["mobile"] = clientDT.Rows[0]["mobile"].ToString();
                        Session["newthread"] = "-1";
                        Session["bymobile"] = "1";
                        Session["threadtoken"] = fixedDT.Rows[0]["thread_fixed_token"];

                        Response.Redirect("/verifier.aspx", true);
                    }
                    else
                    {
                        result = false;
                    }

                }
                else
                {
                    result = false;
                }
            }
        }

        protected void discontentByToken_Click(object sender, EventArgs e)
        {
            bool result = true;
            ShekayatTableAdapters.thread_fixed_tokensTableAdapter threadtokensTA = new ShekayatTableAdapters.thread_fixed_tokensTableAdapter();
            Shekayat.thread_fixed_tokensDataTable threadtokensDT = threadtokensTA.GetDataByFixedToken(token.Text.ToLower());

            string _threadid = "-1";
            if (threadtokensDT.Rows.Count < 1)
            {
                return;
            }
            else
            {
                _threadid = threadtokensDT.Rows[0]["thread_id"].ToString();
            }




            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            Shekayat.threadsDataTable threadDT = threadTA.GetThreadByThreadID(Convert.ToInt64(_threadid));
            ShekayatTableAdapters.thread_fixed_tokensTableAdapter fixedTA = new ShekayatTableAdapters.thread_fixed_tokensTableAdapter();
            Shekayat.thread_fixed_tokensDataTable fixedDT = fixedTA.GetDataByThreadID(Convert.ToInt64(_threadid));
            if (threadDT.Rows.Count > 0)
            {
                Session["threadid"] = threadDT.Rows[0]["thread_id"];
                Session["threadsubject"] = threadDT.Rows[0]["subject"];
                Session["userid"] = threadDT.Rows[0]["userid"];
                Session["replied"] = threadDT.Rows[0]["replied"];
                Session["threadscore"] = threadDT.Rows[0]["score"];
                Session["threadtoken"] = fixedDT.Rows[0]["thread_fixed_token"];
                Session["threaddepartment"] = threadDT.Rows[0]["department_id"].ToString();
                ShekayatTableAdapters.clientsTableAdapter clientTA = new ShekayatTableAdapters.clientsTableAdapter();
                Shekayat.clientsDataTable clientDT = clientsTA.GetUserByID(Convert.ToInt64(Session["userid"].ToString()));
                if (clientDT.Rows.Count > 0)
                {
                    // generate new random token
                    var rnd = new Random(DateTime.Now.Millisecond);
                    int token = rnd.Next(1000, 9999);
                    Session["tokenerrors"] = 4; // token error count reset
                    Session["token"] = token;
                    Session["mobile"] = clientDT.Rows[0]["mobile"].ToString();
                    Session["newthread"] = "-1";
                    Session["bymobile"] = "-1";
                    if (Session["mobile"].ToString()=="ناشناس")
                    {
                        logs.CreateLog(Convert.ToInt32(Session["userid"]), -1, 38, "ورود موفق شاکی با کد پیگیری:" + Session["userid"], "ناشناس", -1, " ");
                        Response.Redirect("/thread.aspx", true);
                    }
                    else
                    {
                        Response.Redirect("/verifier.aspx", true);
                    }
                    
                }
                else
                {
                    result = false;
                }




            }
            else
            {
                result = false;
            }

        }

        protected void newDiscontent_Click(object sender, EventArgs e)
        {
            if (validateNewDiscontent())
            {
                // search for client with mobile number
                Shekayat.clientsDataTable clients = clientsTA.GetClientsByMobile(mobile.Text);

                // generate new random token
                var rnd = new Random(DateTime.Now.Millisecond);
                int token = rnd.Next(1000, 9999);

                // check if client has records or not
                if (clients.Rows.Count > 0)
                {
                    // client has records
                    clientsTA.UpdateClient(firstName.Text, lastName.Text, mobile.Text, Convert.ToInt32(Province.SelectedValue), city.Text, Convert.ToDateTime(clients.Rows[0]["creationdate"]), DateTime.Now, true, token.ToString(), NationalCode.Text, InsuranceCode.Text, Convert.ToInt64(clients.Rows[0]["userid"]));
                    Session["userid"] = clients.Rows[0]["userid"];
                }
                else
                {
                    // new client
                    object identity = clientsTA.InsertClient(firstName.Text, lastName.Text, mobile.Text, Convert.ToInt32(Province.SelectedValue), city.Text, DateTime.Now, DateTime.Now, true, token.ToString(), NationalCode.Text, InsuranceCode.Text);
                    if (Convert.ToInt32(identity) == 1)
                    {
                        clients = clientsTA.GetClientsByMobile(mobile.Text);
                        if (clients.Rows.Count > 0)
                        {
                            Session["userid"] = clients.Rows[0]["userid"];
                            logs.CreateLog(Convert.ToInt32(identity), -1, 6, "شاکی جدید:" + mobile.Text, firstName.Text + " " + lastName.Text, -1, Province.SelectedItem.Text + "," + city.Text);
                        }
                    }


                }

                Session["tokenerrors"] = 4; // token error count reset
                Session["token"] = token;
                Session["mobile"] = mobile.Text;
                Session["newthread"] = "1";
                Response.Redirect("/verifier.aspx", true);
                //Server.Transfer("/verifier.aspx", true);
            }
        }
        protected void unknownDiscontent_Click(object sender, EventArgs e)
        {

            // search for client with mobile number
            //Shekayat.clientsDataTable clients = clientsTA.GetClientsByMobile(mobile.Text);
            Shekayat.clientsDataTable clients = new Shekayat.clientsDataTable();

            // generate new random token
            var rnd = new Random(DateTime.Now.Millisecond);
            int token = rnd.Next(1000, 9999);

            // check if client has records or not
            //if (clients.Rows.Count > 0)
            //{
            //    // client has records
            //    clientsTA.UpdateClient(firstName.Text, lastName.Text, mobile.Text, Convert.ToInt32(Province.SelectedValue), city.Text, Convert.ToDateTime(clients.Rows[0]["creationdate"]), DateTime.Now, true, token.ToString(), NationalCode.Text, InsuranceCode.Text, Convert.ToInt64(clients.Rows[0]["userid"]));
            //    Session["userid"] = clients.Rows[0]["userid"];
            //}
            //else
            //{
            // new client
            object identity = clientsTA.InsertUnknown("ناشناس", "ناشناس", "ناشناس", 32, "ناشناس", DateTime.Now, DateTime.Now, true, token.ToString(), "ناشناس", "ناشناس");
            if (Convert.ToInt32(identity) > 0)
            {
                clients = clientsTA.GetClientByClientID(Convert.ToInt64(identity));
                if (clients.Rows.Count > 0)
                {
                    Session["userid"] = clients.Rows[0]["userid"];
                    logs.CreateLog(Convert.ToInt32(identity), -1, 37, "شاکی ناشناس جدید:" + Session["userid"], "ناشناس", -1, " ");
                }
            }


            //}

            Session["tokenerrors"] = 4; // token error count reset
            Session["token"] = token;
            Session["mobile"] = "";
            Session["newthread"] = "1";
            //logs.CreateLog(Convert.ToInt32(identity), -1, 1, "ورود شاکی ناشناس", "token:" + Session["token"], -1, "");
            Response.Redirect("/newdiscontent.aspx", true);
            //Server.Transfer("/verifier.aspx", true);

        }


        bool validateNewDiscontent()
        {
            bool result = true;
            if (firstName.Text.Length < 1 || PermissionChecks.checkForSQLInjection(firstName.Text))
            {
                result = false;
                RemoveCssClass(firstName, "is-invalid");
                AddCssClass(firstName, "is-invalid");
            }
            else
            {
                RemoveCssClass(firstName, "is-invalid");
            }

            if (lastName.Text.Length < 1 || PermissionChecks.checkForSQLInjection(lastName.Text))
            {
                result = false;
                RemoveCssClass(lastName, "is-invalid");
                AddCssClass(lastName, "is-invalid");
            }
            else
            {
                RemoveCssClass(lastName, "is-invalid");
            }

            if (NationalCode.Text.Length < 10 || PermissionChecks.checkForSQLInjection(NationalCode.Text))
            {
                result = false;
                RemoveCssClass(NationalCode, "is-invalid");
                AddCssClass(NationalCode, "is-invalid");
            }
            else
            {
                RemoveCssClass(NationalCode, "is-invalid");
            }

            if (!IsValidPhone(mobile.Text) || PermissionChecks.checkForSQLInjection(mobile.Text))
            {
                result = false;
                RemoveCssClass(mobile, "is-invalid");
                AddCssClass(mobile, "is-invalid");
            }
            else
            {
                RemoveCssClass(mobile, "is-invalid");
            }

            if (Province.SelectedValue == "-1")
            {
                result = false;
                RemoveCssClass(Province, "is-invalid");
                AddCssClass(Province, "is-invalid");
            }
            else
            {
                RemoveCssClass(Province, "is-invalid");
            }

            if (city.Text.Length < 1 || PermissionChecks.checkForSQLInjection(city.Text))
            {
                result = false;
                RemoveCssClass(city, "is-invalid");
                AddCssClass(city, "is-invalid");
            }
            else
            {
                RemoveCssClass(city, "is-invalid");
            }


            return result;
        }


        public bool IsValidPhone(string Phone)
        {
            try
            {
                if (string.IsNullOrEmpty(Phone))
                    return false;
                if (Phone.StartsWith("0"))
                {
                    Phone = Phone.Remove(0, 1);
                }

                var r = new Regex(@"^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$");
                return r.IsMatch(Phone);

            }
            catch (Exception)
            {
                throw;
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