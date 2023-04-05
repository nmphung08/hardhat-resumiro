function renameProps(obj) {
    // mapping of old property names to new property names
    const propMap = {
      id: 'id',
      owned: 'owned',
      avatar: 'avatar',
      background: 'background',
      addressWallet: 'address_wallet',
      fullName: 'full_name',
      email: 'email',
      phone: 'phone',
      position: 'position',

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
  
  async function parseRecruiter(id, contract) {
    let Recruiter = await contract.getRecruiter(id)
    Recruiter = { ...Recruiter }
    Recruiter = renameProps(Recruiter)
    return Recruiter
  }
  
  module.exports = { parseRecruiter, renameProps }
  
  
  
  
  