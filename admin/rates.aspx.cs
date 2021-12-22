using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PersianCalendar;
using Shekayat.controllers;
using System.Text;


namespace Shekayat.admin
{
    public partial class rates : System.Web.UI.Page
    {
        public int score0 = 0;
        public int score1 = 0;
        public int score2 = 0;
        public int score3 = 0;
        public int score4 = 0;
        public int score5 = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            int adminid = Convert.ToInt32(Session["adminid"]);
            bool pagepermission = true;
            // check admin permission for view threads
            pagepermission = PermissionChecks.CheckPermission(18, adminid);
            if (!pagepermission)
            {
                Response.Redirect("~/admin/dashboard.aspx", true);
            }
            else
            {
                bindData();
            }
            
            //if (!Page.IsPostBack)
            //{
            //    bindData();
            //}

            //SqlCommand cmd = new SqlCommand("insert into Employee_Master(EmployeeID,EmpFirstName,EmpLastName,EmpEmail,EmpUserRole,EmpUserName,EmpPassword,EmpContactNo,EmpDepartmentName)values('" + EmpIdTB.Text + "','" + EmpFnameTB.Text + "','" + EmpLastnameTB.Text + "','" + EmpEmailTB.Text + "','" + AuthorizationDDL.Text + "','" + EmpUsernameTB.Text + "','" + EmpPwdTB.Text + "','" + EmpContactTB.Text + "','" + DepartNameDDL.Text + "')", con);

            //cmd.ExecuteNonQuery();
            //Response.Write("<script>alert('Value Inserted Succesfully!!!')</script>");
            //bindData();
            //var dv = new DataView();
            //var dt = new DataTable();

            //// Here mySQLDataSource is the ID of SQLDataSource
            //dv = SqlDataSource3.Select(DataSourceSelectArguments.Empty) as DataView;
            //dt = dv.ToTable();
        }

        protected void DropDownList1_DataBound(object sender, EventArgs e)
        {
            DropDownList1.Items.Insert(0, new ListItem("همه", "0"));

        }

        protected void DropDownList2_DataBound(object sender, EventArgs e)
        {
            DropDownList2.Items.Insert(0, new ListItem("همه", "2"));
        }

        protected void SqlDataSource3_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {

        }

        //---- Bind data in GridView.
        public void bindData()
        {
            
            //--- Getting connection string defined in the web.config file. Pointed to the database we want to use.
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["shekayatConnectionString"].ConnectionString);
            string cmdText = "SELECT threads.thread_id AS 'شناسه شکایت', clients.name AS نام, clients.family AS 'نام خانوادگی' ,threads.creationdate AS تاریخ, states.state_name AS استان, clients.city AS شهر, departments.name AS دپارتمان,threads.score AS امتیاز , clients.mobile AS 'تلفن همراه',threads.subject AS 'موضوع شکایت'  FROM  clients INNER JOIN  threads ON clients.userid = threads.userid INNER JOIN departments ON threads.department_id = departments.department_id INNER JOIN states ON clients.state_id = states.state_id WHERE (1=1) ";
            //string cmdText = "SELECT clients.state_id, threads.userid, threads.creationdate, threads.department_id, threads.score FROM clients INNER JOIN threads ON clients.userid = threads.userid WHERE (threads.creationdate > '1/1/2018') AND (threads.creationdate < '1/1/2022') AND (threads.department_id = 2)";
            if (DropDownList1.SelectedValue.Length > 0)
            {
                if (DropDownList1.SelectedValue != "0")
                {
                    cmdText += " AND (clients.state_id = " + DropDownList1.SelectedValue + ")";
                }

            }

            if (DropDownList2.SelectedValue.Length > 0)
            {
                if (DropDownList2.SelectedValue != "2")
                {
                    cmdText += "AND (threads.department_id = " + DropDownList2.SelectedValue + ")";
                }
            }

            if (txtFromDate.Text.Length>1)
            {
                var p = new System.Globalization.PersianCalendar();
                string PersianDate1 = txtFromDate.Text;
                string[] parts = PersianDate1.Split('/', '-');
                DateTime dta1 = p.ToDateTime(Convert.ToInt32(parts[0]), Convert.ToInt32(parts[1]), Convert.ToInt32(parts[2]), 0, 0, 0, 0);
                cmdText += "AND (threads.creationdate > '"+dta1.Month.ToString()+"/"+dta1.Day.ToString()+"/"+dta1.Year.ToString()+"')";
            }

            if (txtToDate.Text.Length > 1)
            {
                var p = new System.Globalization.PersianCalendar();
                string PersianDate1 = txtToDate.Text;
                string[] parts = PersianDate1.Split('/', '-');
                DateTime dta1 = p.ToDateTime(Convert.ToInt32(parts[0]), Convert.ToInt32(parts[1]), Convert.ToInt32(parts[2]), 0, 0, 0, 0);
                cmdText += "AND (threads.creationdate < '" + dta1.Month.ToString() + "/" + dta1.Day.ToString() + "/" + dta1.Year.ToString() + "')";
            }


            cmdText += " ORDER BY threads.creationdate DESC ";
            //--- Select Query.


            SqlDataAdapter adp = new SqlDataAdapter(cmdText, con);
            DataSet ds = new DataSet();
            adp.Fill(ds);

            float scores = 0;
            score0 = 0;
            score1 = 0;
            score2 = 0;
            score3 = 0;
            score4 = 0;
            score5 = 0;

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                scores += Convert.ToInt32(ds.Tables[0].Rows[i][7].ToString());
                switch (ds.Tables[0].Rows[i][7].ToString())
                {
                    case "0":
                        //ds.Tables[0].Rows[i][7] = "---";
                        score0 += 1;
                        break;
                    case "1":
                        //ds.Tables[0].Rows[i][7] = "خیلی بد";
                        score1 += 1;
                        break;
                    case "2":
                        //ds.Tables[0].Rows[i][7] = "بد";
                        score2 += 1;
                        break;
                    case "3":
                        //ds.Tables[0].Rows[i][7] = "متوسط";
                        score3 += 1;
                        break;
                    case "4":
                        //ds.Tables[0].Rows[i][7] = "خوب";
                        score4 += 1;
                        break;
                    case "5":
                        //ds.Tables[0].Rows[i][7] = "خیلی خوب";
                        score5 += 1;
                        break;
                    default:
                        break;
                }

            }

            GridView1.DataSource = ds;
            GridView1.DataBind();
            threadCounts.Text = ds.Tables[0].Rows.Count.ToString();
            if (threadCounts.Text != "0")
            {
                ScoreSum.Text = (scores / (Convert.ToInt32(threadCounts.Text))).ToString();
                if (ScoreSum.Text.Contains("."))
                {
                    
                }
            }
            else
            {
                ScoreSum.Text = scores.ToString();
            }

        }

        protected void txtFromDate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            bool pagepermission = PermissionChecks.CheckPermission(14, adminid);
            if (!pagepermission)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('خروجی گرفتن از');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                logs.CreateLog(-1, adminid, 33, "Excel", "دسترسی خروجی اکسل وجود نداشت", 0, "");
                return;
            }


            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=رضایتمندی.xls");
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            this.GridView1.RenderControl(new HtmlTextWriter(sw));
            logs.CreateLog(-1, adminid, 34, "Excel", "خروج موفق اکسل", 0, "");
            Response.Write(sw.ToString());
            Response.End();
            
        }



        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

    }
}