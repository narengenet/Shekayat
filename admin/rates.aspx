<%@ Page Title="" Language="C#" MasterPageFile="~/adminpages.Master" AutoEventWireup="true" CodeBehind="rates.aspx.cs" Inherits="Shekayat.admin.rates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" language="JavaScript" src="../js/JsFarsiCalendar.js">
    </script>
    <link rel="stylesheet" type="text/css" href="../css/calendar.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white scrollarea" style="width: 83%;">

        <a href="#" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold">گزارش رضایتمندی</span>
        </a>

        <div class="d-flex flex-row">
            <div class="flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1" style="text-align: center;">
                از تاریخ&nbsp;
                <asp:TextBox ID="txtFromDate" CssClass="form-control  w-50 inline-block" runat="server" AutoPostBack="True" OnTextChanged="txtFromDate_TextChanged"></asp:TextBox>

                <img src="../img/calendar.jpg" style="width: 17px; height: 14px; display: inline-block;" onclick="displayDatePicker('ctl00$ContentPlaceHolder1$txtFromDate');">
                <br />
                <br />
                تا تاریخ&nbsp;
                <asp:TextBox ID="txtToDate" CssClass="form-control  w-50 inline-block" runat="server" AutoPostBack="True"></asp:TextBox>

                <img src="../img/calendar.jpg" style="width: 17px; height: 14px; display: inline-block;" onclick="displayDatePicker('ctl00$ContentPlaceHolder1$txtToDate');">
            </div>
            <div class="flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                <asp:Label Text="استان" runat="server" AssociatedControlID="DropDownList1" CssClass="form-label inline-48"></asp:Label>
                <asp:DropDownList ID="DropDownList1" CssClass="form-select w-50 bold-smal-text inline-48" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="state_name" DataValueField="state_id" OnDataBound="DropDownList1_DataBound">
                </asp:DropDownList>
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [states]"></asp:SqlDataSource>
                <asp:Label Text="دپارتمان" runat="server" AssociatedControlID="DropDownList2" CssClass="form-label inline-48"></asp:Label>
                <asp:DropDownList ID="DropDownList2" CssClass="form-select w-50 bold-smal-text inline-48" runat="server" DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="department_id" AutoPostBack="True" OnDataBound="DropDownList2_DataBound">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [departments]"></asp:SqlDataSource>

            </div>


            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" OnSelected="SqlDataSource3_Selected" SelectCommand="SELECT clients.state_id, threads.userid, threads.creationdate, threads.department_id, threads.score, states.state_name, departments.name FROM clients INNER JOIN threads ON clients.userid = threads.userid INNER JOIN departments ON threads.department_id = departments.department_id INNER JOIN states ON clients.state_id = states.state_id WHERE (clients.state_id = @state_id) AND (threads.creationdate &gt; @fromdate) AND (threads.creationdate &lt; @todate) AND (threads.department_id = @department_id) AND (threads.iscompleted = 1) ORDER BY threads.creationdate DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="state_id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="txtFromDate" Name="fromdate" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtToDate" Name="todate" PropertyName="Text" />
                    <asp:ControlParameter ControlID="DropDownList2" Name="department_id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>

            <%--<div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                شکایت های بی پاسخ بیش از پنج روز
                <asp:Label ID="avgScores" runat="server" Text="Label"></asp:Label>
            </div>--%>
        </div>

        <div class="d-flex flex-row">
            <%--<div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                شکایت های نامشخص
                <asp:Label ID="mostStates" runat="server" Text="Label"></asp:Label>
            </div>--%>
            <%--            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                
                <asp:Label ID="leastStates" runat="server" Text="Label"></asp:Label> شکایت
            </div>--%>
            <%--<div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                شکایت های پایان یافته
            </div>--%>
        </div>

        <div class="d-flex flex-row p-3 text-center">
            تعداد شکایات : &nbsp;<asp:Label ID="threadCounts" runat="server" CssClass="form-label text-primary"></asp:Label>&nbsp;<span class="text-primary">شکایت</span>
            <hr />&nbsp;,
            میانگین سطح رضایت : &nbsp;<asp:Label ID="ScoreSum" runat="server" CssClass="form-label text-secondary"></asp:Label>&nbsp;<span class="text-secondary"> از 5</span>



                <div class="d-flex flex-row align-items-right" style="margin-right: 1rem;margin-top:-0.4rem;">
                    <label class="form-label bold-smal-text pt-2">خروجی:</label>
                    <asp:Button ID="Button2" runat="server" UseSubmitBehavior="false" CssClass="btn-export btn-excel" Text=" " TabIndex="10" OnClick="Button2_Click" />
                    &nbsp;
                    <span class="btn-export btn-chrt" onclick="exportChrt();">&nbsp;</span>
                    <%--<asp:Button ID="Button3" runat="server" CssClass="btn-export btn-pdf" Text=" " OnClick="Button3_Click"  />--%><%--<asp:Button ID="Button3" runat="server" CssClass="btn-export btn-pdf" Text=" " OnClick="Button3_Click"  />--%>
                </div>

        </div>
        <div class="d-flex flex-row p-3 text-center">
            <div style="margin:auto;width:50%;">
            <asp:GridView ID="GridView1" runat="server" CellPadding="4" CssClass="grid-data" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
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
                </div>
            
            <div id="chartContainer" style="height: 370px; width: 50%;"></div>
            
        </div>




        <script>
            function exportChrt() {
                chart.exportChart({ format: "jpg" });
            }
            var chart;
            window.onload = function () {

                var score0 = '<%= score0.ToString() %>';
                var score1 = '<%= score1.ToString() %>';
                var score2 = '<%= score2.ToString() %>';
                var score3 = '<%= score3.ToString() %>';
                var score4 = '<%= score4.ToString() %>';
                var score5 = '<%= score5.ToString() %>';


                $("#ContentPlaceHolder1_txtFromDate").click(function () {
                    displayDatePicker('ctl00$ContentPlaceHolder1$txtFromDate');
                });

                $("#ContentPlaceHolder1_txtToDate").click(function () {
                    displayDatePicker('ctl00$ContentPlaceHolder1$txtToDate');
                });

                changeCurrentPage('rates-lnk');

                var options = {
                    animationEnabled: true,
                    theme: "light2", // "light1", "light2", "dark1", "dark2"
                    title: {
                        text: "آمار رضایتمندی",
                        fontFamily: "IranSans"
                    },
                    subtitles: [{
                        text: " ",
                        fontSize: 16
                    }],
                    axisY: {
                        prefix: "نفر",
                        labelFontFamily: "IranSans"
                    },
                    axisX: {
                        labelFontFamily: "IranSans"
                    },
                    toolTip: {
                        fontFamily: "IranSans"
                    },
                    data: [{
                        type: "column",
                        dataPoints: [
                            { label: "بدون نظر", y: parseInt(score0) },
                            { label: "خیلی بد", y: parseInt(score1) },
                            { label: "بد", y: parseInt(score2) },
                            { label: "متوسط", y: parseInt(score3) },
                            { label: "خوب", y: parseInt(score4) },
                            { label: "خیلی خوب", y: parseInt(score5) }
                        ]
                    }]
                };
                //$("#chartContainer").CanvasJSChart(options);
                chart = new CanvasJS.Chart("chartContainer", options);
                chart.render();

                function toogleDataSeries(e) {
                    if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                        e.dataSeries.visible = false;
                    } else {
                        e.dataSeries.visible = true;
                    }
                    e.chart.render();


                }
                document.getElementById("exportChart").addEventListener("click", function () {
                    chart.exportChart({ format: "jpg" });
                });

            }




            function notEditPermited(subject) {
                permission_errore = true;
                permission_errore_subject = subject;
            }

            function notEditPermitedShow() {
                $('.toast-header').addClass('bg-danger');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('اشکال سطج دسترسی');
                $('#toastbody').html('شما دسترسی لازم برای ' + permission_errore_subject + ' گزارش را ندارید.');
                $('.toast').toast('show');
            }
        </script>

    </div>

    <div class="b-example-divider"></div>


</asp:Content>
