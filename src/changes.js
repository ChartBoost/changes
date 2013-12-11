function Changes() { this.initialize.apply(this, arguments); }

Changes.prototype.initialize = function initialize(resultFn, changeFn) {
    this._frequency = 200;
    this._lastResult = resultFn();
    this._resultFn = resultFn;
    this._changeFn = changeFn;
};

Changes.prototype.setFrequency = function setFrequency(milliseconds) {
    this._frequency = milliseconds;
    this.stop();
    this.start();
};

Changes.prototype.isChanged = function isChanged() {
    this._nextResult = this._resultFn();
    return this._lastResult !== this._nextResult;
};

Changes.prototype.start = function start() {
    if (this._interval) { return false; }
    var self = this;
    this._interval = setInterval(function(){
        if (self.isChanged()) {
            self.trigger();
        }
    }, this._frequency);
};

Changes.prototype.trigger = function trigger() {
    this._changeFn(this._lastResult, this._nextResult);
    this._lastResult = this._nextResult;
};

Changes.prototype.stop = function stop() {
    clearInterval(this._interval);
};

module.exports = Changes;