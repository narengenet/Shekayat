using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shekayat.controllers
{
    public static class PermissionChecks
    {

        public static bool CheckPermission(int permissionID, int adminID)
        {
            ShekayatTableAdapters.admin_rolesTableAdapter adminroleTA = new ShekayatTableAdapters.admin_rolesTableAdapter();
            Shekayat.admin_rolesDataTable dt = adminroleTA.GetRoleByAdminAndRoleID(Convert.ToInt64(adminID), permissionID);
            if (dt.Rows.Count > 0)
            {
                return true;
            }
            return false;
        }



        public static Boolean checkForSQLInjection(string userInput)

        {

            bool isSQLInjection = false;

            string[] sqlCheckList = { "--",

                                       ";--",

                                       ";",

                                       "/*",

                                       "*/",

                                        "@@",

                                        "@",

                                        "char",

                                       "nchar",

                                       "varchar",

                                       "nvarchar",

                                       "alter",

                                       "begin",

                                       "cast",

                                       "create",

                                       "cursor",

                                       "declare",

                                       "delete",

                                       "drop",

                                       "end",

                                       "exec",

                                       "execute",

                                       "fetch",

                                            "insert",

                                          "kill",

                                             "select",

                                           "sys",

                                            "sysobjects",

                                            "syscolumns",

                                           "table",

                                           "update"

                                       };

            string CheckString = userInput.Replace("'", "''");

            for (int i = 0; i <= sqlCheckList.Length - 1; i++)
            {
                if ((CheckString.IndexOf(sqlCheckList[i],StringComparison.OrdinalIgnoreCase) >= 0))
                {
                    isSQLInjection = true;
                }
            }

            return isSQLInjection;
        }
    }
}