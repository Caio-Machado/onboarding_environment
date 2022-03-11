defmodule MailerWeb.MailerServiceTest do
  use MailerWeb.ConnCase

  alias MailerWeb.MailerService

  describe "create_email/0" do
    test "with correct information" do
      email_info = MailerService.create_email()
      [attachment_info] = email_info.attachments

      assert email_info.subject == "Products Report"
      assert email_info.from == "testemail2@email.com"
      assert email_info.to == "testemail1@email.com"

      assert attachment_info.data == "amount,barcode,description,id,name,price,sku\n50,123456789,Description,6216692d77161b03291e1f4c,Name,10.0,Sku\n"
    end
  end
end
