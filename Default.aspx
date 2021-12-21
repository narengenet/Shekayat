<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Shekayat.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="p-4 p-md-5 mb-4 text-white rounded bg-slider">
        <%--        <div class="col-md-6 px-0">
            <h1 class="display-6" style="color:black;font-weight:bold;">سامانه شکایات مردمی صندوق بیمه اجتماعی کشاورزان روستاییان و عشایر</h1>
            <p class="lead my-3" style="background-color:rgba(0,0,0,0.5);padding:5px;border-radius:10px;">همراهان گرامی صندوق بیمه اجتماعی کشاورزان، روستاییان و عشایر ارسال نظرات و انتقادات شما در هر حوضه عملکردی این صندوق می تواند مارا برای ارائه هرچه بهتر خدمات یاری رساند.</p>
            <p class="lead mb-0"><a href="#" class="text-white fw-bold">ادامه ...</a></p>
            <p>
                <br />
            </p>
        </div>
                    <p style="color:black; background-color:orange; padding:5px; border-radius:5px; display:inline-block;">
                این سامانه توسط دفتر مدیرعامل صندوق مدیریت میشود. 
            </p>--%>
    </div>

    <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link home active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">ثبت شکایت جدید</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link home" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">پیگیری شکایت</button>
        </li>
        <%--        <li class="nav-item" role="presentation">
            <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">تماس با ما</button>
        </li>--%>
    </ul>
    <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
            <div class="card mb-4 rounded-3 shadow-sm  border-top-0 back-card-a">
                <div class="card-body">
                    <div runat="server" id="formNewDiscontent" class="needs-validation">
                        <asp:Panel runat="server" DefaultButton="newDiscontent">
                            <div class="row g-3">
                                <div class="col-sm-4">
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="firstName" CssClass="form-label" Text="نام"></asp:Label><span class="text-danger"> * </span>
                                    <asp:TextBox ID="firstName" runat="server" class="form-control mandatory"></asp:TextBox>
                                    <div runat="server" id="firstNameErr" class="invalid-feedback">
                                        لطفا نام خود را بنویسید.
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="lastName" CssClass="form-label" Text="نام خانوادگی"></asp:Label><span class="text-danger"> * </span>
                                    <asp:TextBox ID="lastName" runat="server" class="form-control mandatory"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        لطفا نام خانوادگی خود را بنویسید.
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="mobile" class="form-label" Text="شماره تلفن همراه"></asp:Label><span class="text-danger"> * </span>
                                    <asp:TextBox ID="mobile" runat="server" AutoCompleteType="Cellular" class="form-control mandatory" placeholder="شماره همراه به صورت 09391234567"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        لطفا شماره تلفن همراه خود را بنویسید.
                                    </div>
                                </div>

                                <div class="col-6">
                                    <asp:Label ID="Label8" runat="server" AssociatedControlID="NationalCode" class="form-label" Text="کد ملی"></asp:Label><span class="text-danger"> * </span>
                                    <asp:TextBox ID="NationalCode" runat="server" class="form-control mandatory" placeholder="کدملی ده رقمی"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        لطفا کد ملی ده رقمی خود را کامل بنویسید.
                                    </div>
                                </div>

                                <div class="col-6">
                                    <asp:Label ID="Label9" runat="server" AssociatedControlID="InsuranceCode" class="form-label" Text="کد بیمه"></asp:Label>
                                    <asp:TextBox ID="InsuranceCode" runat="server" class="form-control mandatory" placeholder="کد بیمه ای"></asp:TextBox>
                                </div>

                                <div class="col-md-6">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="state" CssClass="form-label" Text="استان"></asp:Label><span class="text-danger"> * </span>
                                    <asp:DropDownList ID="state" runat="server" class="form-select mandatory">
                                        <asp:ListItem Selected="True" Value="-1">انتخاب استان ...</asp:ListItem>
                                        <asp:ListItem Value="1">آذربایجان شرقی</asp:ListItem>
                                        <asp:ListItem Value="2">آذربایجان غربی</asp:ListItem>
                                        <asp:ListItem Value="3">اردبیل</asp:ListItem>
                                        <asp:ListItem Value="4">اصفهان</asp:ListItem>
                                        <asp:ListItem Value="5">البرز</asp:ListItem>
                                        <asp:ListItem Value="6">ایلام</asp:ListItem>
                                        <asp:ListItem Value="7">بوشهر</asp:ListItem>
                                        <asp:ListItem Value="8">تهران</asp:ListItem>
                                        <asp:ListItem Value="9">چهارمحال و بختیاری</asp:ListItem>
                                        <asp:ListItem Value="10">خراسان جنوبی</asp:ListItem>
                                        <asp:ListItem Value="11">خراسان رضوی</asp:ListItem>
                                        <asp:ListItem Value="12">خراسان شمالی</asp:ListItem>
                                        <asp:ListItem Value="13">خوزستان</asp:ListItem>
                                        <asp:ListItem Value="14">زنجان</asp:ListItem>
                                        <asp:ListItem Value="15">سمنان</asp:ListItem>
                                        <asp:ListItem Value="16">سیستان و بلوچستان</asp:ListItem>
                                        <asp:ListItem Value="17">فارس</asp:ListItem>
                                        <asp:ListItem Value="18">قزوین</asp:ListItem>
                                        <asp:ListItem Value="19">قم</asp:ListItem>
                                        <asp:ListItem Value="20">کردستان</asp:ListItem>
                                        <asp:ListItem Value="21">کرمان</asp:ListItem>
                                        <asp:ListItem Value="22">کرمانشاه</asp:ListItem>
                                        <asp:ListItem Value="23">کهگیلویه و بویراحمد</asp:ListItem>
                                        <asp:ListItem Value="24">گلستان</asp:ListItem>
                                        <asp:ListItem Value="25">گیلان</asp:ListItem>
                                        <asp:ListItem Value="26">لرستان</asp:ListItem>
                                        <asp:ListItem Value="27">مازندران</asp:ListItem>
                                        <asp:ListItem Value="28">مرکزی</asp:ListItem>
                                        <asp:ListItem Value="29">هرمزگان</asp:ListItem>
                                        <asp:ListItem Value="30">همدان</asp:ListItem>
                                        <asp:ListItem Value="31">یزد</asp:ListItem>
                                    </asp:DropDownList>
                                    <div class="invalid-feedback">
                                        لطفا استان محل سکونت خود را انتخاب کنید.
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="city" CssClass="form-label" Text="شهر / روستا / ده"></asp:Label><span class="text-danger"> * </span>
                                    <asp:TextBox ID="city" runat="server" class="form-control mandatory"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        لطفا نام شهر/روستا یا ده خود را وارد کنید.
                                    </div>

                                </div>
                            </div>
                            <br />
                            <span class="text-danger">فیلدهای * دار الزامی هستند.</span>
                            <br />
                            <br />
                            <asp:Button ID="newDiscontent" runat="server" CssClass="w-100 btn btn-lg btn-primary mainmandatory" Text="ادامه" OnClick="newDiscontent_Click" />
                        </asp:Panel>
                    </div>

                </div>
            </div>

        </div>
        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
            <div class="card mb-4 rounded-3 shadow-sm border-top-0 back-card-b">
                <div class="card-body">
                    <div class="row align-items-center text-center mb-3">
                        <label class="form-label text-danger fw-bold">* شما میتوانید از یکی  از روش‌های زیر برای پیگیری شکایت خود اقدام کنید.</label>
                    </div>

                    <div class="needs-validation mt-2">
                        <div class="row g-3">
                            <div class="col-sm-12 col-md-5 border rounded p-2 back-card-c">
                                <asp:Panel ID="p" runat="server" DefaultButton="discontentByMobile">
                                    <asp:Label ID="Label6" runat="server" AssociatedControlID="phone" CssClass="form-label bold-smal-text" Text="پیگیری از طریق شماره تلفن همراه"></asp:Label>
                                    <asp:TextBox ID="phone" runat="server" AutoCompleteType="Cellular" CssClass="form-control" placeholder="شماره همراه به صورت 0939123456789"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        لطفا شماره تلفن همراه خود را بنویسید.
                                    </div>
                                    <asp:Button ID="discontentByMobile" runat="server" CssClass="w-100 btn btn-lg btn-info mt-2" Text="ادامه" OnClick="discontentByMobile_Click" />
                                </asp:Panel>
                            </div>
                            <div class="col-sm-12 col-md-2 text-center">
                                یا
                            </div>

                            <div class="col-sm-12 col-md-5 border rounded p-2 back-card-d">
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="discontentByToken">
                                    <asp:Label ID="Label7" runat="server" AssociatedControlID="token" CssClass="form-label bold-smal-text" Text="پیگیری از طریق شماره پیگیری"></asp:Label>
                                    <asp:TextBox ID="token" runat="server" CssClass="form-control"></asp:TextBox>
                                    <div class="invalid-feedback">
                                        لطفا شماره پیگیری خود را بنویسید.
                                    </div>
                                    <asp:Button ID="discontentByToken" runat="server" CssClass="w-100 btn btn-lg btn-warning mt-2" Text="ادامه" OnClick="discontentByToken_Click" />
                                </asp:Panel>
                            </div>


                        </div>


                    </div>

                </div>
            </div>
        </div>
        <%--        <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
            <div class="card mb-4 rounded-3 shadow-sm border-top-0">
                <div class="card-body">
                    در صورت بروز هر نوع مشکل و یا نیاز به تماس تلفنی می توانید با شماره تلفن های زیر تماس حاصل فرمایید.
            <a href="tel:+982122222222">02122222222</a>
                </div>
            </div>
        </div>--%>
    </div>

    <%--<div class="row row-cols-1 row-cols-md-2 mb-2 text-center">
        <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm border-primary">
                <div class="card-header py-3 text-white bg-success border-primary">
                    <h4 class="my-0 fw-normal">ثبت شکایت جدید</h4>
                </div>
                <div class="card-body">
                    <div class="needs-validation">
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <label for="firstName" class="form-label">نام<span class="text-muted">(اجباری)</span></label>
                                <input type="text" class="form-control" id="firstName" placeholder="" value="" required="">
                                <div class="invalid-feedback">
                                    لطفا نام خود را بنویسید.
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <label for="lastName" class="form-label">نام خانوادگی<span class="text-muted">(اجباری)</span></label>
                                <input type="text" class="form-control" id="lastName" placeholder="" value="" required="">
                                <div class="invalid-feedback">
                                    لطفا نام خانوادگی خود را بنویسید.
                                </div>
                            </div>

                            <div class="col-12">
                                <label for="mobile" class="form-label">تلفن همراه <span class="text-muted">(اجباری)</span></label>
                                <input type="tel" class="form-control" id="mobile" placeholder="0939123456789" required="">
                                <div class="invalid-feedback">
                                    لطفا شماره تلفن همراه خود را بنویسید.
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="state" class="form-label">استان</label>
                                <select class="form-select" id="state" required="">
                                    <option value="">انتخاب کنید...</option>
                                    <option>تهران</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a valid country.
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="city" class="form-label">شهر / روستا / ده</label>
                                <input type="text" class="form-control" id="city" placeholder="" required="">
                                <div class="invalid-feedback">
                                    Zip code required.
                                </div>
                            </div>
                        </div>

                        <hr class="my-4">
                    </div>
                    <button type="button" class="w-100 btn btn-lg btn-primary">ادامه ...</button>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card mb-4 rounded-3 shadow-sm">
                <div class="card-header py-3">
                    <h4 class="my-0 fw-normal">پیگیری شکایت</h4>
                </div>
                <div class="card-body">
                    
                    <div class="needs-validation">
                        <div class="row g-3">

                            <div class="col-12">
                                <label for="phone" class="form-label">پیگیری از طریق شماره تلفن همراه</label>
                                <input type="tel" class="form-control" id="phone" placeholder="0939123456789" required="">
                                <div class="invalid-feedback">
                                    لطفا شماره تلفن همراه خود را بنویسید.
                                </div>
                            </div>
                            <button type="button" class="w-100 btn btn-lg btn-info">ادامه</button>
                            <br /><br /><br />
                            <hr class="my-4" />
                            <div class="col-12">
                                <label for="token" class="form-label">پیگیری از طریق کد رهگیری شکایت</label>
                                <input type="text" class="form-control" id="token"  required="">
                                <div class="invalid-feedback">
                                    لطفا شماره تلفن همراه خود را بنویسید.
                                </div>
                            </div>
                            <button type="button" class="w-100 btn btn-lg btn-warning">ادامه</button>

                        </div>

                        
                    </div>
                    
                </div>
            </div>
        </div>
    </div>--%>


    <script>
        $(document).ready(function () {
            if (getUrlVars().verifier == 'false') {
                $('.toast-header').addClass('bg-danger');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('ورود ناموفق');
                $('#toastbody').html('دفعات مجاز ورود با کد پیامکی به اتمام رسید. لطفا کمی بعد محددا تلاش کنید.');
                $('.toast').toast('show');
            }
            $('#ContentPlaceHolder1_newDiscontent').attr('disabled', 'disabled');
        });


        $(".mandatory").change(function () {

            validateBtn();
            console.log($(this).val() + " :sina");

        });

        $(".mandatory").keyup(function () {

            validateBtn();
            console.log($(this).val() + " :sina");

        });

        $(".mandatory").focus(function () {

            validateBtn();

        });




        function validateBtn() {
            result = true;
            if ($('#ContentPlaceHolder1_firstName').val().length < 1) {
                result = false;
            }
            if ($('#ContentPlaceHolder1_lastName').val().length < 1) {
                result = false;
            }

            if ($('#ContentPlaceHolder1_mobile').val().length != 11) {
                result = false;
            }

            if ($('#ContentPlaceHolder1_NationalCode').val().length != 10) {
                result = false;
            }

            if ($('#ContentPlaceHolder1_state').val() == '-1') {
                result = false;
            }

            if ($('#ContentPlaceHolder1_city').val().length < 1) {
                result = false;
            }

            if (result) {
                $('#ContentPlaceHolder1_newDiscontent').removeAttr('disabled');
            } else {
                $('#ContentPlaceHolder1_newDiscontent').attr('disabled', 'disabled');
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
