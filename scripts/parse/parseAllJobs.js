
// Parse folder used for parsing blockchain data into JSON

function renameProps(obj) {
  // mapping of old property names to new property names
  const propMap = {
    id: 'id',
    title: 'title',
    locationId: 'location_id',
    jobTypeId: 'job_type_id',
    experience: 'experience',
    requirements: 'requirements',
    benefits: 'benefits',
    createAt: 'create_at',
    updateAt: 'update_at',
    recruiterId: 'recruiter_id',
    companyId: 'company_id',
    salary: 'salary',
    fieldId: 'field_id'
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

async function parseAllJobs(contract) {
  let returnObj = []
  let jobs = await contract.getAllJobs()
  for (let job of jobs) {
    job = { ...job }
    job = renameProps(job)
    returnObj.push(job)
  }
  return returnObj
}

module.exports = { parseAllJobs, renameProps }




