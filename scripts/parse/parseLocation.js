function renameProps(obj) {
    // mapping of old property names to new property names
    const propMap = {
      id: 'id',
      name: 'name'
    };
  
    // create a new object with renamed properties
    let newObj = {};
    Object.keys(obj).forEach(key => {
      if (propMap[key]) {
        newObj[propMap[key]] = obj[key];
      }
    });
  
    return newObj
  }
  
  async function parseLocation(id, contract) {
    let Location = await contract.getLocation(id)
    Location = { ...Location }
    Location = renameProps(Location)
    return Location
  }

  async function parseNewestLocation(contract) {
    let Location = await contract.getNewestLocation()
    Location = { ...Location }
    Location = renameProps(Location)
    return Location
  }
  
  module.exports = { parseLocation, renameProps, parseNewestLocation }
  
  
  
  
  