function MessageView(messageData, $messageDiv) {
  this.senderName = messageData.sender_name;
  this.senderId = messageData.sender;
  this.receiverName = messageData.receiver_name;
  this.receiverId = messageData.receiver;
  this.subject = messageData.subject;
  this.body = messageData.body;
  this.imagePath = messageData.image_path;
  this.$messageDiv = $messageDiv;

  $messageDiv.one('click', '[data-behavior=show-body]', this.showBody.bind(this));
}

MessageView.prototype.showBody = function (event){
  event.preventDefault();
  var $bodyDiv = $("<div id='message-body' data-display='body'>");
  var $html = $(JST['templates/show_body'](this));
  $bodyDiv.append($html);

  this.$messageDiv.append($bodyDiv);
};