const { v4: uuid4 } = require('uuid');

class Band {
  constructor(name = 'no-name') {
    this.id = uuid4().slice(0, 8);
    this.name = name;
    this.votes = 0;
  }
}

module.exports = Band;
