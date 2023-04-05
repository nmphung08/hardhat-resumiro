function renameProps(obj) {
    // mapping of old property names to new property names
    const propMap = {
      id: 'id',
      data: 'data',
      candidate: 'owner_id',
      title: 'title',
      createAt: 'create_at',
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
  
  async function parseResume(id, contract) {
    let Resume = await contract.getResume(id)
    Resume = { ...Resume }
    Resume = renameProps(Resume)
    return Resume
  }

  async function parseNewestResume(contract) {
    let Resume = await contract.getNewestResume()
    Resume = { ...Resume }
    Resume = renameProps(Resume)
    return Resume
  }
  
  module.exports = { parseResume, renameProps, parseNewestResume }
  
  
  
  
  