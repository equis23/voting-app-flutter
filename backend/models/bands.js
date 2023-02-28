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
      let band = this.bands[i];
      if (band.id === id) {
        band.votes += 1;
        break;
      }
    }
    return this.getBands();
  }
}

module.exports = Bands;
