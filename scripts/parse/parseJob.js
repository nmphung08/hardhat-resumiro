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

async function parseJob(id, contract) {
  let job = await contract.getJob(id)
  job = { ...job }
  job = renameProps(job)
  return job
}

async function parseNewestJob(contract) {
  let job = await contract.getNewestJob()
  job = { ...job }
  job = renameProps(job)
  return job
}

module.exports = { parseJob, renameProps, parseNewestJob }




