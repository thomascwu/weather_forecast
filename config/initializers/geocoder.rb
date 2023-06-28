Geocoder.configure(
    esri: {
        api_key: [
            Rails.application.credentials.arcgis_api_user_id, # <your user id used to sign up>
            Rails.application.credentials.arcgis_api_secret_key, # <your ArcGIS API secret key that assigned to you after sign up>
        ], 
        for_storage: true
    }
)
