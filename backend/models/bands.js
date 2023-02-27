const Band = require('./band');

class Bands {
  constructor() {
    this.bands = [];
  }

  addBand(band = new Band()) {
    this.bands.push(band);
  }

  getBands() {
    return this.bands;
  }

  deleteBand(id) {
    this.bands = this.bands.filter((band) => {
      band.id !== id;
    });
    return this.bands;
  }

  voteBand(id) {
    for (let i = 0; i < this.bands.length; i++) {
      if (this.bands[i].id === id) {
        this.bands[i].vote += 1;
        return this.bands;
      }
    }
  }
}

module.exports = Bands;
