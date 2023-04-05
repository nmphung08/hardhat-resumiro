function renameProps(obj) {
    // mapping of old property names to new property names
    const propMap = {
      id: 'id',
      position: 'position',
      start: 'start',
      finish: 'finish',
      companyId: 'company_id',
      userId: 'user_id',
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
  
  async function parseExperience(id, contract) {
    let Experience = await contract.getExperience(id)
    Experience = { ...Experience }
    Experience = renameProps(Experience)
    return Experience
  }

  async function parseNewestExperience(contract) {
    let Experience = await contract.getNewestExperience()
    Experience = { ...Experience }
    Experience = renameProps(Experience)
    return Experience
  }
  
  module.exports = { parseExperience, renameProps, parseNewestExperience }
  
  
  
  
  