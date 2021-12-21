<%@ Page Title="شکایت جدید" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="newdiscontent.aspx.cs" Inherits="Shekayat.newdiscontent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row g-3">
        <div class="col-sm-12">
            <asp:Label ID="Label5" runat="server" AssociatedControlID="subject" CssClass="form-label" Text="موضوع درخواست"></asp:Label>
            <asp:TextBox ID="subject" runat="server" class="form-control"></asp:TextBox>
            <br />
            <input id="subjectsubmit" type="button" class="btn btn-info col-sm-12 w-100" value="ادامه" /><asp:HiddenField ID="HiddenField1" runat="server" Value="-1" />
&nbsp;</div>
        <div class="second-step second-step-hide row">
            <div class="col-sm-12 text-center text-primary fw-bold">
                شما می‌توانید متن درخواست خود را به صورت متن و یا با ضبط صدای خود ارسال کنید.
            </div>
            <br /><br />
            <div class="col-sm-5">
                <input id="bytext" type="button" class="btn-info w-100 switcher" value="به صورت متن" />
            </div>
            <div class="col-sm-5">
                <input id="byvoice" type="button" class="btn-info w-100 switcher" value="به صورت صوتی" />
            </div>
            
            <div class="col-sm-12 by-text d-none">
                <br />
                <asp:Label ID="Label4" runat="server" AssociatedControlID="texts" CssClass="form-label" Text="متن درخواست به صورت نوشته"></asp:Label>
                <asp:TextBox ID="texts" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                <div class="invalid-feedback">
                    لطفا متن درخواست را بنویسید.
                </div>
            </div>
<%--            <div class="col-sm-1 align-content-center align-items-center text-center d-none">
                <span class="text-center">یا</span>
            </div>--%>
            <div class="col-sm-12 align-content-center border-1 border-info  by-voice d-none">
                <br />
                <div class="text-start">درخواست به صورت صوتی</div>
                <div class="m-2"></div>
                <div id="controls">
                    <button id="recordButton" class="btn-danger">ضبط صدا</button>
                    <button id="pauseButton" disabled>توقف</button>
                    <button id="stopButton" disabled>پایان ضبط</button>
                </div>
                <div id="formats"></div>
                <p><strong></strong></p>
                <ol id="recordingsList"></ol>
            </div>
            <hr class="my-4"/>
            <div class="col-sm-12">

                <asp:Button ID="Button1" runat="server" CssClass="btn-success w-100" Text="ارسال درخواست" Enabled="False" OnClick="Button1_Click" OnClientClick="return goSubmit()" />

            </div>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script>



        $(document).ready(function () {
            $('#subjectsubmit').click(function () {
                if ($('#ContentPlaceHolder1_subject').val() != '') {
                    $('.second-step').removeClass('second-step-hide');
                    $('#subjectsubmit').hide();
                } else {
                    alert('no');
                }
            });

            $('.switcher').click(function () {
                if ($(this).attr('id') == 'bytext') {
                    $('.by-text').removeClass('d-none');
                    $('.by-voice').addClass('d-none');
                } else {
                    $('.by-voice').removeClass('d-none');
                    $('.by-text').addClass('d-none');
                }
            });



            $('#uploaddata').click(function () {
                var filename = new Date().toISOString();

                var xhr = new XMLHttpRequest();
                xhr.onload = function (e) {
                    if (this.readyState === 4) {
                        console.log("Server returned: ", e.target.responseText);
                    }
                };
                var fd = new FormData();
                fd.append("audio_data", blob, filename);
                xhr.open("POST", "upload.aspx", true);
                xhr.send(fd);

            });



            $("#ContentPlaceHolder1_texts").on('change keyup paste', function () {
                if ($("#ContentPlaceHolder1_texts").val() != "") {
                    $("#ContentPlaceHolder1_Button1").removeAttr("disabled");
                    $('#ContentPlaceHolder1_HiddenField1').val(1);
                } else {
                    if (!post_status) {
                        $('#ContentPlaceHolder1_HiddenField1').val('-1');
                        $("#ContentPlaceHolder1_Button1").attr("disabled","disable");
                    }
                }
            });
        });







        post_status = false;

        function voiceUploaded(status) {
            post_status = true;
            $('#ContentPlaceHolder1_HiddenField1').val(1);
            $('#ContentPlaceHolder1_Button1').removeAttr("disabled");
        }


        function goSubmit() {
            if (post_status == true) {
                return true;
            } else {
                alert('nooooo');
                return false;
            }
        }
    </script>
    <script src="js/recorder.js"></script>
    <script src="js/app.js"></script>
</asp:Content>
