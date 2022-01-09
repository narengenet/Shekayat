using Shekayat.controllers;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Text;
using System.Data;
using System.Collections.Specialized;

namespace Shekayat.admin
{
    public partial class clientthreads : System.Web.UI.Page
    {
        public static long threadid_client = -1;
        public static string threadsubject_client = "";
        public static string threadfullname_client = "";
        public static string threadfulllocation_client = "";
        public static string threadscore_client = "";
        public static string threaddep_client = "";
        public static string threadnational_client = "";
        public static string threadinsurance_client = "";
        public static string threadmobile_client = "";
        public static string threadfixedtoken = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            int adminid = Convert.ToInt32(Session["adminid"]);
            bool pagepermission = true;
            // check admin permission for view threads
            pagepermission = PermissionChecks.CheckPermission(5, adminid);
            if (!pagepermission)
            {
                Response.Redirect("~/admin/dashboard.aspx", true);
            }


            if (Session["successdeleted"] != null)
            {

                if (SessionHelpers.GetSession("successdeleted", false) == "1")
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "showDeletResult();", true);
                }

                Session["successdeleted"] = null;

                return;
            }

            if (Session["delete"] != null)
            {
                // check admin permission for delete thread
                pagepermission = PermissionChecks.CheckPermission(7, adminid);
                if (!pagepermission)
                {
                    Response.Redirect("~/admin/clientthreads.aspx", true);
                }
                Session["delete"] = null;
                string _threadid = Session["threadid"].ToString();
                Session["threadid"] = null;
                Session["successdeleted"] = "0";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "goDeleteThread(" + _threadid + ");", true);
                // delete thread
                //deleteThreadConfirmed(Convert.ToInt64(Request.QueryString["id"]));
                //Response.Redirect("~/admin/clientthreads.aspx?result=deleted", true);


            }
            else if (Session["delete"] == null)
            {


                //if (Session["result"]!=null && Session["selectedindex"] != null)
                //{
                //    Session["result"] = null;
                //    int selectedindex = Convert.ToInt32(Session["selectedindex"]);
                //    int pageindex = Convert.ToInt32(Session["pageindex"]);
                //    Session["selectedindex"] = null;
                //    Session["pageindex"] = null;
                //    GridView1.PageIndex = pageindex;
                //    GridView1.SelectRow(selectedindex);
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "successEditThread();", true);
                //}


            }

            if (!IsPostBack)
            {
                DropDownList2.Items.Add(new System.Web.UI.WebControls.ListItem("بدون دسته بندی ...", "-1"));
            }

            searchBox.Visible = false;

            if (DropDownList3.SelectedValue != "-1")
            {
                switch (DropDownList3.SelectedValue)
                {
                    case "0":
                        Session["datasource"] = todayDS;
                        GridView1.DataSource = todayDS;
                        GridView1.DataBind();
                        break;
                    case "1":
                        Session["datasource"] = notseenDS;
                        GridView1.DataSource = notseenDS;
                        GridView1.DataBind();
                        break;
                    case "2":
                        //Session["datasource"] = notansweredDS;
                        //GridView1.DataSource = notansweredDS;
                        //GridView1.DataBind();
                        //break;
                        Session["datasource"] = Threads;
                        GridView1.DataSource = Threads;
                        GridView1.DataBind();
                        break;
                    case "3":
                        Session["datasource"] = openDS;
                        GridView1.DataSource = openDS;
                        GridView1.DataBind();
                        break;
                    case "4":
                        Session["datasource"] = closedDS;
                        GridView1.DataSource = closedDS;
                        GridView1.DataBind();
                        break;
                    case "5":
                        Session["datasource"] = searchDS;
                        GridView1.DataSource = searchDS;
                        GridView1.DataBind();
                        searchBox.Visible = true;
                        break;
                    default:
                        break;
                }

                    

            }
            else
            {
                //GridView1.DataSource = Threads;
                //GridView1.DataBind();
                Session["datasource"] = notansweredDS;
                GridView1.DataSource = notansweredDS;
                GridView1.DataBind();
                
            }


            if (SessionHelpers.GetSession("threadgridpagesize", true) != null && DropDownList4.SelectedIndex==0)
            {

                if (DropDownList4.SelectedIndex != Convert.ToInt32(SessionHelpers.GetSession("threadgridpagesize", true)))
                {
                    DropDownList4.SelectedIndex = Convert.ToInt32(SessionHelpers.GetSession("threadgridpagesize", true));
                    GridView1.PageSize = Convert.ToInt32(DropDownList4.SelectedValue);
                    GridView1.DataBind();
                }

            }
            //Repeater1.DataBind();

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex < 0)
            {
                return;
            }


            long threadid = -1;
            bool isreplyed = false;
            if (GridView1.SelectedIndex >= 0)
            {
                string _threadid = GridView1.SelectedRow.Cells[1].Text;
                CheckBox _isreplyed=(CheckBox)GridView1.SelectedRow.Cells[9].Controls[0];
                threadid = Convert.ToInt64(_threadid);
                isreplyed = _isreplyed.Checked;
            }

            int adminid = Convert.ToInt32(Session["adminid"]);
            // ekhtetam shekayat
            if (DropDownList1.SelectedValue=="1" && !PermissionChecks.CheckPermission(16, adminid))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('اختتام  ');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                return;
            }
            
            // ekhtetam shekayat but thread is not replyed
            if (DropDownList1.SelectedValue=="1" && isreplyed == false)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('اختتام این ');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                return;
            }
            // laghve ekhtetam
            if (DropDownList1.SelectedValue == "2" && !PermissionChecks.CheckPermission(17, adminid))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('لغو اختتام شکایت ');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                return;
            }

            if (DropDownList1.SelectedValue != "5" && !PermissionChecks.CheckPermission(6, adminid))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('ایجاد تغییرات در');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                return;
            }

            if (DropDownList1.SelectedValue == "5" && !PermissionChecks.CheckPermission(7, adminid))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "deleteScript", "notEditPermited('حذف');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                return;
            }



            switch (DropDownList1.SelectedValue)
            {
                case "-1":
                    int score = Convert.ToInt32(SessionHelpers.GetSession("currentscore", true));
                    string isclosed = SessionHelpers.GetSession("isclosed", true);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed + "');", true);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainers", "showEditDeps();", true);
                    break;
                case "1":
                    closeThread(threadid, GridView1.SelectedIndex, GridView1.PageIndex);
                    GridView1.DataBind();
                    if (GridView1.Rows.Count>0 && GridView1.Rows.Count>GridView1.SelectedIndex)
                    {
                        GridView1.SelectRow(GridView1.SelectedIndex);
                    }
                    else
                    {
                        GridView1.SelectRow(0);
                    }

                    DropDownList1.SelectedIndex= 0;
                    break;
                case "2":
                    openThread(threadid, GridView1.SelectedIndex, GridView1.PageIndex);
                    GridView1.DataBind();
                    DropDownList1.SelectedIndex = 0;
                    break;
                case "3":
                    seenThread(threadid, GridView1.SelectedIndex, GridView1.PageIndex);
                    GridView1.SelectedIndex = 0;
                    DropDownList1.SelectedIndex = 0;
                    break;
                case "4":
                    notSeenThread(threadid, GridView1.SelectedIndex, GridView1.PageIndex);
                    GridView1.SelectedIndex = GridView1.SelectedIndex;
                    DropDownList1.SelectedIndex = 0;
                    break;
                case "5":
                    GridView1.SelectedIndex = 0;
                    deleteThread(threadid);
                    break;
                default:
                    break;
            }

            if (GridView1.Rows.Count > 0 && GridView1.Rows.Count > GridView1.SelectedIndex)
            {
                GridView1.SelectRow(GridView1.SelectedIndex);
            }
            else
            {
                GridView1.SelectRow(0);
            }
            Repeater1.DataBind();
        }

        void closeThread(long threadid, int selectedIndex, int pageindex)
        {
            int adminid = Convert.ToInt32(Session["adminid"]);
            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            threadTA.UpdateIsClosedThreadByThreadID(true, threadid);
            logs.CreateLog(-1, adminid, 20, "اختتام شکایت توسط ادمین:", adminid.ToString(), Convert.ToInt32(threadid), "");


            //Session["result"] = "edited";
            //Session["selectedindex"] = selectedIndex;
            //Session["pageindex"] = pageindex;
            //todayDS.DataBind();
            GridView1.DataBind();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainerr", "successEditThread();", true);
            int score = Convert.ToInt32(SessionHelpers.GetSession("currentscore", true));
            string isclosed = SessionHelpers.GetSession("isclosed", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed + "');", true);
            //Response.Redirect("~/admin/clientthreads.aspx");
        }

        void openThread(long threadid, int selectedIndex, int pageindex)
        {
            int adminid = Convert.ToInt32(Session["adminid"]);
            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            threadTA.UpdateIsClosedThreadByThreadID(false, threadid);
            logs.CreateLog(-1, adminid, 21, "باز کردن شکایت توسط مدیر:", adminid.ToString(), Convert.ToInt32(threadid), "");
            //Session["result"] = "edited";
            //Session["selectedindex"] = selectedIndex;
            //Session["pageindex"] = pageindex;
            //Response.Redirect("~/admin/clientthreads.aspx");
            //todayDS.DataBind();
            GridView1.DataBind();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainerr", "successEditThread();", true);
            int score = Convert.ToInt32(SessionHelpers.GetSession("currentscore", true));
            string isclosed = SessionHelpers.GetSession("isclosed", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed + "');", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "openReplyy", "showReply();", true);
        }


        void seenThread(long threadid, int selectedIndex, int pageindex)
        {
            int adminid = Convert.ToInt32(Session["adminid"]);
            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            threadTA.UpdateSeenThreadByThreadID(true, threadid);
            logs.CreateLog(-1, adminid, 22, "دیده شدن شکایت توسط مدیر:", adminid.ToString(), Convert.ToInt32(threadid), "");
            //Session["result"] = "edited";
            //Session["selectedindex"] = selectedIndex;
            //Session["pageindex"] = pageindex;
            //Response.Redirect("~/admin/clientthreads.aspx");
            GridView1.DataBind();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainerr", "successEditThread();", true);
            int score = Convert.ToInt32(SessionHelpers.GetSession("currentscore", true));
            string isclosed = SessionHelpers.GetSession("isclosed", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed + "');", true);
        }

        void notSeenThread(long threadid, int selectedIndex, int pageindex)
        {
            int adminid = Convert.ToInt32(Session["adminid"]);
            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            threadTA.UpdateSeenThreadByThreadID(false, threadid);
            logs.CreateLog(-1, adminid, 23, "تغییر شکایت به دیده نشده توسط مدیر:", adminid.ToString(), Convert.ToInt32(threadid), "");
            //Session["result"] = "edited";
            //Session["selectedindex"] = selectedIndex;
            //Session["pageindex"] = pageindex;
            //Response.Redirect("~/admin/clientthreads.aspx");
            GridView1.DataBind();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainerr", "successEditThread();", true);
            int score = Convert.ToInt32(SessionHelpers.GetSession("currentscore", true));
            string isclosed = SessionHelpers.GetSession("isclosed", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed + "');", true);
        }
        void deleteThread(long threadid)
        {
            //Response.Redirect("~/admin/clientthreads.aspx?action=delete&id="+threadid, true);
            //int adminid = Convert.ToInt32(Session["adminid"]);
            //ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            //threadTA.UpdateSeenThreadByThreadID(false, threadid);
            //logs.CreateLog(-1, adminid, 23, "not seen thread by admin:", adminid.ToString(), Convert.ToInt32(threadid), "");


            int adminid = Convert.ToInt32(Session["adminid"]);
            //ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            //threadTA.UpdateSeenThreadByThreadID(false, threadid);
            //logs.CreateLog(-1, adminid, 23, "not seen thread by admin:", adminid.ToString(), Convert.ToInt32(threadid), "");
            Session["delete"] = "delete";
            Session["threadid"] = threadid;
            Response.Redirect("~/admin/clientthreads.aspx");

        }
        void deleteThreadConfirmed(long threadid)
        {

        }




        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

            foreach (GridViewRow item in GridView1.Rows)
            {
                if (item.RowIndex != GridView1.SelectedIndex)
                {
                    ImageButton imgbtn = (ImageButton)item.Cells[0].Controls[0];
                    imgbtn.ImageUrl = "~/img/select.png";
                }
                else
                {
                    ImageButton imgbtn = (ImageButton)item.Cells[0].Controls[0];
                    imgbtn.ImageUrl = "~/img/selected.png";
                }
            }

            if (GridView1.SelectedIndex >= 0 && GridView1.Rows.Count>0)
            {
                //SessionHelpers.SetSession("editingmode", false, "1");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);


                // selected thread score detection
                int score = -1;
                long threadid = -1;
                bool isseen = false;
                bool isclosed = false;
                if (GridView1.SelectedIndex >= 0)
                {
                    // get selected thread score from selected row
                    string _score = GridView1.SelectedRow.Cells[17].Text;
                    score = Convert.ToInt32(_score);
                    string _subject = GridView1.SelectedRow.Cells[4].Text;
                    threadsubject_client = _subject;
                    string _fullname= GridView1.SelectedRow.Cells[2].Text+" "+GridView1.SelectedRow.Cells[3].Text; ;
                    threadfullname_client = _fullname;

                    threaddep_client = GridView1.SelectedRow.Cells[18].Text;
                    threadnational_client= GridView1.SelectedRow.Cells[19].Text;
                    threadinsurance_client = GridView1.SelectedRow.Cells[20].Text;
                    threadfixedtoken= GridView1.SelectedRow.Cells[21].Text;
                    threadmobile_client= GridView1.SelectedRow.Cells[14].Text;

                    threadfulllocation_client = GridView1.SelectedRow.Cells[15].Text + "،" + GridView1.SelectedRow.Cells[16].Text;
                    switch (GridView1.SelectedRow.Cells[17].Text)
                    {
                        case "0":
                            threadscore_client = "بی پاسخ";
                            break;
                        case "1":
                            threadscore_client = "خیلی بد";
                            break;
                        case "2":
                            threadscore_client = "بد";
                            break;
                        case "3":
                            threadscore_client = "متوسط";
                            break;
                        case "4":
                            threadscore_client = "خوب";
                            break;
                        case "5":
                            threadscore_client = "خیلی خوب";
                            break;
                        default:
                            break;
                    }

                    // get selected thread id from selected row
                    string _threadid = GridView1.SelectedRow.Cells[1].Text;
                    threadid = Convert.ToInt64(_threadid);
                    threadid_client = threadid;
                    
                    // get selected thread is seen from selected row
                    CheckBox _isseen = (CheckBox)GridView1.SelectedRow.Cells[8].Controls[0];
                    if (_isseen.Checked)
                    {
                        isseen = true;
                    }

                    CheckBox _isclosed = (CheckBox)GridView1.SelectedRow.Cells[7].Controls[0];
                    if (_isclosed.Checked)
                    {
                        isclosed = true;
                    }

                    // set selected thread to seen for first time
                    if (!isseen)
                    {
                        int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
                        ShekayatTableAdapters.threadsTableAdapter _ta = new ShekayatTableAdapters.threadsTableAdapter();
                        _ta.UpdateIsSeenByThreadID(true, threadid);
                        // log thread's first seen by admin
                        logs.CreateLog(-1, adminid, 27, "اولین نمایش شکایت توسط مدیر:"+ threadsubject_client,"ادمین:"+ adminid.ToString(), Convert.ToInt32(threadid), "شکایت:"+threadid.ToString());
                    }
                    else
                    {
                        int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
                        logs.CreateLog(-1, adminid, 21, "باز کردن شکایت توسط مدیر:"+ threadsubject_client, "ادمین:" + adminid.ToString(), Convert.ToInt32(threadid), "شکایت:" + threadid.ToString());
                    }
                }
                Repeater1.DataBind();
                SessionHelpers.SetSession("currentscore", true, score);
                SessionHelpers.SetSession("isclosed", true, isclosed.ToString());
                Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed.ToString() + "');", true);
            }
            else
            {
                //SessionHelpers.SetSession("editingmode", false, "0");


                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "hideEditDeps();", true);

            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (GridView1.SelectedIndex < 0)
            {
                return;
            }


            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            bool pagepermission = PermissionChecks.CheckPermission(6, adminid);
            if (!pagepermission)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('ایجاد تغییرات در');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                return;
            }


            long threadid = -1;
            string last_dep_text = "&nbsp;";
            if (GridView1.SelectedIndex >= 0)
            {
                string _threadid = GridView1.SelectedRow.Cells[1].Text;
                threadid = Convert.ToInt64(_threadid);
                
                last_dep_text = GridView1.SelectedRow.Cells[18].Text;
            }

            int selectedDepIndex = Convert.ToInt32(DropDownList2.SelectedValue);
            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            threadTA.UpdateDepIDByThreadID(selectedDepIndex, threadid);

            if (last_dep_text == "&nbsp;")
            {
                logs.CreateLog(-1, adminid, 28, "تایین دپارتمان جدید برای شکایت:", threadid.ToString(), Convert.ToInt32(threadid), DropDownList2.SelectedItem.Text);
            }
            else
            {
                logs.CreateLog(-1, adminid, 29, "تغییر دپارتمان شکایت از :"+ last_dep_text, last_dep_text, Convert.ToInt32(threadid), DropDownList2.SelectedItem.Text);
            }
            //Session["result"] = "edited";
            //Session["selectedindex"] = selectedDepIndex;
            //Session["pageindex"] = GridView1.PageIndex;
            //Response.Redirect("~/admin/clientthreads.aspx");

            GridView1.DataBind();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainerr", "successEditThread();", true);
            int score = Convert.ToInt32(SessionHelpers.GetSession("currentscore", true));
            string isclosed = SessionHelpers.GetSession("isclosed", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed + "');", true);


        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
            GridView1.SelectedIndex = -1;
        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList3.SelectedValue != "-1")
            {
                switch (DropDownList3.SelectedValue)
                {
                    case "0":
                        GridView1.DataSource = todayDS;
                        GridView1.DataBind();
                        break;
                    case "1":

                        break;
                    case "2":
                        break;
                    case "3":
                        break;
                    case "4":
                        break;
                    default:
                        break;
                }

            }
            else
            {
                GridView1.DataSource = notansweredDS;
                GridView1.DataBind();
            }
            if (GridView1.Rows.Count>0)
            {
                GridView1.SelectRow(0);
            }
            Repeater1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // get admin reply text
            Control FooterTemplate = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0];
            TextBox adminReplyText = FooterTemplate.FindControl("replyText") as TextBox;

            FileUpload fileupload = FooterTemplate.FindControl("fileupload") as FileUpload;

            if (adminReplyText.Text.Length < 1)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainerr", "showEditDeps();", true);
                return;
            }

            string file=gofileUpload(fileupload);


            // GET selected grid view thread id
            long threadid = -1;
            if (GridView1.SelectedIndex >= 0)
            {
                string _threadid = GridView1.SelectedRow.Cells[1].Text;
                threadid = Convert.ToInt64(_threadid);
            }
            // check if admin has permission to reply the threads or not
            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            bool pagepermission = PermissionChecks.CheckPermission(12, adminid);
            if (!pagepermission)
            {
                // not permitted to reply the thread
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('ارسال پاسخ به');", true);
                return;
            }







            // insert reply text to post from relevent thread
            ShekayatTableAdapters.postsTableAdapter postTA = new ShekayatTableAdapters.postsTableAdapter();
            ShekayatTableAdapters.threadsTableAdapter threadTA = new ShekayatTableAdapters.threadsTableAdapter();
            if (file!="-1")
            {
                string serv = Request.ServerVariables["HTTP_ORIGIN"];
                adminReplyText.Text += "<br/><br/><a target='_blank' style='text-decoration:none;font-weight:bold;' href='/admin/" + file + "'>دریافت فایل ضمیمه</a>";
                if (file.EndsWith("jpg"))
                {
                    adminReplyText.Text += "<br/><img src='/admin/"+ file + "' style='width:100%;' />";
                }
                if (file.EndsWith("pdf"))
                {
                    adminReplyText.Text += "<object data='/admin/" + file + "' type='application/pdf' width='100%' height='500px' > <a href='/admin/" + file + "' >pdf</a></object>";
                    //adminReplyText.Text += "<iframe src='" + file + "' width='100%' height = '500px' ></ iframe >";
                }
            }
            postTA.InsertReplyText(threadid, adminReplyText.Text, DateTime.Now);
            // update thread to replied
            threadTA.UpdateReplyedByThreadID(true,DateTime.Now, threadid);
            // close thread after reply
            threadTA.UpdateIsClosedThreadByThreadID(true, threadid);

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "closeReplyy", "closeReply();", true);
            logs.CreateLog(-1, adminid, 30, "ارسال پاسخ به شکایت:", adminid.ToString(), Convert.ToInt32(threadid), adminReplyText.Text);


            // send sms
            Shekayat.threadsDataTable _tmpDT= threadTA.GetThreadByThreadID(threadid);
            long userid = -1;
            if (_tmpDT.Rows.Count>0)
            {
                userid = Convert.ToInt64(_tmpDT.Rows[0]["userid"]);
            }

            ShekayatTableAdapters.clientsTableAdapter _clientTA = new ShekayatTableAdapters.clientsTableAdapter();
            string themobile= _clientTA.GetClientByClientID(userid).Rows[0]["mobile"].ToString();

            ShekayatTableAdapters.thread_fixed_tokensTableAdapter _ttA = new ShekayatTableAdapters.thread_fixed_tokensTableAdapter();
            Shekayat.thread_fixed_tokensDataTable _ttDT = _ttA.GetDataByThreadID(threadid);
            string fixedtoken = "";
            if (_ttDT.Rows.Count>0)
            {
                fixedtoken = _ttDT.Rows[0]["thread_fixed_token"].ToString();
            }

            if (themobile!="ناشناس")
            {
                verifier.SendSMS("پاسخ شکایت شما در سامانه شکایات مردمی ارسال شد. \n کد پیگیری:" + fixedtoken + " \n http://roostaa.ir", themobile);
            }
            

            // end sms send


            

            // update gridview and posts
            GridView1.DataBind();
            if (GridView1.Rows.Count > 0 && GridView1.Rows.Count > GridView1.SelectedIndex)
            {
                GridView1.SelectRow(GridView1.SelectedIndex);
            }
            else
            {
                GridView1.SelectRow(0);
            }
            Repeater1.DataBind();


            Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainerr", "successEditThread();", true);
            //int score = Convert.ToInt32(SessionHelpers.GetSession("currentscore", true));
            //string isclosed = SessionHelpers.GetSession("isclosed", true);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "scoreDetection", "selectedScoreIs('" + score + "','" + isclosed + "');", true);
        }

        private string gofileUpload( FileUpload filecontainer)
        {
            string result = "-1";
            StringBuilder sb = new StringBuilder();

            if (filecontainer.HasFile)
            {

                string fileExtension = Path.GetExtension(filecontainer.FileName);

                if (fileExtension.ToLower() != ".jpg" && fileExtension.ToLower() != ".pdf" && fileExtension.ToLower() != ".doc" && fileExtension.ToLower() != ".docx")
                {
                    return "-1";    
                }



                try
                {
                    string strYear = DateTime.Now.Year.ToString();
                    string strMonth = DateTime.Now.Month.ToString();

                    bool exists = System.IO.Directory.Exists(Server.MapPath("files/" + strYear));

                    if (!exists)
                        System.IO.Directory.CreateDirectory(Server.MapPath("files/" + strYear));

                    exists = System.IO.Directory.Exists(Server.MapPath("files/" + strYear + "/" + strMonth));

                    if (!exists)
                        System.IO.Directory.CreateDirectory(Server.MapPath("files/" + strYear + "/" + strMonth));



                    //sb.AppendFormat(" Uploading file: {0}", filecontainer.FileName);
                    
                    //saving the file
                    var savedFileName = Server.MapPath(Path.Combine("files/" + strYear + "/" + strMonth, filecontainer.FileName));
                    filecontainer.SaveAs(savedFileName);
                    result = "files/" + strYear + "/" + strMonth+"/"+ filecontainer.FileName;

                }
                catch (Exception ex)
                {
                    sb.Append("<br/> Error <br/>");
                    sb.AppendFormat("Unable to save file <br/> {0}", ex.Message);
                }
            }
            else
            {
                string message = sb.ToString();
            }

            return result;
        }

        protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView1.SelectedIndex = -1;
            GridView1.PageSize = Convert.ToInt32(DropDownList4.SelectedValue);
            if (SessionHelpers.GetSession("threadgridpagesize",true)!=null)
            {
                if(Convert.ToInt32(SessionHelpers.GetSession("threadgridpagesize", true)) != DropDownList4.SelectedIndex) { 
                SessionHelpers.SetSession("threadgridpagesize", true, DropDownList4.SelectedIndex);
                }
            }
            else
            {
                SessionHelpers.SetSession("threadgridpagesize", true, DropDownList4.SelectedIndex);
            }
            
            
            GridView1.DataBind();

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            int adminid = Convert.ToInt32(SessionHelpers.GetSession("adminid", true));
            bool pagepermission = PermissionChecks.CheckPermission(14, adminid);
            if (!pagepermission)
            {
                logs.CreateLog(-1, adminid, 33, "Excel", "دسترسی خروجی اکسل وجود نداشت", 0, "");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editScript", "notEditPermited('خروجی گرفتن از');", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "editDepContainer", "showEditDeps();", true);
                
                return;
            }


            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=شکایات.xls");
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

        protected void Button3_Click(object sender, EventArgs e)
        {
            try
            {

                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        //To Export all pages                      
                        GridView1.RenderControl(hw);
                        StringReader sr = new StringReader(sw.ToString());
                        Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
                        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                        pdfDoc.Open();
                        htmlparser.Parse(sr);
                        pdfDoc.Close();

                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf");
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        Response.Write(pdfDoc);
                        Response.End();
                    }
                }
            }
            catch (Exception)
            {

                
            }


        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridView1.DataSource = Session["datasource"];
            GridView1.DataBind();

        }

        protected void Button3_Click1(object sender, EventArgs e)
        {
            
        }

        protected void openDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }

        protected void Threads_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }

        protected void closedDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }

        protected void notseenDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }

        protected void todayDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }

        protected void searchDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }

        protected void notansweredDS_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            countall.Text = e.AffectedRows.ToString();
        }
    }
}