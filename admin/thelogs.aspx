<%@ Page Title="" Language="C#" MasterPageFile="~/adminpages.Master" AutoEventWireup="true" CodeBehind="thelogs.aspx.cs" Inherits="Shekayat.admin.thelogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 83%;">

        <a href="#" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold">لاگ فعالیت ها</span>
        </a>

<%--        <div class="d-flex flex-row">
            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                تعداد همه شکایت کنندگان &nbsp;
                <asp:Label ID="todayAllClients" runat="server" Text="Label"></asp:Label>&nbsp;
                نفر
            </div>
            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                تعداد همه شکایت ها &nbsp;
                <asp:Label ID="allThreads" runat="server" Text="Label"></asp:Label>&nbsp;
                شکایت
            </div>
            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                میانگین سطح رضایتمندی &nbsp;
                <asp:Label ID="avgScores" runat="server" Text="Label"></asp:Label>&nbsp;
            </div>

        </div>--%>

         <div class="d-flex flex-row">
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                نوع لاگ
                
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="sqlLogTypes" DataTextField="name" DataValueField="type_id" OnDataBound="DropDownList1_DataBound">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlLogTypes" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [logtypes]"></asp:SqlDataSource>
                
            </div>

<%--            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                شکایت های پایان یافته
            </div>--%>

        </div>

        <div class="d-flex flex-row p-3 scrollarea">

            <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4"  ForeColor="#333333" GridLines="None" PageSize="20" OnPageIndexChanging="GridView3_PageIndexChanging">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="name" HeaderText="نام شاکی" SortExpression="name" />
                    <asp:BoundField DataField="family" HeaderText="نام خانوادگی شاکی" SortExpression="family" />
                    <asp:BoundField DataField="mobile" HeaderText="موبایل شاکی" SortExpression="mobile" />
                    <asp:BoundField DataField="logtypename" HeaderText="نوع لاگ" SortExpression="logtypename" />
                    <asp:BoundField DataField="description" HeaderText="توضیحات" SortExpression="description" />
                    <asp:BoundField DataField="subject" HeaderText="موضوع" SortExpression="subject" />
                    <asp:BoundField DataField="details" HeaderText="جزییات" SortExpression="details" />
                    <asp:BoundField DataField="creationdate" HeaderText="زمان لاگ" SortExpression="creationdate" />
                    <asp:BoundField DataField="log_item_id" HeaderText="آیتم لاگ" SortExpression="log_item_id" />
                    <asp:BoundField DataField="log_item_body" HeaderText="بدنه آیتم لاگ" SortExpression="log_item_body" />
                    <asp:BoundField DataField="adminname" HeaderText="نام ادمین" SortExpression="adminname" />
                    <asp:BoundField DataField="adminfamily" HeaderText="نام خانوادگی ادمین" SortExpression="adminfamily" />
                    <asp:BoundField DataField="adminmobile" HeaderText="موبایل ادمین" SortExpression="adminmobile" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT clients.name, clients.family, clients.mobile, logtypes.name AS logtypename, logtypes.description, logs.subject, logs.details, logs.creationdate, logs.log_item_id, logs.log_item_body, admins.name AS adminname, admins.family AS adminfamily, admins.mobile AS adminmobile, logtypes.type_id FROM logtypes RIGHT OUTER JOIN logs ON logtypes.type_id = logs.logtype LEFT OUTER JOIN clients ON logs.client_id = clients.userid LEFT OUTER JOIN admins ON logs.admin_id = admins.adminid WHERE (logtypes.type_id = @type_id) ORDER BY logs.creationdate DESC" OnSelected="SqlDataSource2_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="type_id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
           
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT clients.name, clients.family, clients.mobile, logtypes.name AS logtypename, logtypes.description, logs.subject, logs.details, logs.creationdate, logs.log_item_id, logs.log_item_body, admins.name AS adminname, admins.family AS adminfamily, admins.mobile AS adminmobile FROM logtypes RIGHT OUTER JOIN logs ON logtypes.type_id = logs.logtype LEFT OUTER JOIN clients ON logs.client_id = clients.userid LEFT OUTER JOIN admins ON logs.admin_id = admins.adminid ORDER BY logs.creationdate DESC" OnSelected="SqlDataSource1_Selected"></asp:SqlDataSource>
           
        </div>

           <div class="p-1 m-1" style="text-align:left;border:1px solid black;text-align:center;border-radius:5px;">
               تعداد کل: <asp:Label runat="server" ID="countall" CssClass="muted-text"></asp:Label>
           </div>


        <script>
            
            window.onload = function () {

                changeCurrentPage('logs-lnk');

            }
        </script>

    </div>
</asp:Content>
