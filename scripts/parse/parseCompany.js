function renameProps(obj) {
  // mapping of old property names to new property names
  const propMap = {
    id: "id",
    ownerId: "owner_id",
    name: "name",
    logo: "logo",
    background: "background",
    about: "about",
    scale: "scale",
    website: "website",
    locationId: "location_id",
    addr: "address",
    introduction: "introduction",
  };

  // create a new object with renamed properties
  let newObj = {};
  Object.keys(obj).forEach((key) => {
    if (propMap[key]) {
      newObj[propMap[key]] = obj[key];
    }
  });

  return newObj;
}

async function parseCompany(id, contract) {
  let Company = await contract.getCompany(id);
  Company = { ...Company };
  Company = renameProps(Company);
  return Company;
}

async function parseNewestCompany(contract) {
  let Company = await contract.getNewestCompany();
  Company = { ...Company };
  Company = renameProps(Company);
  return Company;
}

module.exports = { parseCompany, renameProps, parseNewestCompany };
