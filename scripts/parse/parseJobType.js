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
  
  async function parseJobType(id, contract) {
    let JobType = await contract.getJobType(id)
    JobType = { ...JobType }
    JobType = renameProps(JobType)
    return JobType
  }

  async function parseNewestJobType(contract) {
    let JobType = await contract.getNewestJobType()
    JobType = { ...JobType }
    JobType = renameProps(JobType)
    return JobType
  }
  
  module.exports = { parseJobType, renameProps, parseNewestJobType }
  
  
  
  
  