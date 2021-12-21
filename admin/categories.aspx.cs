using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat.admin
{
    public partial class categories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));

            if (SessionHelpers.GetSession("successdeleted", false) != null)
            {

                if (SessionHelpers.GetSession("successdeleted", false) == "1")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "successDeleteDep();", true);
                }
                SessionHelpers.SetSession("successdeleted", false, null);



                GridView1.DataSource = departmentsSqlDataSource;
                GridView1.DataBind();
                return;
            }


            bool permissionpage = PermissionChecks.CheckPermission(8, adminid);
            if (!permissionpage)
            {
                Response.Redirect("~/admin/dashboard.aspx", true);
            }



            //if (SessionHelpers.GetSession("editingmode",false)!=null)
            //{
            //    if (SessionHelpers.GetSession("editingmode",false)=="1")
            //    {
            //        Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
            //    }

            //    if (SessionHelpers.GetSession("editingmode", false) == "0")
            //    {
            //        Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "hideEditDeps();", true);
            //    }

            //    SessionHelpers.SetSession("editingmode", false, null);
            //}
            //else
            //{
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "hideEditDeps();", true);
            //}

            if (SessionHelpers.GetSession("result", false) != null)
            {
                string _result = SessionHelpers.GetSession("result", false).ToString();
                SessionHelpers.SetSession("result", false, null);
                // permission problem to create new dep
                if (_result == "0")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "errorPermission('ایجاد دسته بندی جدید');", true);
                }
                // permission problem to delete dep
                if (_result == "-2")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "errorPermission('حذف دسته بندی');", true);
                }
                // success delete dep
                if (_result == "2")
                {
                    string _delDepIndex = SessionHelpers.GetSession("selectedindex", false).ToString();
                    SessionHelpers.SetSession("selectedindex", false, null);
                    SessionHelpers.SetSession("successdeleted", false, "0");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "goDeleteDep(" + _delDepIndex + ");", true);
                }
                // permission problem to edit dep
                if (_result == "-3")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "errorPermission('ویرایش دسته بندی');", true);
                }
                // problem to edit dep
                if (_result == "-4")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "errorEditDep();", true);
                }
                // problem to edit dep
                if (_result == "3")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "successEditDep();", true);
                }

                // new dep name was used before
                if (_result == "-1")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "errorCreateNewDep('ایجاد دسته بندی جدید');", true);
                }
                // new dep was created
                if (_result == "1")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "successCreateNewDep();", true);
                }



                GridView1.DataSource = departmentsSqlDataSource;
                GridView1.DataBind();

            }
            else
            {
                if (IsPostBack)
                {
                    if (search.Text.Length > 0)
                    {
                        GridView1.DataSource = searchSqlDataSource;
                        GridView1.DataBind();
                    }
                    else
                    {
                        GridView1.DataSource = departmentsSqlDataSource;
                        GridView1.DataBind();
                    }
                }
                else
                {
                    GridView1.DataSource = departmentsSqlDataSource;
                    GridView1.DataBind();
                }
            }

        }

        protected void btnCreateNewCategory_Click(object sender, EventArgs e)
        {
            if (newCategory.Text.Length > 0)
            {
                int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
                bool permissionpage = PermissionChecks.CheckPermission(9, adminid);
                if (!permissionpage)
                {
                    SessionHelpers.SetSession("result", false, "0");
                    Response.Redirect("~/admin/categories.aspx", true);
                }

                ShekayatTableAdapters.departmentsTableAdapter depTA = new ShekayatTableAdapters.departmentsTableAdapter();
                Shekayat.departmentsDataTable _dt = new Shekayat.departmentsDataTable();
                _dt = depTA.GetDepByName(newCategory.Text);
                if (_dt.Rows.Count > 0)
                {
                    SessionHelpers.SetSession("result", false, "-1");
                    Response.Redirect("~/admin/categories.aspx", true);
                }
                else
                {
                    object newdepID = depTA.InsertNewDepartment(newCategory.Text);
                    SessionHelpers.SetSession("result", false, "1");
                    logs.CreateLog(-1, adminid, 25, "دپارتمان جدید:", newCategory.Text, Convert.ToInt32(newdepID), newCategory.Text);
                    Response.Redirect("~/admin/categories.aspx", true);
                }

            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue != "-1")
            {
                int _selectedIndex = Convert.ToInt32(DropDownList1.SelectedValue);
                switch (DropDownList1.SelectedValue)
                {
                    case "1":
                        deleteDep(_selectedIndex);
                        break;
                    case "2":
                        editDep(_selectedIndex);
                        break;
                    default:
                        break;
                }

            }
        }


        void deleteDep(int ind)
        {
            bool permissionpage = false;
            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            permissionpage = PermissionChecks.CheckPermission(10, adminid);
            if (!permissionpage)
            {
                SessionHelpers.SetSession("result", false, "-2");
                Response.Redirect("~/admin/categories.aspx", true);
            }
            else
            {
                int selectedDepId = Convert.ToInt32(GridView1.SelectedRow.Cells[1].Text);
                //ShekayatTableAdapters.departmentsTableAdapter depTA = new ShekayatTableAdapters.departmentsTableAdapter();
                //depTA.DeleteDepByID(selectedDepId);

                SessionHelpers.SetSession("result", false, "2");
                SessionHelpers.SetSession("selectedindex", false, selectedDepId);

                Response.Redirect("~/admin/categories.aspx", true);
            }

        }

        void editDep(int ind)
        {
            bool permissionpage = false;
            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            // check admin permission for edit department
            permissionpage = PermissionChecks.CheckPermission(11, adminid);
            if (!permissionpage)
            {
                SessionHelpers.SetSession("result", false, "-3");
                Response.Redirect("~/admin/categories.aspx", true);
            }
            else
            {
                int selectedDepId = Convert.ToInt32(GridView1.SelectedRow.Cells[1].Text);
                string selectedDepText = GridView1.SelectedRow.Cells[2].Text;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDep", "enableEdit(" + selectedDepId + ",'" + selectedDepText + "')", true);

                //Session["result"] = "3";
                //Session["selectedindex"] = selectedDepId;
                //Response.Redirect("~/admin/categories.aspx", true);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int depVal = Convert.ToInt32(HiddenField1.Value);
            if (TextBox1.Text.Length < 1)
            {
                return;
            }
            else
            {
                bool _result = true;
                ShekayatTableAdapters.departmentsTableAdapter depTA = new ShekayatTableAdapters.departmentsTableAdapter();
                Shekayat.departmentsDataTable _dt = new Shekayat.departmentsDataTable();
                _dt = depTA.GetDepByName(TextBox1.Text);
                if (_dt.Rows.Count == 1)
                {
                    if (_dt.Rows[0]["department_id"].ToString() != depVal.ToString())
                    {
                        SessionHelpers.SetSession("result", true, "-4");
                    }
                }
                else if (_dt.Rows.Count == 0)
                {
                    depTA.Update(TextBox1.Text, depVal);
                    SessionHelpers.SetSession("result", true, "3");

                }

                Response.Redirect("~/admin/categories.aspx", true);
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex >= 0)
            {
                //SessionHelpers.SetSession("editingmode", false, "1");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                var dv = new DataView();
                var dt = new DataTable();

                // Here mySQLDataSource is the ID of SQLDataSource
                dv = SqlDataSource1.Select(DataSourceSelectArguments.Empty) as DataView;
                dt = dv.ToTable();
                thiscategoryThreadCount.Text = dt.Rows.Count.ToString();
            }
            else
            {
                //SessionHelpers.SetSession("editingmode", false, "0");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "hideEditDeps();", true);

            }
        }
    }
}