TTR.Views.Favorite = Backbone.View.extend({
  
  template: JST['favorite'],
  
  events: {
    "click .btn-danger": "removeFavorite",
    "click .btn-success": "addFavorite"
  },
  
  render: function(){
    var renderedContent = this.template({ count: this.numOfFavorites() })
    this.$el.html(renderedContent);
    this.customizeButton();
    return this;
  },
  
  customizeButton: function(){
    var button = this.$el.find('a');
    if( this.isOwnedByCurrentUser() || this.userNotLoggedIn() ){
      button.attr('disabled', true);
    } else if ( this.isFavoritedByCurrentUser() ){
      button.removeClass();
      button.addClass('btn btn-small btn-danger');
    } else {
      button.removeClass();
      button.addClass('btn btn-small btn-success');
    }
  },
  
  addFavorite: function(){    
    var that = this;
    var fav = new TTR.Models.Favorite()
    fav.set({loop_collection_id: this.collection.loopCollectionId});
    
    this.collection.create(fav, {
      success: function(){
        that.render(); 
      }
    });

  },
  
  removeFavorite: function(){  
    var that = this;
    var ajaxCallBack = { 
      success: function(){ 
        that.render() 
      }, 
      failure: function(){
        console.log('fart') 
      }
    };
    
    this.currentUserFavorite().destroy(ajaxCallBack);
  },
  
  isOwnedByCurrentUser: function(){
    return this.collection.findWhere({isOwnedByCurrentUser: true});
  },
  
  userNotLoggedIn: function(){
    if (this.collection.first()){
      return this.collection.first().get('userNotLoggedIn');
    } else {
      return false
    }
  },
  
  isFavoritedByCurrentUser: function(){
    return this.currentUserFavorite() ? true : false;
  },
  
  currentUserFavorite: function(){ 
    return this.collection.findWhere({isCurrentUserFavorite: true});
  },
  
  numOfFavorites: function(){
    return this.collection.length
  },

});