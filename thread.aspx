<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="thread.aspx.cs" Inherits="Shekayat.thread" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row g-3 align-content-center">
                <div class="col-sm-4 p-0">
            <div class="bg-secondary p-1 mb-0 pb-3 text-white text-center rounded">
                تمام درخواست های ثبت شده شما
            </div>
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                <HeaderTemplate>
                    <div class="messages border border-secondary rounded mt-1">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="message border-bottom border-secondary pe-2 ps-2" data-thread='<%# Eval("thread_id") %>'>
                        <div class="row">

                            <a class="text-decoration-none text-secondary fw-bold" href='?thread=<%# Eval("thread_id") %>'>
                                <%# Eval("subject") %>
                            </a>

                        </div>
                        <div class="row align-items-baseline">
                            <a class="text-decoration-none text-muted" href='?thread=<%# Eval("thread_id") %>' style="direction: ltr;">
                                <span class="text-muted"><%# DateTime.Parse(Eval("creationdate").ToString()).ToString("f") %></span>
                            </a>
                        </div>
                        <%--<hr class="mb-1" />--%>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>

            </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [threads] WHERE ([userid] = @userid)">
                <SelectParameters>
                    <asp:SessionParameter Name="userid" SessionField="userid" Type="Int64" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="col-sm-8">
            <label class="form-label" for="subject">موضوع</label>
            <input class="form-control" id="subject" disabled runat="server" />
            <label class="form-label mt-2" for="subject">کد پیگیری 
                <input id="fixedtoken" style="text-align:center;" disabled runat="server" />
            </label>
            
            

            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
                    <div class="chat-back container pt-1">
                        <label class="form-label">متن پیام (ها)</label>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="row align-items-baseline <%#Eval("isreply").ToString()=="True" ? "is-reply-row":"is-not-reply-row"%>">
                        <div class="col-sm-12 fw-bold <%#Eval("isreply").ToString()=="True" ? "":"d-none"%>">
                            پاسخ صندوق
                        </div>
                        <div class="col-sm-12 fw-bold <%#Eval("isreply").ToString()=="True" ? "d-none":""%>">
                            پیام شما
                        </div>
                        <div class='col-sm-6 <%#Eval("isvoice").ToString()=="True" ? "":"d-none"%> <%#Eval("isreply").ToString()=="True" ? "is-reply":"is-not-reply"%>'>
                            <audio controls>
                                <source src='<%# Eval("voice") %>' type='audio/wav'>
                                امکان پخش این فایل صوتی برای مرورگر شما وجود ندارد.
                            </audio>
                        </div>
                        <div class='col-sm-6 <%#Eval("isvoice").ToString()=="True" ? "d-none":""%> <%#Eval("isreply").ToString()=="True" ? "is-reply":"is-not-reply"%>'>
                            <label class="form-label"><%# Eval("text") %></label>
                        </div>
                        <div class="col-sm-5 align-content-end">
                            <span class="text-muted"><%# DateTime.Parse(Eval("creationdate").ToString()).ToString("f") %></span>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    <div id="not-replied-text" style="border:1px solid black;margin:1rem;border-radius:5px; background-color:antiquewhite;text-align:center;padding:1rem;">

                    </div>
                    <div class="<%# Session["replied"].ToString()=="True" ? "":"d-none"%>">
                        <div class="row">
                            <hr class="mb-1 mt-2" />
                            <div class="col">
                                <label class="form-label" id="rating_label_text" for="rates">سطح رضایت شما از پاسخگویی چطور بود؟</label>
                            </div>
                        </div>
                        <div class="ratings">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" name="inlineRadioOptions" id="inlineRadio5" value="5">
                                <label class="form-check-label" for="inlineRadio5">خیلی خوب</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" name="inlineRadioOptions" id="inlineRadio4" value="4">
                                <label class="form-check-label" for="inlineRadio4">خوب</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="3">
                                <label class="form-check-label" for="inlineRadio3">متوسط</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="2">
                                <label class="form-check-label" for="inlineRadio2">بد</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input rating-radio" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1">
                                <label class="form-check-label" for="inlineRadio1">خیلی بد</label>
                            </div>

                            <div class="form-check form-check-inline mb-2">
                                <input type="button" id="submitscorebtn" class="btn-warning rounded" value="ثبت" onclick="registerRate()" />
                            </div>
                        </div>
                    </div>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [posts] WHERE ([thread_id] = @thread_id) ORDER BY [creationdate]">
                <SelectParameters>
                    <asp:SessionParameter Name="thread_id" SessionField="threadid" Type="Int64" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>


    </div>

    <div class="text-center border-top m-2 p-4">
        <a href="Default.aspx" class="btn-info p-2 rounded">بازگشت</a>
    </div>

    <asp:HiddenField ID="HiddenField1" runat="server" Value="-1" />





    <script>
        function doPostbackThread(threadid) {
            $("#ContentPlaceHolder1_HiddenField1").val(threadid)
            __doPostBack();
        }

        var ratingval = 0;
        var theThreadID = 0;
        var theUserID = 0;

        function registerRate() {
            var obj = {
                'threadid': theThreadID,
                'rate': ratingval,
                'userid': theUserID
            }
            $.ajax({
                url: "rates.ashx",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: obj,
                responseType: "json",
            }).done(function (response) {
                $('.toast-header').addClass('bg-success');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('ثبت موفق');
                $('#toastbody').html('امتیاز شما ثبت شد');
                $('.toast').toast('show');
            }).fail(function (jqXHR, textStatus) {
                $('.toast-header').addClass('bg-danger');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('ثبت ناموفق');
                $('#toastbody').html('امتیاز شما ثبت نشد. لطفا کمی بعد محددا تلاش کنید.');
                $('.toast').toast('show');
            });
        }

        $(document).ready(function () {
            var userid = '<%= Session["userid"].ToString() %>';
            var threadid = '<%= Session["threadid"].ToString() %>';
            var thescore = '<%= Session["threadscore"].ToString() %>';
            var replied = '<%= Session["replied"].ToString() %>';
            $('.message[data-thread=' + threadid + ']').addClass('bg-warning');

            if (thescore=='0') {
                $('#submitscorebtn').css('display', 'block');
            } else {
                $("#inlineRadio" + thescore).prop("checked", true);
                $('.rating-radio').attr('disabled', 'true');
                $('#submitscorebtn').css('display', 'none');
                $('#rating_label_text').html('سطح رضایت ثبت شده توسط نسبت به این شکایت:')
            }

            if (replied=='False') {
                //alert('هنوز پاسخ شکایت شما ارسال نشده است. در اسرع وقت به شکایت شما رسیدگی خواهد شد.');
                $('#not-replied-text').html('هنوز پاسخ شکایت شما ارسال نشده است. در اسرع وقت به شکایت شما رسیدگی خواهد شد.');
            } else {
                $('#not-replied-text').css('display', 'none');
            }




            $('.rating-radio').change(function () {
                //alert($(this).val());
                ratingval = $(this).val();
                theUserID = userid;
                theThreadID = threadid;
                //var obj = {
                //    'threadid': threadid,
                //    'rate': $(this).val(),
                //    'userid': userid
                //}
                //$.ajax({
                //    url: "rates.ashx",
                //    contentType: "application/json; charset=utf-8",
                //    dataType: "json",
                //    data: obj,
                //    responseType: "json",
                //}).done(function (response) {
                //    $('.toast-header').addClass('bg-success');
                //    $('#toasttitle').addClass('text-white');
                //    $("#toasttitle").html('ثبت موفق');
                //    $('#toastbody').html('امتیاز شما ثبت شد');
                //    $('.toast').toast('show');
                //}).fail(function (jqXHR, textStatus) {
                //    $('.toast-header').addClass('bg-danger');
                //    $('#toasttitle').addClass('text-white');
                //    $("#toasttitle").html('ثبت ناموفق');
                //    $('#toastbody').html('امتیاز شما ثبت نشد. لطفا کمی بعد محددا تلاش کنید.');
                //    $('.toast').toast('show');
                //});

            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
