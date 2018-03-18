class LoginView extends View {

  constructor(activationToken) {
    super();
    this.activationToken = activationToken;
  }

  template() {
    return `
    <document>
      <alertTemplate>
        <title>Activate your account by visiting:</title>
        <text style="font-weight: bold; font-size: 50;">${data.options.BASEURL}/activate/${this.activationToken}</text>
      </alertTemplate>
    </document>`;
  }

}
