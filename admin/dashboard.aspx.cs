using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat.admin
{
    public partial class dashboard : System.Web.UI.Page
    {
        public int score0 = 1;
        public int score1 = 2;
        public int score2 = 3;
        public int score3 = 4;
        public int score4 = 5;
        public int score5 = 6;
        public int[] states = new int[31];
        public string[] state_names = new string[31];
        protected void Page_Load(object sender, EventArgs e)
        {
            ShekayatTableAdapters.clientsTableAdapter clientsTA = new ShekayatTableAdapters.clientsTableAdapter();
            int _allClients = Convert.ToInt32(clientsTA.CountAllClients());
            todayAllClients.Text = _allClients.ToString();
            
            ShekayatTableAdapters.threadsTableAdapter threadsTA = new ShekayatTableAdapters.threadsTableAdapter();
            Shekayat.threadsDataTable _dt= threadsTA.GetAllThreads();
            
            double _avgScores = 0;
            double sum = 0;
            for (int i = 0; i < _dt.Rows.Count; i++)
            {
                sum += Convert.ToInt64(_dt.Rows[i]["score"]);
            }

            if (_dt.Rows.Count>0)
            {
                _avgScores = (sum/ _dt.Rows.Count)*20;
            }
            
            object _allThreads = threadsTA.CountAllThreads();

            int endCount=(Convert.ToInt64(_avgScores.ToString().Length)>4)?4:1;
            avgScores.Text = _avgScores.ToString().Substring(0, endCount) + " درصد ";
            
            allThreads.Text = _allThreads.ToString();

            // get most threaded state
            //ShekayatTableAdapters.QueriesTableAdapter qTA = new ShekayatTableAdapters.QueriesTableAdapter();
            //object a= qTA.ScalarQuery();
            //object _customDT = threadsTA.GetMostUsedStates();
            //mostStates.Text = a.ToString();



            var dv = new DataView();
            var dt = new DataTable();
            var dv2 = new DataView();
            var dt2 = new DataTable();

            // Here mySQLDataSource is the ID of SQLDataSource
            dv = sqlProviences.Select(DataSourceSelectArguments.Empty) as DataView;
            dt = dv.ToTable();

            dv2 = sqlProviencesCount.Select(DataSourceSelectArguments.Empty) as DataView;
            dt2 = dv2.ToTable();

            

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    if (Convert.ToInt32(dt.Rows[i]["state_id"])== Convert.ToInt32(dt2.Rows[j]["state_id"]))
                    {
                        states[i] = Convert.ToInt32(dt2.Rows[j]["Expr1"]);
                    }
                }
                state_names[i] = dt.Rows[i]["state_name"].ToString();
            }


        }

        protected void SqlDataSource3_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {


        }
    }
}