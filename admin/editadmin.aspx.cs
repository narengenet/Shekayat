using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Shekayat.admin
{
    public partial class editadmin : System.Web.UI.Page
    {
        Shekayat.admin_rolesDataTable admin_rolesDT = new Shekayat.admin_rolesDataTable();
        public bool newadmin_mode = false;
        protected void Page_Load(object sender, EventArgs e)
        {





            if (!IsPostBack)
            {
                // get selected admin id from query string
                if (Request.QueryString["id"] == null && Request.QueryString["action"] == null)
                {
                    Response.Redirect("~/admin/dashboard.aspx", true);
                    return;
                }

                if (Request.QueryString["id"] != null)
                {
                    LoadAdmin();
                }

            }

            if (Request.QueryString["action"] != null)
            {
                NewAdmin();
            }



        }


        protected void NewAdmin()
        {
            // check permission for new admin
            int _adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            if (!PermissionChecks.CheckPermission(3, _adminid))
            {
                Response.Redirect("~/admin/admins.aspx?from=newadmin&result=failed&id=-1", true);
                return;
            }
            newadmin_mode = true;

        }


        protected void LoadAdmin()
        {
            // check permission for update admin
            int _adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            if (!PermissionChecks.CheckPermission(2, _adminid))
            {
                Response.Redirect("~/admin/dashboard.aspx", true);
                return;
            }


            int targetadminid = Convert.ToInt32(Request.QueryString["id"]);

            // search for admin by id
            ShekayatTableAdapters.adminsTableAdapter adminTA = new ShekayatTableAdapters.adminsTableAdapter();
            Shekayat.adminsDataTable dt = new Shekayat.adminsDataTable();
            dt = adminTA.GetDataByID(targetadminid);
            // fill admin data
            if (dt.Rows.Count > 0)
            {
                name.Text = dt.Rows[0]["name"].ToString();
                family.Text = dt.Rows[0]["family"].ToString();
                mobile.Text = dt.Rows[0]["mobile"].ToString();
                isactive.Checked = dt.Rows[0]["isactive"].ToString() == "True" ? true : false;

                ShekayatTableAdapters.admin_rolesTableAdapter arTA = new ShekayatTableAdapters.admin_rolesTableAdapter();
                admin_rolesDT = arTA.GetRolesByAdminID(targetadminid);
                string stringRows = DataTableToJSONWithStringBuilder(admin_rolesDT);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myScript", "FillRoles(" + stringRows + ");", true);


            }
        }

        bool validate()
        {
            bool result = true;
            if (name.Text.Length < 1 || PermissionChecks.checkForSQLInjection(name.Text))
            {
                result = false;
                RemoveCssClass(name, "is-invalid");
                AddCssClass(name, "is-invalid");
            }
            else
            {
                RemoveCssClass(name, "is-invalid");
            }


            if (family.Text.Length < 1 || PermissionChecks.checkForSQLInjection(family.Text))
            {
                result = false;
                RemoveCssClass(family, "is-invalid");
                AddCssClass(family, "is-invalid");
            }
            else
            {
                RemoveCssClass(family, "is-invalid");
            }

            if (!IsValidPhone(mobile.Text))
            {
                result = false;
                RemoveCssClass(mobile, "is-invalid");
                AddCssClass(mobile, "is-invalid");
            }
            else
            {
                // check mobile number is unique or not
                ShekayatTableAdapters.adminsTableAdapter _ta = new ShekayatTableAdapters.adminsTableAdapter();
                Shekayat.adminsDataTable _tmpDT = _ta.GetDataByMobile(mobile.Text);
                if (_tmpDT.Rows.Count==1)
                {
                    // own mobile or not
                    if (_tmpDT.Rows[0]["adminid"].ToString()==Request.QueryString["id"] && !newadmin_mode)
                    {
                        RemoveCssClass(mobile, "is-invalid");
                    }
                    else
                    {
                        result = false;
                        RemoveCssClass(mobile, "is-invalid");
                        AddCssClass(mobile, "is-invalid");
                    }
                }
                // mobile number is vacant
                if (_tmpDT.Rows.Count == 0)
                {
                    RemoveCssClass(mobile, "is-invalid");
                }
                
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (newadmin_mode)
            {
                createNewAdmin();
            }
            else
            {
                updateAdmin();
            }


        }

        void createNewAdmin()
        {


            if (!validate())
            {
                return;
            }

            long adminid = Convert.ToInt64(SessionHelpers.GetSession("adminid", true));

            ShekayatTableAdapters.adminsTableAdapter adminTA = new ShekayatTableAdapters.adminsTableAdapter();
            object _targetadminid= adminTA.InsertNewAdmin(name.Text, family.Text, mobile.Text, DateTime.Now, DateTime.Now, "1234", isactive.Checked);
            long targetadminid = Convert.ToInt64(_targetadminid);

            if (Convert.ToInt64(_targetadminid) < 1)
            {
                logs.CreateLog(-1, Convert.ToInt32(adminid), 19, "insert admin by:", adminid.ToString(), Convert.ToInt32(targetadminid), "");

                Response.Redirect("~/admin/admins.aspx?from=newadmin&result=failed", true);
                return;
            }

            // clear all admin permissions
            ShekayatTableAdapters.admin_rolesTableAdapter arTA = new ShekayatTableAdapters.admin_rolesTableAdapter();
            arTA.DeleteAllRolesByAdminID(targetadminid);

            foreach (Control item in Repeater2.Controls)
            {
                foreach (var control in item.Controls)
                {
                    if (control is CheckBox)
                    {
                        if (((CheckBox)control).Checked)
                        {
                            CheckBox chb = (CheckBox)control;
                            string thename = chb.Text;
                            ShekayatTableAdapters.rolesTableAdapter rolesTA = new ShekayatTableAdapters.rolesTableAdapter();
                            Shekayat.rolesDataTable _tmpDT = rolesTA.GetRoleByName(thename);
                            if (_tmpDT.Rows.Count > 0)
                            {
                                int roleid = Convert.ToInt32(_tmpDT.Rows[0]["role_id"]);
                                arTA.InsertAdminRole(targetadminid, roleid, adminid, DateTime.Now);
                            }
                        }
                        else
                        {
                            //do your stuff
                        }
                    }
                }

            }

            logs.CreateLog(-1, Convert.ToInt32(adminid), 18, "insert admin by:", adminid.ToString(), Convert.ToInt32(targetadminid), "");

            Response.Redirect("~/admin/admins.aspx?from=newadmin&result=success&id=" + targetadminid.ToString(), true);

        }

        void updateAdmin()
        {
            if (!validate())
            {
                return;
            }
            // update admin table
            ShekayatTableAdapters.adminsTableAdapter adminsTA = new ShekayatTableAdapters.adminsTableAdapter();
            long targetadminid = Convert.ToInt64(Request.QueryString["id"]);
            long adminid = Convert.ToInt64(SessionHelpers.GetSession("adminid", true));
            adminsTA.UpdateAdmin(name.Text, family.Text, mobile.Text, DateTime.Now, isactive.Checked, targetadminid);

            // clear all admin permissions
            ShekayatTableAdapters.admin_rolesTableAdapter arTA = new ShekayatTableAdapters.admin_rolesTableAdapter();
            arTA.DeleteAllRolesByAdminID(targetadminid);

            foreach (Control item in Repeater2.Controls)
            {
                foreach (var control in item.Controls)
                {
                    if (control is CheckBox)
                    {
                        if (((CheckBox)control).Checked)
                        {
                            CheckBox chb = (CheckBox)control;
                            string thename = chb.Text;
                            ShekayatTableAdapters.rolesTableAdapter rolesTA = new ShekayatTableAdapters.rolesTableAdapter();
                            Shekayat.rolesDataTable _tmpDT = rolesTA.GetRoleByName(thename);
                            if (_tmpDT.Rows.Count > 0)
                            {
                                int roleid = Convert.ToInt32(_tmpDT.Rows[0]["role_id"]);
                                arTA.InsertAdminRole(targetadminid, roleid, adminid, DateTime.Now);
                            }
                        }
                        else
                        {
                            //do your stuff
                        }
                    }
                }

            }

            logs.CreateLog(-1, Convert.ToInt32(adminid), 16, "update admin by:", adminid.ToString(), Convert.ToInt32(targetadminid), "");

            Response.Redirect("~/admin/admins.aspx?from=adminedit&result=success&id=" + targetadminid.ToString(), true);
        }




        public string DataTableToJSONWithStringBuilder(DataTable table)
        {
            var JSONString = new StringBuilder();
            if (table.Rows.Count > 0)
            {
                JSONString.Append("[");
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    JSONString.Append("{");
                    for (int j = 0; j < table.Columns.Count; j++)
                    {
                        if (j < table.Columns.Count - 1)
                        {
                            JSONString.Append("\"" + table.Columns[j].ColumnName.ToString() + "\":" + "\"" + table.Rows[i][j].ToString() + "\",");
                        }
                        else if (j == table.Columns.Count - 1)
                        {
                            JSONString.Append("\"" + table.Columns[j].ColumnName.ToString() + "\":" + "\"" + table.Rows[i][j].ToString() + "\"");
                        }
                    }
                    if (i == table.Rows.Count - 1)
                    {
                        JSONString.Append("}");
                    }
                    else
                    {
                        JSONString.Append("},");
                    }
                }
                JSONString.Append("]");
            }
            return JSONString.ToString();
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/admins.aspx", true);
        }
    }
}