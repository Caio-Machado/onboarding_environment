defmodule MailerWeb.MailerServiceTest do
  use MailerWeb.ConnCase

  alias MailerWeb.MailerService

  setup_all do
    subject = "Products report updated"
    from = "testemail2@email.com"
    to = "testemail1@email.com"

    data =
      "amount,barcode,description,id,name,price,sku\n50,123456789,Description,6216692d77161b03291e1f4c,Name,10.0,Sku\n"

    [subject: subject, from: from, to: to, data: data]
  end

  describe "create_email/0" do
    test "with correct information", %{subject: subject, from: from, to: to, data: data} do
      email_info = MailerService.create_email()
      [attachment_info] = email_info.attachments

      assert email_info.subject == subject
      assert email_info.from == from
      assert email_info.to == to

      assert attachment_info.data == data
    end
  end
end
