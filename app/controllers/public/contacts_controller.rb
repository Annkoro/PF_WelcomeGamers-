class Public::ContactsController < ApplicationController
  before_action :authenticate_user!
  def new
    @contact = Contact.new
  end

  # 確認画面送信ボタンを押されたらcreateアクションを実行
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  # 入力内容に誤りがあった場合入力内容を保持したまま前のページに戻る
  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  # ここで初めて入力内容を保存
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to thanks_contacts_path
    else
      render :new
    end
  end

  # 送信完了画面
  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :subject, :message)
  end
end
