DogSittingApp.Views.DogShow = Backbone.CompositeView.extend({
  template: JST['dogs/show'],

  initialize: function() {
    this.listenTo(this.model, 'add', this.render);
    this.listenTo(this.model.bookings(), 'add', this.addBooking);

    this.model.bookings().each(this.addBooking.bind(this));
  },

  events: {
    'click .removeDog': 'removeDog'
  },

  addBooking: function (booking) {
    var subview = new DogSittingApp.Views.DogBookingShow({
      model: booking
    });

    this.addSubview('.dog_bookings', subview.render());
  },

  render: function() {

    var renderedContent = this.template({
      dog: this.model
    });



    this.$el.html(renderedContent);

    this.attachSubviews();

    return this;
  },

  removeDog: function(event) {

    event.preventDefault();
    this.model.destroy();

    Backbone.history.navigate("/", { trigger: true })
  }
});