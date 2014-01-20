var Pioneer = {
};

Pioneer.Main = function() {
  this.onFundsSuccessBind = this.onFundsSuccess.bind(this);
  this.onFundClickBind = this.onFundClick.bind(this);
  this.onFundItemsSuccessBind = this.onFundItemsSuccess.bind(this);
};

Pioneer.Main.prototype = {
  start: function() {
    this.chart = new Highcharts.StockChart({
      chart: {
        renderTo: 'chart'
      },
      rangeSelector: {
        selected: 1
      },
      series: [
        {}
      ]
    });
    
    $.get('/api/funds', this.onFundsSuccessBind);
  },
  
  onFundsSuccess: function(data, status, response) {
    $('#funds').html(_.map(data, this.renderFundItem, this));
  },
  
  renderFundItem: function(i) {
    var li = $(document.createElement('li'));
    var a = $(document.createElement('a'));
    
    a.attr('href', '/api/funds/' + i.id);
    a.html(i.name);
    a.on('click', this.onFundClickBind);
    
    li.addClass('list-group-item');
    li.append(a);
    
    return li;
  },
  
  onFundClick: function(e) {
    e.preventDefault();
    
    var el = $(e.currentTarget);
    
    this.fundName = el.html();
    
    $.get(el.attr('href'), this.onFundItemsSuccessBind);
  },
  
  onFundItemsSuccess: function(data, status, response) {
    this.updateChart(data);
  },
  
  updateChart: function(data) {
    this.chart.series[0].update({name: this.fundName}, false);
    this.chart.series[0].setData(_.map(data, this.toValues, this), false);

    this.chart.redraw();
  },
  
  toValues: function(i) {
    return [Date.parse(i.date), i.value];
  }
};

var main = new Pioneer.Main();

$(function() {
  main.start();
});
