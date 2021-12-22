<%@ Page Title="" Language="C#" MasterPageFile="~/adminpages.Master" AutoEventWireup="true" CodeBehind="clientthreads.aspx.cs" Inherits="Shekayat.admin.clientthreads" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 83%;">



        <a href="#" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold">شکایات</span>
        </a>


        <div class="d-flex flex-row align-items-stretch pt-2">



            <div class="d-flex flex-column w-20 align-items-center">
                <div class="d-flex flex-row align-items-center" style="margin-right: 1rem;">
                    <label class="form-label bold-smal-text" for="ContentPlaceHolder1_DropDownList3">فیلتر:</label>

                    <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" CssClass="form-select w-70 bold-smal-text" Style="margin-right: 1rem;">
                        <asp:ListItem Value="-1">شکایات بی پاسخ</asp:ListItem>
                        <asp:ListItem Value="0">شکایات امروز</asp:ListItem>
                        <asp:ListItem Value="1">شکایات دیده نشده</asp:ListItem>
                        <asp:ListItem Value="2">آرشیو همه شکایات</asp:ListItem>
                        <asp:ListItem Value="3">شکایات باز</asp:ListItem>
                        <asp:ListItem Value="4">شکایات اختتام یافته</asp:ListItem>
                        <asp:ListItem Value="5">جستجو</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="d-flex flex-column w-20 align-items-center">
                <div class="d-flex flex-row align-items-right" style="margin-right: 1rem;">
                    <label class="form-label bold-smal-text pt-2" for="ContentPlaceHolder1_DropDownList4">تعداد:</label>
                    <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" CssClass="form-select w-70 bold-smal-text" Style="margin-right: 1rem;" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged">
                        <asp:ListItem Value="0">انتخاب کنید</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>20</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                    </asp:DropDownList>
                </div>


            </div>
            <div class="d-flex flex-column w-20 align-items-center">
                <div class="d-flex flex-row align-items-right" style="margin-right: 1rem;">
                    <label class="form-label bold-smal-text pt-2">خروجی:</label>
                    <asp:Button ID="Button2" runat="server" UseSubmitBehavior="false" CssClass="btn-export btn-excel" Text=" " OnClick="Button2_Click" TabIndex="10" />
                    <%--<asp:Button ID="Button3" runat="server" CssClass="btn-export btn-pdf" Text=" " OnClick="Button3_Click"  />--%><%--<asp:Button ID="Button3" runat="server" CssClass="btn-export btn-pdf" Text=" " OnClick="Button3_Click"  />--%>
                </div>

            </div>
            <div id="searchBox" runat="server" class="d-flex flex-column w-20 align-items-center" style="background-color: #ffc107!important; margin-right: 1rem; padding-right: 0.5rem; padding-left: 0.5rem;">
                <div class="d-flex flex-row align-items-center" style="margin-right: 1rem;">
                    <label class="form-label" for="ContentPlaceHolder1_TextBox1">جستجو:</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control m-1" placeholder=""></asp:TextBox>
                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click1" UseSubmitBehavior="true" Text="جستجو" />
                </div>

            </div>
        </div>



        <div class="list-group list-group-flush border-bottom scrollarea p-2 head-part">

            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="3" DataKeyNames="thread_id" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnPageIndexChanging="GridView1_PageIndexChanging" Width="100%" OnSorting="GridView1_Sorting">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectText="انتخاب" SelectImageUrl="../img/select.png" />
                    <asp:BoundField DataField="thread_id" HeaderText="شناسه شکایت" InsertVisible="False" ReadOnly="True" SortExpression="thread_id" />
                    <asp:BoundField DataField="name" HeaderText="نام" SortExpression="name" />
                    <asp:BoundField DataField="family" HeaderText="نام خانوادگی" SortExpression="family" />
                    <asp:BoundField DataField="subject" HeaderText="موضوع" SortExpression="subject" />
                    <asp:BoundField DataField="creationdate" HeaderText="تاریخ ثبت" SortExpression="creationdate" />
                    <asp:CheckBoxField DataField="iscompleted" HeaderText="تکمیل شده" SortExpression="iscompleted" Visible="False" />
                    <asp:CheckBoxField DataField="isclosed" HeaderText="اختتام یافته" SortExpression="isclosed" />
                    <asp:CheckBoxField DataField="seen" HeaderText="دیده شده" SortExpression="seen" />
                    <asp:CheckBoxField DataField="replied" HeaderText="پاسخ داده شده" SortExpression="replied" />
                    <asp:BoundField DataField="replydate" HeaderText="تاریخ اختتام" SortExpression="replydate" />
                    <asp:BoundField DataField="department_id" HeaderText="department_id" SortExpression="department_id" Visible="False" />
                    <asp:BoundField DataField="userid" HeaderText="userid" SortExpression="userid" Visible="False" />
                    <asp:BoundField DataField="state_id" HeaderText="state_id" InsertVisible="False" ReadOnly="True" SortExpression="state_id" Visible="False" />
                    <asp:BoundField DataField="mobile" HeaderText="تلفن همراه" SortExpression="mobile" />
                    <asp:BoundField DataField="state_name" HeaderText="استان" SortExpression="state_name" />
                    <asp:BoundField DataField="city" HeaderText="شهر" SortExpression="city" />
                    <asp:BoundField DataField="score" HeaderText="امتیار رضایت" SortExpression="score" />
                    <asp:BoundField DataField="Expr1" HeaderText="دپارتمان" SortExpression="Expr1" />
                    <asp:BoundField DataField="national_code" HeaderText="کدملی" SortExpression="national_code" />
                    <asp:BoundField DataField="insurance_code" HeaderText="شماره بیمه" SortExpression="insurance_code" />
                    <asp:BoundField DataField="thread_fixed_token" HeaderText="کدپیگیری" SortExpression="thread_fixed_token" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#FFC107" ForeColor="#333333" Font-Bold="True" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="Threads" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT DISTINCT threads.thread_id, threads.subject, threads.creationdate, threads.iscompleted, threads.isclosed, threads.score, threads.seen, threads.replied, threads.department_id, clients.name, clients.family, states.state_name, threads.userid, states.state_id, clients.mobile, clients.city, departments.name AS Expr1, clients.national_code, clients.insurance_code, threads.replydate, thread_fixed_tokens.thread_fixed_token FROM states INNER JOIN clients ON states.state_id = clients.state_id INNER JOIN threads ON clients.userid = threads.userid INNER JOIN thread_fixed_tokens ON threads.thread_id = thread_fixed_tokens.thread_id LEFT OUTER JOIN posts ON threads.thread_id = posts.thread_id LEFT OUTER JOIN departments ON threads.department_id = departments.department_id ORDER BY threads.creationdate DESC" OnSelected="Threads_Selected"></asp:SqlDataSource>
        </div>
        <div class="p-1 text-muted" style="text-align:center;font-size:0.7rem;font-weight:bold;border:solid 1px black;border-radius:8px;margin:1rem;">
            تعداد کل <asp:Label runat="server" ID="countall"></asp:Label>
        </div>

        <div class="align-items-stretch p-1 bg-warning" id="editThreadContainer" style="margin-right: .4rem; margin-bottom: .4rem;">
            <div class="d-flex flex-row align-items-stretch p-1 ">
                <div class="d-flex flex-row w-25 align-items-center">
                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DropDownList1" CssClass="form-label w-50 bold-smal-text" Text="عملیات با شکایت انتخاب شده:"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CssClass="form-select w-50 bold-smal-text" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        <asp:ListItem Value="-1">...</asp:ListItem>
                        <asp:ListItem Value="1">اختتام شکایت</asp:ListItem>
                        <asp:ListItem Value="2">لغواختتام شکایت</asp:ListItem>
                        <asp:ListItem Value="3">دیده شده</asp:ListItem>
                        <asp:ListItem Value="4">دیده نشده</asp:ListItem>
                        <asp:ListItem Value="5">حذف شکایت</asp:ListItem>
                        <asp:ListItem Value="6">جستجو در شکایات</asp:ListItem>
                        <asp:ListItem Value="7">جستجو در متن شکایات</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="d-flex flex-row w-25 align-items-center " style="margin-right: 100px;">
                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DropDownList2" CssClass="form-label w-50 bold-smal-text" Text="انتقال به دسته بندی:"></asp:Label>
                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" CssClass="form-select w-50 bold-smal-text" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" DataSourceID="Departments" DataTextField="name" DataValueField="department_id">
                        <asp:ListItem Value="-1">...</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="Departments" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [departments]"></asp:SqlDataSource>
                </div>
                <div class="d-flex flex-row w-25 align-items-center " style="margin-right: 100px;">
                    <asp:Label ID="lblPrint" runat="server" CssClass="form-label w-50 bold-smal-text" Text="پرینت متن شکایت و پاسخ"></asp:Label>
                    <a onclick="goPrint()" class="print-icon">
                        <img src="../img/print.png" style="width: 27px;" />
                    </a>
                </div>
            </div>
            <%--<hr class="m-0" />--%>
        </div>

        <div class="scrollarea">

            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="Posts">
                <HeaderTemplate>
                    <div class="chat-back container">
                        <label class="form-label">شناسه شکایت:</label><label class="form-label subject-header"><%= threadid_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        
                        <label class="form-label">نام و نام خانوادگی:</label><label class="form-label subject-header"><%= threadfullname_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">استان و شهرستان:</label><label class="form-label subject-header"><%= threadfulllocation_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">تلفن همراه:</label><label class="form-label subject-header"><%= threadmobile_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">کدپیگیری:</label><label class="form-label subject-header"><%= threadfixedtoken.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">سطح رضایتمندی:</label><label class="form-label subject-header"><%= threadscore_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">دپارتمان:</label><label class="form-label subject-header"><%= threaddep_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">کدملی:</label><label class="form-label subject-header"><%= threadnational_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">شماره بیمه:</label><label class="form-label subject-header"><%= threadinsurance_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <br />
                        <label class="form-label">موضوع:</label><label class="form-label subject-header"><%= threadsubject_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                            <%--<div class="subject-parent">
                                <h3 class="subject-header"></h3>
                            </div>--%>
                        <hr style="height:5px;margin-top:0.5rem;background-color:black;border-radius:10px;" />
                        <label class="form-label">متن پیام (ها)</label>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="row align-items-baseline <%#Eval("isreply").ToString()=="True" ? "is-not-reply-row":"is-reply-row"%>">
                        <div class="col-sm-12 fw-bold <%#Eval("isreply").ToString()=="True" ? "":"d-none"%>">
                            پاسخ صندوق
                        </div>
                        <div class="col-sm-12 fw-bold <%#Eval("isreply").ToString()=="True" ? "d-none":""%>">
                            پیام کاربر
                        </div>
                        <div class='col-sm-6 post-<%#Eval("postid").ToString()%> <%#Eval("isvoice").ToString()=="True" ? "":"d-none"%> <%#Eval("isreply").ToString()=="True" ? "is-not-reply":"is-reply"%>'>
                            <audio controls>
                                <source src='../<%# Eval("voice") %>' type='audio/wav'>
                                امکان پخش این فایل صوتی برای مرورگر شما وجود ندارد.
                            </audio>
                        </div>
                        <div class='col-sm-6 post-<%#Eval("postid").ToString()%> <%#Eval("isvoice").ToString()=="True" ? "d-none":""%> <%#Eval("isreply").ToString()=="True" ? "is-not-reply":"is-reply"%>'>
                            <div class="form-label"><%# Eval("text") %></div>
                        </div>
                        <div class="col-sm-5 align-content-end post-<%#Eval("postid").ToString()%>">
                            <span class="text-muted"><%# DateTime.Parse(Eval("creationdate").ToString()).ToString("f") %></span>
                            <span onclick="deletePostAsk(<%#Eval("postid").ToString()%>);" style="cursor: pointer;" class="text-white bg-danger p-1 rounded <%#Eval("isreply").ToString()=="True" ? "":"d-none"%>">حذف پیام</span>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    <div>
                        <div id="replyFromAdmin" class="bg-warning p-1 rounded">
                            <div class="col-sm-12 fw-bold">
                                پاسخ شما
                            </div>
                            <div class="reply-from-admin d-flex flex-row align-items-end">
                                <asp:TextBox ID="replyText" runat="server" TextMode="MultiLine" Style="border: solid 3px black" CssClass="form-control w-100 d-flex" Rows="5"></asp:TextBox>
                            </div>
                            <div class="reply-from-admin m-2" style="text-align: left">
                                <asp:Label runat="server" AssociatedControlID="fileupload" CssClass="upload-label" Text="فایل ضمیمه"></asp:Label>
                                <asp:Label runat="server" CssClass="form-label text-danger upload-label-label" Text="فایل های مجاز DOC,PDF,JPG"></asp:Label>
                                <asp:FileUpload runat="server" ID="fileupload" CssClass="hidden-input" />
                                <input type="button" class="btn-info rounded p-1 temp-send-reply-btn" value="آماده سازی برای ارسال" onclick="prepareSubmitBtn()" />
                                <asp:Button ID="Button1" runat="server" Text="ارسال پاسخ" OnClick="Button1_Click" CssClass="btn-success rounded p-1 main-send-reply-btn d-none" />
                            </div>
                        </div>
                        <div class="row">
                            <hr class="mb-1 mt-2" />
                            <div class="col">
                                <label class="form-label" for="rates">سطح رضایت کاربر از پاسخگویی جطور بود؟</label>
                            </div>
                        </div>

                        <div class="ratings pb-2">

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio5" value="4">
                                <label class="form-check-label" for="inlineRadio5">خیلی خوب</label>
                            </div>


                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio4" value="3">
                                <label class="form-check-label" for="inlineRadio4">خوب</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio3" value="2">
                                <label class="form-check-label" for="inlineRadio3">متوسط</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio2" value="1">
                                <label class="form-check-label" for="inlineRadio2">بد</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio1" value="0">
                                <label class="form-check-label" for="inlineRadio1">خیلی بد</label>
                            </div>
                        </div>





                    </div>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <asp:SqlDataSource ID="Posts" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [posts] WHERE ([thread_id] = @thread_id) ORDER BY [creationdate]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="thread_id" PropertyName="SelectedValue" Type="Int64" />
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="notansweredDS" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT threads.thread_id, threads.subject, threads.creationdate, threads.iscompleted, threads.isclosed, threads.score, threads.seen, threads.replied, threads.department_id, clients.name, clients.family, states.state_name, threads.userid, states.state_id, clients.mobile, clients.city, departments.name AS Expr1, clients.national_code, clients.insurance_code, threads.replydate, thread_fixed_tokens.thread_fixed_token FROM states INNER JOIN clients ON states.state_id = clients.state_id INNER JOIN threads ON clients.userid = threads.userid INNER JOIN thread_fixed_tokens ON threads.thread_id = thread_fixed_tokens.thread_id LEFT OUTER JOIN departments ON threads.department_id = departments.department_id WHERE (threads.replied = 0) AND (threads.iscompleted = 1) ORDER BY threads.creationdate DESC" OnSelected="notansweredDS_Selected"></asp:SqlDataSource>
            <asp:SqlDataSource ID="openDS" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT threads.thread_id, threads.subject, threads.creationdate, threads.iscompleted, threads.isclosed, threads.score, threads.seen, threads.replied, threads.department_id, clients.name, clients.family, states.state_name, threads.userid, states.state_id, clients.mobile, clients.city, departments.name AS Expr1, clients.national_code, clients.insurance_code, threads.replydate, thread_fixed_tokens.thread_fixed_token, thread_fixed_tokens_1.thread_fixed_token AS Expr2 FROM states INNER JOIN clients ON states.state_id = clients.state_id INNER JOIN threads ON clients.userid = threads.userid INNER JOIN thread_fixed_tokens ON threads.thread_id = thread_fixed_tokens.thread_id INNER JOIN thread_fixed_tokens AS thread_fixed_tokens_1 ON threads.thread_id = thread_fixed_tokens_1.thread_id LEFT OUTER JOIN departments ON threads.department_id = departments.department_id WHERE (threads.isclosed = 0) ORDER BY threads.creationdate DESC" OnSelected="openDS_Selected"></asp:SqlDataSource>
            <asp:SqlDataSource ID="closedDS" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT threads.thread_id, threads.subject, threads.creationdate, threads.iscompleted, threads.isclosed, threads.score, threads.seen, threads.replied, threads.department_id, clients.name, clients.family, states.state_name, threads.userid, states.state_id, clients.mobile, clients.city, departments.name AS Expr1, clients.national_code, clients.insurance_code, threads.replydate, thread_fixed_tokens.thread_fixed_token FROM states INNER JOIN clients ON states.state_id = clients.state_id INNER JOIN threads ON clients.userid = threads.userid INNER JOIN thread_fixed_tokens ON threads.thread_id = thread_fixed_tokens.thread_id LEFT OUTER JOIN departments ON threads.department_id = departments.department_id WHERE (threads.isclosed = 1) ORDER BY threads.creationdate DESC" OnSelected="closedDS_Selected"></asp:SqlDataSource>
            <asp:SqlDataSource ID="notseenDS" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT threads.thread_id, threads.subject, threads.creationdate, threads.iscompleted, threads.isclosed, threads.score, threads.seen, threads.replied, threads.department_id, clients.name, clients.family, states.state_name, threads.userid, states.state_id, clients.mobile, clients.city, departments.name AS Expr1, clients.national_code, clients.insurance_code, threads.replydate FROM states INNER JOIN clients ON states.state_id = clients.state_id INNER JOIN threads ON clients.userid = threads.userid LEFT OUTER JOIN departments ON threads.department_id = departments.department_id WHERE (threads.seen = 0) ORDER BY threads.creationdate DESC" OnSelected="notseenDS_Selected"></asp:SqlDataSource>


            <asp:SqlDataSource ID="todayDS" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT threads.thread_id, threads.subject, threads.creationdate, threads.iscompleted, threads.isclosed, threads.score, threads.seen, threads.replied, threads.department_id, clients.name, clients.family, states.state_name, threads.userid, states.state_id, clients.mobile, clients.city, departments.name AS Expr1, clients.national_code, clients.insurance_code, threads.replydate, thread_fixed_tokens.thread_fixed_token FROM states INNER JOIN clients ON states.state_id = clients.state_id INNER JOIN threads ON clients.userid = threads.userid INNER JOIN thread_fixed_tokens ON threads.thread_id = thread_fixed_tokens.thread_id LEFT OUTER JOIN departments ON threads.department_id = departments.department_id WHERE (CAST(threads.creationdate AS DATE) = CAST(GETDATE() AS DATE)) ORDER BY threads.creationdate DESC" OnSelected="todayDS_Selected"></asp:SqlDataSource>


            <asp:SqlDataSource ID="searchDS" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT DISTINCT threads.thread_id, threads.subject, threads.creationdate, threads.iscompleted, threads.isclosed, threads.score, threads.seen, threads.replied, threads.department_id, clients.name, clients.family, states.state_name, threads.userid, states.state_id, clients.mobile, clients.city, departments.name AS Expr1, clients.national_code, clients.insurance_code, threads.replydate, thread_fixed_tokens.thread_fixed_token FROM threads INNER JOIN departments ON threads.department_id = departments.department_id INNER JOIN clients ON threads.userid = clients.userid INNER JOIN states ON clients.state_id = states.state_id INNER JOIN thread_fixed_tokens ON threads.thread_id = thread_fixed_tokens.thread_id WHERE (threads.subject = @search) OR (departments.name = @search) OR (clients.mobile = @search) OR (clients.name = @search) OR (clients.family = @search) OR (clients.mobile = @search) OR (clients.city = @search) OR (threads.subject = @search) OR (departments.name = @search) OR (threads.subject = @search) OR (clients.national_code = @search) OR (clients.insurance_code = @search) OR (thread_fixed_tokens.thread_fixed_token = @search) OR (threads.thread_id LIKE @search)" OnSelected="searchDS_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="search" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>


        </div>
    </div>









    <script>


        function prepareSubmitBtn() {
            alert('پس از ارسال پاسخ، پیامک اطلاع رسانی برای شاکی ارسال خواهد شد. این عملیات بدون بازگشت است. چنانچه از صحت پاسخ خود اطمینان دارید دکمه ارسال پاسخ را بزنید.');
            $('.main-send-reply-btn').removeClass('d-none');
            $('.temp-send-reply-btn').addClass('d-none');
        }


        $(document).ready(function () {

            changeCurrentPage('clientthreads-lnk');


            if (showdelete_result) {
                successDeleteThread();
            }
            if (getUrlVars().result == 'edited') {
                successEditThread(getUrlVars().id);
            }

            if (_successEditThread) {
                successEditThreadShow();
            }

            if (permission_errore) {
                notEditPermitedShow();
            }

            if (threadid_delete != "-1") {
                deleteThreadAsk();
            }




            if (show_edit_container == "-1") {
                $('#editThreadContainer').css('display', 'none');
                console.log('hide');
            } else {
                $('#editThreadContainer').css('display', 'block');
                console.log('SHOW');
            }

            if (the_score_is != "0") {
                $('#inlineRadio' + the_score_is).attr('checked', 'true');
            }

            if (is_closed == "True") {
                $('#replyFromAdmin').hide();
                console.log("is closed");
            }





            $('#myModalOk').click(function () {
                $('#myModal').modal('hide');



                if (threadid_delete != "-1" && postid_delete == "-1") {
                    deleteThread();
                }

                if (threadid_delete == "-1" && postid_delete != "-1") {
                    deletePost();
                }









            });
        });


        function goPrint() {
            var threadid = '<%= threadid_client.ToString() %>';
            var myWindow = window.open("printform.aspx?thread=" + threadid, "", "width=800,height=800");
        }

        function closeReply() {
            $('#replyFromAdmin').hide();
        }

        function showReply() {
            $('#replyFromAdmin').css('display', 'block');
        }

        function deleteThread() {
            //alert($(this).val());
            var obj = {
                'adminid': adminid,
                'threadid': threadid_delete
            }
            $.ajax({
                url: "../handlers/deleteThread.ashx",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: obj,
                responseType: "json",
            }).done(function (response) {
                if (response == "1") {
                    //successDeleteThread();
                    refreshDeleted();
                } else {
                    failureDeleteThread();
                }

            }).fail(function (jqXHR, textStatus) {
                failureDeleteAdmin();
            });
        }

        function deletePost() {
            //alert($(this).val());
            var obj = {
                'adminid': adminid,
                'postid': postid_delete
            }
            $.ajax({
                url: "../handlers/deletePost.ashx",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: obj,
                responseType: "json",
            }).done(function (response) {
                if (response == "1") {
                    //successDeleteThread();
                    refreshDeleted();
                } else {
                    failureDeletePost();
                }

            }).fail(function (jqXHR, textStatus) {
                failureDeleteAdmin();
            });
        }

        //function successCloseThread() {
        //    $('.toast-header').addClass('bg-success');
        //    $('#toasttitle').addClass('text-white');
        //    $("#toasttitle").html('ویرایش موفق');
        //    $('#toastbody').html('شکایت مورد نظر بسته شد.');
        //    $('.toast').toast('show');
        //}

        function successEditThreadShow() {
            show_edit_container = "1";
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('ویرایش موفق');
            $('#toastbody').html('شکایت مورد نظر ویرایش شد.');
            $('.toast').toast('show');
        }
        _successEditThread = false;
        function successEditThread() {
            _successEditThread = true;
        }

        showdelete_result = false;
        function showDeletResult() {
            showdelete_result = true;
        }

        function goDeleteThread(threadid) {
            threadid_delete = threadid;
        }


        var threadid_delete = "-1";
        function deleteThreadAsk() {

            $('#myModalTitle').html('حذف شکایت');
            $('#myModalBody').html('مطمئن هستید که میخواهید این شکایت را حذف کنید؟');
            $('#myModalClose').html('خیر');
            $('#myModalOk').html('بله. حذف شود');

            $('#myModal').modal('show');
        }

        var postid_delete = "-1";
        function deletePostAsk(id) {
            postid_delete = id;
            $('#myModalTitle').html('حذف پاسخ');
            $('#myModalBody').html('مطمئن هستید که میخواهید این پاسخ را حذف کنید؟');
            $('#myModalClose').html('خیر');
            $('#myModalOk').html('بله. حذف شود');

            $('#myModal').modal('show');
        }

        function refreshDeleted() {
            $('.post-' + postid_delete).hide();
            successDeletePost();
            window.location.reload();
        }



        function failureDeleteThread() {
            $('.toast-header').addClass('bg-danger');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('حذف ناموفق');
            $('#toastbody').html('مدیر مورد نظر شما حذف نشد. لطفا کمی بعد محددا تلاش کنید.');
            $('.toast').toast('show');
        }
        function failureDeletePost() {
            $('.toast-header').addClass('bg-danger');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('حذف ناموفق');
            $('#toastbody').html('پاسخ مورد نظر شما حذف نشد. امکان حذف این پست برای شما در حال حاضر ممکن نیست.');
            $('.toast').toast('show');
        }

        function successDeleteThread() {
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('حذف موفق');
            $('#toastbody').html('شکایت مورد نظر حذف شد.');
            $('.toast').toast('show');
        }

        function successDeletePost() {
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('حذف موفق');
            $('#toastbody').html('پاسخ مورد نظر حذف شد.');
            $('.toast').toast('show');
        }

        permission_errore = false;
        permission_errore_subject = "";


        function notEditPermited(subject) {
            permission_errore = true;
            permission_errore_subject = subject;
        }

        function notEditPermitedShow() {
            $('.toast-header').addClass('bg-danger');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('اشکال سطح دسترسی');
            $('#toastbody').html('شما دسترسی لازم برای ' + permission_errore_subject + ' شکایت را ندارید.');
            $('.toast').toast('show');
        }





        show_edit_container = "-1";

        function showEditDeps() {
            //document.getElementById("editCategoriesContainer").style.display = "block!important";
            show_edit_container = "1";
            //alert('y');
        }

        function hideEditDeps() {
            //document.getElementById("editCategoriesContainer").style.display = "none!important";
            show_edit_container = "-1";
        }

        the_score_is = "0";
        is_closed = "false";
        function selectedScoreIs(score, _isclosed) {
            the_score_is = score;
            is_closed = _isclosed;
            console.log('isclosed:' + _isclosed);
        }

    </script>
</asp:Content>
