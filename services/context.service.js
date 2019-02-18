function Context(ObjectContext) {
    this.ObjectContext = ObjectContext;
}

Context.prototype.set = function (ObjectContext) {
    this.ObjectContext = ObjectContext;
};

Context.prototype.get = function () {
    return this.ObjectContext;
};

module.exports = Context;