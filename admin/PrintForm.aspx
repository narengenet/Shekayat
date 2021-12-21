<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintForm.aspx.cs" Inherits="Shekayat.admin.PrintForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%= threadsubject_client.ToString() %></title>
    <link href="../css/bootstrap.rtl.min.css" media="print" rel="stylesheet" />
    <link href="../css/sidebars.css" media="print" rel="stylesheet" />
    <link href="../css/style.css" media="print" rel="stylesheet" />
    <link href="../css/bootstrap.rtl.min.css" rel="stylesheet" />
    <link href="../css/sidebars.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
    <style type="text/css" media="print">
        @media print {
            body {
                -webkit-print-color-adjust: exact;
            }
        }

        @page {
            size: A4 portrait;
            margin-left: 0px;
            margin-right: 0px;
            margin-top: 0px;
            margin-bottom: 0px;
            margin: 0;
            -webkit-print-color-adjust: exact;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [posts] WHERE ([thread_id] = @thread_id)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="thread_id" QueryStringField="thread" Type="Int64" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
                    <style>
                        .is-not-reply, .is-reply {
                            width: 60% !important;
                        }
                    </style>
                    <div class="chat-back-print container" style="width: 800px; direction: rtl;">

                        <label class="form-label">شناسه شکایت:</label><label class="form-label subject-header"><%= threadid_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">موضوع:</label><label class="form-label subject-header"><%= threadsubject_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">نام و نام خانوادگی:</label><label class="form-label subject-header"><%= threadfullname_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">استان و شهرستان:</label><label class="form-label subject-header"><%= threadfulllocation_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">تلفن همراه:</label><label class="form-label subject-header"><%= threadmobile_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">کدپیگیری:</label><label class="form-label subject-header"><%= threadfixedtoken.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">سطح رضایتمندی:</label><label class="form-label subject-header"><%= threadscore_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">دپارتمان:</label><label class="form-label subject-header"><%= threaddep_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">کدملی:</label><label class="form-label subject-header"><%= threadnational_client.ToString() %></label>&nbsp;&nbsp;&nbsp;
                        <label class="form-label">شماره بیمه:</label><label class="form-label subject-header"><%= threadinsurance_client.ToString() %></label>&nbsp;&nbsp;&nbsp;

                        <hr />
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
                        <div class='col-sm-6 <%#Eval("isvoice").ToString()=="True" ? "":"d-none"%> <%#Eval("isreply").ToString()=="True" ? "is-not-reply":"is-reply"%>'>
                            <audio controls>
                                <source src='../<%# Eval("voice") %>' type='audio/wav'>
                                امکان پخش این فایل صوتی برای مرورگر شما وجود ندارد.
                            </audio>
                        </div>
                        <div class='col-sm-6 <%#Eval("isvoice").ToString()=="True" ? "d-none":""%> <%#Eval("isreply").ToString()=="True" ? "is-not-reply":"is-reply"%>'>
                            <label class="form-label"><%# Eval("text") %></label>
                        </div>
                        <div class="col-sm-5 align-content-end">
                            <span class="text-muted"><%# DateTime.Parse(Eval("creationdate").ToString()).ToString("f") %></span>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    <div>
                        <div class="row">
                            <hr class="mb-1 mt-2" />
                            <div class="col">
                                <label class="form-label" for="rates">سطح رضایت کاربر از پاسخگویی جطور بود؟</label>
                            </div>
                        </div>

                        <div class="ratings pb-2">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio1" value="0">
                                <label class="form-check-label" for="inlineRadio1">خیلی بد</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio2" value="1">
                                <label class="form-check-label" for="inlineRadio2">بد</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio3" value="2">
                                <label class="form-check-label" for="inlineRadio3">متوسط</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio4" value="3">
                                <label class="form-check-label" for="inlineRadio4">خوب</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" disabled name="inlineRadioOptions" id="inlineRadio5" value="4">
                                <label class="form-check-label" for="inlineRadio5">خیلی خوب</label>
                            </div>
                        </div>





                    </div>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
