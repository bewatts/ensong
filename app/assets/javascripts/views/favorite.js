TTR.Views.Favorite = Backbone.View.extend({
  
  template: JST['favorite'],
  
  events: {
    "click .btn-danger": "removeFavorite",
    "click .btn-success": "addFavorite"
  },
  
  render: function(){    
    var tooltip_message = this.generateTooltipMessage();
    var renderedContent = this.template({ count: this.model.get('numFavorites'), message: tooltip_message })
    this.$el.html(renderedContent);
    this.customizeButton();
    this.$el.find('.tip').tooltip();
    return this;
  },
  
  generateTooltipMessage: function(){
    if (this.model.get('isOwnedByCurrentUser')){
     return "Cannot favorite your own ensōng"; 
    } else if(this.model.get('userNotLoggedIn')){
     return "Must be logged in to favorite ensōngs";     
    } else {
     return; 
    }
  },
  
  customizeButton: function(){
    var button = this.$el.find('a');
    if( this.model.get('isOwnedByCurrentUser') || this.model.get('userNotLoggedIn') ){
      button.attr('disabled', true);
    } else if ( this.model.get('isFavoritedByCurrentUser') ){
      button.removeClass().addClass('btn btn-small btn-danger');
    } else {
      button.removeClass().addClass('btn btn-small btn-success');
    }
  },
  
  addFavorite: function(){    
    var that = this;

    $.ajax({
      url: "/api/favorites",
      type: "POST",
      data: { loop_collection_id: that.model.id }
    });
    
    this.changeFavorite("up");
    this.render();
  },
  
  removeFavorite: function(){  
    var that = this;

    $.ajax({
      url: "/api/favorites/destroy",
      type: "DELETE",
      data: { loop_collection_id: that.model.id }
    });
     
    this.changeFavorite("down");
    this.render();
  },  
  
  changeFavorite: function(direction){
    var newFavNum = this.model.get('numFavorites') + ( (direction === 'up') ? 1 : -1 ); 
    var opposite = !this.model.get('isFavoritedByCurrentUser');
    this.model.set('numFavorites', newFavNum);
    this.model.set('isFavoritedByCurrentUser', opposite);
  }
  
});