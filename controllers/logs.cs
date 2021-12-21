using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shekayat.controllers
{
    public static class logs
    {
        public static void CreateLog(int clientid,int adminid, int logtype,string subject,string details,int itemid,string itembody)
        {
            ShekayatTableAdapters.logsTableAdapter logsTA = new ShekayatTableAdapters.logsTableAdapter();
            logsTA.InsertLog(subject, logtype, Convert.ToInt64(clientid), Convert.ToInt64(adminid), details, DateTime.Now, Convert.ToInt64(itemid), itembody);
        }
    }
}