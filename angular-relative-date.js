(function() {
  'use strict';
  angular.module('relativeDate', []).value('now', new Date()).filter('relativeDate', [
    'now', function(now) {
      return function(date) {
        var calculateDelta, day, delta, hour, minute, month, week, year;
        if (!(date instanceof Date)) {
          date = new Date(date);
        }
        delta = null;
        minute = 60;
        hour = minute * 60;
        day = hour * 24;
        week = day * 7;
        month = day * 30;
        year = day * 365;
        calculateDelta = function() {
          return delta = Math.round((now - date) / 1000);
        };
        calculateDelta();
        if (delta > day && delta < week) {
          date = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
          calculateDelta();
        }
        switch (false) {
          case !(delta < 30):
            return '剛剛';
          case !(delta < minute):
            return "" + delta + " 秒前";
          case !(delta < 2 * minute):
            return '1 分鐘前';
          case !(delta < hour):
            return "" + (Math.floor(delta / minute)) + " 分鐘前";
          case Math.floor(delta / hour) !== 1:
            return '1 小時前';
          case !(delta < day):
            return "" + (Math.floor(delta / hour)) + " 小時前";
          case !(delta < day * 2):
            return '昨天';
          case !(delta < week):
            return "" + (Math.floor(delta / day)) + " 天前";
          case Math.floor(delta / week) !== 1:
            return '1 週前';
          case !(delta < month):
            return "" + (Math.floor(delta / week)) + " 週前";
          case Math.floor(delta / month) !== 1:
            return '上個月';
          case !(delta < year):
            return "" + (Math.floor(delta / month)) + " 個月前";
          case Math.floor(delta / year) !== 1:
            return '1 年前';
          default:
            return '很久以前';
        }
      };
    }
  ]);

}).call(this);

/*
//@ sourceMappingURL=angular-relative-date.js.map
*/