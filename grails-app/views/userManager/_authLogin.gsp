<fieldset>
    <legend><h4 class="header">&nbsp;Login&nbsp;</h4></legend>
    <form action='${request.contextPath}/j_spring_security_check' method='POST'>
        <div class="row">
            <div class="input-field col s12">
                <i class="material-icons prefix">contact_mail</i>
                <input id="email" name="j_username" type="email" class="validate" required/>
                <label for="email">E-mail <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12">
                <a id="btnShowPassword"
                   class="waves-effect waves-indigo accent-2 btn-flat grey lighten-4 black-text button-show-password"
                   onmousedown="showPassword()" onmouseup="hidePassword()">
                    <i class="fa fa-eye"></i>
                </a>
                <i class="material-icons prefix">lock</i>
                <input id="password" name="j_password" type="password" class="validate"
                       required minlength="5">
                <label for="password">Senha <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 center">
                <button class="btn-large waves-effect waves-light blue darken-3" type="submit" name="submit">
                    <i class="fa fa-sign-in left"></i>Entrar
                </button>
            </div>
        </div>
    </form>
</fieldset>

<script type="text/javascript">

    function showPassword() {
        $("#password").attr("type", "text");
    }

    function hidePassword() {
        $("#password").attr("type", "password");
    }

</script>
