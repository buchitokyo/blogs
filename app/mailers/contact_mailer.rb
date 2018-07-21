class ContactMailer < ApplicationMailer
  def contact_mail(blog)
    @blog = blog
  @contact_user = @blog.user.email
    mail to: @contact_user, subject: "ブログの完了確認メール"
  end
end
