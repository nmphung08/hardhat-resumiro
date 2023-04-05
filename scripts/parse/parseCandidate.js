function renameProps(obj) {
    // mapping of old property names to new property names
    const propMap = {
      id: 'id',
      avatar: 'avatar',
      background: 'background',
      addressWallet: 'address_wallet',
      fullName: 'full_name',
      email: 'email',
      phone: 'phone',
      about: 'about',

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
  
  async function parseCandidate(id, contract) {
    let Candidate = await contract.getCandidate(id)
    Candidate = { ...Candidate }
    Candidate = renameProps(Candidate)
    return Candidate
  }
  
  module.exports = { parseCandidate, renameProps }
  
  
  
  
  