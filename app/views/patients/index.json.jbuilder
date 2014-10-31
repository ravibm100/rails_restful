json.array!(@patients) do |patient|
  json.extract! patient, :id, :name_first, :name_last, :birth_dt_tm
  json.url patient_url(patient, format: :json)
end
