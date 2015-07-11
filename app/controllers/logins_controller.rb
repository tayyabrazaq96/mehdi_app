class LoginsController < ApplicationController
	

	def login_call

		@saved_data = Login.where("facebookID = ? and facebookHASH = ?", 
			params[:facebookID].to_s, params[:facebookHASH].to_s).first
		
		@new_data = Hash.new

		if @saved_data.nil?
			Login.create([{"facebookID" => params[:facebookID].to_s, "facebookHASH" => params[:facebookHASH].to_s,
					"fullName" => params[:fullName].to_s, "gender" => params[:gender].to_s}])
			
			@saved_data = Login.where("facebookID = ? and facebookHASH = ?", 
			params[:facebookID].to_s, params[:facebookHASH].to_s).first
		
		end

		@new_data = {"userID" => @saved_data.id, "facebookID" => @saved_data.facebookID, 
					"fullName" => @saved_data.fullName}

		render :json => @new_data

	end



	def upload_image

		@file = params[:Image].to_s.split("/").last
		@extension = @file.split(".").last
		@name = @file.split(".").first
		t = Time.now
		t = t.nsec
		@file[@name] = t.to_s;
		if @extension == "png" || @extension == "jpeg"
			
			img = Base64.encode64(@file)
			
			Image.create([{"login_id" => params[:userID].to_s, "image" => img}])


			@result = Image.where("login_id = ?", params[:userID].to_s)
			
			@images = Array.new
			
			@result.each_with_index do |row, i|
				
				@image = Hash.new
						
				@image = {"userID" => row.login_id, "createdTimeStamp" => row.created_at.nsec, "path" => Base64.decode64(row.image)}

			@images[i] = @image;
			end

			render :json => @images
		end

	end

end
