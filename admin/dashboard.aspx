<%@ Page Title="" Language="C#" MasterPageFile="~/adminpages.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Shekayat.admin.dashboard" ViewStateMode="Enabled" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 83%;">

        <asp:SqlDataSource ID="sqlProviencesCount" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT        COUNT(*) AS Expr1, clients.state_id, states.state_name
FROM            threads INNER JOIN
                         clients ON threads.userid = clients.userid INNER JOIN
                         states ON clients.state_id = states.state_id
GROUP BY clients.state_id, states.state_name"></asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlProviences" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [states]"></asp:SqlDataSource>

        <a href="#" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold">پیشخوان</span>
        </a>

        <div class="d-flex flex-row dashboard-data">
            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-1 bg-light m-1 text-center">
                تعداد همه شکایت کنندگان &nbsp;
                <asp:Label ID="todayAllClients" runat="server" Text="Label"></asp:Label>&nbsp;
                نفر
            </div>
            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-1 bg-light m-1">
                تعداد همه شکایت ها &nbsp;
                <asp:Label ID="allThreads" runat="server" Text="Label"></asp:Label>&nbsp;
                شکایت
            </div>
            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-1 bg-light m-1">
                میانگین سطح رضایتمندی &nbsp;
                <asp:Label ID="avgScores" runat="server" Text="Label"></asp:Label>&nbsp;
            </div>
            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-1 bg-light m-1">
                تعداد شکایات مربوط به دپارتمان ها
                &nbsp;
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="dep" HeaderText="تعداد شکایات" ReadOnly="True" SortExpression="dep" />
                        <asp:BoundField DataField="name" HeaderText="دپارتمان" SortExpression="name" />
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#F7F7DE" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                    <SortedAscendingHeaderStyle BackColor="#848384" />
                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                    <SortedDescendingHeaderStyle BackColor="#575357" />
                </asp:GridView>
            </div>
        </div>

<%--        <div class="d-flex flex-row">

            <div class="d-flex flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                بیشترین شکایات مربوط به استان
            </div>


        </div>--%>

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT COUNT(threads.department_id) AS 'dep', departments.name FROM threads LEFT OUTER JOIN departments ON threads.department_id = departments.department_id GROUP BY threads.department_id, departments.name ORDER BY 'dep' DESC" OnSelected="SqlDataSource3_Selected"></asp:SqlDataSource>

        <%-- <div class="d-flex flex-row">
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                شکایت های نامشخص
                <asp:Label ID="mostStates" runat="server" Text="Label"></asp:Label>
            </div>

            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                شکایت های پایان یافته
            </div>

        </div>--%>

        <div class="d-flex flex-row p-3 scrollarea">
            <div id="chartContainer" style="height: 370px; width: 100%;"></div>
        </div>


        <script>

            window.onload = function () {

                changeCurrentPage('dashboard-lnk');



            }
        </script>




        <script>
            function exportChrt() {
                chart.exportChart({ format: "jpg" });
            }
            var chart;
            window.onload = function () {
                
                var score0 = '<%= states[0].ToString() %>';
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

                changeCurrentPage('dashboard-lnk');

                var options = {
                    animationEnabled: true,
                    theme: "light1", // "light1", "light2", "dark1", "dark2"
                    title: {
                        text: "توزیع استانی همه شکایات",
                        fontFamily: "IranSans"
                    },
                    legend: {
                        fontFamily:"IranSans"
                    },
                    subtitles: [{
                        text: " ",
                        fontSize: 16
                    }],
                    axisY: {
                        prefix: " شکایت ",
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
                            { label: "<%= state_names[0].ToString() %>", y: parseInt('<%= states[0].ToString() %>') },
                            { label: "<%= state_names[1].ToString() %>", y: parseInt('<%= states[1].ToString() %>') },
                            { label: "<%= state_names[2].ToString() %>", y: parseInt('<%= states[2].ToString() %>') },
                            { label: "<%= state_names[3].ToString() %>", y: parseInt('<%= states[3].ToString() %>') },
                            { label: "<%= state_names[4].ToString() %>", y: parseInt('<%= states[4].ToString() %>') },
                            { label: "<%= state_names[5].ToString() %>", y: parseInt('<%= states[5].ToString() %>') },
                            { label: "<%= state_names[6].ToString() %>", y: parseInt('<%= states[6].ToString() %>') },
                            { label: "<%= state_names[7].ToString() %>", y: parseInt('<%= states[7].ToString() %>') },
                            { label: "<%= state_names[8].ToString() %>", y: parseInt('<%= states[8].ToString() %>') },
                            { label: "<%= state_names[9].ToString() %>", y: parseInt('<%= states[9].ToString() %>') },
                            { label: "<%= state_names[10].ToString() %>", y: parseInt('<%= states[10].ToString() %>') },
                            { label: "<%= state_names[11].ToString() %>", y: parseInt('<%= states[11].ToString() %>') },
                            { label: "<%= state_names[12].ToString() %>", y: parseInt('<%= states[12].ToString() %>') },
                            { label: "<%= state_names[13].ToString() %>", y: parseInt('<%= states[13].ToString() %>') },
                            { label: "<%= state_names[14].ToString() %>", y: parseInt('<%= states[14].ToString() %>') },
                            { label: "<%= state_names[15].ToString() %>", y: parseInt('<%= states[15].ToString() %>') },
                            { label: "<%= state_names[16].ToString() %>", y: parseInt('<%= states[16].ToString() %>') },
                            { label: "<%= state_names[17].ToString() %>", y: parseInt('<%= states[17].ToString() %>') },
                            { label: "<%= state_names[18].ToString() %>", y: parseInt('<%= states[18].ToString() %>') },
                            { label: "<%= state_names[19].ToString() %>", y: parseInt('<%= states[19].ToString() %>') },
                            { label: "<%= state_names[20].ToString() %>", y: parseInt('<%= states[20].ToString() %>') },
                            { label: "<%= state_names[21].ToString() %>", y: parseInt('<%= states[21].ToString() %>') },
                            { label: "<%= state_names[22].ToString() %>", y: parseInt('<%= states[22].ToString() %>') },
                            { label: "<%= state_names[23].ToString() %>", y: parseInt('<%= states[23].ToString() %>') },
                            { label: "<%= state_names[24].ToString() %>", y: parseInt('<%= states[24].ToString() %>') },
                            { label: "<%= state_names[25].ToString() %>", y: parseInt('<%= states[25].ToString() %>') },
                            { label: "<%= state_names[26].ToString() %>", y: parseInt('<%= states[26].ToString() %>') },
                            { label: "<%= state_names[27].ToString() %>", y: parseInt('<%= states[27].ToString() %>') },
                            { label: "<%= state_names[28].ToString() %>", y: parseInt('<%= states[28].ToString() %>') },
                            { label: "<%= state_names[29].ToString() %>", y: parseInt('<%= states[29].ToString() %>') },
                            { label: "<%= state_names[30].ToString() %>", y: parseInt('<%= states[30].ToString() %>') }
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

        </script>
        <%--<div class="list-group list-group-flush border-bottom scrollarea">
                <a href="#" class="list-group-item list-group-item-action active py-3 lh-tight" aria-current="true">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small>Wed</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Tues</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Mon</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>

                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Wed</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Tues</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Mon</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Wed</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Tues</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Mon</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Wed</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Tues</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
                <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
                    <div class="d-flex w-100 align-items-center justify-content-between">
                        <strong class="mb-1">List group item heading</strong>
                        <small class="text-muted">Mon</small>
                    </div>
                    <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
                </a>
            </div>--%>
    </div>

    <div class="b-example-divider"></div>







</asp:Content>
